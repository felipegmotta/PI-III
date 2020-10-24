<%-- 
    Document   : listaProdutos
    Created on : 10/10/2020, 12:03:30
    Author     : Felipe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Produtos</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(idProduto, nomeProduto){
                $('#nomeProduto').html(nomeProduto);
                $('#idProduto').val(idProduto);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por atualizar o produto
            function atualizarProduto(idProduto) {
                //Envia a requisicao GET para o BD atualizar o produto
                $.get("AtualizarProduto?idProduto="+idProduto, function(resposta) {
                    
                });
            }
            
            //Funcao responsavel por excluir o produto
            function excluirProduto() {
                var idProduto = $('#idProduto').val();
                
                //Envia a requisicao GET para o BD deletar o produto
                $.get("ExcluirProduto?idProduto="+idProduto, function(resposta) {
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
        <h1>Lista de Produtos</h1>
        
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>

        <table>
            <thead>
                <th>idProduto</th>
                <th>Nome</th>
                <th>Descricao</th>
                <th>Preco</th>
                <th>Categoria</th>
                <th>Quantidade em Estoque</th>
                <th>Codigo Fornecedor</th>
                <th>Codigo Loja</th>
                <th>Data Cadastro</th>
            </thead>
            <tbody>
                <c:forEach var="produto" items="${listaProdutos}">
                    <tr>
                        <td>${produto.idProduto}</td>
                        <td>${produto.nome}</td>
                        <td>${produto.descricao}</td>
                        <td>${produto.preco}</td>
                        <td>${produto.categoria}</td>
                        <td>${produto.quantidadeEstoque}</td>
                        <td>${produto.idFornecedor}</td>
                        <td>${produto.idLoja}</td>
                        <td>${produto.dataCadastro}</td>
                        <td><a href="AtualizarProduto?idProduto=${produto.idProduto}"><button type="button" class="btn btn-primary">Atualizar</button></a></td>
                        <td><button type="button" class="btn btn-primary" onclick="mostrarModalExclusao('${produto.idProduto}', '${produto.nome}')">Excluir</button></td>
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
                    Confirma a exclusão do produto <label id="nomeProduto"></label> ?
                    <input id="idProduto" hidden="true"/>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                  <button type="button" class="btn btn-primary" onclick="excluirProduto()">Confirmar</button>
                </div>
              </div>
            </div>
          </div>
        
        <a href="index.jsp"><button type="button" class="btn btn-primary">Voltar</button></a>
    </body>
</html>