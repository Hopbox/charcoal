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
    $c->stash->{submit_url} = $c->uri_for('auth');
    $c->stash->{template} = 'login.html';
}


sub auth :Path('/login/auth') :Args(0) {
    my ( $self, $c ) = @_;

    my $username = $c->request->params->{username} || "";
    my $password = $c->request->params->{password} || "";

# If the username and password values were found in form
    if ($username && $password) {
        # Attempt to log the user in
        $c->log->debug('*** Attempting to authenticate.');
        if ($c->authenticate({ username => $username,
                               password => $password  } )) {
            # If successful, then let them use the application
            $c->response->redirect($c->uri_for('/admin/acls'));
            return;
        } 
        else {
            # Set an error message
            $c->stash->{error_msg} = "Bad username or password.";
        }
    }

    # If either of above don't work out, send to the login page
#    $c->stash->{template} = 'login.tt2';
    $c->response->redirect($c->uri_for('auth'));
    return;

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
