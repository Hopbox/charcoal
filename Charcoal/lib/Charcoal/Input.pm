package Charcoal::Input;

# Small input helpers shared by the controllers.

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(clean_text group_input_error);

# Trim white space (also no-break space) and return '' for undef.
sub clean_text {
    my ($s) = @_;
    $s //= '';
    $s =~ s/^[\s\x{a0}\x{feff}]+|[\s\x{a0}\x{feff}]+$//g;
    return $s;
}

# Check a group name and description. Return an error text or undef.
#   $rs:      resultset of the customer's groups (already filtered by customer)
#   $col:     name column ('name' for source groups, 'category' for destination groups)
#   $exclude: id of the group being edited (or undef)
sub group_input_error {
    my ($rs, $col, $name, $desc, $exclude) = @_;
    return "Enter a group name." unless length $name;
    return "Group name: at most 64 characters." if length($name) > 64;
    return "Description: at most 128 characters." if length($desc) > 128;
    my $same = $rs->search({
        -and => [ \[ "lower(me.$col) = lower(?)", $name ] ],
        (defined $exclude ? ('me.id' => { '!=' => $exclude }) : ()),
    })->count;
    return "A group named \"$name\" already exists." if $same;
    return undef;
}

1;
