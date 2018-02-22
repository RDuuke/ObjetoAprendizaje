<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectTechnical extends Model{

    protected $table= "objetos_tecnico";

    protected $fillable = ['codigo_objeto', 'formato', 'instrucciones', 'tamano', 'ubicacion', 'otro_requerimiento', 'duracion', 'miniatura', 'imagenes_previas', 'imagenes_posteriores'];


    public function formato()
    {
        return $this->belongsTo("\App\Models\Format", "formato");
    }

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }

}
