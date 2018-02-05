<?php

namespace App\Middleware;


class AdminMiddleware extends Middleware
{
    public function __invoke($request, $response, $next)
    {
        if (! $this->container->auth->isAdmin()) {
            return $response->withRedirect($this->container->router->pathFor('home'));
        }
        $response = $next($request, $response);
        return $response;
    }

}