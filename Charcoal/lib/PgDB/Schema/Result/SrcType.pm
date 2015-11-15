use utf8;
package PgDB::Schema::Result::SrcType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::SrcType

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

Related object: L<PgDB::Schema::Result::Src>

=cut

__PACKAGE__->has_many(
  "srcs",
  "PgDB::Schema::Result::Src",
  { "foreign.src_type" => "self.value" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yaKRibbfUPEYRY6wWnJlPg
# These lines were loaded from './PgDB/Schema/Result/SrcType.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::SrcType;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::SrcType

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

Related object: L<PgDB::Schema::Result::Src>

=cut

__PACKAGE__->has_many(
  "srcs",
  "PgDB::Schema::Result::Src",
  { "foreign.src_type" => "self.value" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:20
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:05D5JgyWC4N4REDJwbZ1bw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/SrcType.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
