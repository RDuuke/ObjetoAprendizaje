<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Capsule\Manager as Capsule;


class Object extends Model {

    protected $table = "objetos_cabecera";
    protected $fillable = ["titulo", "adjunto", "descripcion", "tags", "licencia", "descargas",  "idioma", "cobertura", "estructura", "nivel_agregacion", "pais_proveedor"];

    public function licencia()
    {
        return $this->belongsTo("\App\Models\Licence", "licencia");
    }

    public function nucleo()
    {
        return $this->hasOne("\App\Models\objectRelation", "codigo_objeto", "id");
    }

    public function objeto_tecnhincal()
    {
        return $this->hasOne("App\Models\objectTechnical", "codigo_objeto", 'id');
    }

    public function objeto_cycle()
    {
        return $this->hasOne("App\Models\objectCycle", "codigo_objeto", 'id');
    }
    public function objeto_copyrigth()
    {
        return $this->hasOne("App\Models\objectCopyRigth", "codigo_objeto", 'id');
    }

    public function objeto_education()
    {
        return $this->hasOne("App\Models\objectEducation", "codigo_objeto", 'id');
    }
    public function objeto_meta()
    {
        return $this->hasOne("App\Models\objectMeta", "codigo_objeto", 'id');
    }


    public static function searchTagsAndTitle($search)
    {
        $s = $search."%";
        return Capsule::table('objetos_cabecera')
                            ->where('titulo', 'LIKE', "%".$s)
                            ->orWhere('tags', 'LIKE', "%".$s)
                            ->get();
    }

    public static function searchAdvanced($search)
    {
        return Capsule::table('objetos_relacion')
                            ->join('nucleo_conocimiento', 'objetos_relacion.codigo_area', '=', 'nucleo_conocimiento.codigo')
                            ->join('areas_conocimientos', 'nucleo_conocimiento.codigo_area', '=', 'areas_conocimientos.codigo')
                            ->join('objetos_cabecera', 'objetos_relacion.codigo_objeto', '=', 'objetos_cabecera.id')
                            ->join('objetos_derecho', 'objetos_cabecera.id', '=', 'objetos_derecho.codigo_objeto')
                            ->whereIn('objetos_relacion.codigo_area', $search['nucleos'])
                            ->WhereIn('objetos_derecho.costo', $search['licences'])
                            ->Where('areas_conocimientos.id', '=', $search['area'])
                            ->select('objetos_cabecera.*')
                            ->get();
    }
}
