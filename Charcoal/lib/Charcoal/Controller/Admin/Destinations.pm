package Charcoal::Controller::Admin::Destinations;
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

sub base :Chained('/admin/index') :PathPart('destinations') :CaptureArgs(0) {}

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

sub list :Chained('base') :PathPart('list') :Args(0) {
    
    my ( $self, $c ) = @_;

	my $page = $c->request->params->{page};
	$page = 1 if ( ( $page !~ /^\d+$/ ) or (!$page) );
	
	my $destinations = $c->model('PgDB::CDomain')->search({ 
						customer => $c->user->customer->id,
						},
						{
							page	=> $page,
							rows	=> 10,
							order_by => { -asc => 'domain' }
						},
						);
						
	$c->stash->{destinations} 	= 	[ $destinations->all ];
	$c->stash->{pager}			=	$destinations->pager;
	$c->stash->{template} 		= 	'destinations.tt2';
	
    $c->forward( $c->view() );
   
   # $c->response->body('Matched Charcoal::Controller::Admin::Destinations in Admin::Destinations.');
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
							rows => 10,
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
