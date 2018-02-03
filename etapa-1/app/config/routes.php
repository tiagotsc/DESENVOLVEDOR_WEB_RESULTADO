<?php
use Phalcon\Mvc\Router;
$router = new Router(false);
$router->removeExtraSlashes(true);
$router->notFound(['controller' => 'Error', 'action' => 'error404']);
$router->add('/',       ['controller' => 'Index', 'action' => 'index'])->setName('site.inicio');


$router->add('/imoveis',                        ['controller' => 'Imovel', 'action' => 'listar'])       ->setName('site.imovel.listar');
$router->add('/imoveis/adicionar',              ['controller' => 'Imovel', 'action' => 'frm'])       ->setName('site.imovel.adicionar');
$router->add('/imoveis/apagaImagem',              ['controller' => 'Imovel', 'action' => 'apagaImagem'])       ->setName('site.imovel.apagaImagem');
$router->add('/imoveis/alterar/{id}',              ['controller' => 'Imovel', 'action' => 'frm'])       ->setName('site.imovel.alterar');
$router->add('/imoveis/salvar',              ['controller' => 'Imovel', 'action' => 'salvar'])       ->setName('site.imovel.salvar');
$router->add('/imoveis/remover',              ['controller' => 'Imovel', 'action' => 'remover'])       ->setName('site.imovel.remover');
$router->add('/imoveis/ajaxGetLogradouros',              ['controller' => 'Imovel', 'action' => 'ajaxGetLogradouros'])       ->setName('site.imovel.ajaxGetLogradouros');
$router->add('/imoveis/ajaxExisteCodigo',              ['controller' => 'Imovel', 'action' => 'ajaxExisteCodigo'])       ->setName('site.imovel.ajaxExisteCodigo');


return $router;