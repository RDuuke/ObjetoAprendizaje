<?php
session_start();
error_reporting(E_ALL ^ E_NOTICE);
define("DS", DIRECTORY_SEPARATOR);
require_once dirname(__DIR__) . DS . "bootstrap" . DS . "app.php";

$app->run();