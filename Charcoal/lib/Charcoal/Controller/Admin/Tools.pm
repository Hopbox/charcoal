package Charcoal::Controller::Admin::Tools;
use Moose;
use namespace::autoclean;
use JSON::XS qw(decode_json);
use Charcoal::Domain qw(normalize_domain search_levels);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::Tools - Search Domain (and later Test ACL)

=cut

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
    my @levels = search_levels($domain);
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

    $c->stash->{domain}  = $domain;
    $c->stash->{levels}  = \@levels;
    $c->stash->{results} = \@results;
}

__PACKAGE__->meta->make_immutable;

1;
