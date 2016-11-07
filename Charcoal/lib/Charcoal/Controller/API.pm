package Charcoal::Controller::API;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::API - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut


sub index :Chained('/') :PathPart('api') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

# Nothing to do as of now

}

sub auto :ActionClass('Deserialize'){
	
	my ($self, $c) = @_;
	
	if ($c->controller eq $c->controller('API::Login')) {
        return 1;
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
