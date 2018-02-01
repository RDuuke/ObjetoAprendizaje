<?php

namespace App\Controllers;

use Slim\Container;


class Controller
{
    protected $conntainer;

    public function __construct(Container $conntainer)
    {
        $this->container = $conntainer;
    }

    public function __get($property)
    {
        if ($this->conntainer->{$property}) {
            return $this->conntainer->{$property};
        }
    }

}