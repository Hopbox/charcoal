use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::User::Register;

ok( request('/user/register')->is_success, 'Request should succeed' );
done_testing();
