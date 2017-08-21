use utf8;
package Charcoal::Schema::PgDB::Result::UsersSignup;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::UsersSignup

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

=head1 TABLE: C<users_signup>

=cut

__PACKAGE__->table("users_signup");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'users_signup_id_seq'

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 verify_key

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 t_created

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 t_updated

  data_type: 'timestamp with time zone'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "users_signup_id_seq",
  },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "verify_key",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "t_created",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "t_updated",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-08-09 13:24:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:y4Gw1E3yqgowtcvkXKY3+g


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
