package Charcoal::Controller::API::SrcGroups;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

=head1 NAME

Charcoal::Controller::API::SrcGroups - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub srcgroup :Local :Chained('/api/index') :PathPart('srcgrp') :Args(1) :ActionClass('REST') { }
sub srcgroups :Local :Chained('/api/index') :PathPart('srcgrps') :Args(0) :ActionClass('REST') { }

sub srcgroup_GET {
	
	my ( $self, $c, $gid ) = @_;
	
	my (%grp_hash, %member_hash, @member_arr);
	
	$grp_hash{name} = $c->model('PgDB::Group')->find($gid)->name;
	
	my @members = $c->model('PgDB::Src')->search({
							'src_groups.id'	=> $gid,
							customer => $c->user->customer->id,
						},
						{	join => 'src_groups',
						});
						
	$c->log->debug("Members: " . @members);
	
	foreach my $member (@members) {
		$member_hash{id} = $member->id;
		$member_hash{value} = $member->value;
		$member_hash{type}  = $member->src_type->type;
		
		push @member_arr, \%member_hash;
	}
	
	$grp_hash{members} = \@member_arr;
	
	$c->stash->{json} = \%grp_hash;
	
	$c->forward( 'View::JSON' );
}

sub srcgroups_GET {
	
	my ( $self, $c ) = @_;

	$c->log->debug("User Object is " . $c->user);
	
	my @src_grps = $c->model('PgDB::Group')->search({ 
						customer => $c->user->customer->id 
						},
						{ 
							order_by => { -asc => 'name' } 
						});
    
    my @grp_arr;
    
    foreach my $grp (@src_grps) {
		my %grp_hash;
		$c->log->debug("SRC GRP: " . $grp->id . "," . $grp->name);
				
		$grp_hash{id}	= $grp->id;
		$grp_hash{name} = $grp->name;
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
