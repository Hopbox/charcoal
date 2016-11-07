use utf8;
package PgDB::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Category

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

Related object: L<PgDB::Schema::Result::CDomCat>

=cut

__PACKAGE__->has_many(
  "c_dom_cats",
  "PgDB::Schema::Result::CDomCat",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 customer

Type: belongs_to

Related object: L<PgDB::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "PgDB::Schema::Result::Customer",
  { id => "customer" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 gl_dom_cats

Type: has_many

Related object: L<PgDB::Schema::Result::GlDomCat>

=cut

__PACKAGE__->has_many(
  "gl_dom_cats",
  "PgDB::Schema::Result::GlDomCat",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tWtdU4PCwAIRLCMAsoRrfw
# These lines were loaded from './PgDB/Schema/Result/Category.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::Category;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Category

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

Related object: L<PgDB::Schema::Result::CDomCat>

=cut

__PACKAGE__->has_many(
  "c_dom_cats",
  "PgDB::Schema::Result::CDomCat",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 customer

Type: belongs_to

Related object: L<PgDB::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "PgDB::Schema::Result::Customer",
  { id => "customer" },
  { is_deferrable => 0, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 gl_dom_cats

Type: has_many

Related object: L<PgDB::Schema::Result::GlDomCat>

=cut

__PACKAGE__->has_many(
  "gl_dom_cats",
  "PgDB::Schema::Result::GlDomCat",
  { "foreign.category" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vmRrQSClnN11HgNs4DS6Iw

__PACKAGE__->many_to_many(
	'cdomains'	=>	'c_dom_cats', 'domain'
);

__PACKAGE__->many_to_many(
	'domains'	=>	'gl_dom_cats', 'domain'
);

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/Category.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
