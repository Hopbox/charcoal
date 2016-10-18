use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Charcoal::API::SrcGroups;

ok( request('/charcoal/api/srcgroups')->is_success, 'Request should succeed' );
done_testing();
