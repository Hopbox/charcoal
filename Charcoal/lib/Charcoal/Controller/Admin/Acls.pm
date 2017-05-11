package Charcoal::Controller::Admin::Acls;
use Moose;
use namespace::autoclean;

use Data::Dumper;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Charcoal::Controller::Admin::Acls - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/admin/index') :PathPart('acls') :CaptureArgs(0) {}

sub moveup :Chained('base') :PathPart('moveup') :Args(1) {
    
    my ( $self, $c, $acl_id ) = @_;

    ## Find the rule above this and swap SEQ
    
    my $this_acl = $c->model('PgDB::ACL')->find( {customer => $c->user->customer->id, id => $acl_id });
    my $this_seq = $this_acl->seq;
    
    my $oneup = $c->model('PgDB::ACL')->search( { customer => $c->user->customer->id,
                                                  seq   => { '<' => $this_seq },
                                                    },
                                                {
                                                    
                                                    order_by => { -desc => 'seq' },
                                                    rows     => 1,
                                                },
                                            )->single;
    
    if ($oneup){
        my $oneup_seq = $oneup->seq;
        $oneup->update( {'seq' => $this_seq} );
        $this_acl->update( {'seq' => $oneup_seq} );
        $c->flash->{status_msg} = "ACLs reordered successfully.";
    }
    
    $c->res->redirect($c->uri_for('list'));
    $c->detach;
}

sub movedown :Chained('base') :PathPart('movedown') :Args(1) {

    my ( $self, $c, $acl_id ) = @_;

    ## Find the rule below this and swap SEQ
    
    my $this_acl = $c->model('PgDB::ACL')->find( {customer => $c->user->customer->id, id => $acl_id });
    my $this_seq = $this_acl->seq;
    
    my $onedown = $c->model('PgDB::ACL')->search( { customer => $c->user->customer->id,
                                                  seq   => { '>' => $this_seq },
                                                    },
                                                {
                                                    
                                                    order_by => { -asc => 'seq' },
                                                    rows     => 1,
                                                },
                                            )->single;
    
    if ($onedown){
        my $onedown_seq = $onedown->seq;
        $onedown->update( {'seq' => $this_seq} );
        $this_acl->update( {'seq' => $onedown_seq} );
        $c->flash->{status_msg} = "ACLs reordered successfully.";
    }
    $c->res->redirect($c->uri_for('list'));
	$c->detach;

}

sub list :Chained('base') :PathPart('list') :Args(0) {
    my ( $self, $c ) = @_;

	my $page = $c->request->params->{page} || "";
	$page = 1 if ( ( $page !~ /^\d+$/ ) or ( !$page ) );

    my $acls = $c->model('PgDB::Acl')->search( { customer => $c->user->customer->id }, 
														{ 
															page	=> $page,
															rows	=> 15,
															order_by => { -asc => 'seq' } 
															
														},
														
														);
    my ($acl_seq, $acl_acl, $acl_id);

    my (@acl_arr);
	use Data::Dumper;
	
    foreach my $acl ( $acls->all ) {
        $c->log->debug("ACL: " . $acl->id . "," . $acl->customer->id . ", " . $acl->seq . ", " . $acl->acl);
        my $acl_json = JSON::XS->new->utf8->allow_nonref->decode($acl->acl);
        my %acl_hash;
        $acl_hash{id} = $acl->id;
        $acl_hash{seq} = $acl->seq;
        
        ## Get SRC names and populate the HASH
        my $src_string;
        my @src_array;
        foreach my $src ( @{$acl_json->{'src'}} ){
			$c->log->debug("SRC: " . $src);
			if ( $src == 0 ){
				$src = "ALL";
				$src_string .= "$src, ";
				push @src_array, $src;
			}
			else {
				my $src_grp = $c->model('PgDB::Group')->find($src)->name;
				$c->log->debug("SRCGRP: " . $src_grp);
				$src_string .= "$src_grp, ";
				push @src_array, $src_grp;
			}
			$src_string =~ s/(.*)(\,\s)$/$1/;
		}
        $acl_hash{src} = $src_string;
        $acl_hash{src_array} = \@src_array;
        
        ## GET DST names and populate the HASH
        my $dst_string;
        my @dst_array;
        foreach my $dst ( @{$acl_json->{'dst'}} ){
			$c->log->debug("DST: " . $dst);
			if ( $dst == 0 ){
				$dst = "ALL";
				$dst_string .= "$dst, ";
				push @dst_array, $dst;
			}
			else {
				my $dst_cat = $c->model('PgDB::Category')->find($dst)->category;
				$c->log->debug("DSTCAT: " . $dst_cat);
				$dst_string .= "$dst_cat, ";
				push @dst_array, $dst_cat;
			}
		}
		$dst_string =~ s/^(.*)(,\s+)$/$1/;
        $acl_hash{dst} = $dst_string;
        $acl_hash{dst_array} = \@dst_array;
        
        ## GET TIMES names and populate the HASH
        my $times_string;
        foreach my $time ( @{$acl_json->{'times'}} ){
			$c->log->debug("TIME: " . $time);
			if ( $time == 0 ){
				$time = "ALL";
				$times_string .= "$time, ";
			}
		}
		$times_string =~ s/^(.*)(,\s+)$/$1/;
        $acl_hash{times} = $times_string;
        
        $acl_hash{access} = $acl_json->{'access'};
        $acl_hash{desc} = $acl_json->{'desc'};
        $acl_hash{moveup_url} = $c->uri_for('moveup', $acl_hash{id});
        $acl_hash{movedown_url} = $c->uri_for('movedown', $acl_hash{id});
        $acl_hash{edit_url} = $c->uri_for('edit', $acl_hash{id});
        $acl_hash{delete_url} = $c->uri_for('delete', $acl_hash{id});
        push @acl_arr, \%acl_hash;
	}
	$c->stash->{create_url} = $c->uri_for('create');
	$c->stash->{acl_list} = \@acl_arr;
	$c->stash->{pager} = $acls->pager;
	$c->stash->{template} = 'acls.tt2';
	

	$c->forward( $c->view());
}

sub create :Chained('base') :PathPart('create') :Args(0){

    my ($self, $c, $acl_id) = @_;
	
	my $cust_id = $c->user->customer->id;
	
	## Get all the CUSTOMER SRC & DST groups
	
	my (%all_src_hash, %acl_hash);
    
    my @all_src_grps = $c->model('PgDB::Group')->search({ 
						customer => $c->user->customer->id 
						},
						{ 
							order_by => { -asc => 'name' } 
						});
    
        
    foreach my $all_src_grp (@all_src_grps) {
		
		
		$c->log->debug("ALL SRC GRP: " . $all_src_grp->id . "," . $all_src_grp->name);
		
		$all_src_hash{$all_src_grp->id}	= $all_src_grp->name; 
		
    }
    
 
        
    $acl_hash{all_src_hash} = \%all_src_hash;
    
    my $all_cats = $c->model('PgDB::Category')->search(
                                                    {
                                                        customer => [ 1, $c->user->customer->id ] ,
                                                    },
                                                    {
                                                        order_by => { -asc => 'category' }
                                                    });
    my %all_dst_hash;                                            
    foreach my $cat ($all_cats->all){
        $c->log->debug("CUSTDST: " . $cat->id . $cat->category);
        $all_dst_hash{$cat->id} = $cat->category;
    }
    
    $acl_hash{all_dst_hash} = \%all_dst_hash;
	
	## Global DST groups

    $c->stash->{acl} = \%acl_hash;
	$c->stash->{submit_create_acl} = $c->uri_for('create_submit');
	$c->stash->{template} = 'create-acl.tt2';
	$c->forward( $c->view());

}

sub create_submit :Chained('base') :PathPart('create_submit'): Args(0){
	
	my ($self, $c) = @_;
	
	my $cust_id = $c->user->customer->id;
	
	my $acl_desc = $c->req->params->{desc} || "No Description";
	my $acl_access = $c->req->params->{access} || "";;
	my $acl_src_all = $c->req->params->{src_all} || "";
    my @acl_src = map { ref $_ ? @$_ : defined $_ ? $_:() } $c->req->params->{src} || "0";
    my $acl_dst_all = $c->req->params->{dst_all} || "";
    my @acl_dst = map { ref $_ ? @$_ : defined $_ ? $_:() } $c->req->params->{dst} || "0";
    my @acl_times = map { ref $_ ? @$_ : defined $_ ? $_:() } $c->req->params->{times} || "0";
    
    @acl_src = "0" if ($acl_src_all);
    @acl_dst = "0" if ($acl_dst_all);
    @acl_times = "0";
	
	$c->log->debug("CREATE-SUBMIT ACL: acl_desc = " . $acl_desc . " CUST ID: " . $cust_id);
	
	# Populate the ACL hash to show
	                                    
    my %for_acl;
    
    $for_acl{src} = \@acl_src;
    $for_acl{dst} = \@acl_dst;
    $for_acl{desc} = $acl_desc;
    $for_acl{access} = $acl_access;
    $for_acl{times} = \@acl_times;
    
    my $acl_json = JSON::XS->new->utf8->allow_nonref->encode(\%for_acl);
    
#    my %acl_db_json;
#    $acl_db_json{acl} = $acl_json;
#    
#    my $acl = $c->model('PgDB::ACL')->new();
#    
#    my $result = $acl->update(\%acl_db_json);
#    
#    if ($result == -1){
#        $c->flash->{error_msg} = "ACL $acl_desc could not be created.";
#    }
#    else {
#        $c->flash->{status_msg} = "ACL $acl_desc created successfully.";
#    }
#    
    
    $c->log->debug("CREATE-SUBMIT ACL JSON: " . $acl_json);
    
    ### GET ALL THE ACLs for customer ordered by SEQ. Start new sequence from 2 and create new ACL with SEQ 1.
    
    my $existing_acls = $c->model('PgDB::ACL')->search( { customer => $cust_id }, { order_by => { -asc => 'seq' } } );
    
    
    my $index = 2;
    
    foreach my $existing_acl ($existing_acls->all){
        $c->log->debug("EXISTING ACL: SEQ: " . $existing_acl->seq . " ID: " . $existing_acl->id);
        
        my $result = $existing_acl->update( { seq => $index } );
        
        if ($result == -1){
            $c->flash->{error_msg} = "ACL $acl_desc could not be created.";
            $c->res->redirect($c->uri_for('list'));
            $c->detach;
        }
        
        
        $index++;
    }
    
    my %new_acl;
    
    
    $new_acl{customer} = $cust_id;
    $new_acl{seq} = 1;
    $new_acl{acl} = $acl_json;
    
    $c->log->debug("CREATE-SUBMIT ACL: Creating NEW ACL: SEQ " . $new_acl{seq} . " CUST: " . $new_acl{customer} );
    $c->log->debug("CREATE-SUBMIT ACL: Creating NEW ACL: ACL " . $new_acl{acl});
    
    
    
    my $result = $c->model('PgDB::ACL')->create(\%new_acl);
    
    if ($result == -1){
        $c->flash->{error_msg} = "ACL $acl_desc could not be created.";
    }
    else {
        $c->flash->{status_msg} = "ACL $acl_desc created successfully.";
    }
    
    $c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub edit :Chained('base') :PathPart('edit') :Args(1){

	my ($self, $c, $acl_id) = @_;
	
	my $cust_id = $c->user->customer->id;
	
	$c->log->debug("EDIT ACL: acl_id = " . $acl_id . " CUST ID: " . $cust_id);
	
	# Populate the ACL hash to show
	my $acl = $c->model('PgDB::ACL')->find(
                                            {
                                                customer => $c->user->customer->id,
                                                id       => $acl_id,
                                            },
                                        );
	
	# get ACL, all the src, dst with selected ones chosen
    my ($acl_seq, $acl_acl, $acl_id);

    my (@acl_arr);
	
    $c->log->debug("ACL: " . $acl->id . "," . $acl->customer->id . ", " . $acl->seq . ", " . $acl->acl);
    my $acl_json = JSON::XS->new->utf8->allow_nonref->decode($acl->acl);
    my %acl_hash;
    $acl_hash{id} = $acl->id;
    $acl_hash{seq} = $acl->seq;
    
       
    ## GET all the SRC and populate the HASH
    
    my %all_src_hash;
    
    my @all_src_grps = $c->model('PgDB::Group')->search({ 
						customer => $c->user->customer->id 
						},
						{ 
							order_by => { -asc => 'name' } 
						});
    
        
    foreach my $all_src_grp (@all_src_grps) {
		
		
		$c->log->debug("ALL SRC GRP: " . $all_src_grp->id . "," . $all_src_grp->name);
		
		$all_src_hash{$all_src_grp->id}	= $all_src_grp->name; 
		
    }
    
    
    
    ## Get SRC names and populate the HASH
    my $src_string;
    my @src_array;
    my %src_hash_selected;
    
    foreach my $src ( @{$acl_json->{'src'}} ){
        $c->log->debug("SRC: " . $src);
        if ( $src == 0 ){
			$src = "ALL";
			$src_string .= "$src, ";
			push @src_array, $src;
			$src_hash_selected{0} = "ALL";
        }
		else {
				my $src_grp = $c->model('PgDB::Group')->find($src)->name;
				$c->log->debug("SRCGRP: " . $src_grp);
				$src_string .= "$src_grp, ";
				push @src_array, $src_grp;
				$src_hash_selected{$src} = $src_grp;
				delete $all_src_hash{$src};
        }
        
        $src_string =~ s/(.*)(\,\s)$/$1/;
    }
        
    $acl_hash{src} = $src_string;
    $acl_hash{src_array} = \@src_array;
    $acl_hash{src_hash_selected} = \%src_hash_selected;
    $acl_hash{all_src_hash} = \%all_src_hash;
    
    ## GET all the DST and populate the HASH
    
    my $all_cats = $c->model('PgDB::Category')->search(
                                                    {
                                                        customer => [ 1, $c->user->customer->id ],
                                                    },
                                                );
    my %all_dst_hash;                                            
    foreach my $cat ($all_cats->all){
        $c->log->debug("ALLDST: " . $cat->id . $cat->category);
        $all_dst_hash{$cat->id} = $cat->category;
    }
    
    ## DELETE already selected DST from the list
    ## While
    ## GETting DST names and populate the HASH
    
    my $dst_string;
    my @dst_array;
    my %dst_hash_selected;
        
    foreach my $dst ( @{$acl_json->{'dst'}} ){
		$c->log->debug("DST: " . $dst);
		if ( $dst == 0 ){
			$dst = "ALL";
			$dst_string .= "$dst, ";
			push @dst_array, $dst;
			$dst_hash_selected{0} = "ALL";
		}
        else {
            my $dst_cat = $c->model('PgDB::Category')->find($dst)->category;
            $c->log->debug("DSTCAT: " . $dst_cat);
            $dst_string .= "$dst_cat, ";
            push @dst_array, $dst_cat;
            $dst_hash_selected{$dst} = $dst_cat;
            delete $all_dst_hash{$dst};
        }
    }
    
    $dst_string =~ s/^(.*)(,\s+)$/$1/;
    $acl_hash{dst} = $dst_string;
    $acl_hash{dst_array} = \@dst_array;
    $acl_hash{dst_hash_selected} = \%dst_hash_selected;
    $acl_hash{all_dst_hash} = \%all_dst_hash;
        
    ## GET TIMES names and populate the HASH
    my $times_string;
    my %times_hash_selected;
        
    foreach my $time ( @{$acl_json->{'times'}} ){
		$c->log->debug("TIME: " . $time);
		if ( $time == 0 ){
			$time = "ALL";
            $times_string .= "$time, ";
            $times_hash_selected{0} = "ALL";
            
		}
    }
	
	$times_string =~ s/^(.*)(,\s+)$/$1/;
    $acl_hash{times} = $times_string;
    $acl_hash{times_hash_selected} = \%times_hash_selected;
        
    $acl_hash{access} = $acl_json->{'access'};
    $acl_hash{desc} = $acl_json->{'desc'};
        
    $c->stash->{acl} = \%acl_hash;
	
	$c->stash->{template} = 'edit-acls.tt2';
	$c->stash->{submit_edit_acl} = $c->uri_for('edit_submit');
	$c->forward( $c->view());

}

sub edit_submit :Chained('base') :PathPart('edit_submit') :Args(0){

	my ($self, $c) = @_;
	
	my $cust_id = $c->user->customer->id;
	my $acl_id = $c->req->params->{id} || "";
	my $acl_desc = $c->req->params->{desc} || "No Description";
	my $acl_access = $c->req->params->{access} || "";;
	my $acl_src_all = $c->req->params->{src_all} || "";
    my @acl_src = map { ref $_ ? @$_ : defined $_ ? $_:() } $c->req->params->{src} || "0";
    my $acl_dst_all = $c->req->params->{dst_all} || "";
    my @acl_dst = map { ref $_ ? @$_ : defined $_ ? $_:() } $c->req->params->{dst} || "0";
    my @acl_times = map { ref $_ ? @$_ : defined $_ ? $_:() } $c->req->params->{times} || "0";
    
    @acl_src = "0" if ($acl_src_all);
    @acl_dst = "0" if ($acl_dst_all);
    @acl_times = "0";
	
	$c->log->debug("EDIT-SUBMIT ACL: acl_id = " . $acl_id . " CUST ID: " . $cust_id);
	
#	$c->log->debug("EDIT-SUBMIT ACL: src = " . @$acl_src .  $acl_src_all . " dst = " . @$acl_dst . $acl_dst_all);
	
	# Populate the ACL hash to show
	my $acl = $c->model('PgDB::ACL')->find(
                                            {
                                                customer => $c->user->customer->id,
                                                id       => $acl_id,
                                            },
                                        );
                                        
    my %for_acl;
    
    $for_acl{src} = \@acl_src;
    $for_acl{dst} = \@acl_dst;
    $for_acl{desc} = $acl_desc;
    $for_acl{access} = $acl_access;
    $for_acl{times} = \@acl_times;
    
    my $acl_json = JSON::XS->new->utf8->allow_nonref->encode(\%for_acl);
    
    my %acl_db_json;
    $acl_db_json{acl} = $acl_json;
    
    my $result = $acl->update(\%acl_db_json);
    
    if ($result == -1){
        $c->flash->{error_msg} = "ACL $acl_desc could not be updated.";
    }
    else {
        $c->flash->{status_msg} = "ACL $acl_desc updated successfully.";
    }
    
    
    $c->log->debug("EDIT-SUBMIT ACL JSON: " . $acl_json);
    
    $c->res->redirect($c->uri_for('list'));
	$c->detach;
}

sub delete :Chained('base') :PathPart('delete') :Args(1){

	my ($self, $c, $acl_id) = @_;
	
	# Query the object and then delete
	my $acl = $c->model('PgDB::ACL')->find(
                                            {
                                                customer => $c->user->customer->id,
                                                id       => $acl_id,
                                            },
                                        );
                                        
    my $result = $acl->delete;
    
    if ($result == -1){
        $c->flash->{error_msg} = "ACL could not be deleted.";
    }
    else {
        $c->flash->{status_msg} = "ACL deleted successfully.";
    }
    
    
	
	$c->res->redirect($c->uri_for('list'));
	$c->detach;
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
