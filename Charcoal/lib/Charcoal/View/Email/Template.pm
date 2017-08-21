package Charcoal::View::Email::Template;

use strict;
use base 'Catalyst::View::Email::Template';

__PACKAGE__->config(
    stash_key       => 'email',
    template_prefix => ''
);

=head1 NAME

Charcoal::View::Email::Template - Templated Email View for Charcoal

=head1 DESCRIPTION

View for sending template-generated email from Charcoal. 

=head1 AUTHOR

Nishant Sharma,,,

=head1 SEE ALSO

L<Charcoal>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
