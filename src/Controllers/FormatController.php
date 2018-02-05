<?php

namespace App\Controllers;

use App\Models\Format;
use Respect\Validation\Validator as v;
use Slim\Http\Request;
use Slim\Http\Response;


class FormatController extends Controller
{
    public function create(Request $request,Response $response) {

        return $this->view->render($response, 'admin/format/formulario.twig');
    }

    public function store(Request $request, Response $response)
    {
        $validation = $this->validation->validate($request, [
            "name" => v::notEmpty()
        ]);
        if ($validation->failed()) {
            $this->flash->addMessage('error', "No sé creo correctamente el formato");
            return $response->withRedirect($this->router->pathFor('format.create'));
        }
        Format::create([
            "name" => $request->getParam('name')
        ]);

        $this->flash->addMessage('info', "Se creo correctamente el formato");
        return $response->withRedirect($this->router->pathFor('format.index'));

    }

    public function delete(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $licence = Format::find($router->getArgument('id'));
        if ($licence->delete()) {
            $this->flash->addMessage('info', "Se Elimino correctamente el formato");
        } else {
            $this->flash->addMessage('Error', "No sé Elimino correctamente el formato");
        }
        return $response->withRedirect($this->router->pathFor('format.index'));
    }

    public function show(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $format = Format::find($router->getArgument('id'));
        return $this->view->render($response, 'admin/format/formulario.twig', [
            'format' => $format]
        );
    }

    public function update(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $format = Format::find($router->getArgument('id'));
        $format->name = $request->getParam('name');
        $format->save();
        $this->flash->addMessage('info', "Se Actualizo correctamente el formato");
        return $response->withRedirect($this->router->pathFor('format.index'));
    }

}