use utf8;
package Charcoal::Schema::PgDB::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::User

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

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_id_seq'

=head2 username

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 password

  data_type: 'varchar'
  is_nullable: 1
  size: 16

=head2 firstname

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 lastname

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 active

  data_type: 'integer'
  is_nullable: 1

=head2 customer

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
    sequence          => "users_id_seq",
  },
  "username",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "password",
  { data_type => "varchar", is_nullable => 1, size => 16 },
  "firstname",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "lastname",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "active",
  { data_type => "integer", is_nullable => 1 },
  "customer",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
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

Related object: L<Charcoal::Schema::PgDB::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "Charcoal::Schema::PgDB::Result::Customer",
  { id => "customer" },
  {
    is_deferrable => 0,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-21 19:13:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:U0U4nRNlGX9+fxZV1RyK5A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
