#!/usr/bin/perl -s
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

use IO::Socket;

$|=1; #Flush after write

my $DEBUG = 1 if $d;
my $squidver = 3;
$squidver = 2 if $c;

# ARGUMENTS REQUIRED
# 1. API Key

if ($h){
	print STDERR "Usage:\t$0 [-cdh] <api-key>\n";
	print STDERR "\t$0 -c -d <api-key>\t: send debug messages to STDERR\n";
	print STDERR "\t$0 -h\t\t\t: print this message\n";
    print STDERR "\t$0 -c\t\t\t: run helper in Squid 2.x compatibility mode.\n";
	exit 0;
}

if ( @ARGV < 1){
	print STDERR "BH message=Usage: $0 -[cdh] <api-key>\n";
	exit 1;
}


#########
## Server: charcoal.hopbox.in
## Port  : 80
##
#my $charcoal_server = '192.168.216.94';
my $charcoal_server = 'tunnelr3.hopbox.in';
my $charcoal_port   = '6603';
my $proto           = 'tcp';
my $timeout         = 10;

my $apikey = shift @ARGV;

print STDERR "Received API KEY $apikey\n";
print STDERR "Running for Squid Version $squidver\n";


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
        print STDERR "Sending $apikey|$squidver|$clientip|$ident|$method|$blah|$url\n";
    	my $sock = IO::Socket::INET->new(PeerAddr  => $charcoal_server,
					PeerPort   => $charcoal_port,
					Proto	   => $proto,
					Timeout	   => $timeout,
#					MultiHomed => 1,
#					Blocking   => 1,
				) || (print STDERR "BH message=Error connecting to charcoal server $!\n" && die);

	    print STDERR "Connected to $charcoal_server on $proto port $charcoal_port.\n" if $DEBUG;

        print $sock "$apikey|$squidver|$clientip|$ident|$method|$blah|$url\r\n";
        my $access = <$sock>;
        chomp $access;
		my $res = $chan . ' ' . $access;
        $sock->close();
		print "$res\n";
		print STDERR "$res\n" if $DEBUG;
	}
	else {
	### Concurrency disabled
		print STDERR "Concurrency Disabled\n" if $DEBUG;
		my ($url, $clientip, $ident, $method, $blah, $proxyip, $proxyport) = split(/\s+/);
        print STDERR "Sending $apikey|$squidver|$clientip|$ident|$method|$blah|$url\n";
    	my $sock = IO::Socket::INET->new(PeerAddr  => $charcoal_server,
					PeerPort   => $charcoal_port,
					Proto	   => $proto,
					Timeout	   => $timeout,
					MultiHomed => 1,
					Blocking   => 1,
				) || (print STDERR "BH message=Error connecting to charcoal server $!\n" && die);

	    print STDERR "Connected to $charcoal_server on $proto port $charcoal_port.\n" if $DEBUG;
        print $sock "$apikey|$squidver|$clientip|$ident|$method|$blah|$url\r\n";
        my $access = <$sock>;
        chomp $access;
		my $res = $chan . ' ' . $access;
        $sock->close();
		print "$res\n";
		print STDERR "$res\n" if $DEBUG;
	}

}
