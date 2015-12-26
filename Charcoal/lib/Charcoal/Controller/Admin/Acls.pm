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

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    my @acls = $c->model('PgDB::Acl')->search( { customer => $c->user->customer->id }, { order_by => { -asc => 'seq' } } );
    my ($acl_seq, $acl_acl, $acl_id);

    my (@acl_arr);
	use Data::Dumper;
	
    foreach my $acl (@acls) {
        $c->log->debug("ACL: " . $acl->id . "," . $acl->customer->id . ", " . $acl->seq . ", " . $acl->acl);
        my $acl_json = JSON::XS->new->utf8->allow_nonref->decode($acl->acl);
        my %acl_hash;
        $acl_hash{id} = $acl->id;
        $acl_hash{seq} = $acl->seq;
        ## Get SRC names and populate the HASH
        my $src_string;
        foreach my $src ( @{$acl_json->{'src'}} ){
			$c->log->debug("SRC: " . $src);
			if ( $src == 0 ){
				$src = "ALL";
				$src_string .= "$src, ";
			}
			else {
				my $src_grp = $c->model('PgDB::Group')->find($src)->name;
				$c->log->debug("SRCGRP: " . $src_grp);
				$src_string .= "$src_grp, ";
			}
			$src_string =~ s/(.*)(\,\s)$/$1/;
		}
        $acl_hash{src} = $src_string;
        ## GET DST names and populate the HASH
        my $dst_string;
        foreach my $dst ( @{$acl_json->{'dst'}} ){
			$c->log->debug("DST: " . $dst);
			if ( $dst == 0 ){
				$dst = "ALL";
				$dst_string .= "$dst, ";
			}
			else {
				my $dst_cat = $c->model('PgDB::Category')->find($dst)->category;
				$c->log->debug("DSTCAT: " . $dst_cat);
				$dst_string .= "$dst_cat, ";
			}
		}
		$dst_string =~ s/^(.*)(,\s+)$/$1/;
        $acl_hash{dst} = $dst_string;
        
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
        push @acl_arr, \%acl_hash;
	}
	
	$c->stash->{acl_list} = \@acl_arr;
	$c->stash->{template} = 'acls.tt2';
	

	$c->forward( $c->view());

}

sub acl_list_json :Path('json/list') :Args(0) {
    my ( $self, $c ) = @_;

    my @acls = $c->model('PgDB::Acl')->search( { customer => $c->user->customer->id }, { order_by => { -asc => 'seq' } } );
    my ($acl_seq, $acl_acl, $acl_id);

    my (@acl_arr);
	use Data::Dumper;
	
    foreach my $acl (@acls) {
        $c->log->debug("ACL: " . $acl->id . "," . $acl->customer->id . ", " . $acl->seq . ", " . $acl->acl);
        my $acl_json = JSON::XS->new->utf8->allow_nonref->decode($acl->acl);
        my %acl_hash;
        $acl_hash{id} = $acl->id;
        $acl_hash{seq} = $acl->seq;
        ## Get SRC names and populate the HASH
        my $src_string;
        foreach my $src ( @{$acl_json->{'src'}} ){
			$c->log->debug("SRC: " . $src);
			if ( $src == 0 ){
				$src = "ALL";
				$src_string .= "$src, ";
			}
			else {
				my $src_grp = $c->model('PgDB::Group')->find($src)->name;
				$c->log->debug("SRCGRP: " . $src_grp);
				$src_string .= "$src_grp, ";
			}
			$src_string =~ s/(.*)(\,\s)$/$1/;
		}
        $acl_hash{src} = $src_string;
        ## GET DST names and populate the HASH
        my $dst_string;
        foreach my $dst ( @{$acl_json->{'dst'}} ){
			$c->log->debug("DST: " . $dst);
			if ( $dst == 0 ){
				$dst = "ALL";
				$dst_string .= "$dst, ";
			}
			else {
				my $dst_cat = $c->model('PgDB::Category')->find($dst)->category;
				$c->log->debug("DSTCAT: " . $dst_cat);
				$dst_string .= "$dst_cat, ";
			}
		}
		$dst_string =~ s/^(.*)(,\s+)$/$1/;
        $acl_hash{dst} = $dst_string;
        
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
        push @acl_arr, \%acl_hash;
	}
	
	$c->stash->{json} = \@acl_arr;

	$c->forward( 'View::JSON' );

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
