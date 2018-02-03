<?php

use Phalcon\Mvc\Model;

class Logradouro extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    public $bairro_id;
    public $tipo;
    public $nome;
    
    public function initialize()
    {
        $this->setSource("logradouro");

        $this->belongsTo(
            'bairro_id',
            'bairro',
            'id'
        );

        $this->hasMany(
            'id',
            'imovel',
            'logradouro_id'
        );
    }

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }
    

}
