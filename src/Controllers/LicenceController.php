<?php

namespace App\Controllers;

use App\Models\Licence;
use Respect\Validation\Validator as v;
use Slim\Http\Request;
use Slim\Http\Response;


class LicenceController extends Controller
{

    public function create(Request $request,Response $response) {

        return $this->view->render($response, 'admin/licence/formulario.twig');
    }

    public function store(Request $request, Response $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty()
        ]);
        if ($validation->failed()) {
            $this->flash->addMessage('error', "No sé creo correctamente la licencia");
            return $response->withRedirect($this->router->pathFor('licence.create'));
        }
        Licence::create([
            "name" => $request->getParam('name')
        ]);

        $this->flash->addMessage('info', "Se creo correctamente la licencia");
        return $response->withRedirect($this->router->pathFor('licence.index'));

    }

    public function delete(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Licence::find($router->getArgument('id'));
        if ($licence->delete()) {
            $this->flash->addMessage('info', "Se Elimino correctamente la licencia");
            return $response->withRedirect($this->router->pathFor('admin.home'));
        }
        $this->flash->addMessage('Error', "No sé Elimino correctamente la licencia");
        return $response->withRedirect($this->router->pathFor('licence.index'));
    }

    public function show(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Licence::find($router->getArgument('id'));
        return $this->view->render($response, 'admin/licence/formulario.twig', [
            'licence' => $licence]
        );
    }

    public function update(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Licence::find($router->getArgument('id'));
        $licence->name = $request->getParam('name');
        $licence->save();
        $this->flash->addMessage('info', "Se Actualizo correctamente la licencia");
        return $response->withRedirect($this->router->pathFor('licence.index'));
    }

}