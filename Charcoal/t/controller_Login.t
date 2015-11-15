use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::Login;

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
