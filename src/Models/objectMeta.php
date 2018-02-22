<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class objectMeta extends Model{

    protected $table = "objetos_meta";

    protected $fillable = ['codigo_objeto', 'contribuyente', 'esquema_metadato', 'idioma'];

    public function objeto()
    {
        return $this->belongsTo("\App\Models\Object", "codigo_objeto");
    }
}