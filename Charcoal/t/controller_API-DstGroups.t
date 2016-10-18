use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::API::DstGroups;

ok( request('/api/dstgroups')->is_success, 'Request should succeed' );
done_testing();
