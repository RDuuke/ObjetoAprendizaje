<?php
session_start();
define("DS", DIRECTORY_SEPARATOR);
define("BASE_DIR",  dirname(__DIR__) . DS);
require_once dirname(__DIR__) . DS . "bootstrap" . DS . "app.php";
die();
$app->run();
