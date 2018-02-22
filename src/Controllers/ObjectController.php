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
use App\Models\objectEducation;
use App\Models\objectMeta;
use App\Models\objectCopyRigth;
use Slim\Http\Request;
use Slim\Http\Response;
use Respect\Validation\Validator as v;
use Slim\Http\UploadedFile;
use Slim\Http\Stream;


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

        //$filesNames = $request->getUploadedFiles();
        /*$validation = $this->validation->validate($request, [
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
        }*/
        $object = Object::create($request->getParam('general'));
        $technic = $request->getParam('technic');
        $technic["codigo_objeto"] = $object->id;
        objectTechnical::create($technic);

        $cycle = $request->getParam('cycle');
        $cycle["codigo_objeto"] = $object->id;
        objectCycle::create($cycle);

        $copyright = $request->getParam('copyright');
        $copyright["codigo_objeto"] = $object->id;
        objectCopyRigth::create($copyright);

        $education = $request->getParam('education');
        $education["codigo_objeto"] = $object->id;
        objectEducation::create($education);

        $meta = $request->getParam('meta');
        $meta["codigo_objeto"] = $object->id;
        objectMeta::create($meta);


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
        return $this->getObject($router->getArgument('object'), "object/index.twig", $response);

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

    public function getDownloadAction(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $object = Object::find($router->getArgument('id'));
        $file =  BASE_DIR ."resources". DS . $object->adjunto;
        $string = trim($object->titulo);

    $string = str_replace(
        array('á', 'à', 'ä', 'â', 'ª', 'Á', 'À', 'Â', 'Ä'),
        array('a', 'a', 'a', 'a', 'a', 'A', 'A', 'A', 'A'),
        $string
    );

    $string = str_replace(
        array('é', 'è', 'ë', 'ê', 'É', 'È', 'Ê', 'Ë'),
        array('e', 'e', 'e', 'e', 'E', 'E', 'E', 'E'),
        $string
    );

    $string = str_replace(
        array('í', 'ì', 'ï', 'î', 'Í', 'Ì', 'Ï', 'Î'),
        array('i', 'i', 'i', 'i', 'I', 'I', 'I', 'I'),
        $string
    );

    $string = str_replace(
        array('ó', 'ò', 'ö', 'ô', 'Ó', 'Ò', 'Ö', 'Ô'),
        array('o', 'o', 'o', 'o', 'O', 'O', 'O', 'O'),
        $string
    );

    $string = str_replace(
        array('ú', 'ù', 'ü', 'û', 'Ú', 'Ù', 'Û', 'Ü'),
        array('u', 'u', 'u', 'u', 'U', 'U', 'U', 'U'),
        $string
    );

    $string = str_replace(
        array('ñ', 'Ñ', 'ç', 'Ç'),
        array('n', 'N', 'c', 'C',),
        $string
    );
    $string = str_replace(
       " ",
       "",
        $string
    );
        $extension =  end(explode('.',$file));
        $fileName = $string.".".$extension;

        $fh = fopen($file, "rb");
        $stream = new Stream($fh);

        return $response->withHeader('Content-Type', 'application/force-download')
                    ->withHeader('Content-Type', 'application/octet-stream')
                    ->withHeader('Content-Type', 'application/download')
                    ->withHeader('Content-Description', 'File Transfer')
                    ->withHeader('Content-Transfer-Encoding', 'binary')
                    ->withHeader('Content-Disposition', 'attachment; filename="' . $fileName . '"')
                    ->withHeader('Expires', '0')
                    ->withHeader('Cache-Control', 'must-revalidate, post-check=0, pre-check=0')
                    ->withHeader('Pragma', 'public')
                    ->withBody($stream);
    }
}
