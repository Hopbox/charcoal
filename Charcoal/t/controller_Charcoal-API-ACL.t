use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Charcoal::API::ACL;

ok( request('/charcoal/api/acl')->is_success, 'Request should succeed' );
done_testing();
