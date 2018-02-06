<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Object extends Model {
    
    protected $table = "objetos_cabecera";
    protected $fillable = ["titulo", "adjunto", "descripcion", "tags", "licencia", "descargas", "codigo"];
    
    public function licencia()
    {
        return $this->belongsTo("App\Models\Licence", "licencia");
    }

    public function nucleo()
    {
        return $this->belongsTo("App\Models\Nucleo", "codigo");
    }
    
    public function objeto_tecnhincal()
    {
        return $this->hasOne("App\Models\objectTechnical", "codigo_objeto", 'id');
    }
    
    public function objeto_cycle()
    {
        return $this->hasOne("App\Models\objectCycle", "codigo_objeto", 'id');
    }
}
