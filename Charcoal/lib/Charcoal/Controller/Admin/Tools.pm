package Charcoal::Controller::Admin::Tools;
use Moose;
use namespace::autoclean;
use JSON::XS qw(decode_json);
use Charcoal::Domain qw(normalize_domain search_levels);
use Charcoal::Input qw(clean_text);
use Charcoal::ServerClient;
use Data::Validate::IP qw(is_ipv4);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::Tools - Search Domain, Test ACL

=head1 CONFIG

    <Controller::Admin::Tools>
        charcoal_host        active.charcoal.io
        charcoal_port        6606
        charcoal_tls         1
        charcoal_tls_verify  1
        charcoal_ca_file     /path/ca.pem     # optional
        timeout              5
        tests_per_minute     10
    </Controller::Admin::Tools>

=cut

has charcoal_host       => (is => 'ro', default => 'active.charcoal.io');
has charcoal_port       => (is => 'ro', default => 6606);
has charcoal_tls        => (is => 'ro', default => 1);
has charcoal_tls_verify => (is => 'ro', default => 1);
has charcoal_ca_file    => (is => 'ro', default => undef);
has timeout             => (is => 'ro', default => 5);
has tests_per_minute    => (is => 'ro', default => 10);

sub base :Chained('/admin/index') :PathPart('tools') :CaptureArgs(0) {}

sub search :Chained('base') :PathPart('search') :Args(0) {
    my ($self, $c) = @_;

    my $q = $c->req->params->{q} // '';
    $c->stash->{template} = 'tools-search.tt2';
    $c->stash->{q}        = $q;
    return if $q eq '';

    my $domain = normalize_domain($q);
    unless ($domain) {
        $c->stash->{error_msg} = "Enter a domain name or a URL, for example www.example.com";
        return;
    }
    my ($levels, $results) = _domain_categories($c, [ search_levels($domain) ]);
    $c->stash->{domain}  = $domain;
    $c->stash->{levels}  = $levels;
    $c->stash->{results} = $results;
}

# Categories (global, and own of this customer) that contain one of the
# names in $levels, with the customer's rules that use each category.
# Returns ($levels, \@results), sorted most specific name first.
sub _domain_categories {
    my ($c, $levels) = @_;
    my @levels = @$levels;
    my %level_no; @level_no{@levels} = (0 .. $#levels);
    my $cid = $c->user->customer->id;

    my ($cats, $acls) = $c->model('PgDB')->storage->dbh_do(sub {
        my (undef, $dbh) = @_;

        # Global categories, and own categories of this customer only.
        my $cats = $dbh->selectall_arrayref(q{
            SELECT d.domain AS matched, c.id AS cat_id, c.category AS cat_name,
                   c.customer AS cat_customer, 'global' AS list
              FROM domains d
              JOIN gl_dom_cat g ON g.domain = d.id
              JOIN categories c ON c.id = g.category
             WHERE d.domain = ANY(?)
            UNION ALL
            SELECT d.domain, c.id, c.category, c.customer, 'own'
              FROM c_domains d
              JOIN c_dom_cat g ON g.domain = d.id
              JOIN categories c ON c.id = g.category
             WHERE d.customer = ? AND d.domain = ANY(?)
               AND c.customer IN (1, ?)
        }, { Slice => {} }, \@levels, $cid, \@levels, $cid);

        my @ids = do { my %u; grep { !$u{$_}++ } map { "$_->{cat_id}" } @$cats };
        my $acls = @ids ? $dbh->selectall_arrayref(q{
            SELECT id, acl->>'desc' AS name, acl->>'access' AS access, seq,
                   acl->'dst' AS dst
              FROM acls
             WHERE customer = ? AND jsonb_exists_any(acl->'dst', ?)
             ORDER BY seq
        }, { Slice => {} }, $cid, \@ids) : [];

        return ($cats, $acls);
    });

    # Rules of this customer per category
    my %rules_for;
    for my $acl (@$acls) {
        my $dst = eval { decode_json($acl->{dst}) } || [];
        push @{ $rules_for{$_} }, { name => $acl->{name}, access => $acl->{access} } for @$dst;
    }

    my @results = sort {
        $level_no{$a->{matched}} <=> $level_no{$b->{matched}}
            || lc($a->{cat_name} // '') cmp lc($b->{cat_name} // '')
    } map {
        +{ %$_,
           is_global => ($_->{cat_customer} == 1 ? 1 : 0),
           rules     => $rules_for{ $_->{cat_id} } || [],
           members_url => ($_->{cat_customer} == $cid
               ? $c->uri_for('/admin/destinationgroups/listmembers', $_->{cat_id}) : undef),
         }
    } @$cats;

    return (\@levels, \@results);
}

# --- Tools > Test ACL ---------------------------------------------------
#
# Sends one request to charcoal-server, exactly like the Squid helper, and
# shows its answer. Below it, the portal computes the decision with the
# same logic as charcoal-server (check_acl / evaluate_acl, 2.0.x) on the
# primary database, to show which rule decided. The server answer is the
# authority; a difference means replica lag, cache, or a server change.

sub test :Chained('base') :PathPart('test') :Args(0) {
    my ($self, $c) = @_;
    my $p = $c->req->params;

    my $ip    = clean_text($p->{ip});
    my $user  = clean_text($p->{user});
    my $input = clean_text($p->{url});
    my $proto = ($p->{proto} // '') eq 'http' ? 'http' : 'https';
    $proto = 'http'  if $input =~ m{^http://}i;
    $proto = 'https' if $input =~ m{^https://}i;

    $c->stash->{template} = 'tools-test.tt2';
    $c->stash->{form} = { ip => $ip, user => $user, url => $input, proto => $proto };
    return unless length $ip || length $input;    # empty form

    my $hostport = normalize_domain($input);
    my $err;
    $err = "Enter a valid IPv4 address as source." unless is_ipv4($ip);
    $err ||= "Enter a domain name or a URL to test." unless $hostport;
    $err ||= "User: no spaces or | characters, at most 128 characters."
        if length $user && ($user =~ /[\s|]/ || length($user) > 128);
    if ($err) { $c->stash->{error_msg} = $err; return; }

    # Rate limit per portal user
    my $rk = 'acltest:' . $c->user->id;
    my $n  = $c->cache->get($rk) // 0;
    if ($n >= $self->tests_per_minute) {
        $c->stash->{error_msg} = "Too many tests. Wait one minute and try again.";
        return;
    }
    $c->cache->set($rk, $n + 1, 60);

    # What Squid sends (field 7), and the destination charcoal-server takes
    # from it: HTTP keeps a non-default port; CONNECT (https) loses it.
    my ($host, $port) = $hostport =~ /^(.*?)(?::(\d+))?$/;
    my ($url, $server_dst) = $proto eq 'https'
        ? ($host . ':' . ($port // 443), $host)
        : ("http://$hostport/", $hostport);

    my $nonce = 'guitest-' . join('', map { ('a' .. 'z', 0 .. 9)[rand 36] } 1 .. 12);
    my @fields = (3, $ip, (length $user ? $user : '-'),
                  ($proto eq 'https' ? 'CONNECT' : 'GET'), $nonce, $url);
    my $line = join '|', $c->user->customer->api, @fields;

    my ($reply, $cerr) = Charcoal::ServerClient::query(
        host    => $self->charcoal_host,
        port    => $self->charcoal_port,
        tls     => $self->charcoal_tls,
        verify  => $self->charcoal_tls_verify,
        ca_file => $self->charcoal_ca_file,
        timeout => $self->timeout,
        line    => $line,
    );

    my $verdict;
    if    ($cerr)                               { $c->stash->{server_error} = $cerr }
    elsif ($reply =~ /^OK\s*$/)                 { $verdict = 'ALLOW' }
    elsif ($reply =~ /^OK\s+status=30\d\b/)     { $verdict = 'DENY' }
    elsif ($reply =~ /^ERR\b/)                  { $c->stash->{server_error} = "charcoal-server refused the request: $reply" }
    else                                        { $c->stash->{server_error} = "Unexpected reply from charcoal-server: $reply" }

    # charcoal-server 2.0.7 adds reason=threat-<feed> to the block URL
    my ($threat) = defined $reply ? $reply =~ /[?&]reason=threat-([A-Za-z0-9_.-]+)/ : ();

    my $explain = _explain($c, $ip, $user, $server_dst);
    my (undef, $cats) = _domain_categories($c, $explain->{walk});

    $c->log->info(sprintf 'ACL TEST user=%s ip=%s user_field=%s url=%s server=%s portal=%s',
        $c->user->username // '?', $ip, (length $user ? $user : '-'), $url,
        $verdict // 'error', $explain->{access});

    $c->stash->{tested}         = 1;
    $c->stash->{request_line}   = join '|', '<your API key>', @fields;
    $c->stash->{server_reply}   = $reply;
    $c->stash->{server_verdict} = $verdict;
    $c->stash->{threat}         = $threat;
    $c->stash->{explain}        = $explain;
    $c->stash->{categories}     = $cats;
    $c->stash->{server_name}    = $self->charcoal_host . ':' . $self->charcoal_port;
}

# The Charcoal decision (charcoal-server 2.0.7 logic), on the portal's database:
#   1. source groups of the IP / user
#   2. walk the WHOLE domain (www.a.example.com -> a.example.com -> example.com
#      -> com) and collect the destination groups of every name
#   3. first rule by position that matches:
#        (source group AND destination group) OR (ALL AND destination group)
#        OR (source group AND ALL)
#   4. else the default rule (ALL -> ALL, last position)
sub _explain {
    my ($c, $ip, $user, $dst) = @_;
    my $cid = $c->user->customer->id;

    my @walk = ($dst);
    { my $d = $dst; push @walk, $d while $d =~ s/^.*?\.//; }

    (my $short = $user) =~ s/\@.*$//;
    $short =~ s/^.*\\//;

    return $c->model('PgDB')->storage->dbh_do(sub {
        my (undef, $dbh) = @_;

        my $default = $dbh->selectrow_hashref(q{
            SELECT id, acl->>'desc' AS name, seq, acl->>'access' AS access
              FROM acls
             WHERE customer = ? AND jsonb_exists(acl->'src', '0')
               AND jsonb_exists(acl->'dst', '0')
             ORDER BY seq DESC LIMIT 1
        }, undef, $cid);

        # Source groups: same rules as charcoal-server 2.0.7 ($sth_src_match)
        my $o = '(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])';
        my $groups = $dbh->selectall_arrayref(qq{
            SELECT DISTINCT gr.id, gr.name, s.value
              FROM src s
              JOIN src_groups g ON g.member = s.id
              JOIN groups gr    ON gr.id = g.grp
             WHERE s.customer = ? AND CASE
               WHEN s.src_type IN (2, 4) AND s.value ~ '^($o\\.){3}$o(/(3[0-2]|[12]?[0-9]))?\$'
                 THEN ?::inet <<= s.value::inet
               WHEN s.src_type = 3 AND s.value ~ '^($o\\.){3}$o-($o\\.){3}$o\$'
                 THEN ?::inet BETWEEN split_part(s.value, '-', 1)::inet AND split_part(s.value, '-', 2)::inet
               WHEN s.src_type = 1 AND ? <> ''
                 THEN lower(s.value) IN (lower(?), lower(?))
               ELSE false END
             ORDER BY gr.name
        }, { Slice => {} }, $cid, $ip, $ip, $user, $user, $short);
        my @gids = do { my %u; grep { !$u{$_}++ } map { "$_->{id}" } @$groups };

        # Destination groups of every name in the walk; remember the most
        # specific name where each group was found
        my (%found_at, @cats);
        for my $level (@walk) {
            my $cats = $dbh->selectcol_arrayref(q{
                SELECT category FROM gl_dom_cat
                 WHERE domain IN (SELECT id FROM domains WHERE domain = ?)
                UNION
                SELECT category FROM c_dom_cat
                 WHERE domain IN (SELECT id FROM c_domains WHERE customer = ? AND domain = ?)
            }, undef, $level, $cid, $level);
            for (@$cats) { next if exists $found_at{$_}; $found_at{$_} = $level; push @cats, "$_"; }
        }

        my %result = (walk => \@walk, groups => $groups, default => $default);

        if (@gids || @cats) {
            my @g = @gids ? @gids : ('dummy');
            my @k = @cats ? @cats : ('dummy');
            my $rule = $dbh->selectrow_hashref(q{
                SELECT id, acl->>'desc' AS name, seq, acl->>'access' AS access,
                       acl->'src' AS src, acl->'dst' AS dst
                  FROM acls
                 WHERE customer = ? AND seq != ?
                   AND (    jsonb_exists_any(acl->'src', ?) AND jsonb_exists_any(acl->'dst', ?)
                        OR (jsonb_exists_any(acl->'src', array['0']) AND jsonb_exists_any(acl->'dst', ?))
                        OR (jsonb_exists_any(acl->'src', ?) AND jsonb_exists_any(acl->'dst', array['0'])))
                 ORDER BY seq ASC LIMIT 1
            }, undef, $cid, ($default ? $default->{seq} : undef), \@g, \@k, \@k, \@g);

            if ($rule) {
                my $rsrc = eval { decode_json($rule->{src}) } || [];
                my $rdst = eval { decode_json($rule->{dst}) } || [];
                my %gset = map { $_ => 1 } @gids;
                my ($via_dst) = grep { exists $found_at{$_} } @$rdst;    # destination group that matched
                my $via_name;
                if (defined $via_dst) {
                    $via_name = $dbh->selectrow_array('SELECT category FROM categories WHERE id = ?', undef, $via_dst);
                }
                my ($via_src) = grep { $gset{$_} } @$rsrc;
                my $via_src_name = defined $via_src
                    ? (map { $_->{name} } grep { "$_->{id}" eq $via_src } @$groups)[0] : undef;
                return { %result, rule => $rule, type => 'SPECIFIC',
                         access   => ($rule->{access} // '') eq 'ALLOW' ? 'ALLOW' : 'DENY',
                         via_dst  => (defined $via_dst ? { name => $via_name, at => $found_at{$via_dst} } : undef),
                         via_src  => $via_src_name };
            }
        }
        return { %result, rule => $default, type => 'DEFAULT',
                 access => ($default && ($default->{access} // '') eq 'ALLOW') ? 'ALLOW' : 'DENY' };
    });
}

__PACKAGE__->meta->make_immutable;

1;
