use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Charcoal::API::ACLs;

ok( request('/charcoal/api/acls')->is_success, 'Request should succeed' );
done_testing();
