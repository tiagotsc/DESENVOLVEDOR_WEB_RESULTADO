<?php

use Phalcon\Mvc\Controller;
use Phalcon\Tag;
use Phalcon\Mvc\Url;
use Phalcon\Http\Request;
use Phalcon\Filter;
use Phalcon\Http\Response;
use Phalcon\Paginator\Adapter\Model as PaginatorModel;

class ImovelController extends Controller
{

	public function listarAction()
	{
        $util = new Util();
        $lista = $util->montaCondicaoBusca('Imovel');
        list($campos, $condicao) = $lista; 
        
        foreach($campos as $campo => $valor){
            $this->view->$campo = $valor;
        }
        
        $res = Imovel::find(['conditions' => $condicao]);
        $currentPage = (int) $_GET['page'];

        $paginator = new PaginatorModel(
            [
                'data'  => $res,
                'limit' => 15,
                'page'  => $currentPage,
            ]
        );

        $this->view->tipoImovel = Tipo_imovel::find();
        $this->view->page = $paginator->getPaginate();
        $this->view->dados = $res;
    }

    public function frmAction($id = false)
	{ 
        $imagem = '';
        $bairro = '';
        $res = '';

        if($id){
            $res = Imovel::findFirst(['conditions' => "id = ".$id]);
            if($res){
                $lugar = Logradouro::findFirst(['conditions' => "id = ".$res->logradouro_id]);
                $img = ImovelImagem::findFirst(['conditions' => "imovel_id = ".$res->id]);
                $imagem = 'files/'.(($img->caminho)? $img->caminho: '');
                $bairro = $lugar->bairro_id;
            }
        }
        
        $this->view->id = $id;
        $this->view->bairro_id = $bairro;
        $this->view->imagem = $imagem;
        $this->view->dados = $res;
        $this->view->tipoImovel = Tipo_imovel::find();
        $this->view->filial = Filial::find();
        $this->view->bairro = Bairro::find();
        $this->view->logradouro = Logradouro::find(['columns' => "id , concat(tipo,' ',nome) AS nome"]);
    }
    
    public function removerAction()
	{
        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(
                [
                    "controller" => "imovel",
                    "action"     => "listar",
                ]
            );
        }
        try{
            $ok = true;
            $id = $this->request->getPost('apg_id', 'int');
            $this->db->begin();
            $res = Imovel::findFirst(['conditions' => "id = ".$id]);
            $img = ImovelImagem::findFirst(['conditions' => "imovel_id = ".$id]);
            if($img){
                unlink('files/'.$img->caminho);
                if($img->delete() === false){ 
                    $ok = false;
                }
            }
            if($res->delete() === false){
                $ok = false;
            }
            if($ok === true){
                $this->db->commit();
                $this->flashSession->success('Imóvel apagado com sucesso!');
            }else{
                $this->db->rollback();
                $this->flashSession->error('Erro! Imóvel não apagado!');
            }
        }catch( Exception $e ){      
            echo $e->getMessage();
        }
        $this->response->redirect("imoveis");
    }
    
    public function salvarAction()
    {

        if (!$this->request->isPost()) {
            return $this->dispatcher->forward(
                [
                    "controller" => "imovel",
                    "action"     => "adicionar",
                ]
            );
        }

        try{
            $_POST['publicado'] = (!isset($_POST['publicado']))? 'N': $_POST['publicado'];
            $ok = true;
            $this->db->begin();

            $imovel = new Imovel();
            $util = new Util();

            $filtros = $util->filtrosImovel();
            foreach($filtros as $campo => $filtro){
                if($campo != 'id'){
                    $imovel->$campo = $this->request->getPost($campo, $filtro);
                }
            }
            
            if( !empty($this->request->getPost('id', 'int')) ){
                $imovel->id = $this->request->getPost('id', 'int'); 
                $res = $imovel->save();  
                $id_imovel = $this->request->getPost('id', 'int');
                $acao = "alterado";
            }else{
                $res = $imovel->save();  
                $id_imovel = Imovel::maximum(["column" => "id",]);
                $acao = "cadastrado";
            }
            
            if ($res === false) {
                $ok = false;
            }

            if ($this->request->hasFiles()) {
                $upload_dir = 'files/';
                $img = ImovelImagem::findFirst(['conditions' => "imovel_id = ".$id_imovel]); 
                $upload = $util->upload($id_imovel, $upload_dir, $img, array('png', 'jpeg', 'jpg'));
                if($upload['status']){
                    if($res === true){
                        $ok = true;
                        $redimensionar = $util->redimensionar($upload_dir, $upload['nome'], $upload['extensao'], $id_imovel, 400, null);
                        if($redimensionar){
                            $imagem = new ImovelImagem();
                            $imagem->imovel_id = $id_imovel;
                            $imagem->caminho = $id_imovel.'.'.$upload['extensao'];
                            if($imagem->save() === false){
                                $ok = false;
                            }
                        }
                    }
                }
            }

            if($ok === true){
                $this->db->commit();
                $this->flashSession->success('Imóvel '.$acao.' com sucesso!');
                $this->response->redirect("imoveis/alterar/".$id_imovel);
            }else{
                $this->db->rollback();
                $this->flashSession->error('Erro! imóvel não '.$acao.'!');
                $this->response->redirect("imoveis/adicionar");
            }

        }catch( Exception $e ){      
            echo $e->getMessage();
        }
  
    }

    public function apagaImagemAction()
    {
        $imagemCaminho = $this->request->getPost('apg_img', 'string');
        $imagem = str_replace('files/','',$imagemCaminho);
        $id_imovel = explode('.',$imagem);
        
        $busca = ImovelImagem::findFirst(['conditions' => "imovel_id = ".$id_imovel[0]]);

        if($busca->delete() and unlink($imagemCaminho)){
            $this->flashSession->success('Imagem apagada com sucesso!');
        }else{
            $this->flashSession->error('Erro! ao apagar imagem!');
        }
        
        $this->response->redirect("imoveis/alterar/".$id_imovel[0]);
   
    }

    public function ajaxGetLogradourosAction()
    {
        $bairro = $this->request->getPost('bairro', 'int');
        echo json_encode(Logradouro::find(['columns' => "id , concat(tipo,' ',nome) AS nome", 'conditions' => "bairro_id = ".$bairro])->toArray());
    }

    public function ajaxExisteCodigoAction()
    { 
        $valor = strtoupper($this->request->getPost('codigo', 'string'));
        $res = Imovel::find(['conditions' => "codigo = '". $valor."'"]);
        if(count($res) > 0){
            $status = array('status' => 'SIM');
        }else{
            $status = array('status' => 'NAO');
        }
        echo json_encode($status);
    }

}
