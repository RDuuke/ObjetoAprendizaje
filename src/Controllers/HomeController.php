<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Models\Area;
use App\Models\Object;
use App\Models\Format;
use App\Models\Nucleo;
use Respect\Validation\Rules\Readable;
use App\Models\Licence;

class HomeController extends Controller
{

    public function index(Request $request,Response $response)
    {

        $objects = Object::all();

        return $this->view->render($response, "home.twig", [
            'objects' => $objects
        ]);
    }

    public function search(Request $request, Response $response)
    {
        $queryParams = $request->getQueryParams();
        $areas = Area::all();
        $licences = Licence::all();
        $objects = Object::searchTagsAndTitle($queryParams['search']);
        return $this->view->render($response, 'search.twig', [
            'objects' => $objects,
            'areas' => $areas,
            'licences' => $licences
        ]);
    }

    public function searchAdvanced(Request $request, Response $response)
    {
        $search = ['area'=> $request->getParam('area'), 'nucleos' => $request->getParam('nucleos'), 'licences' => $request->getParam('licences')];
        $areas = Area::all();
        $licences = Licence::all();
        $objects =Object::searchAdvanced($search);
        return $this->view->render($response, 'search.twig', [
            'objects' => $objects,
            'areas' => $areas,
            'licences' => $licences
        ]);
    }

    public function ajaxNucleo(Request $request, Response $response)
    {
        $id = $request->getQueryParam('id');
        $nucleos = json_encode(Nucleo::where("codigo_area", "=", $id)->get()->toArray());
        echo $nucleos;
        return true;
    }
}