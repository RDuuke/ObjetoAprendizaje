<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectTechnical extends Model{

    protected $table= "objetos_tecnico";
    
    protected $fillable = ['codigo_objeto', 'formato', 'instrucciones', 'requerimiento'];
    
    
    public function formato()
    {
        return $this->belongsTo("\App\Models\Format", "formato");
    }
    
}
