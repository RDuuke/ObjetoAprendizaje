<?php

namespace App\Validation\Rules;


use App\Models\Object;
use Respect\Validation\Rules\AbstractRule;

class TitleAvailable extends AbstractRule
{

    public function validate($input)
    {
        return Object::where('titulo', $input)->count() === 0;
    }
}