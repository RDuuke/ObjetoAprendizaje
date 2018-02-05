<?php

namespace App\Controllers;

use App\Models\Area;
use App\Models\Format;
use App\Models\Licence;

use Slim\Http\Request;
use Slim\Http\Response;

class AdminController extends Controller
{

    public function index(Request $request,Response $response) {

        return $this->view->render($response, 'admin/home.twig');
    }

    public function indexLicence(Request $request, Response $response)
    {
        $licences = Licence::all()->toArray();
        return $this->view->render($response, 'admin/licence/index.twig', [
            'licences' => $licences
        ]);
    }

    public function indexFormat(Request $request, Response $response)
    {
        $formats = Format::all()->toArray();
        return $this->view->render($response, 'admin/format/index.twig', [
            'formats' => $formats
        ]);
    }

    public function indexArea(Request $request, Response $response)
    {
        $areas = Area::all()->toArray();
        return $this->view->render($response, 'admin/area/index.twig', [
            'areas' => $areas
        ]);
    }


}