<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Capsule\Manager as Capsule;


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

    public static function searchTagsAndTitle($search)
    {
        $s = $search."%";
        return Capsule::table('objetos_cabecera')
                            ->where('titulo', 'LIKE', $s)
                            ->orWhere('tags', 'like', "%".$search)
                            ->get();
    }
}
