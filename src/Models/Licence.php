<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Licence extends Model
{
    protected $table = "licencias";
    protected $fillable = ["name"];
}