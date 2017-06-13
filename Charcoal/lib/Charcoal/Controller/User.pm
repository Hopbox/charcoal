package Charcoal::Controller::User;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::User - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Chained('/') :PathPart('user') :CaptureArgs(0) {
    my ( $self, $c ) = @_;

	$c->stash->{status_msg} = $c->flash->{status_msg} if ( exists $c->flash->{status_msg});
	$c->stash->{error_msg} = $c->flash->{error_msg} if ( exists $c->flash->{error_msg});

    # Display Admin landing page
    # Profile and customer information should be available from Root.pm
    # 

    #$c->stash->{no_wrapper} = 0;
    #$c->stash->{template} = 'admin.tt2';

#    $c->response->body('Matched Charcoal::Controller::Admin in Admin.');
}



=encoding utf8

=head1 AUTHOR

Unmukti Technology Pvt Ltd,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
