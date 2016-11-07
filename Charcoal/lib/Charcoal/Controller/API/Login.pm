package Charcoal::Controller::API::Login;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

Charcoal::Controller::API::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub login :Local :Chained('/api/index') :PathPart('login') :ActionClass('REST') { }

sub login_POST {
	
	my ($self, $c) = @_;
	
	my $auth_data = $c->req->data;
	my ($user, $pass) = ($auth_data->{username} || "", $auth_data->{password} || "");
	
	if ( $user && $pass ) {
		
		$c->log->debug("API Authentication attempt...");
		
		if ($c->authenticate( {username => $user, password => $pass} )){
			my $sess = $c->change_session_id;
			
			$self->status_ok($c,
						entity => { token => $sess });
		}
		else {
			# login failed
			$c->log->debug("User/Pass incorrect failed");
			$c->res->status(403); # forbidden
			$c->res->body("Incorrect credentials. You are not authorized to use the REST API.");
			$c->detach;
		}
	}
	else {
		# login failed
		$c->log->debug("Credentials not supplied.");
		$c->res->status(403); # forbidden
		$c->res->body("Credentials not supplied.");
		$c->detach;
	}
}

#sub index :Path :Args(0) {
#    my ( $self, $c ) = @_;
#
#    $c->response->body('Matched Charcoal::Controller::API::Login in API::Login.');
#}



=encoding utf8

=head1 AUTHOR

Nishant Sharma,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
