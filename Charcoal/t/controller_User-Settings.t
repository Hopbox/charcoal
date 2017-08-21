use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Charcoal';
use Charcoal::Controller::User::Settings;

ok( request('/user/settings')->is_success, 'Request should succeed' );
done_testing();
