<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectCopyRigth extends Model{

    protected $table = "objetos_derecho";

    protected $fillable = ['codigo_objeto', 'costo', 'poseedor_derecho_patrimonial', 'descripcion'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }
}