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
  size: 64

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
  { data_type => "varchar", is_nullable => 1, size => 64 },
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

# --- Password hashing -------------------------------------------------
#
# New format: Argon2id, e.g. $argon2id$v=19$m=19456,t=2,p=1$<salt>$<hash>
# Old format: base64(SHA-256(password . salt)) . salt, 4-char salt, 47 chars
#             (from DBIx::Class::EncodedColumn, used until 2026-11).
#
# Any plain-text value set on 'password' is hashed with Argon2id
# (create, update, set_column). check_password() accepts both formats and
# replaces an old hash, or an Argon2id hash with old parameters, with a
# new Argon2id hash after a correct password.
#
# The column must hold at least 97 characters (varchar(255)).

use Crypt::Argon2 qw(argon2id_pass argon2_verify argon2_needs_rehash);
use Digest::SHA qw(sha256_base64);
use Encode qw(encode_utf8);

# Argon2id parameters (OWASP minimum): t_cost, m_cost, parallelism, hash length
my @ARGON2   = (2, '19M', 1, 32);
my $SALT_LEN = 16;
my $ARGON2_RE = qr/^\$argon2id\$v=\d+\$m=\d+,t=\d+,p=\d+\$[A-Za-z0-9+\/]+\$[A-Za-z0-9+\/]+$/;

sub _random_salt {
    open my $fh, '<:raw', '/dev/urandom' or die "Cannot open /dev/urandom: $!";
    my $n = read($fh, my $salt, $SALT_LEN);
    die "Short read from /dev/urandom" unless defined $n && $n == $SALT_LEN;
    return $salt;
}

sub _hash_password {
    my ($plain) = @_;
    return argon2id_pass(encode_utf8($plain), _random_salt(), @ARGON2);
}

sub store_column {
    my ($self, $col, $val) = @_;
    $val = _hash_password($val)
        if $col eq 'password' && defined $val && $val !~ $ARGON2_RE;
    return $self->next::method($col, $val);
}

sub check_password {
    my ($self, $plain) = @_;
    return 0 unless defined $plain && length $plain;
    my $stored = $self->get_column('password');
    return 0 unless defined $stored;

    if ($stored =~ $ARGON2_RE) {
        return 0 unless argon2_verify($stored, encode_utf8($plain));
        $self->_upgrade_hash($plain)
            if argon2_needs_rehash($stored, 'argon2id', @ARGON2, $SALT_LEN);
        return 1;
    }

    # Old format. The old code hashed the Perl string as given; try that
    # first, then the UTF-8 bytes.
    return 0 unless length($stored) == 47;
    my ($digest, $salt) = (substr($stored, 0, 43), substr($stored, 43));
    for my $p ($plain, encode_utf8($plain)) {
        next if $p =~ /[^\x00-\xff]/;
        if (sha256_base64($p . $salt) eq $digest) {
            $self->_upgrade_hash($plain);
            return 1;
        }
    }
    return 0;
}

# Store a new Argon2id hash. A failure here must not stop the login
# (e.g. column still varchar(64)): warn and keep the old hash.
sub _upgrade_hash {
    my ($self, $plain) = @_;
    eval { $self->update({ password => $plain }); 1 }
        or warn "Password hash upgrade failed for user " . ($self->username // '?') . ": $@";
}

1;
