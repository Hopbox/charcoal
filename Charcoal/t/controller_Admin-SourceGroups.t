use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Admin::SourceGroups;

ok( request('/admin/sourcegroups')->is_success, 'Request should succeed' );
done_testing();
