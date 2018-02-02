<?php

namespace App\Controllers;

use App\Models\User;
use Respect\Validation\Validator as v;


class AuthController extends Controller
{
    public function create($request, $response)
    {
        return $this->view->render($response, 'users/signup.twig');
    }

    public function store($request, $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty()->alpha(),
            "email" => v::notEmpty()->email()->noWhitespace(),
            "password" => v::notEmpty()->noWhitespace()
        ]);
        if ($validation->failed()) {
            return $response->withRedirect($this->router->pathFor("user.create"));
        }
        User::create([
            "name" => $request->getParam("name"),
            "email" => $request->getParam("email"),
            "password" => password_hash($request->getParam("email"), PASSWORD_DEFAULT)
        ]);

        return $response->withRedirect($this->router->pathFor("home"));
    }
}