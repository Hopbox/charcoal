package Charcoal::Controller::User::Register;
use Moose;
use namespace::autoclean;

use Crypt::JWT ':all';
use Email::Valid;
use UUID 'uuid';

BEGIN { extends 'Catalyst::Controller'; }

#has 'jwt_key' => ( is => 'ro', required => 1 );

=head1 NAME

Charcoal::Controller::User::Register - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/user/index') :PathPart('register') :CaptureArgs(0){}

sub nothing :Chained('base') :PathPart('') :Args(0){

    my ($self, $c) = @_;

    $c->response->body('Nothing here.');

}

sub welcome :Chained('base') :PathPart('welcome') :Args(0){

    my ($self, $c) = @_;
    
    $c->log->debug("*** Register WELCOME");
    
    $c->stash->{submit_email} = $c->uri_for('gotmail');
    $c->stash->{template} = 'register-welcome.tt2';
}

sub submit_email :Chained('base') :PathPart('gotmail') :Args(0) POST {

    my ($self, $c) = @_;
    
    $c->log->debug("*** Register GOTMAIL");
    
    my $email = $c->request->params->{email} || "";
    
    $c->log->debug("GOTMAIL:" . $email);
    
    if ($email) {
    
        # Check if account already exists 
        # Or sign-up verification pending
        
        my $is_user = $c->model('PgDB::User')->search( { username => $email} )->next;
        my $is_reg = $c->model('PgDB::UsersSignup')->search({ email => $email })->next;
        
        if ($is_user) {
            $c->log->debug("GOTMAIL: User already exists");
            $c->response->body($email . ' is already registered.');
            $c->detach;
        }
        
        if ($is_reg) {
            $c->log->debug("GOTMAIL: User already in UsersSignup.");
            $c->response->body($email . ' is already signedup but not yet verified');
            $c->detach;
        }
        
        # Validate and Verify using Email::Valid 
        my $valid_addr;
        
        eval {
            $valid_addr = Email::Valid->address( -address => $email,
                                            -mxcheck => 1 );
        };
        if ($@){
            $c->log->debug("Email::Valid an error occurred: " . $@);
        }
    
        if($valid_addr) {
        
            $c->log->debug("Email::Valid: Email validated." . $valid_addr);
        
        # Get JWT Key from the config
            $c->log->debug("Email: Got JWT Key: " . $self->{jwt_key});
            
            my $jws_token = encode_jwt( payload => { username => $valid_addr }, alg => 'HS256', key => $self->{jwt_key} );
        
        
            
      # Send email
            $c->forward('send_verification_email', [$jws_token, $valid_addr]);
            
        # Create entry in the table    
            my $result = $c->model('PgDB::UsersSignup')->create( {email => $valid_addr} );
    
            if ($result == -1){
                $c->flash->{error_msg} = "Problem registering account.";
            }
            else {
                $c->flash->{status_msg} = "Account registered.";
            }
            
    
        }
        else {
            $c->log->debug("Email failed check: " . $Email::Valid::Details);
            $c->stash->{error_msg} = "Invalid E-mail . " . uc($Email::Valid::Details) . " failed.";
            $c->stash->{submit_email} = $c->uri_for('gotmail');
            $c->stash->{template} = 'register-email-invalid.tt2';
            $c->detach;
        }
    
    }
    
    
}

sub resend_verify_request :Chained('base') :PathPart('resendverify') :Args(0){

    my ($self, $c) = @_;
    
    my $email = $c->request->params->{email} || "";
}

sub send_verification_email :Private {

    my ($self, $c, $jws_token, $valid_addr) = @_;
    
    $c->log->debug("SENDMAIL: Got e-mail and token. " . $valid_addr . ' ' . $jws_token);

    $c->stash->{verify_url} = $c->uri_for('verify', $jws_token);
    $c->stash->{email} = {
        to          =>  "$valid_addr",
        from        =>  'Charcoal Webfilter <charcoal@hopbox.in>',
        subject     =>  '[Charcoal] New Account Verification',
        template    =>  'email-verification.tt2',
    };
    
    $c->forward( $c->view('Email::Template'));
          
    if ( scalar @{ $c->error }) {
        $c->log->debug("Email: Error sending email " . @{ $c->error });
        $c->error(0);
        $c->stash->{valid_email} = $valid_addr;
        $c->stash->{template} = 'email-send-fail.tt2';
        $c->detach;
    }
    
# Forward to confirmation page
    $c->stash->{valid_email} = $valid_addr;
    $c->stash->{template} = 'register-email-sent.tt2';
    return;
}

sub verify_email :Chained('base') :PathPart('verify') :Args(1) {
    my ($self, $c, $token) = @_;
    
    my $payload = decode_jwt( token => $token, key => $self->{jwt_key} )->{username};
    
    my $is_user = $c->model('PgDB::User')->search( { username => $payload, active => { '!=' => 2 } } )->first;
    
    my $is_verify_awaited = $c->model('PgDB::User')->search( { username => $payload, active => 2 } )->first;

    if ($is_user) {
        $c->log->debug("VERIFY EMAIL: User already exists");
        $c->response->body($payload . ' is already registered.');
        $c->detach;
    }
    
    # Find the user in registration table
    
    my $is_reg = $c->model('PgDB::UsersSignup')->search( { email => $payload })->first;
    # Create in user table
    my (%customer, %user);
    
    if ($is_reg || $is_verify_awaited) {
    
        $c->log->debug("Creating USER: " . $payload);
        
        
        # First create customer and get ID
        if (! $is_verify_awaited) {
            $customer{name}    = $payload . '\'s Org';
            $customer{api}     = 'c' . uuid();
            $customer{mongoid} = 'TBD';
        
            my $result = $c->model('PgDB::Customer')->create(\%customer);
        
            $c->log->debug("Create CUSTOMER ID: " . $result->id);
        
            if ($result == -1){
                $c->log->debug("Create CUSTOMER $customer{name} could not be created.");
                $c->response->body("Error creating account. C F.");
                $c->detach;
            }
    
    
        
            $user{username}  = $payload;
            $user{firstname} = 'My ';
            $user{lastname}  = 'Name';
            $user{customer}  = $result;
            $user{active}    = 2;
        
        # Create user and forward for password setting
        
            my $user_result = $c->model('PgDB::User')->create(\%user);
        
            $c->log->debug("Create USER ID: " . $user_result->id);
        
            if ($user_result == -1){
                $c->log->debug("Create USER $user{name} could not be created.");
                $c->response->body("Error creating account. U F.");
                $c->detach;
            }
        
        }
        
        # Show set password page
        my $jws_token = encode_jwt( payload => { username => $payload }, alg => 'HS256', key => $self->{jwt_key} );
        $c->stash->{setpass_submit} = $c->uri_for('setpass', $jws_token);
        $c->stash->{template} = 'register-email-setpass.tt2';
        $c->detach;
    }
    else {
    
        $c->log->debug("USER NOT FOUND: " . $payload);
        $c->response->body("Verification failed.");
        $c->detach;
    }
    
    
}


sub set_pass :Chained('base') :PathPart('setpass') :Args(1) POST {

    my ($self, $c, $token) = @_;
    my $password = $c->request->params->{password} || "";
    
    if (! $password) {

        $c->flash->{error_msg} = "Password not entered. Try again.";
        $c->stash->{setpass_submit} = $c->uri_for('setpass', $token);
        $c->{template} = 'register-email-setpass.tt2';
        $c->detach;
    }
    my $username = decode_jwt( token => $token, key => $self->{jwt_key} )->{username};
    
    my $user_obj = $c->model('PgDB::User')->search( { username => $username, active => { '!=' => 1 } } )->first;
    
    if (! $user_obj ) {
        $c->response->body("Password is already set. Status active.");
        $c->detach;
    }
    
    my $user_result = $user_obj->update( {password => $password, active => 1} );
    
    if ($user_result == -1){
        $c->log->debug("Set PASS: $username failed.");
        $c->response->body("Error setting password.");
        $c->detach;
    }
    
    # If the username and password values were found in form
    if ($username && $password) {
        # Attempt to log the user in
        $c->log->debug('*** Attempting to authenticate.');
        if ($c->authenticate({ username => $username,
                               password => $password  } )) {
            # If successful, then let them use the application
            $c->response->redirect($c->uri_for('/admin/acls/list'));
            return;
        } 
        else {
            # Set an error message
            $c->flash->{error_msg} = "Bad username or password.";
            $c->stash->{error_msg} = "Bad username or password.";
            $c->response->redirect($c->uri_for('/login'));
            $c->detach;
        }
    }
    
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
