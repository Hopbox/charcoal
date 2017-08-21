use utf8;
package Charcoal::Schema::PgDB::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::Category

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=item * L<DBIx::Class::EncodedColumn>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp", "EncodedColumn");

=head1 TABLE: C<categories>

=cut

__PACKAGE__->table("categories");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'categories_id_seq'

=head2 category

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 customer

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "categories_id_seq",
  },
  "category",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "customer",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 c_dom_cats

Type: has_many

Related object: L<Charcoal::Schema::PgDB::Result::CDomCat>

=cut

__PACKAGE__->has_many(
  "c_dom_cats",
  "Charcoal::Schema::PgDB::Result::CDomCat",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 customer

Type: belongs_to

Related object: L<Charcoal::Schema::PgDB::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "Charcoal::Schema::PgDB::Result::Customer",
  { id => "customer" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 gl_dom_cats

Type: has_many

Related object: L<Charcoal::Schema::PgDB::Result::GlDomCat>

=cut

__PACKAGE__->has_many(
  "gl_dom_cats",
  "Charcoal::Schema::PgDB::Result::GlDomCat",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-08-09 13:24:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:c1sEDH9oogORglUNIWsWig


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
