package Charcoal::Domain;

# Domain name helpers shared by the controllers.

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(normalize_domain domain_levels search_levels);

# Turn user input into a lower-case host name, with a port if the port is
# not a default port (80, 443).
#   "https://user@www.Example.com:443/path?x" -> "www.example.com"
#   "https://fams.example.in:8000/po/home"    -> "fams.example.in:8000"
#   " example.com. "                          -> "example.com"
# Returns undef if the input is not a valid host name.
# Squid sends host names in lower case, and charcoal-server compares them
# exactly, so an entry with upper case letters would never match.
# An entry "host:port" matches only that port (a feature: allow or deny a
# non-standard port in an ACL).
sub normalize_domain {
    my ($in) = @_;
    my $d = lc($in // '');
    $d =~ s/^\s+|\s+$//g;
    $d =~ s{^[a-z][a-z0-9+.-]*://}{};   # scheme
    return undef if $d =~ m{^\d+\.\d+\.\d+\.\d+/\d+$};   # a network: not a destination
    $d =~ s{[/?#].*$}{};                 # path, query, fragment
    $d =~ s{^[^@]*@}{};                  # user:password@
    my $port = $d =~ s{:(\d*)$}{} ? $1 : '';
    $d =~ s{\.+$}{};                     # trailing dot
    return undef unless length $d && length $d <= 253;
    return undef unless $d =~ /^[a-z0-9_-]+(?:\.[a-z0-9_-]+)*$/;
    $port =~ s/^0+(?=\d)//;
    return undef if length $port && ($port < 1 || $port > 65535);
    return ($port eq '' || $port == 80 || $port == 443) ? $d : "$d:$port";
}

# Names to look up for a search: "host:port" first if there is a port,
# then the walk of the host name.
#   "fams.example.in:8000" -> fams.example.in:8000, fams.example.in, example.in, in
sub search_levels {
    my ($d) = @_;
    my ($host, $port) = $d =~ /^(.*?)(?::(\d+))?$/;
    return ((defined $port ? "$host:$port" : ()), domain_levels($host));
}

# The same walk as charcoal-server:
# www.a.example.com -> a.example.com -> example.com -> com
sub domain_levels {
    my ($d) = @_;
    my @levels = ($d);
    push @levels, $d while $d =~ s/^[^.]*\.//;
    return @levels;
}

1;
