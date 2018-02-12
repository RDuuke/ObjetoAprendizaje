<?php

namespace App\Controllers;

use App\Models\User;
use Respect\Validation\Validator as v;
use Slim\Http\Request;
use Slim\Http\Response;

class AuthController extends Controller
{
    public function create(Request $request,Response $response)
    {
        return $this->view->render($response, 'users/signup.twig');
    }
    public function createAdmin(Request $request,Response $response)
    {
        return $this->view->render($response, 'admin/user/formulario.twig');
    }

    public function store(Request $request,Response $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty()->alpha(),
            "email" => v::notEmpty()->email()->noWhitespace()->emailAvailable(),
            "password" => v::notEmpty()->noWhitespace()
        ]);
        if ($validation->failed()) {
            return $response->withRedirect($this->router->pathFor("user.create"));
        }
        $user = User::create([
            "name" => $request->getParam("name"),
            "email" => $request->getParam("email"),
            "password" => password_hash($request->getParam("password"), PASSWORD_DEFAULT)
        ]);
        // @TODO refactorizar
        $this->flash->addMessage("info", "Usted ha sido registrado");

        $this->auth->attempt($user->email, $request->getParam('password'));

        return $response->withRedirect($this->router->pathFor("home"));
    }

    public function storeAdmin(Request $request,Response $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty()->alpha(),
            "email" => v::notEmpty()->email()->noWhitespace()->emailAvailable(),
            "password" => v::notEmpty()->noWhitespace()
        ]);
        if ($validation->failed()) {
            return $response->withRedirect($this->router->pathFor("admin.user.create"));
        }
        $user = User::create([
            "name" => $request->getParam("name"),
            "email" => $request->getParam("email"),
            "password" => password_hash($request->getParam("password"), PASSWORD_DEFAULT),
            "role" => $request->getParam('role')
        ]);
        // @TODO refactorizar
        $this->flash->addMessage("info", "Usted ha sido registrado");

        //$this->auth->attempt($user->email, $request->getParam('password'));

        return $response->withRedirect($this->router->pathFor("admin.user.index"));
    }

    public function signin(Request $request,Response $response)
    {
        $auth = $this->auth->attempt(
            $request->getParam('email'),
            $request->getParam('password')
        );
        if (! $auth) {
            return $response->withRedirect($this->router->pathFor('home'));
        }
        return $response->withRedirect($this->router->pathFor('home'));
    }

    public function signout(Request $request,Response $response)
    {
        $this->auth->logout();
        return $response->withRedirect($this->router->pathFor('home'));
    }

    public function show(Request $request,Response $response)
    {
        $router = $request->getAttribute('route');
        $user = User::find($router->getArgument('id'));
        return $this->view->render($response, 'admin/user/formulario.twig', ['user' => $user]);

    }

    public function update(Request $request,Response $response)
    {
        $router = $request->getAttribute('route');
        $user = User::find($router->getArgument('id'));
        $user->name = $request->getParam("name");
        $user->email = $request->getParam("email");
        $user->role = $request->getParam("role");
        $user->save();
        $this->flash->addMessage("info", "usuario actualizado.");

        return $response->withRedirect($this->router->pathFor('admin.user.index'));

    }

    public function delete(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $user = User::find($router->getArgument('id'));
        if ($user->delete()) {
            $this->flash->addMessage('info', "Se Elimino correctamente");
            return $response->withRedirect($this->router->pathFor('admin.user.index'));
        }
        $this->flash->addMessage('Error', "No sé Elimino correctamente");
        return $response->withRedirect($this->router->pathFor('admin.user.index'));
    }

}