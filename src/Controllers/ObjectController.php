<?php

namespace App\Controllers;

use App\Controllers\Controller;
use App\Models\Format;
use App\Models\Licence;
use App\Models\Object;
use App\Models\objectCycle;
use App\Models\objectTechnical;
use Slim\Http\Request;
use Slim\Http\Response;
use Respect\Validation\Validator as v;


class ObjectController extends Controller {

    public function create(Request $request,Response $response) {
        
        $formats = Format::all();
        $licences = Licence::all();
        return $this->view->render($response, 'admin/object/formulario.twig', [
            'formats' => $formats,
            'licences' => $licences
        ]);
    }
    
    public function store(Request $request,Response $response) {
        $validation = $this->validation->validate($request, [
            "titulo" => v::notEmpty(),
            "descripcion" => v::notEmpty(),
            "tags" => v::notEmpty(),
            "licence" => v::notEmpty(),
            "formato" => v::notEmpty(),
            "instrucciones" => v::notEmpty(),
            "requerimientos" => v::notEmpty(),
            "autor" => v::notEmpty(),
            "entidad" => v::notEmpty(),
            "version" => v::notEmpty(),
            "fecha" => v::notEmpty(),
        ]);
        if ($validation->failed()) {
            $this->flash->addMessage('error', "No sé creo correctamente el objeto");
            return $response->withRedirect($this->router->pathFor('object.create'));
        }
        $object = Object::create([
            "titulo" => $request->getParam("titulo"),
            "descripcion" => $request->getParam("descripcion"),
            "tags" => $request->getParam("tags"),
            "adjunto" => $request->getParam("password"),
            "licencia" => $request->getParam("licencia")
        ]);
        
        objectTechnical::create([
            "formato" => $request->getParam("formato"),
            "instrucciones" => $request->getParam("instrucciones"),
            "requerimientos" => $request->getParam("requerimientos"),
            "codigo_objeto" => $object->id
        ]);
        
        objectCycle::create([
            "autor" => $request->getParam("autor"),
            "entidad" => $request->getParam("entidad"),
            "version" => $request->getParam("version"),
            "fecha" => $request->getParam("fecha"),
            "codigo_objeto" => $object->id
        ]);

        $this->flash->addMessage('info', "Se creo correctamente el objeto");
        return $response->withRedirect($this->router->pathFor('object.index'));
    }
}
