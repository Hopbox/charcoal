package Charcoal::View::HTML;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    INCLUDE_PATH => [
        Charcoal->path_to( 'root', 'src' ),
        Charcoal->path_to( 'root', 'lib' )
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    ERROR        => 'error.tt2',
    TIMER        => 0,
    render_die   => 1,
	debug		=> 'all',
});

=head1 NAME

Charcoal::View::HTML - Catalyst TT Twitter Bootstrap View

=head1 SYNOPSIS

See L<Charcoal>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

Unmukti Technology Pvt Ltd,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

