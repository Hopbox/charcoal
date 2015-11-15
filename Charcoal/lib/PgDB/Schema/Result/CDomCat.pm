use utf8;
package PgDB::Schema::Result::CDomCat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::CDomCat

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

Related object: L<PgDB::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "PgDB::Schema::Result::Category",
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

Related object: L<PgDB::Schema::Result::CDomain>

=cut

__PACKAGE__->belongs_to(
  "domain",
  "PgDB::Schema::Result::CDomain",
  { id => "domain" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qtePswCKmIhSfOZMQftetQ
# These lines were loaded from './PgDB/Schema/Result/CDomCat.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::CDomCat;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::CDomCat

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

Related object: L<PgDB::Schema::Result::Category>

=cut

__PACKAGE__->belongs_to(
  "category",
  "PgDB::Schema::Result::Category",
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

Related object: L<PgDB::Schema::Result::CDomain>

=cut

__PACKAGE__->belongs_to(
  "domain",
  "PgDB::Schema::Result::CDomain",
  { id => "domain" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:N5wIiRGgbl1G4f9unPiCpw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/CDomCat.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
