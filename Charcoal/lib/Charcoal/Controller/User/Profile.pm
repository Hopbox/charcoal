package Charcoal::Controller::User::Profile;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::User::Profile - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/user/index') :PathPart('profile') :CaptureArgs(0) {}
    
sub show :Chained('base') :PathPart('show') :Args(0) {

    my ( $self, $c ) = @_;

    $c->stash->{submit_change_passwd} = $c->uri_for('change_password');
    $c->stash->{template} = 'user-profile.tt2';
#    $c->forward;
#    $c->detach;
#    $c->response->body('Matched Charcoal::Controller::User::Profile in User::Profile.');
}

sub change_password :Chained('base') :PathPart('change_password') :Args(0) POST {
    my ($self, $c) = @_;
    
    $c->log->debug("**** Inside Change Password");
    
    my $cur_pass = $c->req->parameters->{current_password} || '';
    my $new_pass = $c->req->parameters->{new_password} || '';
    my $new_pass_re = $c->req->parameters->{new_password_re} || '';
    
    # Check if new_pass and new_pass_re match and both are provided
    
    if ($new_pass eq $new_pass_re){
    
    # Then check if current pass is correct
        if ($c->authenticate({username => $c->user->username, password => $cur_pass})){
    # If yes, then change password
            my $user_obj = $c->model('PgDB::User')->find($c->user->id);
            
            my $result = $user_obj->update( {password => $new_pass} );
            
            if ($result == -1){
                $c->flash->{error_msg} = "An error occured updating password.";
                $c->res->redirect($c->uri_for('show'));
                $c->detach;
            }
            else {
                $c->flash->{status_msg} = "Password changed successfully.";
                $c->res->redirect($c->uri_for('show'));
                $c->detach;
            }
            
            
        }
        else{
            ## Current password incorrect
            $c->flash->{error_msg} = "Password incorrect. Try again.";
            $c->res->redirect($c->uri_for('show'));
            $c->detach;
        }
    
    
    }
    else {
    
    ## Provided new passwords do not match
        $c->flash->{error_msg} = "New password do not match. Try again.";
        $c->res->redirect($c->uri_for('show'));
        $c->detach;
    }
    
    # Else populate error_msg in stash
    # And redirect
    $c->flash->{error_msg} = "Something nasty has happened while changing the password. Try again.";
    $c->res->redirect($c->uri_for('show'));
    $c->detach;
}

=encoding utf8

=head1 AUTHOR

Nishant Sharma,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
