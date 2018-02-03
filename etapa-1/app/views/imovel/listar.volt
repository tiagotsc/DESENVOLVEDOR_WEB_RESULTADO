{% extends "layouts/template.volt" %}

{% block content %}
<!-- Modal -->
<div id="apagar" class="modal fade" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        {{ form('imoveis/remover', 'id': 'frm-imoveis-apg', 'method': 'post') }}
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="fechar close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Deseja apagar o imóvel?</h4>
            </div>
            <div class="modal-body">
                <input type="text" id="apg_nome" class="form-control" readonly />
            </div>
            <div class="modal-footer">
                <input type="hidden" id="apg_id" name="apg_id" />
                <button type="button" class="fechar btn btn-default" data-dismiss="modal">Não</button>
                <button type="submit" class="btn btn-primary">Sim</button>
            </div>
        </div>
        </form>
    </div>
</div>
<div class="container">
    <div class="row">
        <div class="col-xs-12 text-center">
            <h1>Listar Imóveis</h1>
        </div>
    </div>

    <p><?php $this->flashSession->output() ?></p>
    <div class="row">
        
        <div class="col-xs-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Buscar</h3>
                </div>
                <div class="panel-body">
                        {{ form('imoveis', 'id': 'frm-imoveis-pesq', 'method': 'get') }}
                        <div class="row">
                            <div class="col-xs-12 col-sm-3" class="input-group">
                                <label for="codigo">Código</label>
                                {{ text_field('codigo', 'value': codigo, 'maxlength': 4, 'class':'form-control') }}
                            </div>
                            <div class="col-xs-12 col-sm-3" class="input-group">
                                <label for="titulo_imovel">Título</label>
                                {{ text_field('titulo_imovel', 'value': titulo_imovel, 'class':'form-control') }}
                            </div>
                            <div class="col-xs-12 col-sm-3" class="input-group">
                                <label for="tipo_imovel_id">Tipo de imóvel</label>
                                {{ select('tipo_imovel_id', tipoImovel, 'using': ['id', 'nome'] , 'value': tipo_imovel_id, 'class':'form-control', 
                                'useEmpty': true, 'emptyText': '', 'emptyValue': '') }}
                            </div>
                            <div class="col-xs-12 col-sm-3">
                                <input type="submit" value="Buscar" class="marginTop btn btn-success">
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-xs-12 text-center">
                <hr>
            {{ link_to(['for':'site.imovel.adicionar'], 'Adicionar', 'class': 'btn btn-default btn-lg') }}
            <hr>
        </div>

        <div class="col-xs-12">
            <table class="table table-striped">
                <tr>
                    <th>Código</th>
                    <th>Título</th>
                    <th>Tipo de Imóvel</th>
                    <th>Tipo de Negócio</th>
                    <th>Valor do Imóvel</th>
                    <th class="text-center">Ações</th>
                </tr>
                {% for res in page.items %}
                <tr>
                    <td>{{ res.codigo }}</td>
                    <td>{{ res.titulo_imovel }}</td>
                    <td>{{ res.tipo_imovel.nome }}</td>
                    <td>{% if res.tipo_negocio === "A" %} Aluguel {% else %} Venda {% endif %}</td>
                    <td>R$ {% if res.tipo_negocio === "A" %} {{ res.valor_aluguel }} {% else %} {{ res.valor_venda }} {% endif %}</td>
                    <td class="text-center">
                        <a title="Editar" href="{{  url('imoveis/alterar/') }}{{ res.id }}" class="icone" ><i class="fas fa-edit fa-lg"></i></a>
                        <a title="Apagar" href="#" class="icone deletar" data-toggle="modal" data-target="#apagar" key="{{ res.id }}" nome="{{ res.titulo_imovel }}"><i class="fas fa-trash-alt fa-lg"></i></a>
                    </td>
                </tr>
                {% endfor  %}
            </table>
            <p class="text-right"><b>Página {{ page.current }} de {{ page.total_pages }}</b></p>
            <ul class="pagination">
                <li><a href="{{  url('imoveis') }}">Primeira</a></li>
                <li><a href="{{  url('imoveis') }}?page= {{ page.before }}&codigo={{ codigo }}&titulo_imovel={{ titulo_imovel }}&tipo_imovel_id={{ tipo_imovel_id }}">Anterior</a></li>
                <li><a href="{{  url('imoveis') }}?page= {{ page.next }}&codigo={{ codigo }}&titulo_imovel={{ titulo_imovel }}&tipo_imovel_id={{ tipo_imovel_id }}">Próxima</a></li>
                <li><a href="{{  url('imoveis') }}?page= {{ page.last }}&codigo={{ codigo }}&titulo_imovel={{ titulo_imovel }}&tipo_imovel_id={{ tipo_imovel_id }}">Última</a></li>
            </ul>
        </div>
    </div>
</div>
{% endblock %}
