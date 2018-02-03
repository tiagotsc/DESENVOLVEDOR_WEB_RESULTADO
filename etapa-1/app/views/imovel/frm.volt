{% extends "layouts/template.volt" %}

{% block content %}
{{ form('imoveis/apagaImagem', 'id': 'frm-imagem-apg', 'method': 'post') }}
    <input type="hidden" id="apg_img" name="apg_img" />
</form>
<div class="container">
    <div class="row">
        <div class="col-xs-12 text-center">
            <h1><a title="Voltar para pesquisa" href="{{  url('imoveis') }}"><i style="float:left" class="fas fa-home"></i></a>Adicionar Imovel</h1>
        </div>
    </div>
    <p><?php $this->flashSession->output() ?></p>
    <div class="row">
            {{ form('imoveis/salvar', 'id': 'frm-imoveis', 'method': 'post', 'enctype': 'multipart/form-data') }}
        <div class="col-xs-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Dados Básicos</h3>
                </div>
                <div class="panel-body">
                    <div class="col-xs-4">
                        <label for='codigo'>Código<span class="obrigatorio">*</span></label>
                        {% if dados.codigo is defined %}
                        {% set var_codigo = dados.codigo %}
                        {% else %}
                        {% set var_codigo = '' %}
                        {% endif %}
                        {{ text_field('codigo', 'class':'form-control', 'maxlength': 4, 'value': var_codigo , 'placeholder':'No máximo 4 caracteres') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='titulo_imovel'>Título do imóvel<span class="obrigatorio">*</span></label>
                        {% if dados.titulo_imovel is defined %}
                        {% set var_titulo_imovel = dados.titulo_imovel %}
                        {% else %}
                        {% set var_titulo_imovel = '' %}
                        {% endif %}
                        {{ text_field('titulo_imovel', 'value': var_titulo_imovel, 'class':'form-control') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='tipo_imovel_id'>Tipo de imóvel<span class="obrigatorio">*</span></label>
                        {% if dados.tipo_imovel_id is defined %}
                        {% set var_tipo_imovel_id = dados.tipo_imovel_id %}
                        {% else %}
                        {% set var_tipo_imovel_id = '' %}
                        {% endif %}
                        {{ select('tipo_imovel_id', tipoImovel, 'using': ['id', 'nome'] , 'value': var_tipo_imovel_id, 'class':'form-control', 
                        'useEmpty': true, 'emptyText': 'Por favor, seleccione uma opção', 'emptyValue': '') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='filial_id'>Filial<span class="obrigatorio">*</span></label>
                        {% if dados.filial_id is defined %}
                        {% set var_filial_id = dados.filial_id %}
                        {% else %}
                        {% set var_filial_id = '' %}
                        {% endif %}
                        {{ select('filial_id', filial, 'using': ['id', 'nome'] , 'value': var_filial_id, 'class':'form-control', 
                        'useEmpty': true, 'emptyText': 'Por favor, selecione uma opção', 'emptyValue': '') }}
                    </div>
                    <div class="col-xs-4">
                        <label id="labelPublicado" for='publicado'>Publicar:</label>
                        {% if dados.publicado is defined %}
                        {% set var_publicado = dados.publicado %}
                        {% else %}
                        {% set var_publicado = '' %}
                        {% endif %}
                        <input type="checkbox" id="publicado" {% if var_publicado == "S" %} checked {% endif %} name="publicado" value="S"/> Sim
                    </div>
                    <div id="divDataExpiracao" class="col-xs-4">
                        <label for='data_expiracao'>Data de expiração<span class="obrigatorio">*</span></label>
                        {% if dados.data_expiracao is defined %}
                        {% set var_data_expiracao = dados.data_expiracao %}
                        {% else %}
                        {% set var_data_expiracao = '' %}
                        {% endif %}
                        {{ text_field('data_expiracao', 'readonly': 'readonly', 'value': var_data_expiracao, 'class':'data form-control') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='ativo'>Status</label>
                        {% if dados.ativo is defined %}
                        {% set var_ativo = dados.ativo %}
                        {% else %}
                        {% set var_ativo = '' %}
                        {% endif %}
                        {{ select('ativo', ['S':'Sim', 'N':'Não'], 'value': var_ativo , 'class':'form-control') }}
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Localizacao</h3>
                </div>
                <div class="panel-body">
                    <div class="col-xs-4">
                        <label for='bairro'>Bairro<span class="obrigatorio">*</span></label>
                        {{ select('bairro', bairro, 'using': ['id', 'nome'], 'value': bairro_id , 'class':'form-control', 
                        'useEmpty': true, 'emptyText': 'Por favor, selecione uma opção', 'emptyValue': '') }}
                    </div>
                    <div class="col-xs-4 localidade">
                        <label id="labelLogradouro" for='logradouro_id'>Logradouro<span class="obrigatorio">*</span></label>
                        {% if dados.logradouro_id is defined %}
                        {% set var_logradouro_id = dados.logradouro_id %}
                        {% else %}
                        {% set var_logradouro_id = '' %}
                        {% endif %}
                        {{ select('logradouro_id', logradouro, 'using': ['id', 'nome'], 'value': var_logradouro_id , 'class':'form-control', 
                        'useEmpty': true, 'emptyText': 'Por favor, selecione uma opção', 'emptyValue': '') }}
                    </div>
                    <div class="col-xs-4 localidade">
                        <label for='numero'>Número<span class="obrigatorio">*</span></label>
                        {% if dados.numero is defined %}
                        {% set var_numero = dados.numero %}
                        {% else %}
                        {% set var_numero = '' %}
                        {% endif %}
                        {{ text_field('numero', 'class':'form-control numero', 'value': var_numero, 'placeholder':'Somente dígitos') }}
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Valores</h3>
                </div>
                <div class="panel-body">
                    <div class="col-xs-4">
                        <label class="block" for='tipo_negocio'>Tipo negócio<span class="obrigatorio">*</span></label>
                        {% if dados.tipo_negocio is defined %}
                        {% set var_tipo_negocio = dados.tipo_negocio %}
                        {% else %}
                        {% set var_tipo_negocio = '' %}
                        {% endif %}
                        <label>
                        <input type="radio" name="tipo_negocio" {% if var_tipo_negocio === "V" %} checked {% endif %} value="V"><span class="estiloRadio">Vender</span>
                        </label>
                        <label>
                        <input type="radio" name="tipo_negocio" {% if var_tipo_negocio === "A" %} checked {% endif %} value="A"><span class="estiloRadio">Alugar</span>
                        </label>
                    </div>
                    <div id="vender" class="col-xs-4">
                        <label for='valor_venda'>Valor venda<span class="obrigatorio">*</span></label>
                        {% if dados.valor_venda is defined %}
                        {% set var_valor_venda = dados.valor_venda %}
                        {% else %}
                        {% set var_valor_venda = '' %}
                        {% endif %}
                        {{ text_field('valor_venda', 'value': var_valor_venda, 'class':'form-control dinheiro') }}
                    </div>
                    <div id="alugar" class="col-xs-4">
                        <label for='valor_aluguel'>Valor alugar<span class="obrigatorio">*</span></label>
                        {% if dados.valor_aluguel is defined %}
                        {% set var_valor_aluguel = dados.valor_aluguel %}
                        {% else %}
                        {% set var_valor_aluguel = '' %}
                        {% endif %}
                        {{ text_field('valor_aluguel', 'value': var_valor_aluguel, 'class':'form-control dinheiro') }}
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Imagem</h3>
                    </div>
                    <div class="panel-body">
                        
                        <div id="selecImagem" class="col-xs-4">
                            <div class="alert alert-warning">
                                <strong>Formato aceito!</strong> Somente jpg/jpeg ou png.
                            </div>
                            <label for='file_imagem'>Selecionar imagem:</label>
                            <input type="file" id="file_imagem" name="file_imagem">
                        </div>

                        <div class="col-xs-8 text-right">
                            {% if imagem !== "files/" and imagem != '' %}
                            <img width="250px" alt="{{imagem}}" src="{{url(imagem)}}">
                            <a title="Apagar" id="apg_imagem" imagem="{{ imagem }}" href="#"><i class="fas fa-trash-alt fa-lg"></i></a>
                            {% endif %}
                        </div>
                    </div>
                </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Detalhes</h3>
                </div>
                <div class="panel-body">
                    <div class="col-xs-4">
                        <label for='dormitorios'>Dormitórios</label>
                        {% if dados.numero is defined %}
                        {% set var_numero = dados.numero %}
                        {% else %}
                        {% set var_numero = '' %}
                        {% endif %}
                        {{ text_field('dormitorios', 'class':'form-control numero', 'value': var_numero, 'placeholder':'Quantidade') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='area_terreno'>Metragem (m²)</label>
                        {% if dados.area_terreno is defined %}
                        {% set var_area_terreno = dados.area_terreno %}
                        {% else %}
                        {% set var_area_terreno = '' %}
                        {% endif %}
                        {{ text_field('area_terreno', 'value': var_area_terreno, 'class':'form-control metragem') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='banheiros'>Banheiros</label>
                        {% if dados.banheiros is defined %}
                        {% set var_banheiros = dados.banheiros %}
                        {% else %}
                        {% set var_banheiros = '' %}
                        {% endif %}
                        {{ text_field('banheiros', 'value': var_banheiros, 'class':'form-control numero', 'placeholder':'Quantidade') }}
                    </div>
                    <div class="col-xs-4">
                        <label for='vagas_garagem'>Vaga garagem</label>
                        {% if dados.vagas_garagem is defined %}
                        {% set var_vagas_garagem = dados.vagas_garagem %}
                        {% else %}
                        {% set var_vagas_garagem = '' %}
                        {% endif %}
                        {{ text_field('vagas_garagem', 'value': var_vagas_garagem, 'class':'form-control numero', 'placeholder':'Quantidade') }}
                    </div>
                    <div class="col-xs-12">
                        <label for="descricao">Descrição</label>
                        {% if dados.descricao is defined %}
                        {% set var_descricao = dados.descricao %}
                        {% else %}
                        {% set var_descricao = '' %}
                        {% endif %}
                        <textarea class="form-control" rows="5" id="descricao" name="descricao">{{var_descricao}}</textarea>
                    </div>
                </div>
            </div>

            <div class="text-center">
                {% if dados.id is defined %} 
                <input type="hidden" id="id" name="id" value="{{dados.id}}" />
                {% endif %}
                <input type="submit" value="Salvar" class="btn btn-success">
            </div>
        </div>
        <?= $this->tag->endForm() ?>
    </div>
</div>
{% endblock %}
