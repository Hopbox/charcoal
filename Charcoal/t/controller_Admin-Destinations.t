use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Admin::Destinations;

ok( request('/admin/destinations')->is_success, 'Request should succeed' );
done_testing();
