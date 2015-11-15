use utf8;
package PgDB::Schema::Result::SrcGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::SrcGroup

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

=head1 TABLE: C<src_groups>

=cut

__PACKAGE__->table("src_groups");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'src_groups_id_seq'

=head2 grp

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 member

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
    sequence          => "src_groups_id_seq",
  },
  "grp",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 grp

Type: belongs_to

Related object: L<PgDB::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "grp",
  "PgDB::Schema::Result::Group",
  { id => "grp" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 member

Type: belongs_to

Related object: L<PgDB::Schema::Result::Src>

=cut

__PACKAGE__->belongs_to(
  "member",
  "PgDB::Schema::Result::Src",
  { id => "member" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hWcHMnbgPhNgmrofXj+MBg
# These lines were loaded from './PgDB/Schema/Result/SrcGroup.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::SrcGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::SrcGroup

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

=head1 TABLE: C<src_groups>

=cut

__PACKAGE__->table("src_groups");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'src_groups_id_seq'

=head2 grp

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 member

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
    sequence          => "src_groups_id_seq",
  },
  "grp",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "member",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 grp

Type: belongs_to

Related object: L<PgDB::Schema::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "grp",
  "PgDB::Schema::Result::Group",
  { id => "grp" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 member

Type: belongs_to

Related object: L<PgDB::Schema::Result::Src>

=cut

__PACKAGE__->belongs_to(
  "member",
  "PgDB::Schema::Result::Src",
  { id => "member" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:19
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N6buEaaT7HL+aW5sVCrnCw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/SrcGroup.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
