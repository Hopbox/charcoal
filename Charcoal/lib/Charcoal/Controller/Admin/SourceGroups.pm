package Charcoal::Controller::Admin::SourceGroups;
use Moose;
use namespace::autoclean;

use Data::Validate::IP qw(is_ipv4 is_innet_ipv4);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::SourceGroups - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('admin/sourcegroups') :CaptureArgs(0) {}

sub list :Chained('base') :PathPart('list') :Args(0){
    my ( $self, $c ) = @_;

	my @src_grps = $c->model('PgDB::Group')->search( { customer => $c->user->customer->id },{ order_by => { -asc => 'name' } });
    
    my @grp_arr;
    
    foreach my $grp (@src_grps) {
		my %grp_hash;
		
		$c->log->debug("SRC GRP: " . $grp->id . "," . $grp->name);
		
		$grp_hash{id}	= $grp->id;
		$grp_hash{name} = $grp->name;
		push @grp_arr, \%grp_hash;
	}
    
    $c->stash->{add_submit_url} = $c->uri_for('addgroup');
    $c->stash->{grp_list} = \@grp_arr;
    $c->stash->{template} = 'sourcegroups.tt2';
    
    $c->forward( $c->view() );
    
    #$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');
}

sub addgroup :Chained('base') :PathPart('addgroup') :Args(0){
	my ( $self, $c ) = @_;
	
	my $groupname = $c->request->params->{groupname};
	
	$c->log->debug("ADDGRP: Attempting to add group " . $groupname);
	
	my $group = $c->model('PgDB::Group')->create ({
				name		=>	$groupname,
				customer	=>	$c->user->customer->id,
			});
	
	$c->log->debug("ADDGRP: Addition returned id " . $group->id);
			
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub listmembers :Chained('base') :PathPart('listmembers') :Args(1){
	my ($self, $c, $grp_id) = @_;
	
	my $group = $c->model('PgDB::Group')->find( $grp_id );
	
	my @members = $c->model('PgDB::Src')->search( 
							{ 
								customer		=>	$c->user->customer->id,
								'src_groups.grp' => $grp_id,
							},
							{ 
								join => 'src_groups' 
							}
					);
	
	my @member_arr;
	
	foreach my $member (@members) {
		my %member_hash;
		$c->log->debug("SRC: " . $grp_id . "," . $member->id . "," . $member->customer->id . ", " . $member->value . "," . $member->src_type->type);
		$member_hash{id} 	= $member->id;
		$member_hash{value} = $member->value;
		$member_hash{type} 	= uc($member->src_type->type);
		
		push @member_arr, \%member_hash;
	}
	
	$c->stash->{add_submit_url} = $c->uri_for('addmember', $grp_id);
	$c->stash->{group}			= \%{$group};
	$c->stash->{member_list} 	= \@member_arr;
	$c->stash->{template} 		= 'viewsourcegrp.tt2';
	
	$c->forward( $c->view() );
	
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');
}

sub addmember :Chained('base') :PathPart('addmember') :Args(1){
	my ($self, $c, $grp ) = @_;
	
	my $type = $c->request->params->{membertype} || "";
	my $value = $c->request->params->{membervalue} || "";
	
	## Check if value is a valid IP
	
	if (is_ipv4($value)) {
		$c->log->debug("ADDMEMBER: Value is an IP");
		# Add to Src
		my $src = $c->model('PgDB::Src')->create ({
						value		=>	$value,
						src_type	=>	$type,
						customer	=>	$c->user->customer->id
					});
					
		# Link to the Grp via SrcGroup
		$src->add_to_src_groups({
					grp	=>	$grp
				});
	}
	else {
		$c->log->debug("ADDMEMBER: Value is not an IP");
	}
	
	$c->log->debug("ADDMEMBER: Got values " . $grp . "," . $type . "," . $value);
	
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;

}

sub delmember :Chained('base') :PathPart('delmember') :Args(2){
	my ( $self, $c, $src, $grp ) = @_;
	
	$c->log->debug("DELMEM: Args: " . $src . "," . $grp);
	
	my $obj = $c->model('PgDB::Src')->find($src);
	$obj->delete();
	
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');	
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;
	
}
#sub root :Chained('base') :PathPart('') :Args(0) {}

=encoding utf8

=head1 AUTHOR

Nishant Sharma,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
