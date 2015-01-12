use strict;
use warnings;

use Charcoal;

my $app = Charcoal->apply_default_middlewares(Charcoal->psgi_app);
$app;

