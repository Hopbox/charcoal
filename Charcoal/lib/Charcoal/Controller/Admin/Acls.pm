package Charcoal::Controller::Admin::Acls;
use Moose;
use namespace::autoclean;

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

sub reorder :Chained('base') :PathPart('reorder') :Args(0) {

    my ($self, $c) = @_;
    
    my $acl = $c->request->params->{acl} || "";
    my $move = $c->request->params->{move} || "";
    
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
        $acl_hash{edit_url} = $c->uri_for('edit', $acl_hash{id});
        $acl_hash{delete_url} = $c->uri_for('delete', $acl_hash{id});
        push @acl_arr, \%acl_hash;
	}
	
	$c->stash->{acl_list} = \@acl_arr;
	$c->stash->{pager} = $acls->pager;
	$c->stash->{template} = 'acls.tt2';
	

	$c->forward( $c->view());
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
    
    my @all_src_grp_arr;
    
    foreach my $all_src_grp (@all_src_grps) {
		my %all_src_grp_hash;
		
		$c->log->debug("ALL SRC GRP: " . $all_src_grp->id . "," . $all_src_grp->name);
		
		$all_src_grp_hash{id}	= $all_src_grp->id;
		$all_src_grp_hash{name} = $all_src_grp->name;
		push @all_src_grp_arr, \%all_src_hash;
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
	$c->forward( $c->view());

}

sub create :Chained('base') :PathPart('create') :Args(0){
}

sub delete :Chained('base') :PathPart('delete') :Args(1){

	my ($self, $c, $acl_id) = @_;
	
	# Query the object and then delete
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
