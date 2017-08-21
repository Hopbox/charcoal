use utf8;
package Charcoal::Schema::PgDB::Result::CDomCat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::CDomCat

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

=head1 TABLE: C<c_dom_cat>

=cut

__PACKAGE__->table("c_dom_cat");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'c_dom_cat_id_seq'

=head2 domain

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 category

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "c_dom_cat_id_seq",
  },
  "domain",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "category",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 category

Type: belongs_to

Related object: L<Charcoal::Schema::PgDB::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "Charcoal::Schema::PgDB::Result::Category",
  { id => "category" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 domain

Type: belongs_to

Related object: L<Charcoal::Schema::PgDB::Result::CDomain>

=cut

__PACKAGE__->belongs_to(
  "domain",
  "Charcoal::Schema::PgDB::Result::CDomain",
  { id => "domain" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-08-09 13:24:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6kYuOz4FDmvChnR3ZiAikQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
