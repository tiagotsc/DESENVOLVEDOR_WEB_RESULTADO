<?php

use Phalcon\Mvc\Model;

class Imovel extends Model
{
    /* Dica: Olhar Schema do Banco de dados para criar os atributos e relacionamentos corretamente */
    public $id;
    public $codigo;
    public $tipo_imovel_id;
    public $filial_id;
    public $logradouro_id;
    public $numero;
    public $tipo_negocio;
    public $valor_venda;
    public $valor_aluguel;
    public $dormitorios;
    public $area_terreno;
    public $banheiros;
    public $vagas_garagem;
    public $titulo_imovel;
    public $descricao;
    public $publicado;
    public $data_expiracao;
    public $ativo;
    
    public function initialize()
    {
        $this->setSource("imovel");

        $this->hasMany(
            'id',
            'imovel_imagem',
            'imovel_id'
        );

        $this->belongsTo(
            'tipo_imovel_id',
            'tipo_imovel',
            'id'
        );

        $this->belongsTo(
            'filial_id',
            'filial',
            'id'
        );

        $this->belongsTo(
            'logradouro_id',
            'logradouro',
            'id'
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

    public function afterFetch()
    { 
        $this->data_expiracao = ($this->data_expiracao == '0000-00-00 00:00:00')? '': implode('/',array_reverse(explode("-", substr($this->data_expiracao, 0, 10) )));
        $this->valor_venda = number_format($this->valor_venda, 2, ',', '.');
        $this->valor_aluguel = number_format($this->valor_aluguel, 2, ',', '.'); 
        $this->area_terreno = number_format($this->area_terreno, 2, '.', '');
    }

    public function beforeCreate()
    {
        $this->codigo = strtoupper($this->codigo);
        $this->data_expiracao = implode('-',array_reverse(explode("/", substr($this->data_expiracao, 0, 10) )));
        $this->valor_venda = str_replace(',','.',str_replace('.','', $this->valor_venda));
        $this->valor_aluguel = str_replace(',','.',str_replace('.','', $this->valor_aluguel));
    }

    public function beforeUpdate()
    {   
        $this->codigo = strtoupper($this->codigo);
        $this->data_expiracao = implode('-',array_reverse(explode("/", substr($this->data_expiracao, 0, 10) )));
        $this->valor_venda = str_replace(',','.',str_replace('.','', $this->valor_venda));
        $this->valor_aluguel = str_replace(',','.',str_replace('.','', $this->valor_aluguel));
    }

}
