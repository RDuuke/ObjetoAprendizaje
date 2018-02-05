<?php

namespace App\Middleware;


use Slim\Http\Request;
use Slim\Http\Response;

class AuthMiddleware extends Middleware
{

    public function __invoke(Request $request, Response $response, $next)
    {
        if (! $this->container->auth->check()) {
            $this->container->flash->addMessage("info", "Por favor ingresa primero");
            return $response->withRedirect($this->container->router->pathFor('home'));
        }

        $response = $next($request, $response);
        return $response;
    }
}