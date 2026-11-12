use utf8;
package Charcoal::Schema::PgDB::Result::Domain;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Charcoal::Schema::PgDB::Result::Domain

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

=head1 TABLE: C<domains>

=cut

__PACKAGE__->table("domains");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'domains_id_seq'

=head2 domain

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "domains_id_seq",
  },
  "domain",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 gl_dom_cats

Type: has_many

Related object: L<Charcoal::Schema::PgDB::Result::GlDomCat>

=cut

__PACKAGE__->has_many(
  "gl_dom_cats",
  "Charcoal::Schema::PgDB::Result::GlDomCat",
  { "foreign.domain" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-07-21 19:13:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Wc+rkX549v9/PFTC2n78AQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
