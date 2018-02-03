$( document ).ready(function() {

    var baseUrl = 'http://'+$("#base_url").val()+'/';
    if($("#frm-imoveis-pesq").length > 0){ // Pesquisa
        $(".deletar").click(function(){
            $("#apg_nome").val($(this).attr("nome"));
            $("#apg_id").val($(this).attr("key"));
        });
        $(".fechar").click(function(){ 
            $("#apg_nome").val('');
            $("#apg_id").val('');
        });
    }
    if($("#frm-imoveis").length > 0){ // Frm
        $("#logradouro_id").chosen({no_results_text: "Não localizados!"});
        $(".dinheiro").maskMoney({prefix:'R$ ', allowNegative: true, thousands:'.', decimal:',', affixesStay: false});
        $(".metragem").maskMoney({prefix:'', allowNegative: true, thousands:'', decimal:'.', affixesStay: false});
        $("#vender").hide();
        $("#alugar").hide();
        $("#divDataExpiracao").hide();
        $(".localidade").hide();

        if($("#data_expiracao").val() != ''){
            $("input[name='publicado']").prop("checked", true);
            $("#divDataExpiracao").show();
        }
        
        if($("#id").length == 0){
            $("input[name='publicado']").prop("checked", true);
            $("#divDataExpiracao").show();
        }

        // INICIO EDITAR
        if($("#id").length > 0){

            if($("#apg_imagem").length > 0){
                $("#apg_imagem").click(function(event){
                    event.preventDefault();
                    var r = confirm("Deseja apagar a imagem?");
                    if (r == true) {
                        $("#apg_img").val($(this).attr("imagem"));
                        $("#frm-imagem-apg").submit();
                    } else {
                        $("#apg_img").val('');
                    }
                });
            }

            $("#codigo").attr('readonly', true);
            if($("#id").val() != ''){
                if( $("input[name='publicado']").prop("checked")){
                    $("#divDataExpiracao").show();
                }else{
                    $("#divDataExpiracao").hide();
                }
                
                    $(".localidade").show();
                
                if($('[type=radio][name=tipo_negocio]:checked').val() == 'V'){ // Vender
                    $("#vender").show();
                }else{ // Alugar
                    $("#alugar").show();
                }
            }
        }
        // FIM EDITAR

        $("#codigo").keyup(function(){
            if($(this).val().length == 4){
                $.ajax({
                dataType: "json",
                type: 'POST',
                url: baseUrl+'imoveis/ajaxExisteCodigo',
                data: {'codigo': $(this).val()},
                success: function(data) { 
                    if(data.status == 'SIM'){
                        alert("Código já existe, tente outro, por favor.");
                        $("#codigo").val('');
                    }
                },
                error: function(data){
                    //alert("Erro ao verificar código");
                }
                });
            }
        });

        $("#bairro").change(function(){
            if($(this).val() != ''){

                $.ajax({
                dataType: "json",
                type: 'POST',
                url: baseUrl+'imoveis/ajaxGetLogradouros',
                data: {'bairro': $(this).val()},
                success: function(data) { 
                    if(data.length > 0){ 
                        $("#logradouro_id").html('<option value="">Por favor, selecione uma opção</option>');
                        $.each(data, function() { 
                            $("#logradouro_id").append('<option value="'+this.id+'">'+this.nome+'</option>');
                        });
                        $("#logradouro_id").trigger("chosen:updated");
                        $("#logradouro_id").trigger("liszt:updated");
                    }
                },
                error: function(data){
                    //alert('erro ao carregar logradouro');
                }
                });
                $(".localidade").show();
            }else{
                $("#logradouro_id").html('<option value="">Por favor, selecione uma opção</option>');
                $("#logradouro_id").trigger("chosen:updated");
                $("#logradouro_id").trigger("liszt:updated");
                $(".localidade").hide();
            }
            
        });

        $("input[name='tipo_negocio']").click(function(){
            if($(this).val() == 'V'){
                $("#vender").show();
                $("#alugar").hide();
                $("#valor_aluguel").val('');
            }else{
                $("#vender").hide();
                $("#alugar").show();
                $("#valor_venda").val('');
            }
        });

        $(".numero").keyup(function(event){ 
            if($(this).val() != ''){ 
                if(('0123456789'.search(event.key) >= 0) == false){
                    $(this).val('');
                }
            }
            
        });

        $("#publicado").click(function(){
            if($(this).prop("checked")){
                $("#divDataExpiracao").show();
            }else{
                $("#divDataExpiracao").hide();
                $("#data_expiracao").val('');
            }
        });

        $(".data").datepicker({
            dateFormat: 'dd/mm/yy',
            dayNames: ['Domingo','Segunda','Ter&ccedil;a','Quarta','Quinta','Sexta','S&aacute;bado','Domingo'],
            dayNamesMin: ['D','S','T','Q','Q','S','S','D'],
            dayNamesShort: ['Dom','Seg','Ter','Qua','Qui','Sex','S&aacute;b','Dom'],
            monthNames: ['Janeiro','Fevereiro','Mar&ccedil;o','Abril','Maio','Junho','Julho','Agosto','Setembro','Outubro','Novembro','Dezembro'],
            monthNamesShort: ['Jan','Fev','Mar','Abr','Mai','Jun','Jul','Ago','Set','Out','Nov','Dez'],
            nextText: 'Pr&oacute;ximo',
            prevText: 'Anterior',
            minDate    : new Date(),
            
            // Traz o calendário input datepicker para frente da modal
            beforeShow :  function ()  { 
                setTimeout ( function (){ 
                    $ ( '.ui-datepicker' ). css ( 'z-index' ,  99999999999999 ); 
                },  0 ); 
            } 
        });

        $.validator.setDefaults({ ignore: ":hidden:not(select)" })
        $("#frm-imoveis").validate({
            debug: false,
            rules: {
                codigo: {
                    required: true
                },
                titulo_imovel: {
                    required: true
                },
                tipo_imovel_id: {
                    required: true
                },
                filial_id: {
                    required: true
                },
                bairro: {
                    required: true
                },
                logradouro_id: {
                    required: true
                },
                numero: {
                    required: true
                },
                tipo_negocio: {
                    required: true
                },
                valor_venda:{
                    required:{
                        depends: function(element){
                            var status = false;
                            if( $("input[name='tipo_negocio']:checked").val() == 'V'){
                                var status = true;
                            }
                            return status;
                        }
                    }
                },
                valor_aluguel:{
                    required:{
                        depends: function(element){
                            var status = false;
                            if( $("input[name='tipo_negocio']:checked").val() == 'A'){
                                var status = true;
                            }
                            return status;
                        }
                    }
                },
                data_expiracao:{
                    required:{
                        depends: function(element){
                            var status = false;
                            if( $("input[name='publicado']").prop("checked")){
                                var status = true;
                            }
                            return status;
                        }
                    }
                },
            },
            messages: {
                codigo: {
                    required: "Informe o código."
                },
                titulo_imovel: {
                    required: "Informe o título."
                },
                tipo_imovel_id: {
                    required: "Selecione o tipo de imóvel."
                },
                filial_id: {
                    required: "Selecione a filial."
                },
                bairro: {
                    required: "Selecione o bairro."
                },
                logradouro_id: {
                    required: "Selecione o logradouro."
                },
                numero: {
                    required: "Informe o número."
                },
                tipo_negocio: {
                    required: "Selecione o tipo de negócio."
                },
                valor_venda: {
                    required: "Informe o valor."
                },
                valor_aluguel: {
                    required: "Informe o valor."
                },
                data_expiracao: {
                    required: "Informe a data."
                }
            }
        });        
    }
});