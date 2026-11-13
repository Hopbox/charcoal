package Charcoal::Controller::Admin::SourceGroups;
use Moose;
use namespace::autoclean;

use Data::Validate::IP qw(is_ipv4 is_innet_ipv4);
use NetAddr::IP;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::SourceGroups - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/admin/index') :PathPart('sourcegroups') :CaptureArgs(0) {}

sub list :Chained('base') :PathPart('list') :Args(0){
    my ( $self, $c ) = @_;

    my $page = $c->request->params->{page} // "";
	$page = 1 unless $page =~ /^[1-9]\d*$/;
	
	my $srcgroups = $c->model('PgDB::Group')->search({ 
						customer => $c->user->customer->id 
						},
						{ 
							page => $page,
							rows => 200,
							order_by => { -asc => 'name' } 
						});
    
    #my @grp_arr;
    
    #foreach my $grp (@src_grps) {
#		my %grp_hash;
#		
#		$c->log->debug("SRC GRP: " . $grp->id . "," . $grp->name);
#		
#		$grp_hash{id}	= $grp->id;
#		$grp_hash{name} = $grp->name;
#		push @grp_arr, \%grp_hash;
#	}
    
    $c->stash->{add_submit_url} = $c->uri_for('addgroup');
    $c->stash->{grp_list} = [ $srcgroups->all ];
    $c->stash->{pager} = $srcgroups->pager;
    $c->stash->{template} = 'sourcegroups.tt2';
    
    $c->forward( $c->view() );
    
    #$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');
}

sub addgroup :Chained('base') :PathPart('addgroup') :Args(0){
	my ( $self, $c ) = @_;
	
	my $groupname = $c->request->params->{groupname};
	my $groupdesc = $c->request->params->{groupdesc};
	
	$c->log->debug("ADDGRP: Attempting to add group " . $groupname);
	
	my $group = $c->model('PgDB::Group')->create ({
				name		=>	$groupname,
				description	=>	$groupdesc,
				customer	=>	$c->user->customer->id,
			});
	
	$c->log->debug("ADDGRP: Addition returned id " . $group->id);
			
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub editgroup :Chained('base') :PathPart('editgroup') :Args(1) {
	my ( $self, $c, $grp) = @_;
	
	my $group = $c->owned_row('PgDB::Group', $grp);
	$c->detach('/default') unless $group;
	
	$c->stash->{group}		= \%{$group};
	$c->stash->{template}	= 'edit-group.tt2';
	
	$c->forward( $c->view() );
	
}

sub editgroup_submit :Chained('base') :PathPart('editgroup_submit') :Args(1) {
	my ( $self, $c, $grp) = @_;
	
	my $groupname = $c->request->params->{groupname};
	my $groupdesc = $c->request->params->{groupdesc};
	
	my $group = $c->owned_row('PgDB::Group', $grp);
	
	if ($group) {
		$group->update({ name => $groupname, description => $groupdesc });
		$c->flash->{status_msg} = "Group details updated successfully.";
	}
	else {
		$c->log->debug("EDITGROUPSUBMIT: Group " . $grp . " not found.");
		$c->flash->{error_msg} = "Group not edited. Object not found: $grp.";
	}
	
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
	
}


sub delgroup :Chained('base') :PathPart('delgroup') :Args(1){
	my ( $self, $c, $grp ) = @_;
	$c->require_post;

	
	my $obj = $c->owned_row('PgDB::Group', $grp);
	unless ($obj) {
		$c->flash->{error_msg} = "Group not found.";
		$c->res->redirect($c->uri_for('list'));
		$c->detach;
	}
	my $grp_name = $obj->name;
	
	## Find if group is being in an ACL. If yes, then show error.
	
	my @using_acls = $c->model('PgDB::ACL')->search( 
                                    {
                                      -and => [
                                        customer => $c->user->customer->id, 
                                        \[ q{acl::jsonb#>'{src}' \\?| array[?]}, $grp ],
                                      ],
                                     },   
                                    );
	
	if (@using_acls) {
        
        $c->flash->{error_msg} = "$grp_name is in use. First remove it from these ACLs:";
        
        foreach my $acl (@using_acls) {
            my $acl_name = JSON::XS->new->utf8->allow_nonref->decode($acl->acl)->{desc};
            
            $c->flash->{error_msg} .= " [" . $acl_name . "]";
            
            $c->log->debug("USING ACLS: " . $acl_name);
        }
    
        $c->res->redirect($c->uri_for('list'));
        $c->detach;
    }
	
	## Find all the Src objects associated with this group
	my @members = $c->model('PgDB::Src')->search( 
							{ 
								customer		=>	$c->user->customer->id,
								'src_groups.grp' => $grp,
							},
							{ 
								join => 'src_groups' 
							}
					);
	## Delete those objects
	foreach my $member (@members){
		$c->log->debug("DELGRP: Deleting member " . $member->value); 
		$member->delete();
	}
	## Delete the group
	
	$c->log->debug("DELGRP: Deleting group " . $obj->name);
	
	$obj->delete();
	
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');	
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub listmembers :Chained('base') :PathPart('listmembers') :Args(1){
	my ($self, $c, $grp_id) = @_;
		
   	my $page = $c->request->params->{page} // "";
	$page = 1 unless $page =~ /^[1-9]\d*$/;
	
	my $group = $c->owned_row('PgDB::Group', $grp_id);
	$c->detach('/default') unless $group;
	
	my $members = $c->model('PgDB::Src')->search( 
							{ 
								customer		=>	$c->user->customer->id,
								'src_groups.grp' => $grp_id,
							},
							{ 
								join => 'src_groups',
								order_by => [qw/ value src_type /],
								page	=> $page,
                                rows	=> 500,
							}
					);
	
	my @member_arr;
	
	foreach my $member ($members->all) {
		my %member_hash;
		$c->log->debug("SRC: " . $grp_id . "," . $member->id . "," . $member->customer->id . ", " . $member->value . "," . $member->src_type->type);
		$member_hash{id} 	= $member->id;
		$member_hash{value} = $member->value;
		$member_hash{description} = $member->description;
		$member_hash{type} 	= uc($member->src_type->type);
		
		push @member_arr, \%member_hash;
	}
	
	$c->stash->{add_submit_url_ip} = $c->uri_for('addmemberip', $grp_id);
	$c->stash->{add_submit_url_iprange} = $c->uri_for('addmemberiprange', $grp_id);
	$c->stash->{add_submit_url_network} = $c->uri_for('addmembernet', $grp_id);
	$c->stash->{add_submit_url_user} = $c->uri_for('addmemberuser', $grp_id);
	$c->stash->{group}			= \%{$group};
	$c->stash->{member_list} 	= \@member_arr;
	$c->stash->{pager}			= $members->pager;
	$c->stash->{template} 		= 'viewsourcegrp.tt2';
	
	$c->forward( $c->view() );
	
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');
}

sub addmembernet :Chained('base') :PathPart('addmembernet') :Args(1){
	my ($self, $c, $grp ) = @_;

	unless ($c->owned_row('PgDB::Group', $grp)) {
		$c->flash->{error_msg} = "Group not found.";
		$c->res->redirect($c->uri_for('list'));
		$c->detach;
	}
	
	my $type = 4;
	my $network = $c->request->params->{network} || "";
	my $prefix  = $c->request->params->{prefix} || "";
	my $description = $c->request->params->{netmemdesc} || "";
	
	my $value = $network . "/" . $prefix;
	
	my $addr = NetAddr::IP->new( $value );
	
	
	## Check if value is a valid SUBNET
	
	if ( $addr ) {
		$c->log->debug("ADDMEMBERNET: $value / $addr is a NETWORK");
		# Add to Src
		my $src = $c->model('PgDB::Src')->create ({
						value		=>	$value,
						src_type	=>	$type,
						description =>  $description,
						customer	=>	$c->user->customer->id
					});
					
		# Link to the Grp via SrcGroup
		$src->add_to_src_groups({
					grp	=>	$grp
				});
		
		my $range = $addr->first() . "-" . $addr->last();
		
		$c->flash->{status_msg} = "Network $value ( $range ) added successfully.";
	
	}
	else {
		$c->log->debug("ADDMEMBERNET: $value / $addr is not a NETWORK");
		
		$c->flash->{error_msg} = "$value is not a valid Network.";
	}
	
	$c->log->debug("ADDMEMBERNET: Got values " . $grp . "," . $type . "," . $value);
	
	#$c->flash_to_stash;
	
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;

}

sub editmember :Chained('base') :PathPart('editmember') :Args(2){
	my ($self, $c, $src, $grp) = @_;
	
	$c->log->debug("EDITMEM: Args: " . $src . "," . $grp);
	
	my $group = $c->owned_row('PgDB::Group', $grp);
	my $member = $c->owned_row('PgDB::Src', $src);
	$c->detach('/default') unless $group && $member;
	my $type = $member->src_type->type;
	
	if ( $type == "ip" ) {
		$c->log->debug("EDITMEM: Type:" . $type );
		my $value = $c->request->params->{editmemvalue} || "";
		my $description = $c->request->params->{editmemdesc} || "";
	}
	
	$c->stash->{type}			= $type;
	$c->stash->{member}			= \%{$member};
	$c->stash->{group}			= \%{$group};
	$c->stash->{template} 		= 'edit-src-member.tt2';
	
	$c->forward( $c->view() );
}

sub editmember_submit :Chained('base') :PathPart('editmember_submit') :Args(2){
	my ($self, $c, $src, $grp) = @_;

	my $value = $c->request->params->{value};
	my $description = $c->request->params->{desc};
	
	my $member = $c->owned_row('PgDB::Src', $src);
	
	if ($member) {
		$c->log->debug("EDITMEMSUBMIT: Member found " . $member->value);
		$member->update( { description => $description } );
		$c->flash->{status_msg} = "Member updated successfully.";
	}
	else {
		$c->flash->{status_msg} = "Member with ID $src not found.";
	}
	
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;
}

sub addmemberip :Chained('base') :PathPart('addmemberip') :Args(1){
	my ($self, $c, $grp ) = @_;

	unless ($c->owned_row('PgDB::Group', $grp)) {
		$c->flash->{error_msg} = "Group not found.";
		$c->res->redirect($c->uri_for('list'));
		$c->detach;
	}
	
	my $type = $c->request->params->{membertype} || "";
	my $value = $c->request->params->{membervalue} || "";
	my $description = $c->request->params->{ipmemdesc} || "";
	
	
	## Check if value is a valid IP
	
	if (is_ipv4($value)) {
		$c->log->debug("ADDMEMBERIP: Value is an IP");
		# Add to Src
		my $src = $c->model('PgDB::Src')->create ({
						value		=>	$value,
						src_type	=>	$type,
						description	=>	$description,
						customer	=>	$c->user->customer->id
					});
					
		# Link to the Grp via SrcGroup
		$src->add_to_src_groups({
					grp	=>	$grp
				});
		
		$c->flash->{status_msg} = "$value added successfully.";
	
	}
	else {
		$c->log->debug("ADDMEMBERIP: Value is not an IP");
		
		$c->flash->{error_msg} = "$value is not a valid IP address.";
	}
	
	$c->log->debug("ADDMEMBERIP: Got values " . $grp . "," . $type . "," . $value);
	
	#$c->flash_to_stash;
	
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;

}

sub delmember :Chained('base') :PathPart('delmember') :Args(2){
	my ( $self, $c, $src, $grp ) = @_;
	$c->require_post;

	
	$c->log->debug("DELMEM: Args: " . $src . "," . $grp);
	
	my $obj = $c->owned_row('PgDB::Src', $src);
	unless ($obj) {
		$c->flash->{error_msg} = "Member not found.";
		$c->res->redirect($c->uri_for('listmembers', $grp));
		$c->detach;
	}
	my $value = $obj->value;
	my $rv = $obj->delete();
	
	if ($rv) {
		$c->flash->{status_msg} = "Member $value deleted from group sucessfully.";
	}
	
	$c->log->debug("DELMEM: RV" . $rv);
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');
		
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;
	
}
#sub root :Chained('base') :PathPart('') :Args(0) {}

=encoding utf8

=head1 AUTHOR

Unmukti Technology Pvt Ltd,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
