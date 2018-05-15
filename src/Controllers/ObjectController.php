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
use App\Models\objectRelation;
use Slim\Http\Request;
use Slim\Http\Response;
use Respect\Validation\Validator as v;
use Slim\Http\UploadedFile;
use Slim\Http\Stream;


class ObjectController extends Controller {

    protected $rangos = ["10-14", "15-19", "20-24", "25-29", "30-34", "35-39", "40-44", "45-49"];
    protected $niveles = ["baja", "media", "alta"];
    protected $tipos_interactividad = ["selectiva", "transformativa", "constructiva"];
    protected $poblacion = ['estudiante', 'profesor', 'estudiantes y profesores'];
    protected $educacion = ['básica', 'media', 'superior'];
    public function create(Request $request,Response $response) {

        $formats = Format::all();
        $licences = Licence::all();
        $areas = Area::all();
        return $this->view->render($response, 'admin/object/formulario.twig', [
            'formats' => $formats,
            'licences' => $licences,
            'areas' => $areas,
            'rangos' => $this->rangos,
            'niveles' => $this->niveles,
            'tipos' => $this->tipos_interactividad,
            'educacion' => $this->educacion,
            'poblacion' => $this->poblacion
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
        $relational['codigo_objeto'] = $object->id;
        $relational['codigo_area'] = $request->getParam('nucleo_select_search');
        objectRelation::create($relational);

        $files = $request->getUploadedFiles();

        if (empty($files['archive'])){
            throw new \Exception("No archive object");
        }else{
            $ubicacion = $this->moveUploadedFile($object->id, $files['archive']);
        }
        if(empty($file["miniatura"])) {
            $miniatura = "No especificada";
        }else {
            $miniatura = $this->moveUploadedFile($object->id, $files['miniatura']);
        }
        $technic = $request->getParam('technic');
        $technic["codigo_objeto"] = $object->id;
        $technic["miniatura"] = $miniatura;
        $technic["ubicacion"] = $ubicacion;
        objectTechnical::create($technic);


        $this->flash->addMessage('info', "Se creo correctamente el objeto");
        return $response->withRedirect($this->router->pathFor('object.index'));
    }
    public function update(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $object_id = $router->getArgument('id');
        Object::where('id', $object_id)->update($request->getParam('general'));

        $cycle = $request->getParam('cycle');
        objectCycle::where('codigo_objeto', $object_id)->update($cycle);

        $copyright = $request->getParam('copyright');
        objectCopyRigth::where('codigo_objeto', $object_id)->update($copyright);

        $education = $request->getParam('education');
        objectEducation::where('codigo_objeto', $object_id)->update($education);

        $meta = $request->getParam('meta');
        objectMeta::where('codigo_objeto', $object_id)->update($meta);

        $relational['codigo_area'] = $request->getParam('nucleo_select_search');
        objectRelation::where('codigo_objeto', $object_id)->update($relational);

        $files = $request->getUploadedFiles();
        $technic = $request->getParam('technic');
        $file = $files['archive'];
        if($file->getError() === UPLOAD_ERR_OK) {
            if (! $file->getError() === UPLOAD_ERR_OK){
                throw new \Exception("No archive object");
            }else{
                $this->deleteFile($object_id);
                $ubicacion = $this->moveUploadedFile($object_id, $file);
            }
            $technic["ubicacion"] = $ubicacion;
        }
        objectTechnical::where('codigo_objeto', $object_id)->update($technic);

        $this->flash->addMessage('info', "Se actualizo correctamente el objeto");
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

    protected function moveUploadedFile($id, UploadedFile $file)
    {
        $directory = $this->upload_directory;
        $object = Object::find($id);
        $directory .=  DS . $object->objeto_relation->nucleo->codigo_area . DS . $object->objeto_relation->codigo_area;
        $savedirectory = DS . $object->objeto_relation->nucleo->codigo_area . DS . $object->objeto_relation->codigo_area;
        if(!file_exists($directory)) {
            mkdir($savedirectory, 0777, true);
        }
        $basename = bin2hex(random_bytes(8));
        $extension = pathinfo($file->getClientFilename(), PATHINFO_EXTENSION);
        $filename = sprintf('%s.%0.8s', $basename, $extension);

        $file->moveTo($directory . DS . $filename);

        return $savedirectory.DS.$filename;
    }

    protected function deleteFile($objecto_id)
    {
        $ubicacion = objectTechnical::select('ubicacion')->where('codigo_objeto', $objecto_id)->first();
        return unlink($this->upload_directory . $ubicacion->ubicacion);
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
            'formats' => $formats,
            'rangos' => $this->rangos,
            'niveles' => $this->niveles,
            'tipos' => $this->tipos_interactividad,
            'educacion' => $this->educacion,
            'poblacion' => $this->poblacion
        ]);
    }

    public function getDownloadAction(Request $request, Response $response)
    {
        $router = $request->getAttribute('route');
        $object = Object::find($router->getArgument('id'));
        $file =  BASE_DIR ."resources". DS . $object->objeto_tecnhincal->ubicacion;
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
