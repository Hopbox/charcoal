use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::User::Profile;

ok( request('/user/profile')->is_success, 'Request should succeed' );
done_testing();
