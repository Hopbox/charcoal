#!/usr/bin/perl -w
#
# Charcoal - URL Re-Director/Re-writer for Squid
# Copyright (C) 2012 Nishant Sharma <codemarauder@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.

$|=1; #Flush after write

my $DEBUG = 1;

# ARGUMENTS REQUIRED
# 1. API Key

if ( @ARGV != 1){
	print STDERR "Usage: $0 <api-key>\n";
	exit 1;
}


#########
## Server: charcoal.hopbox.in
## Port  : 80
##
my $apikey = shift @ARGV;

#For each requested URL, the rewriter will receive on line with the format
#
#	  [channel-ID <SP>] URL [<SP> extras]<NL>
#
#	See url_rewrite_extras on how to send "extras" with optional values to
#	the helper.
#	After processing the request the helper must reply using the following format:
#
#	  [channel-ID <SP>] result [<SP> kv-pairs]
#
#	The result code can be:
#
#	  OK status=30N url="..."
#		Redirect the URL to the one supplied in 'url='.
#		'status=' is optional and contains the status code to send
#		the client in Squids HTTP response. It must be one of the
#		HTTP redirect status codes: 301, 302, 303, 307, 308.
#		When no status is given Squid will use 302.
#
#	  OK rewrite-url="..."
#		Rewrite the URL to the one supplied in 'rewrite-url='.
#		The new URL is fetched directly by Squid and returned to
#		the client as the response to its request.
#
#	  OK
#		When neither of url= and rewrite-url= are sent Squid does
#		not change the URL.
#
#	  ERR
#		Do not change the URL.
#
#	  BH
#		An internal error occurred in the helper, preventing
#		a result being identified. The 'message=' key name is
#		reserved for delivering a log message.
#


while(<>){
	chomp;
	print STDERR "RAW: $_\n" if $DEBUG;
	my @chunks = split(/\s+/);

	print STDERR scalar(@chunks) . " chunks received \n";

	if ($chunks[0] =~ m/^\d+/){
	### Concurrency enabled
		print STDERR "Concurrency Enabled\n" if $DEBUG;
		my ($chan, $url, $clientip, $ident, $method, $blah, $proxyip, $proxyport) = split(/\s+/);
		print "$chan OK\n";
		print STDERR "$chan OK\n" if $DEBUG;
	}
	else {
	### Concurrency disabled
		print STDERR "Concurrency Disabled\n" if $DEBUG;
		print "OK\n";
		print STDERR "OK\n" if $DEBUG;
	}

}
