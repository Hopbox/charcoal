use utf8;
package PgDB::Schema::Result::Expr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Expr

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

=head1 TABLE: C<exprs>

=cut

__PACKAGE__->table("exprs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'exprs_id_seq'

=head2 expr

  data_type: 'text'
  is_nullable: 1

=head2 categories

  data_type: 'jsonb'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "exprs_id_seq",
  },
  "expr",
  { data_type => "text", is_nullable => 1 },
  "categories",
  { data_type => "jsonb", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-11 10:05:04
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qbBaYVd4ZwfL6Br1X4d78w
# These lines were loaded from './PgDB/Schema/Result/Expr.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package PgDB::Schema::Result::Expr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

PgDB::Schema::Result::Expr

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

=head1 TABLE: C<exprs>

=cut

__PACKAGE__->table("exprs");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'exprs_id_seq'

=head2 expr

  data_type: 'text'
  is_nullable: 1

=head2 categories

  data_type: 'jsonb'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "exprs_id_seq",
  },
  "expr",
  { data_type => "text", is_nullable => 1 },
  "categories",
  { data_type => "jsonb", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-10 16:39:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yP/mfdvILCOqNXrWb+fSCQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from './PgDB/Schema/Result/Expr.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
