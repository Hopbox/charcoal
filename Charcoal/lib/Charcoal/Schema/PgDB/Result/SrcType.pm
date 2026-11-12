use utf8;
package Charcoal::Schema::PgDB::Result::SrcType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::SrcType

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

=head1 TABLE: C<src_types>

=cut

__PACKAGE__->table("src_types");

=head1 ACCESSORS

=head2 type

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 value

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "type",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "value",
  { data_type => "integer", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</value>

=back

=cut

__PACKAGE__->set_primary_key("value");

=head1 RELATIONS

=head2 srcs

Type: has_many

Related object: L<Charcoal::Schema::PgDB::Result::Src>

=cut

__PACKAGE__->has_many(
  "srcs",
  "Charcoal::Schema::PgDB::Result::Src",
  { "foreign.src_type" => "self.value" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-21 19:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Z6JYynwELBH+mSE8pKZdeA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
