<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Nucleo extends Model {
    
    protected $table = "nucleo_conocimiento";
    
    protected $fillable = ["codigo", "name", "codigo_area"];

    public function area()
    {
        return $this->belongsTo("\App\Models\Area", "codigo_area");
    }

    public function objeto()
    {
        return $this->hasMany("App\Models\Object", "codigo", 'id');
    }

    public function getCodigoArea($codigo)
    {
        $where = current($this->where("codigo", "=",$codigo)->first()->toArray());
        return $where['codigo_area'];
    }
    
}
