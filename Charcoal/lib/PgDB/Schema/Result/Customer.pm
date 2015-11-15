use utf8;
package PgDB::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Customer

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

=head1 TABLE: C<customers>

=cut

__PACKAGE__->table("customers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'customers_id_seq'

=head2 mongoid

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 api

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "customers_id_seq",
  },
  "mongoid",
  { data_type => "char", is_nullable => 1, size => 64 },
  "api",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<customers_api_idx>

=over 4

=item * L</api>

=back

=cut

__PACKAGE__->add_unique_constraint("customers_api_idx", ["api"]);

=head1 RELATIONS

=head2 acls

Type: has_many

Related object: L<PgDB::Schema::Result::Acl>

=cut

__PACKAGE__->has_many(
  "acls",
  "PgDB::Schema::Result::Acl",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 c_domains

Type: has_many

Related object: L<PgDB::Schema::Result::CDomain>

=cut

__PACKAGE__->has_many(
  "c_domains",
  "PgDB::Schema::Result::CDomain",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 categories

Type: has_many

Related object: L<PgDB::Schema::Result::Category>

=cut

__PACKAGE__->has_many(
  "categories",
  "PgDB::Schema::Result::Category",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 groups

Type: has_many

Related object: L<PgDB::Schema::Result::Group>

=cut

__PACKAGE__->has_many(
  "groups",
  "PgDB::Schema::Result::Group",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 srcs

Type: has_many

Related object: L<PgDB::Schema::Result::Src>

=cut

__PACKAGE__->has_many(
  "srcs",
  "PgDB::Schema::Result::Src",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 users

Type: has_many

Related object: L<PgDB::Schema::Result::User>

=cut

__PACKAGE__->has_many(
  "users",
  "PgDB::Schema::Result::User",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nAn9Of1MWEohu9rl73ooNQ
# These lines were loaded from './PgDB/Schema/Result/Customer.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Customer

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

=head1 TABLE: C<customers>

=cut

__PACKAGE__->table("customers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'customers_id_seq'

=head2 mongoid

  data_type: 'char'
  is_nullable: 1
  size: 64

=head2 api

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 128

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "customers_id_seq",
  },
  "mongoid",
  { data_type => "char", is_nullable => 1, size => 64 },
  "api",
  { data_type => "varchar", is_nullable => 1, size => 128 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 128 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<customers_api_idx>

=over 4

=item * L</api>

=back

=cut

__PACKAGE__->add_unique_constraint("customers_api_idx", ["api"]);

=head1 RELATIONS

=head2 acls

Type: has_many

Related object: L<PgDB::Schema::Result::Acl>

=cut

__PACKAGE__->has_many(
  "acls",
  "PgDB::Schema::Result::Acl",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 c_domains

Type: has_many

Related object: L<PgDB::Schema::Result::CDomain>

=cut

__PACKAGE__->has_many(
  "c_domains",
  "PgDB::Schema::Result::CDomain",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 categories

Type: has_many

Related object: L<PgDB::Schema::Result::Category>

=cut

__PACKAGE__->has_many(
  "categories",
  "PgDB::Schema::Result::Category",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 groups

Type: has_many

Related object: L<PgDB::Schema::Result::Group>

=cut

__PACKAGE__->has_many(
  "groups",
  "PgDB::Schema::Result::Group",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 srcs

Type: has_many

Related object: L<PgDB::Schema::Result::Src>

=cut

__PACKAGE__->has_many(
  "srcs",
  "PgDB::Schema::Result::Src",
  { "foreign.customer" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zrcVttB9giUEqk58cnv4cA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/Customer.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
