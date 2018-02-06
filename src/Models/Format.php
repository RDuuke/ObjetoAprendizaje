<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Format extends Model
{
    protected $table = "formatos";
    protected $fillable = ["name"];

    public function object_technical()
    {
        return $this->hasMany("App\Models\Nucleos", "formato", "id");
    }
}