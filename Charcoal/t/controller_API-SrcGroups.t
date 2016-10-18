use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::API::SrcGroups;

ok( request('/api/srcgroups')->is_success, 'Request should succeed' );
done_testing();
