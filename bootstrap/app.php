<?php
session_start();

require_once dirname(__DIR__) . DS . "vendor" . DS ."autoload.php";

use Slim\App;
use Illuminate\Database\Capsule\Manager;
use Slim\Views\Twig;
use Slim\Views\TwigExtension;
use App\Controllers\HomeController;
use App\Controllers\AuthController;
use App\Validation\Validator;

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

$container['view'] = function ($container) {

    $view = new Twig(__DIR__ . "/../views",[
        'cache' => false
    ]);

    $view->addExtension(new TwigExtension(
        $container->router,
        $container->request->getUri()
    ));

    return $view;
};

$container['validation'] = function ($container) {
    return new Validator;
};
$container['HomeController'] = function($container) {
    return new HomeController($container);
};

$container['AuthController'] = function($container) {
    return new AuthController($container);
};

require_once dirname(__DIR__) . "/src/routes.php";