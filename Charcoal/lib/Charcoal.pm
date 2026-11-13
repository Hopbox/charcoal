package Charcoal;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.90;

# Set flags and add plugins for the application.
#
# Note that ORDERING IS IMPORTANT here as plugins are initialized in order,
# therefore you almost certainly want to keep ConfigLoader at the head of the
# list if you're using it.
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader
    Static::Simple
    Cache::FastMmap

    Authentication
    Session
    Session::State::Cookie
    Session::Store::FastMmap

    StatusMessage

/;

use Catalyst::Authentication::Store::DBIx::Class;

use JSON::XS;
use Data::Validate::IP qw(is_ipv4 is_innet_ipv4);
use Data::Dumper;

extends 'Catalyst';

our $VERSION = '0.03';

# Configure the application.
#
# Note that settings in charcoal.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'Charcoal',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
    # Serve static files only from root/static. Without this, any file
    # with an extension under root/src or root/lib is served without login.
    'Plugin::Static::Simple' => { ignore_dirs => [ qw/src lib/ ] },
    # Catalyst::Plugin::Cache::FastMmap ($c->cache): login rate-limit
    # counters. A fixed file, so that script/charcoal_unblock.pl can find
    # it. Without this, each start creates /tmp/sharefile-<pid>-<random>.
    cache => {
        storage        => '/tmp/charcoal_cache_data',
        unlink_on_exit => 0,
    },
);

# Return the row of $source with primary key $id ONLY if it belongs to the
# logged-in customer. Otherwise return undef.
#
# Do NOT use find({ customer => ..., id => ... }) for this. DBIx::Class find()
# keeps only the columns of a unique constraint (the primary key) and drops
# 'customer' without a warning. The query becomes "WHERE id = ?" and returns
# rows of other customers. search()->single keeps every condition.
sub owned_row {
    my ($c, $source, $id) = @_;
    return undef unless defined $id && $id =~ /^\d+$/;
    return $c->model($source)->search({
        'me.customer' => $c->user->customer->id,
        'me.id'       => $id,
    })->single;
}

# Stop the request with 405 unless it is a POST. Use in every action that
# deletes or changes data, so that a link or <img> on another site cannot
# trigger it (SameSite=Lax cookies are still sent on top-level GET).
sub require_post {
    my ($c) = @_;
    return 1 if $c->req->method eq 'POST';
    $c->res->status(405);
    $c->res->body('Method not allowed');
    $c->detach;
}

# Start the application
__PACKAGE__->setup();

=encoding utf8

=head1 NAME

Charcoal - Catalyst based application

=head1 SYNOPSIS

    script/charcoal_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Charcoal::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Nishant Sharma,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
