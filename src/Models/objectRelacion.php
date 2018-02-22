<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectRelacion extends Model{

    protected $table = "objetos_relacion";

    protected $fillable = ['codigo_objeto', 'codigo'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }
}
