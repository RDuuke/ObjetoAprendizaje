<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Object extends Model {
    
    protected $table = "objetos_cabecera";
    protected $fillable = ["titulo", "adjunto", "descripcion", "tags", "licencia", "descargas"];
    
    public function licencia()
    {
        return $this->belongsTo("\App\Models\Licence", "licencia");
    }
    
    public function objeto_tecnhincal()
    {
        return $this->hasMany("\App\Models\objectTechnical", "codigo_objeto", 'id');
    }
    
    public function objeto_cycle()
    {
        return $this->hasMany("\App\Models\objectCycle", "codigo_objeto", 'id');
    }
}
