#!/usr/bin/env perl
#
# Remove login-failure counters (login rate limit) from the Charcoal cache.
#
# Usage:
#   charcoal_unblock.pl --list              show all counters
#   charcoal_unblock.pl <username>          unblock this username (all IPs)
#   charcoal_unblock.pl <ip>                unblock this IP (all usernames)
#
# Options:
#   --file <path>   cache share file (default: /tmp/charcoal_cache_data,
#                   the 'cache' config in lib/Charcoal.pm)
#
# Run as the same OS user as the application. The cache settings must be
# the same as in the application (this script uses the Cache::FastMmap
# defaults, as the application does).

use strict;
use warnings;
use Cache::FastMmap;
use Getopt::Long;

my $file = '/tmp/charcoal_cache_data';
my $list = 0;
GetOptions('file=s' => \$file, 'list' => \$list) or die "Bad options\n";
my $what = shift @ARGV;
die "Usage: $0 [--file path] --list | <username> | <ip>\n" unless $list || defined $what;
die "Cache file $file not found. Is the application running?\n" unless -e $file;

my $cache = Cache::FastMmap->new(
    share_file     => $file,
    init_file      => 0,
    unlink_on_exit => 0,
);

my @keys = grep { /^login_fail(_ip)?:/ } $cache->get_keys(0);

if ($list) {
    printf "%-60s %s\n", $_, $cache->get($_) // '-' for sort @keys;
    print "No counters.\n" unless @keys;
    exit 0;
}

my $w = lc $what;
my @hit = grep {
    # login_fail:<ip>:<user>   login_fail_ip:<ip>
    my @p = split /:/, $_;
    my $k_user = $p[0] eq 'login_fail' ? $p[-1] : undef;
    my $k_ip   = $p[0] eq 'login_fail' ? join(':', @p[1 .. $#p - 1]) : join(':', @p[1 .. $#p]);
    (defined $k_user && $k_user eq $w) || $k_ip eq $what;
} @keys;

if (!@hit) { print "Nothing to remove for '$what'.\n"; exit 0; }
for (@hit) { $cache->remove($_); print "Removed $_\n"; }
