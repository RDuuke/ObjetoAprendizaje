<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectRelation extends Model{

    protected $table = "objetos_relacion";

    protected $fillable = ['codigo_objeto', 'codigo_area'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }

    public function nucleo()
    {
        return $this->belongsTo("\App\Models\Nucleo", "codigo_area", "codigo");
    }
}