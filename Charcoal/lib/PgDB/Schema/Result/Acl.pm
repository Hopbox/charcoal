use utf8;
package PgDB::Schema::Result::Acl;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Acl

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

=head1 TABLE: C<acls>

=cut

__PACKAGE__->table("acls");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'acls_id_seq'

=head2 customer

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 acl

  data_type: 'jsonb'
  is_nullable: 1

=head2 sequence

  accessor: undef
  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "acls_id_seq",
  },
  "customer",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "acl",
  { data_type => "jsonb", is_nullable => 1 },
  "sequence",
  { accessor => undef, data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1mGjUtWTPCz2Ew9PZQRXNw
# These lines were loaded from './PgDB/Schema/Result/Acl.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::Acl;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Acl

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

=head1 TABLE: C<acls>

=cut

__PACKAGE__->table("acls");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'acls_id_seq'

=head2 customer

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 acl

  data_type: 'jsonb'
  is_nullable: 1

=head2 sequence

  accessor: undef
  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "acls_id_seq",
  },
  "customer",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "acl",
  { data_type => "jsonb", is_nullable => 1 },
  "sequence",
  { accessor => undef, data_type => "integer", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:14
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4A36DRZAhMRsGsTH3GYlWA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/Acl.pm' 


