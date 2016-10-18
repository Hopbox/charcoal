use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::API::ACLs;

ok( request('/api/acls')->is_success, 'Request should succeed' );
done_testing();
