<?php

namespace App\Controllers;

use Slim\Http\Request;
use Slim\Http\Response;
use App\Models\Area;
use App\Models\Object;

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
        $objects = Object::searchTagsAndTitle($queryParams['search']);
        return $this->view->render($response, 'search.twig', [
            'objects' => $objects
        ]);
    }
}