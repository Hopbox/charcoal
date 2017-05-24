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

sub base :Chained('/admin/index') :PathPart('destinationgroups') :CaptureArgs(0) {}

sub list :Chained('base') :PathPart('list') :Args(0) {

	my ( $self, $c ) = @_;
	
	my $page = $c->request->params->{page};
	$page = 1 if ( ( $page !~ /^\d+$/ ) or ( !$page ) );
	
	my $dstgroups = $c->model('PgDB::Category')->search({
						customer => $c->user->customer->id,
						},
						{
							page => $page,
							rows => 15,
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
	
	my $obj = $c->model('PgDB::Category')->find($grp);
	
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
	
	my $obj = $c->model('PgDB::CDomain')->find($dst);
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
	
	my $group = $c->model('PgDB::Category')->find( $gid );
	
	my $destinations = $c->model('PgDB::CDomain')->search({ 
						customer => $c->user->customer->id,
						'c_dom_cats.category' => $gid,
						},
						{
                            join => 'c_dom_cats',
                            order_by => { -asc => 'domain' },
							page	=> $page,
							rows	=> 15,
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
							rows => 15,
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
