<?php

namespace App\Controllers;

use App\Models\Area;
use App\Models\Licence;
use Respect\Validation\Validator as v;
use Slim\Http\Request;
use Slim\Http\Response;


class AreaController extends Controller
{

    public function create(Request $request,Response $response) {

        return $this->view->render($response, 'admin/area/formulario.twig');
    }

    public function store(Request $request, Response $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty(),
            "codigo" => v::notEmpty()->numeric()
        ]);
        if ($validation->failed()) {
            $this->flash->addMessage('error', "No sé creo correctamente");
            return $response->withRedirect($this->router->pathFor('area.create'));
        }
        Area::create([
            "name" => $request->getParam('name'),
            'codigo' => $request->getParam('codigo')
        ]);

        $this->flash->addMessage('info', "Se creo correctamente");
        return $response->withRedirect($this->router->pathFor('area.index'));

    }

    public function delete(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Area::find($router->getArgument('id'));
        if ($licence->delete()) {
            $this->flash->addMessage('info', "Se Elimino correctamente");
            return $response->withRedirect($this->router->pathFor('area.index'));
        }
        $this->flash->addMessage('Error', "No sé Elimino correctamente");
        return $response->withRedirect($this->router->pathFor('area.index'));
    }

    public function show(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Area::find($router->getArgument('id'));
        return $this->view->render($response, 'admin/area/formulario.twig', [
            'area' => $licence]
        );
    }

    public function update(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Area::find($router->getArgument('id'));
        $licence->name = $request->getParam('name');
        $licence->save();
        $this->flash->addMessage('info', "Se Actualizo correctamente");
        return $response->withRedirect($this->router->pathFor('area.index'));
    }
    public function showNucleos(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $area = Area::find($router->getArgument('area'));
        return $this->view->render($response, "area/nucleo.twig", [
            'area' => $area
        ]);
    }

}