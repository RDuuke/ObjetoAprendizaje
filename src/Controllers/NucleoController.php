<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use Respect\Validation\Validator as v;
use App\Models\Area;
use App\Models\Nucleo;

class NucleoController extends Controller{

    public function create(Request $request,Response $response) {
        $areas = Area::all();
        return $this->view->render($response, 'admin/nucleo/formulario.twig', [
            'areas' => $areas
        ]);
    }

    public function store(Request $request, Response $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty(),
            "codigo" =>v::notEmpty()->NoWhitespace(),
            "codigo_area" => v::notEmpty()->NoWhitespace()
        ]);
        if ($validation->failed()) {
            $this->flash->addMessage('error', "No sé creo correctamente el nucleo");
            return $response->withRedirect($this->router->pathFor('nucleo.create'));
        }
        Nucleo::create([
            "name" => $request->getParam('name'),
            "codigo" => $request->getParam('codigo'),
            "codigo_area" => $request->getParam('codigo_area')
        ]);

        $this->flash->addMessage('info', "Se creo correctamente el nucleo");
        return $response->withRedirect($this->router->pathFor('nucleo.index'));

    }

    public function delete(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $nucleo = Nucleo::find($router->getArgument('id'));
        if ($nucleo->delete()) {
            $this->flash->addMessage('info', "Se Elimino correctamente");
        }
        $this->flash->addMessage('Error', "No sé Elimino correctamente");
        return $response->withRedirect($this->router->pathFor('nucleo.index'));
    }

    public function show(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $nucleo = Nucleo::find($router->getArgument('id'));
        $areas = Area::all()->toArray();
        return $this->view->render($response, 'admin/nucleo/formulario.twig', [
            'nucleo' => $nucleo,
            'areas' => $areas
        ]);
    }

    public function update(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $nucleo = Nucleo::find($router->getArgument('id'));
        $nucleo->codigo = $request->getParam('codigo');
        $nucleo->name = $request->getParam('name');
        $nucleo->codigo_area = $request->getParam('codigo_area');
        $nucleo->save();
        $this->flash->addMessage('info', "Se Actualizo correctamente el nucleo");
        return $response->withRedirect($this->router->pathFor('nucleo.index'));
    }

    public function showObjects(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $nucleo = Nucleo::find($router->getArgument('nucleo'));
        return $this->view->render($response, "nucleo/object.twig", [
            'nucleo' => $nucleo
        ]);
    }

}
