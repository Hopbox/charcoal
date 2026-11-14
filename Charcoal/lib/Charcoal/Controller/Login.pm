package Charcoal::Controller::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;
#    $c->flash->{error_msg} = $c->stash->{error_msg};

    if ($c->user){
        $c->response->redirect($c->uri_for('/admin/acls/list'));
        $c->detach;
    }
    
    # Show messages set by auth() before its redirect
    $c->stash->{error_msg}  = delete $c->flash->{error_msg}  if exists $c->flash->{error_msg};
    $c->stash->{status_msg} = delete $c->flash->{status_msg} if exists $c->flash->{status_msg};

    $c->stash->{submit_url} = $c->uri_for('auth');
    $c->stash->{template} = 'login.tt2';
}


# Login rate limit. Counters are in $c->cache (Cache::FastMmap, shared by
# all processes on this host; file set in lib/Charcoal.pm). A counter expires BLOCK_SECONDS after the
# last failed attempt. Unblock by hand: script/charcoal_unblock.pl
use constant {
    FAIL_LIMIT_USER => 5,     # same IP + same username
    FAIL_LIMIT_IP   => 20,    # same IP, any username
    BLOCK_SECONDS   => 900,
};

sub auth :Path('/login/auth') :Args(0) {
    my ( $self, $c ) = @_;

    my $username = $c->request->params->{username} // "";
    my $password = $c->request->params->{password} // "";
    my $ip       = $c->req->address // 'unknown';

    my $k_user = 'login_fail:' . $ip . ':' . lc(substr($username, 0, 64));
    my $k_ip   = 'login_fail_ip:' . $ip;
    my $n_user = $c->cache->get($k_user) // 0;
    my $n_ip   = $c->cache->get($k_ip)   // 0;

    if ($n_user >= FAIL_LIMIT_USER || $n_ip >= FAIL_LIMIT_IP) {
        $c->log->warn("LOGIN BLOCKED ip=$ip user=$username fails_user=$n_user fails_ip=$n_ip");
        $c->flash->{error_msg} = "Too many failed attempts. Try again in 15 minutes.";
        $c->response->redirect($c->uri_for('/login'));
        $c->detach;
    }

    if ($username ne '' && $password ne '') {
        if ($c->authenticate({ username => $username, password => $password, active => 1 })) {
            $c->cache->remove($k_user);

            # New session ID and new CSRF token after login, so that a
            # session ID known before login (session fixation) is useless.
            $c->change_session_id if $c->can('change_session_id');
            delete $c->session->{csrf_token};

            $c->log->info("LOGIN OK ip=$ip user=$username");
            $c->response->redirect($c->uri_for('/admin/acls/list'));
            $c->detach;
        }

        $c->cache->set($k_user, $n_user + 1, BLOCK_SECONDS);
        $c->cache->set($k_ip,   $n_ip + 1,   BLOCK_SECONDS);
        $c->log->warn("LOGIN FAILED ip=$ip user=$username fails_user=" . ($n_user + 1) . " fails_ip=" . ($n_ip + 1));
    }

    $c->flash->{error_msg} = "Bad username or password.";
    $c->response->redirect($c->uri_for('/login'));
    $c->detach;
}


=head2 auth

=cut



=encoding utf8

=head1 AUTHOR

Unmukti Technology Pvt Ltd,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
