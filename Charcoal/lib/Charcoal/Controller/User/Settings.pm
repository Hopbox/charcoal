package Charcoal::Controller::User::Settings;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::User::Settings - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut
sub base :Chained('/user/index') :PathPart('settings') :CaptureArgs(0) {}

sub show :Chained('base') :PathPart('show') :Args(0){

    my ($self, $c) = @_;
    
    my $customer = $c->model('PgDB::User')->find($c->user->id)->customer;
    my $api = $customer->api;
    my $organisation = $customer->name;
    
    $c->stash->{organisation} = $organisation;
    $c->stash->{api} = $api;
    $c->stash->{template} = 'user-settings.tt2';

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
