<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class Area extends Model
{
    protected $table = "areas_conocimientos";
    protected $fillable = ["name", "codigo"];
    
    public function nucleos()
    {
        return $this->hasMany("\App\Models\Nucleo", "codigo_area", "codigo");
    }

}