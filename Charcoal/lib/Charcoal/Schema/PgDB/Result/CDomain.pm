use utf8;
package Charcoal::Schema::PgDB::Result::CDomain;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::CDomain

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

=head1 TABLE: C<c_domains>

=cut

__PACKAGE__->table("c_domains");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'c_domains_id_seq'

=head2 domain

  data_type: 'text'
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
    sequence          => "c_domains_id_seq",
  },
  "domain",
  { data_type => "text", is_nullable => 1 },
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

=head2 c_dom_cats

Type: has_many

Related object: L<Charcoal::Schema::PgDB::Result::CDomCat>

=cut

__PACKAGE__->has_many(
  "c_dom_cats",
  "Charcoal::Schema::PgDB::Result::CDomCat",
  { "foreign.domain" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-21 19:13:26
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VEr4vSA32yKArxr91nzR8Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
