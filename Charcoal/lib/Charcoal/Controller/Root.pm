package Charcoal::Controller::Root;
use Moose;
use namespace::autoclean;
use Data::Dumper;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

Charcoal::Controller::Root - Root Controller for Charcoal

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub index : Path : Args(0){
        my ($self, $c) = @_;
        $c->response->redirect($c->uri_for('/login'));
#        $c->stash->{template} = 'login.tt2';
}

=head2 auto

Check if there is a user and, if not, forward to login page

=cut

# Note that 'auto' runs after 'begin' but before your actions and that
# 'auto's "chain" (all from application path to most specific class are run)
# See the 'Actions' section of 'Catalyst::Manual::Intro' for more info.

sub auto : Private {
    my ($self, $c) = @_;
    # Allow unauthenticated users to reach the login page.  This
    # allows unauthenticated users to reach any action in the Login
    # controller.  To lock it down to a single action, we could use:
    #   if ($c->action eq $c->controller('Login')->action_for('index'))
    # to only allow unauthenticated access to the 'index' action we
    # added above.
    
        
    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }

    if ($c->controller eq $c->controller('Root')->action_for('index')) {
        return 1;
    }
	
	if ($c->request->path =~ /^api/ ) {
		$c->response->headers->header('Access-Control-Allow-Origin' => '*');
		$c->response->headers->header('Access-Control-Allow-Headers' => 'content-type, x-charcoal-auth');
		$c->response->headers->header('Access-Control-Allow-Methods' => '*');
	} 
	
	if ($c->request->method eq 'OPTIONS' && $c->request->path =~ /^api/ ){
		$c->response->headers->header('Access-Control-Allow-Origin' => '*');
		$c->response->headers->header('Access-Control-Allow-Headers' => 'content-type, x-charcoal-auth');
		$c->response->headers->header('Access-Control-Allow-Methods' => '*');
		return 1;
	}
	
	if ($c->controller eq $c->controller('API::Login')){
		$c->response->headers->header('Access-Control-Allow-Origin' => '*');
		$c->response->headers->header('Access-Control-Allow-Headers' => 'content-type, x-charcoal-auth');
		$c->response->headers->header('Access-Control-Allow-Methods' => '*');
		return 1;
	}
	
    # If a user doesn't exist, force login
    if ( !$c->user_exists || !$c->session ) {
        # Dump a log message to the development server debug output
        $c->log->debug('***Root::auto User/Session not found, forwarding to /login');
        # Redirect the user to the login page
        $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }

    # User found, so return 1 to continue with processing after this 'auto'
    $c->stash->{user_fname} = $c->user->firstname;
    $c->stash->{user_sname} = $c->user->lastname;
    return 1;
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

#sub end : Private {
#    my ( $self, $c) = @_;
#    $c->forward( $c->view('HTML'));
#}

sub end : ActionClass('RenderView') { 

	my ( $self, $c ) = @_;
	$c->response->header('X-Frame-Options' => 'DENY');
	#$c->response->header('Strict-Transport-Security' => 'max-age=3600');
	$c->response->header('X-Content-Security-Policy' => "default-src 'self'");
	$c->response->header('X-Content-Type-Options' => 'nosniff');
	$c->response->header('X-Download-Options' => 'noopen');
	$c->response->header('X-XSS-Protection' => "1; 'mode=block'");
	
}

=head1 AUTHOR

Unmukti Technology Pvt Ltd,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
