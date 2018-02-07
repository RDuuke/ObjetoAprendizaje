<?php

namespace App\Controllers;

use App\Controllers\Controller;
use App\Models\Area;
use App\Models\Format;
use App\Models\Licence;
use App\Models\Nucleo;
use App\Models\Object;
use App\Models\objectCycle;
use App\Models\objectTechnical;
use Slim\Http\Request;
use Slim\Http\Response;
use Respect\Validation\Validator as v;
use Slim\Http\UploadedFile;


class ObjectController extends Controller {

    public function create(Request $request,Response $response) {
        
        $formats = Format::all();
        $licences = Licence::all();
        $nucleos = Nucleo::all();
        return $this->view->render($response, 'admin/object/formulario.twig', [
            'formats' => $formats,
            'licences' => $licences,
            'nucleos' => $nucleos
        ]);
    }
    
    public function store(Request $request,Response $response) {
        $filesNames = $request->getUploadedFiles();
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
            "adjunto" => $this->moveUploadedFile($request->getParam('nucleo'), $filesNames['adjunto']),
            "licencia" => $request->getParam("licence"),
            "codigo" => Nucleo::find($request->getParam('nucleo'))->codigo
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

    public function delete(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $nucleo = Object::find($router->getArgument('id'));
        if ($nucleo->delete()) {
            $this->flash->addMessage('info', "Se Elimino correctamente");
        }
        $this->flash->addMessage('Error', "No sé Elimino correctamente");
        return $response->withRedirect($this->router->pathFor('object.index'));
    }

    public function show(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        return $this->getObject($router->getArgument('id'), "admin/object/formulario.twig", $response);

    }

    protected function moveUploadedFile($codigo, UploadedFile $file)
    {
        $directory = $this->upload_directory;
        $directory .= Nucleo::find($codigo)->codigo . DS;
        $directory .= Nucleo::find($codigo)->area->codigo . DS;
        $savedirectory = Nucleo::find($codigo)->codigo . DS . Nucleo::find($codigo)->area->codigo . DS;
        echo $directory;
        if(!file_exists($directory)) {
            mkdir($directory, 0777, true);
        }
        $basename = bin2hex(random_bytes(8));
        $extension = pathinfo($file->getClientFilename(), PATHINFO_EXTENSION);
        $filename = sprintf('%s.%0.8s', $basename, $extension);

        $file->moveTo($directory . $filename);

        return $savedirectory.$filename;
    }
    
    public function showHome(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        return $this->getObject($router->getArgument('id'), "object/index.twig", $response);

    }
    
    public function getObject($id, $template, $response)
    {
    
        $object = Object::find($id);
        $formats = Format::all();
        $licences = Licence::all();
        $nucleos = Nucleo::all();
        return $this->view->render($response, $template, [
            'nucleos' => $nucleos,
            'object' => $object,
            'licences' => $licences,
            'formats' => $formats
        ]);
    }
}
