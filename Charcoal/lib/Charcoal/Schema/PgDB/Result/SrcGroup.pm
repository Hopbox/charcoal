use utf8;
package Charcoal::Schema::PgDB::Result::SrcGroup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::SrcGroup

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

Related object: L<Charcoal::Schema::PgDB::Result::Group>

=cut

__PACKAGE__->belongs_to(
  "grp",
  "Charcoal::Schema::PgDB::Result::Group",
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

Related object: L<Charcoal::Schema::PgDB::Result::Src>

=cut

__PACKAGE__->belongs_to(
  "member",
  "Charcoal::Schema::PgDB::Result::Src",
  { id => "member" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-08-09 13:24:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jJB62deyi0lC4smze7nq7w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
