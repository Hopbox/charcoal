use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Charcoal::API::DestGroups;

ok( request('/charcoal/api/destgroups')->is_success, 'Request should succeed' );
done_testing();
