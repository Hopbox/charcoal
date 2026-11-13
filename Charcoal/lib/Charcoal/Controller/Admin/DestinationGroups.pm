package Charcoal::Controller::Admin::DestinationGroups;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::Destinations - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/admin/index') :PathPart('destinationgroups') :CaptureArgs(0) {
	my ($self, $c) = @_;

	# Customer 1 owns the global categories. These pages manage only
	# customer categories (c_domains / c_dom_cat). Global categories use
	# other tables (domains / gl_dom_cat), and their "in use" check must
	# look at the ACLs of all customers. Block customer 1 until that
	# feature exists.
	if ($c->user->customer->id == 1) {
		$c->res->status(403);
		$c->res->body('Forbidden: global categories cannot be managed here.');
		$c->detach;
	}
}

sub list :Chained('base') :PathPart('list') :Args(0) {

	my ( $self, $c ) = @_;
	
	my $page = $c->request->params->{page};
	$page = 1 if ( ( $page !~ /^\d+$/ ) or ( !$page ) );
	
	my $dstgroups = $c->model('PgDB::Category')->search({
						customer => $c->user->customer->id,
						},
						{
							page => $page,
							rows => 200,
							order_by => { -asc => 'category' }
						},
						);
						
    $c->stash->{add_submit_url} = $c->uri_for('addgroup');
	$c->stash->{dstgroups}	= [ $dstgroups->all ];
	$c->stash->{pager}		=  $dstgroups->pager;
	$c->stash->{template}	= 'dstgroups.tt2';
   # $c->response->body('Matched Charcoal::Controller::Admin::Destinations in Admin::Destinations.');
}

sub addgroup :Chained('base') :PathPart('addgroup') :Args(0){
	my ( $self, $c ) = @_;
	
	my $groupname = $c->request->params->{groupname};
	my $groupdesc = $c->request->params->{groupdesc} || "No Description";
	
	$c->log->debug("ADDCAT: Attempting to add category " . $groupname);
	
	my $category = $c->model('PgDB::Category')->create ({
				category		=>	$groupname,
				description => $groupdesc,
				customer	=>	$c->user->customer->id,
			});
	
	if ($category){
	
        $c->log->debug("ADDCAT: Addition returned id " . $category->id);
        $c->flash->{status_msg} = "Destination Group $groupname ($groupdesc) added successfully.";
	}
	
	else {
	
        $c->flash->{error_msg} = "There was an error adding the Destination Group $groupname.";
	
	}
	
			
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub delgroup :Chained('base') :PathPart('delgroup') :Args(1){
	my ( $self, $c, $grp ) = @_;
	
	my $obj = $c->owned_row('PgDB::Category', $grp);
	unless ($obj) {
		$c->flash->{error_msg} = "Destination group not found.";
		$c->res->redirect($c->uri_for('list'));
		$c->detach;
	}
	
	my $grp_name = $obj->category;
	
	## Find if group is being in an ACL. If yes, then show error.
	
	my @using_acls = $c->model('PgDB::ACL')->search( 
                                    {
                                      -and => [
                                        customer => $c->user->customer->id, 
                                        \[ q{acl::jsonb#>'{dst}' \\?| array[?]}, $grp ],
                                      ],
                                     },   
                                    );
	
	if (@using_acls) {
        
        $c->flash->{error_msg} = "<b>$grp_name</b> is in use. First delete it from following the following ACLs:<br/>";
        
        foreach my $acl (@using_acls) {
            my $acl_name = JSON::XS->new->utf8->allow_nonref->decode($acl->acl)->{desc};
            
            $c->flash->{error_msg} .= "<b>* " . $acl_name . "</b><br>";
            
            $c->log->debug("USING ACLS: " . $acl_name);
        }
    
        $c->res->redirect($c->uri_for('list'));
        $c->detach;
    
    }
    
		
	## Find all the Src objects associated with this group
	my @members = $c->model('PgDB::CDomain')->search( 
							{ 
								customer		=>	$c->user->customer->id,
								'c_dom_cats.category' => $grp,
							},
							{ 
								join => 'c_dom_cats' 
							}
					);
	## Delete those objects
	foreach my $member (@members){
		$c->log->debug("DELCAT: Deleting member " . $member->domain); 
		$member->delete();
	}
	## Delete the group
	
	$c->log->debug("DELCAT: Deleting group " . $obj->category);
	
	my $rv = $obj->delete();
	
	if ($rv) {
		$c->flash->{status_msg} = "Destination Group deleted sucessfully.";
	}
	
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');	
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}


sub addmember :Chained('base') :PathPart('addmember') :Args(1) {

	my ( $self, $c, $category ) = @_;

	unless ($c->owned_row('PgDB::Category', $category)) {
		$c->flash->{error_msg} = "Destination group not found.";
		$c->res->redirect($c->uri_for('list'));
		$c->detach;
	}
	my $domain = $c->request->parameters->{membervalue};
	
	$c->log->debug("ADDDOMAIN: Attempting to add domain " . $domain);
	
	my $dom = $c->model('PgDB::CDomain')->create ({
				domain		=>	$domain,
				customer	=>	$c->user->customer->id,
			});
	
	$c->log->debug("ADDDOMAIN: Addition returned id " . $dom->id);
	
	$dom->add_to_c_dom_cats({
                    category => $category
                            });
			
    $c->flash->{status_msg} = "$domain added successfully.";
	$c->res->redirect($c->uri_for('listmembers', $category));
	$c->detach;
}

sub delmember :Chained('base') :PathPart('delmember') :Args(2){
	my ( $self, $c, $dst, $grp ) = @_;
	
	$c->log->debug("DELMEM: Args: " . $dst . "," . $grp);
	
	my $obj = $c->owned_row('PgDB::CDomain', $dst);
	unless ($obj) {
		$c->flash->{error_msg} = "Domain not found.";
		$c->res->redirect($c->uri_for('listmembers', $grp));
		$c->detach;
	}
	my $value = $obj->domain;
	my $rv = $obj->delete();
	
	if ($rv) {
		$c->flash->{status_msg} = "Member $value deleted from group sucessfully.";
	}
	
	$c->log->debug("DELMEM: RV" . $rv);
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');
		
	$c->res->redirect($c->uri_for('listmembers', $grp));
	$c->detach;
	
}

sub listmembers :Chained('base') :PathPart('listmembers') :Args(1) {
    my ($self, $c, $gid) = @_;

   	my $page = $c->request->params->{page};
	$page = 1 if ( ( $page !~ /^\d+$/ ) or (!$page) );
	
	my $group = $c->owned_row('PgDB::Category', $gid);
	$c->detach('/default') unless $group;
	
	my $destinations = $c->model('PgDB::CDomain')->search({ 
						customer => $c->user->customer->id,
						'c_dom_cats.category' => $gid,
						},
						{
                            join => 'c_dom_cats',
                            order_by => { -asc => 'domain' },
							page	=> $page,
							rows	=> 500,
						},
						);
						
    $c->stash->{add_submit_url_dst} = $c->uri_for('addmember', $group->id);
    $c->stash->{group} = \%{$group};
	$c->stash->{destinations} 	= 	[ $destinations->all ];
	$c->stash->{pager}			=	$destinations->pager;
	$c->stash->{template} 		= 	'destinations.tt2';
	
    $c->forward( $c->view() );
   


    }
    
sub list_grp :Chained('base') :PathPart('groups/list') :Args(0) {
	my ($self, $c) = @_;
	
	my $page = $c->request->params->{page};
	$page = 1 if ( ( $page !~ /^\d+$/ ) or ( !$page ) );
	
	my $dstgroups = $c->model('PgDB::Category')->search({
						customer => $c->user->customer->id,
						},
						{
							page => $page,
							rows => 200,
							order_by => { -asc => 'category' }
						},
						);
	$c->stash->{dstgroups}	= [ $dstgroups->all ];
	$c->stash->{pager}		=  $dstgroups->pager;
	$c->stash->{template}	= 'dstgroups.tt2';
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
