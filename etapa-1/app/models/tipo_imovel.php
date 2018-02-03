<?php

use Phalcon\Mvc\Model;

class Tipo_imovel extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    public $nome;
    
    public function initialize()
    {
        $this->setSource("tipo_imovel");

        $this->hasMany(
            'id',
            'imovel',
            'tipo_imovel_id'
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
