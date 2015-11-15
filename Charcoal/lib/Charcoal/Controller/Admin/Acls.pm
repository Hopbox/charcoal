package Charcoal::Controller::Admin::Acls;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::Acls - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my @acls = $c->model('PgDB::Acl')->search( { customer => $c->user->customer->id }, { order_by => { -asc => 'seq' } } );
    my ($acl_seq, $acl_acl, $acl_id);

    my (@acl_arr);
	use Data::Dumper;
	
    foreach my $acl (@acls) {
        $c->log->debug("ACL: " . $acl->id . "," . $acl->customer->id . ", " . $acl->seq . ", " . $acl->acl);
        my $acl_json = JSON::XS->new->utf8->allow_nonref->decode($acl->acl);
        my %acl_hash;
        $acl_hash{id} = $acl->id;
        $acl_hash{seq} = $acl->seq;
        $acl_hash{src} = $acl_json->{'src'};
        $acl_hash{dst} = $acl_json->{'dst'};
        $acl_hash{times} = $acl_json->{'times'};
        $acl_hash{access} = $acl_json->{'access'};
        $acl_hash{desc} = $acl_json->{'desc'};
        push @acl_arr, \%acl_hash;
	}
	
	$c->stash->{acl_list} = \@acl_arr;
	$c->stash->{template} = 'acls.tt2';
	

	$c->forward( $c->view());

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
