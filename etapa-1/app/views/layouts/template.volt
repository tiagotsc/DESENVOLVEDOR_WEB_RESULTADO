<!DOCTYPE html>
<html>
    <head>
        <title>Avaliação InfoIdéias</title>
        <meta charset="utf-8">
        <link type="text/css" rel="stylesheet" href="/css/bootstrap.min.css">
        <link type="text/css" rel="stylesheet" href="/css/estilo.css">
        <link type="text/css" rel="stylesheet" href="/css/jquery-ui.min.css">
        <link type="text/css" rel="stylesheet" href="/css/chosen.min.css">
    </head>
    <body>
        <nav class="navbar navbar-inverse">
            <div class="container-fluid">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    </button>
                    <!--<a class="navbar-brand" href="{{ link_to(['for':'site.inicio']) }}">Real State</a>-->
                </div>
                <div id="navbar" class="navbar-collapse collapse navbar-right">
                    <ul class="nav navbar-nav">
                    <li class="active">{{ link_to(['for':'site.inicio'], 'Início') }}</li>
                    <li>{{ link_to(['for':'site.imovel.listar'], 'Cadastro de Imóveis') }}</li>
                    </ul>
                </div>
            </div>
        </nav>
        {% block content %}{% endblock %}
        <!-- Styles/Scripts-->
        <link type="text/css" rel="stylesheet" href="/css/styles.css">
        <script type="text/javascript" src="/js/jquery-3.3.1.min.js"></script>
        <script type="text/javascript" src="/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="/js/scripts.js"></script>
        <script type="text/javascript" src="/js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="/js/jquery.maskMoney.min.js"></script>
        <script type="text/javascript" src="/js/jquery.mask.min.js"></script>
        <script type="text/javascript" src="/js/chosen.jquery.min.js"></script>
        <script type="text/javascript" src="/svg-with-js/js/fontawesome-all.js"></script>
        <script type="text/javascript" src="/js/config.js"></script>
        
        <input type="hidden" id="base_url" value="<?php echo $_SERVER['HTTP_HOST'] ?>" />
    </body>
</html>