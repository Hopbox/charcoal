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
	
        $c->flash->{error_msg} = "There was an error adding the Destinati Group $groupname.";
	
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
		$c->log->debug("DELCAT: Deleting member " . $member->value); 
		$member->delete();
	}
	## Delete the group
	
	my $obj = $c->model('PgDB::Category')->find($grp);
	
	$c->log->debug("DELCAT: Deleting group " . $obj->name);
	
	$obj->delete();
	
	#$c->response->body('Matched Charcoal::Controller::Admin::SourceGroups in Admin::SourceGroups.');	
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}


sub add :Chained('base') :PathPart('add') :Args(0) {

	my ( $self, $c ) = @_;
	my $domain = $c->request->params->{domain};
	
	$c->log->debug("ADDDOMAIN: Attempting to add domain " . $domain);
	
	$domain = $c->model('PgDB::CDomain')->create ({
				domain		=>	$domain,
				customer	=>	$c->user->customer->id,
			});
	
	$c->log->debug("ADDDOMAIN: Addition returned id " . $domain->id);
			
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub listmembers :Chained('base') :PathPart('group') :Args(1) {
    my ($self, $c, $gid) = @_;

   	my $page = $c->request->params->{page};
	$page = 1 if ( ( $page !~ /^\d+$/ ) or (!$page) );
	
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
