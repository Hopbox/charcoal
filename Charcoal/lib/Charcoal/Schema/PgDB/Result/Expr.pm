use utf8;
package Charcoal::Schema::PgDB::Result::Expr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::Expr

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<exprs>

=cut

__PACKAGE__->table("exprs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'exprs_id_seq'

=head2 expr

  data_type: 'text'
  is_nullable: 1

=head2 categories

  data_type: 'jsonb'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "exprs_id_seq",
  },
  "expr",
  { data_type => "text", is_nullable => 1 },
  "categories",
  { data_type => "jsonb", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-21 19:13:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9qGHNXubZpK5dpuA7aW47A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
