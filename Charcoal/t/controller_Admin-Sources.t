use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Admin::Sources;

ok( request('/admin/sources')->is_success, 'Request should succeed' );
done_testing();
