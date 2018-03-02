<?php
require_once dirname(__DIR__) . DS . "vendor" . DS ."autoload.php";

use App\Controllers\AreaController;
use App\Controllers\FormatController;
use App\Controllers\LicenceController;
use App\Controllers\NucleoController;
use App\Controllers\ObjectController;
use App\Middleware\OldInputMiddleware;
use Slim\App;
use Illuminate\Database\Capsule\Manager;
use Slim\Flash\Messages;
use Slim\Views\Twig;
use Slim\Views\TwigExtension;
use App\Controllers\HomeController;
use App\Controllers\AuthController;
use App\Controllers\AdminController;
use App\Validation\Validator;
use App\Middleware\ValidationErrorsMiddleware;
use Respect\Validation\Validator as v;
use App\Auth\Auth;
use App\Models\Area;
use App\Models\Nucleo;
use App\Models\Object;

$app = new App([
    'settings' => [
        'determineRouteBeforeAppMiddeware' => false,
        'displayErrorDetails' => true,
    'db' => [
            'driver' => 'mysql',
            'host' => 'localhost',
            'database' => 'bancoobjetos',
            'username' => 'root',
            'password' => '',
            'charset'   => 'utf8',
            'collation' => 'utf8_unicode_ci',
            'prefix'    => '',
        ]
    ]
]);

$container = $app->getContainer();

$capsule = new Manager;

$capsule->addConnection($container['settings']['db']);
$capsule->setAsGlobal();
$capsule->bootEloquent();

$container['db'] = function ($container) use ($capsule) {
    return $capsule;
};

$container['auth'] = function ($container) {
    return new Auth($container);
};
$container['upload_directory'] = dirname(__DIR__ ) . DS ."resources" . DS;

$container['view'] = function ($container) {

    $view = new Twig(__DIR__ . "/../views",[
        'cache' => false
    ]);


    $view->addExtension(new TwigExtension(
        $container->router,
        $container->request->getUri()
    ));

    $view->getEnvironment()->addGlobal('auth', [
        'check' => $container->auth->check(),
        'user' => $container->auth->user()
    ]);
    $g = $container->request->getUri();            ;
    $view->getEnvironment()->addGlobal('request',  $g->getPath());

    $view->getEnvironment()->addGlobal('flash', $container->flash);
    $view->getEnvironment()->addGlobal('areas', \App\Models\Area::all());

    $function = new Twig_SimpleFunction('getNameFormat', function ($id) {
        $format = \App\Models\Format::find($id);
        return $format->name;
    });

    $view->getEnvironment()->addFunction($function);


    $function = new Twig_SimpleFunction('getNameLicence', function ($id) {
        $licence = \App\Models\Licence::find($id);
        return $licence->name;
    });

    $view->getEnvironment()->addFunction($function);

    $function = new Twig_SimpleFunction('getId', function ($table, $campo, $value) {
        $c = "\\App\\Models\\$table";
        $model = new $c;
        $data = $model->where($campo, "=", $value)->first();
        return $data->id;
    });

    $view->getEnvironment()->addFunction($function);
    $function = new Twig_SimpleFunction('getData', function ($table, $campo, $value) {
        $c = "\\App\\Models\\$table";
        $model = new $c;
        $data = $model->where($campo, "=", $value)->first();
        return $data;
    });

    $view->getEnvironment()->addFunction($function);

    $function = new Twig_SimpleFunction('breadcrumbs', function () use ($g) {
        $a= '<nav><div class="nav-wrapper  blue darken-1"><div class="col s12">&nbsp;&nbsp;&nbsp;<a href="/" class="breadcrumb">Principal</a>';

        $items = explode('/', $g->getPath());
        if (count($items) > 1) {
            $anchors = array_slice($items, 2);
            $url = "$g->getHost"."/items";
            $i = 0;
            foreach($anchors as $id) {
                if ($i == 0 ){
                    $name = "&Aacute;reas de conocimiento";
                }else if($i == 1) {
                    $name = Nucleo::find($id)->name;
                }else {
                    break;
                    $name = Object::find($id)->titulo;
                }
                $i++;
                $url .= "/".$id;
                $a .= '<a href="'.$url.'" class="breadcrumb">'.str_replace(".", "", strtolower($name)).'</a>';

            }
        }
           /*<a href="#!" class="breadcrumb">First</a>
           <a href="#!" class="breadcrumb">Second</a>
           <a href="#!" class="breadcrumb">Third</a>*/
        $a .= '</div></div></nav>';
        return $a;
    });

    $view->getEnvironment()->addFunction($function);

    return $view;
};

$container['validation'] = function ($container) {
    return new Validator;
};

$container['flash'] = function ($container) {
    return new Messages;
};

$container['HomeController'] = function($container) {
    return new HomeController($container);
};

$container['AuthController'] = function($container) {
    return new AuthController($container);
};

$container['AdminController'] = function($container) {
    return new AdminController($container);
};
$container['LicenceController'] = function ($container)
{
    return new LicenceController($container);
};
$container['FormatController'] = function ($container)
{
    return new FormatController($container);
};
$container['AreaController'] = function ($container)
{
    return new AreaController($container);
};
$container['NucleoController'] = function ($container)
{
    return new NucleoController($container);
};
$container['ObjectController'] = function ($container)
{
    return new ObjectController($container);
};

$app->add(new ValidationErrorsMiddleware($container));
$app->add(new OldInputMiddleware($container));

v::with("App\\Validation\\Rules\\");

require_once dirname(__DIR__) . "/src/routes.php";