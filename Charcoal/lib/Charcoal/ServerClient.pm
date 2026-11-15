package Charcoal::ServerClient;

# Send one request line to charcoal-server and read one reply line.
# Used by Tools > Test ACL. Same protocol as the Squid helper.

use strict;
use warnings;
use IO::Socket::IP;
use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);

# query(host => , port => , tls => 0|1, verify => 0|1, ca_file => , timeout => , line => )
# Returns ($reply, undef) or (undef, $error_text).
sub query {
    my (%a) = @_;
    my $timeout = $a{timeout} || 5;
    my %peer = (PeerHost => $a{host}, PeerPort => $a{port}, Timeout => $timeout);
    my $sock;

    if ($a{tls}) {
        $sock = IO::Socket::SSL->new(
            %peer,
            SSL_hostname        => $a{host},
            SSL_verify_mode     => $a{verify} ? SSL_VERIFY_PEER : SSL_VERIFY_NONE,
            SSL_verifycn_name   => $a{host},
            SSL_verifycn_scheme => 'default',
            ($a{ca_file} ? (SSL_ca_file => $a{ca_file}) : ()),
        );
        return (undef, "TLS connection to $a{host}:$a{port} failed: "
            . ($IO::Socket::SSL::SSL_ERROR || $! || 'unknown error')) unless $sock;
    }
    else {
        $sock = IO::Socket::IP->new(%peer)
            or return (undef, "Connection to $a{host}:$a{port} failed: " . ($! || $@));
    }

    my $reply;
    my $ok = eval {
        local $SIG{ALRM} = sub { die "timeout\n" };
        alarm $timeout;
        print {$sock} $a{line}, "\r\n";
        $reply = <$sock>;
        alarm 0;
        1;
    };
    alarm 0;
    close $sock;

    return (undef, "No reply from $a{host}:$a{port} within $timeout seconds.")
        if !$ok && ($@ // '') eq "timeout\n";
    return (undef, "Error talking to $a{host}:$a{port}: $@") unless $ok;
    return (undef, "Connection closed by $a{host}:$a{port} without a reply.") unless defined $reply;
    $reply =~ s/[\r\n]+$//;
    return ($reply, undef);
}

1;
