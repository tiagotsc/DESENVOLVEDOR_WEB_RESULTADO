<?php
use Phalcon\Http\Request;
use Phalcon\Filter;

class Util{

    public function montaCondicaoBusca($tabela = 'Imovel')
    {
        $resquest = new Request();
        $filter = new Filter();
        $funcao = 'filtros'.$tabela;
        $filtros = $this->$funcao();
        $condicao = '1=1';
        foreach($filtros as $campo => $filtro){
            if(isset($_GET[$campo])){ 
               $res = $filter->sanitize($resquest->get($campo), $filtro);
               if($res != ''){
                    switch($filtro){
                            case 'alphanum':
                            case 'string':
                                $condicao .= " AND ".$campo." LIKE '%".$res."%'";
                            break;
                            case 'int':
                                $condicao .= " AND ".$campo." = ".$res;
                            break;
                            default:
                                $condicao .= "";
                    }
                    $campos[$campo] = $res = $filter->sanitize($resquest->get($campo), $filtro);
                }else{
                    $campos[$campo] = '';
                }
            }else{
                $campos[$campo] = '';
            }   
        }
        return array($campos, $condicao);
    }

    public function filtrosImovel()
    {

        $campos['codigo'] =             'alphanum';
        $campos['titulo_imovel'] =      'string';
        $campos['tipo_imovel_id'] =     'int';
        $campos['filial_id'] =          'int';
        $campos['publicado'] =          'string';
        $campos['data_expiracao'] =     'string';
        $campos['ativo'] =              'string';
        $campos['logradouro_id'] =      'int';
        $campos['numero'] =             'int';
        $campos['tipo_negocio'] =       'string';
        $campos['valor_venda'] =        'string';
        $campos['valor_aluguel'] =      'string';
        $campos['dormitorios'] =        'int';
        $campos['area_terreno'] =       'string';
        $campos['banheiros'] =          'int';
        $campos['vagas_garagem'] =      'int';
        $campos['descricao'] =          'string';
        $campos['id'] =                 'int';

        return $campos;
    }

    public function upload($id_imovel, $upload_dir, $img, $extensos)
    {
        $resquest = new Request();
        $file = $resquest->getUploadedFiles();
        
        if(in_array($file[0]->getExtension(), $extensos )){ 
            
            if($img){
                unlink($upload_dir.$img->caminho);
                if($img->delete() === false){ 
                    $ok = false;
                }
            }
            
            if (!is_dir($upload_dir)) {
                mkdir($upload_dir, 0755);
            }

            $res['nome'] = $file[0]->getName();
            $res['extensao'] = $file[0]->getExtension();
            $res['status'] = $file[0]->moveTo($upload_dir . $file[0]->getName());
            return $res;
        }else{
            return false;
        }
    }

    public function redimensionar($upload_dir, $nome, $extensao, $novoNome, $width = 400, $height = null)
    {
        $img = new Phalcon\Image\Adapter\Gd($upload_dir . $nome); 
        $path_mini = $upload_dir.$novoNome.".".$extensao; 
        //400 px width, null height
        $img->resize($width,$height, \Phalcon\Image::WIDTH);
        if($img->save($path_mini, 100)){
            $ok = true;
            if(!unlink($upload_dir . $nome)){
                $ok = false;
            }
            return $ok;
        }else{
            return false;
        }
    }

}