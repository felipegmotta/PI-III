<%-- 
    Document   : listaLojas
    Created on : 25/10/2020, 16:13:31
    Author     : Edu Franco
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consulta de Lojas</title>
        
                <script type="text/javascript">
            function mostrarModalExclusao(idLoja, nomeLoja){
                $('#nomeLoja').html(nomeLoja);
                $('#idLoja').val(idLoja);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por atualizar a loja
            function atualizarLoja(idLoja) {
                //Envia a requisicao GET para o BD atualizar a loja
                $.get("AtualizarLoja?idLoja="+idLoja, function(resposta) {
                    
                });
            }
            
            //Funcao responsavel por excluir a loja
            function excluirLoja() {
                var idLoja = $('#idLoja').val();
                
                //Envia a requisicao GET para o BD deletar a loja
                $.get("ExcluirLoja?idLoja="+idLoja, function(resposta) {
                    $('#modalExclusao').modal('hide');
                    if (resposta === "true") {
                        exibeMensagemSucesso();
                    } else {
                        exibeMensagemErro();
                    }
                });
            }
            
            //Exibe um toast de sucesso
            function exibeMensagemSucesso() {
                $('#msgToast').html("Operacao realizada com sucesso!");
                $('#toast').toast('show');
            }
            
            //Exibe um toast de erro
            function exibeMensagemErro() {
                $('#msgToast').html("Erro ao realizar a operacao.");
                $('#toast').toast('show');
            }
        </script>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
