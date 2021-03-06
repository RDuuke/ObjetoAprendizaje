<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectCycle extends Model{

    protected $table = "objetos_ciclo";

    protected $fillable = ['codigo_objeto', 'version', 'estado', 'contribuyente', 'cambio_registro'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }
}
