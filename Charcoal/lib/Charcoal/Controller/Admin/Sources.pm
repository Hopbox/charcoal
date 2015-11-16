package Charcoal::Controller::Admin::Sources;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::Sources - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	my @srcs = $c->model('PgDB::Src')->search( { customer => $c->user->customer->id }, { order_by => { -asc => 'src_type' },
			{ -asc => 'value' } } )->all;
	
	my @src_arr;
	
	foreach my $src (@srcs){
		my %src_hash;
		$c->log->debug("SRC: " . $src->id . "," . $src->customer->id . ", " . $src->value . "," . $src->src_type->type);
		$src_hash{id} = $src->id;
		$src_hash{value} = $src->value;
		$src_hash{type} = uc($src->src_type->type);
		
		push @src_arr, \%src_hash;
	}
	$c->stash->{src_list} = \@src_arr;
	$c->stash->{template} = 'sources.tt2';
	
	$c->forward( $c->view() );
    #$c->response->body('Matched Charcoal::Controller::Admin::Sources in Admin::Sources.');
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
