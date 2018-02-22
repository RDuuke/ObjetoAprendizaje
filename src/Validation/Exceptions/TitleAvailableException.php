<?php

namespace App\Validation\Exceptions;


use Respect\Validation\Exceptions\ValidationException;

class TitleAvailableException extends ValidationException
{
    public static $defaultTemplates = [
        self::MODE_DEFAULT => [
            self::STANDARD => "Title is already taken",
        ]
    ];

}