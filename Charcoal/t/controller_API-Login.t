use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::API::Login;

ok( request('/api/login')->is_success, 'Request should succeed' );
done_testing();
