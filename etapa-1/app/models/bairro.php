<?php

use Phalcon\Mvc\Model;

class Bairro extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    public $nome;
    
    public function initialize()
    {
        $this->setSource("bairro");

        $this->hasMany(
            'id',
            'logradouro',
            'bairro_id'
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
