<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectEducation extends Model{

    protected $table = "objetos_educacional";

    protected $fillable = ['codigo_objeto', 'tipo_interactividad', 'tipo_recurso', 'nivel_interactividad', 'densidad_semantica', 'rangos_edad', 'contexto', 'dificultad', 'tiempo_aprendizaje', 'descripcion'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }
}