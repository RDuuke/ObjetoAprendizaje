<?php

use App\Models\Object;

$app->get("/", "HomeController:index")->setName("home");
$app->get("/search", "HomeController:search")->setName('home.search');
$app->post("/searchAdvanced", "HomeController:searchAdvanced")->setName('home.search.advanced');
$app->get("/ajaxNucleo", "HomeController:ajaxNucleo");
$app->get("/ajaxNucleoTemplate", "HomeController:ajaxNucleoTemplate");
$app->get("/user/create", "AuthController:create")->setName("user.create")->add(new App\Middleware\AuthMiddleware($container));
$app->post("/user/store", "AuthController:store")->setName("user.store");
$app->get("/user/show/{id}", "AuthController:showN")->setName("user.show");
$app->post("/user/update/{id}", "AuthController:updateN")->setName("user.update");
$app->post("/auth/signin", "AuthController:signin")->setName("auth.signin");
$app->get("/auth/signout", "AuthController:signout")->setName("auth.signout");

$app->get("/items/{area}", "AreaController:showNucleos")->setName("area.nucleo.show");
$app->get("/items/{area}/{nucleo}", "NucleoController:showObjects")->setName("nucleo.object.show");
$app->get("/items/{area}/{nucleo}/{object}", "ObjectController:showHome")->setName("object.home.show");
$app->get("/object/dowloading/{id}", "ObjectController:getDownloadAction")->setName("object.dowload");

$app->group("/admin", function (){
   $this->get("", "AdminController:index")->setName("admin.home");
   $this->get("/user", "AdminController:indexUser")->setName("admin.user.index");
   $this->get("/user/create", "AuthController:createAdmin")->setName("admin.user.create");
   $this->post("/user/store", "AuthController:storeAdmin")->setName("admin.user.store");
   $this->get("/user/show/{id}", "AuthController:show")->setName("admin.user.show");
   $this->get("/user/delete/{id}", "AuthController:delete")->setName("admin.user.delete");
   $this->post("/user/update/{id}", "AuthController:update")->setName("admin.user.update");

   $this->get("/licence", "AdminController:indexLicence")->setName("licence.index");
   $this->post("/licence/store", "LicenceController:store")->setName("licence.store");
   $this->get("/licence/delete/{id}", "LicenceController:delete")->setName("licence.delete");
   $this->get("/licence/show/{id}", "LicenceController:show")->setName("licence.show");
   $this->get("/licence/create", "LicenceController:create")->setName("licence.create");
   $this->post("/licence/update/{id}", "LicenceController:update")->setName("licence.update");

   $this->get("/format", "AdminController:indexFormat")->setName("format.index");
   $this->get("/format/page/{page}", "AdminController:indexFormat")->setName("format.index");
   $this->post("/format/store", "FormatController:store")->setName("format.store");
   $this->get("/format/delete/{id}", "FormatController:delete")->setName("format.delete");
   $this->get("/format/show/{id}", "FormatController:show")->setName("format.show");
   $this->get("/format/create", "FormatController:create")->setName("format.create");
   $this->post("/format/update/{id}", "FormatController:update")->setName("format.update");

   $this->get("/area", "AdminController:indexArea")->setName("area.index");
   $this->post("/area/store", "AreaController:store")->setName("area.store");
   $this->get("/area/delete/{id}", "AreaController:delete")->setName("area.delete");
   $this->get("/area/show/{id}", "AreaController:show")->setName("area.show");
   $this->get("/area/create", "AreaController:create")->setName("area.create");
   $this->post("/area/update/{id}", "AreaController:update")->setName("area.update");

   $this->get("/area/nucleo", "AdminController:indexNucleo")->setName("nucleo.index");
   $this->post("/area/nucleo/store", "NucleoController:store")->setName("nucleo.store");
   $this->get("/area/nucleo/delete/{id}", "NucleoController:delete")->setName("nucleo.delete");
   $this->get("/area/nucleo/show/{id}", "NucleoController:show")->setName("nucleo.show");
   $this->get("/area/nucleo/create", "NucleoController:create")->setName("nucleo.create");
   $this->post("/area/nucleo/update/{id}", "NucleoController:update")->setName("nucleo.update");




    $this->get("/object", "AdminController:indexObject")->setName("object.index");
    $this->get("/object/create", "ObjectController:create")->setName("object.create");
    $this->post("/object/store", "ObjectController:store")->setName("object.store");
    $this->get("/object/show/{id}", "ObjectController:show")->setName("object.show");
    $this->post("/object/update/{id}", "ObjectController:update")->setName("object.update");
    $this->get("/object/delete/{id}", "ObjectController:delete")->setName("object.delete");

})->add(new App\Middleware\AdminMiddleware($container));
/*
 * Zona para usuarios logueados
$app->group("", function (){
    $this->get();
})->add(new \App\Middleware\AuthMiddleware($container));
*/
