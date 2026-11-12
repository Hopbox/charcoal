package Charcoal::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

# --- CORS: Allowed origins for API requests ---
my @ALLOWED_ORIGINS = qw(
    https://my.charcoal.io
);

sub index : Path : Args(0){
        my ($self, $c) = @_;
        $c->response->redirect($c->uri_for('/login'));
}

sub auto : Private {
    my ($self, $c) = @_;

    # --- Allow unauthenticated access to Login controller ---
    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }

    if ($c->controller eq $c->controller('Root')->action_for('index')) {
        return 1;
    }

    # --- CORS handling for API routes ---
    if ($c->request->path =~ /^api/) {
        my $origin = $c->req->header('Origin') // '';
        if (grep { $_ eq $origin } @ALLOWED_ORIGINS) {
            $c->response->headers->header('Access-Control-Allow-Origin' => $origin);
            $c->response->headers->header('Access-Control-Allow-Credentials' => 'true');
        }
        $c->response->headers->header('Access-Control-Allow-Headers' => 'content-type, x-charcoal-auth, x-csrf-token');
        $c->response->headers->header('Access-Control-Allow-Methods' => 'GET, POST, PUT, DELETE, OPTIONS');

        # Preflight requests get an early return
        if ($c->request->method eq 'OPTIONS') {
            return 1;
        }
    }

    # --- Allow unauthenticated access to API Login ---
    if ($c->controller eq $c->controller('API::Login')) {
        return 1;
    }

    # --- Require authentication for everything else ---
    if ( !$c->user_exists || !$c->session ) {
        $c->log->debug('***Root::auto User/Session not found, forwarding to /login');
        $c->response->redirect($c->uri_for('/login'));
        return 0;
    }

    # --- CSRF: Generate token if not present ---
    if (!$c->session->{csrf_token}) {
        my @chars = ('a'..'z', 'A'..'Z', '0'..'9');
        $c->session->{csrf_token} = join '', map { $chars[rand @chars] } 1..32;
    }
    $c->stash->{csrf_token} = $c->session->{csrf_token};

    # --- CSRF: Validate on state-changing requests (skip API routes) ---
    if ($c->req->method =~ /^(POST|PUT|DELETE)$/ && $c->req->path !~ /^api/) {
        my $token = $c->req->param('csrf_token') // $c->req->header('X-CSRF-Token') // '';
        unless ($token eq $c->session->{csrf_token}) {
            $c->log->warn('CSRF validation failed for ' . $c->req->path);
            $c->res->status(403);
            $c->res->body('Forbidden: invalid or missing CSRF token');
            return 0;
        }
    }

    # --- User context for templates ---
    $c->stash->{user_fname} = $c->user->firstname;
    $c->stash->{user_sname} = $c->user->lastname;
    return 1;
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;

    $c->response->header('X-Frame-Options' => 'DENY');
    $c->response->header('Content-Security-Policy' => "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'");
    $c->response->header('X-Content-Type-Options' => 'nosniff');
    $c->response->header('X-Download-Options' => 'noopen');
}

__PACKAGE__->meta->make_immutable;

1;
