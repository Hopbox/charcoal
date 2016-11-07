package Charcoal::Controller::API::DstGroups;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

Charcoal::Controller::API::DstGroups - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub dstgroup :Local :Chained('/api/index') :PathPart('dstgrp') :Args(1) :ActionClass('REST') { }
sub dstgroups :Local :Chained('/api/index') :PathPart('dstgrps') :ActionClass('REST') { }

sub dstgroup_GET {
	my ( $self, $c, $cat_id ) = @_;

	my $cust_id = $c->user->customer->id;

	if ( $cat_id ) {
		
		my %grp_hash;
		my $go = 1; 
		
		my $cat = $c->model('PgDB::Category')->find({								
								id	=>	$cat_id,
								customer => $cust_id,
							});
		
		$c->log->debug("CAT, CUST: " . $cat, $c->user->customer->id, $go );
		
		if( $cust_id ne 1 ) {
			
			my @dst_arr;
			
			my @dom = $c->model('PgDB::CDomain')->search({
									'c_dom_cats.category' => $cat_id,	
								},
								{
									join => 'c_dom_cats'
								});
			
			foreach my $dst (@dom){
				push @dst_arr, $dst->domain;
			}					
			
			$c->log->debug("DST object is " . "@dst_arr");
			
			$grp_hash{id}	= $cat_id;
			$grp_hash{name} = $cat->category;
			$grp_hash{desc} = $cat->description;
			$grp_hash{is_custom} = 1 if ($cat->customer->id != 1);
			$grp_hash{domains} = \@dst_arr;		
	
			$c->stash->{json} = \%grp_hash;
		
		}
		else {
			$self->status_bad_request( $c, message => "Now allowed." );
			$c->response->status(500);
			$c->detach();
		}
			
		
		$c->forward( 'View::JSON' );
	}

}

sub dstgroups_GET {
	
	my ($self, $c ) = @_;
	

	my $dstgroups = $c->model('PgDB::Category')->search({
							customer => { '-in' => [ $c->user->customer->id, 1 ] }
						},
						);
		
	my @grp_arr;
		
	foreach my $grp ($dstgroups->all){
			
		my %grp_hash;
		$grp_hash{is_custom} = 0;
		
		$c->log->debug("DST GRP: " . $grp->id . "," . $grp->category . "," . $grp->customer->id);
					
		$grp_hash{id}	= $grp->id;
		$grp_hash{name} = $grp->category;
		$grp_hash{desc} = $grp->description;
		$grp_hash{is_custom} = 1 if ($grp->customer->id != 1);
		push @grp_arr, \%grp_hash;
	}
		
	$c->stash->{json} = \@grp_arr;
	
	$c->forward( 'View::JSON' );
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
