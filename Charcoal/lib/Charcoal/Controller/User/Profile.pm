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

    my $user_obj = $c->model('PgDB::User')->find($c->user->id);
    
    if ($user_obj == -1){
                $c->flash->{error_msg} = "An error occured displaying profile.";
                $c->res->redirect($c->uri_for('/admin/acls/list'));
                $c->detach;
    }
    
    my $orgname = $user_obj->customer->name;
    
    $c->stash->{organisation} = $orgname;
    $c->stash->{submit_change_passwd} = $c->uri_for('change_password');
    $c->stash->{submit_update_profile} = $c->uri_for('update_profile');
    $c->stash->{template} = 'user-profile.tt2';

}

sub update_profile :Chained('base') :PathPart('update_profile') :Args(0) POST {
    my ($self, $c) = @_;
    
    $c->log->debug("**** Inside Update Profile");
    
    my $firstname = $c->req->parameters->{first_name} || "";
    my $lastname = $c->req->parameters->{last_name} || "";
    my $custname = $c->req->parameters->{organisation} || "";
    
    my $user_obj = $c->model('PgDB::User')->find($c->user->id);
    my $customer_obj = $user_obj->customer;
    
    if ( $firstname && $lastname ){
        my $result = $user_obj->update({ firstname => $firstname, lastname => $lastname });
        
        if ($result == -1){
                $c->flash->{error_msg} = "An error occured updating profile.";
                $c->res->redirect($c->uri_for('show'));
                $c->detach;
        }
        
    }
    
    if ($custname){
        my $result = $customer_obj->update({ name => $custname });
    
        if ($result == -1){
                $c->flash->{error_msg} = "An error occured updating profile.";
                $c->res->redirect($c->uri_for('show'));
                $c->detach;
        }
    }
    
    $c->flash->{status_msg} = "Profile updated successfully.";
       
    $c->response->redirect($c->uri_for('show'));
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
