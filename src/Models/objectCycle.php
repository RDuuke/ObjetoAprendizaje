<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectCycle extends Model{

    protected $table = "objetos_ciclo";
    
    protected $fillable = ['codigo_objeto', 'autor', 'entidad', 'version', 'fecha'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }
}
