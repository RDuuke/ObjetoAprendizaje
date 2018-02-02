<?php

$app->get("/", "HomeController:index")->setName("home");
$app->get("/user/create", "AuthController:create")->setName("user.create");
$app->post("/user/store", "AuthController:store")->setName("user.store");