<%-- 
    Document   : listaServiço
    Created on : 24/10/2020, 20:09:30
    Author     : Ygor
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Servico</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(idServico, nomeServico){
                $('#nomeServico').html(nomeServico);
                $('#idServico').val(idServico);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por atualizar o servico
            function atualizarServico(idServico) {
                //Envia a requisicao GET para o BD atualizar o servico
                $.get("AtualizarServico?idServico="+idServico, function(resposta) {
                    
                });
            }
            
            //Funcao responsavel por excluir o servico
            function excluirServico() {
                var idServico = $('#idServico').val();
                
                //Envia a requisicao GET para o BD deletar o servico
                $.get("ExcluirServico?idServico="+idServico, function(resposta) {
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
        <h1>Lista de Servico</h1>
        
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>

        <table>
            <thead>
                <th>idServico</th>
		<th>Nome</th>
		<th>Descricao</th>
		<th>Preco</th>
		<th>Categoria</th>
		<th>Grau Complexidade</th>
		<th>Tipo Serviço</th>
		<th>Agendar Serviço</th>
		<th>Codigo Loja</th>
		<th>Data Cadastro</th>
            </thead>
            <tbody>
                <c:forEach var="servico" items="${listaServicos}">
                    <tr>
                        <td>${servico.idProduto}</td>
                        <td>${servico.nome}</td>
                        <td>${servico.descricao}</td>
                        <td>${servico.preco}</td>
                        <td>${servico.categoria}</td>
                        <td>${servico.grauComplexidade}</td>
                        <td>${servico.tipoServico}</td>
                        <td>${servico.agendarServico}</td>
                        <td>${servico.idLoja}</td>
                        <td>${servico.dataCadastro}</td>
                        <td><a href="AtualizarServico?idServico=${servico.idServico}"><button type="button" class="btn btn-primary">Atualizar</button></a></td>
                        <td><button type="button" class="btn btn-primary" onclick="mostrarModalExclusao('${servico.idServico}', '${servico.nome}')">Excluir</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <div class="modal fade" id="modalExclusao" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
              <div class="modal-content">
                <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Confirmar exclusão</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                </div>
                <div class="modal-body">
                    Confirma a exclusão do servico <label id="nomeServico"></label> ?
                    <input id="idServico" hidden="true"/>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                  <button type="button" class="btn btn-primary" onclick="excluirServico()">Confirmar</button>
                </div>
              </div>
            </div>
          </div>
        
        <a href="index.jsp"><button type="button" class="btn btn-primary">Voltar</button></a>
    </body>
</html>
