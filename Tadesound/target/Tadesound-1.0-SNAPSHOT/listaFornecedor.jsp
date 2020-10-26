<%-- 
    Document   : listaFornecedor
    Created on : 24/10/2020, 20:00:30
    Author     : Ygor
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Fornecedor</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(cnpjFornecedor, nomeFornecedor){
                $('#nomeFornecedor').html(nomeFornecedor);
                $('#cnpjFornecedor').val(cnpjFornecedor);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por atualizar o fornecedor
            function atualizarFornecedor(cnpjFornecedor) {
                //Envia a requisicao GET para o BD atualizar o fornecedor
                $.get("AtualizarFornecedor?cnpj="+cnpjFornecedor, function(resposta) {
                    
                });
            }
            
            //Funcao responsavel por excluir o fornecedor
            function excluirFornecedor() {
                var cnpjFornecedor = $('#cnpjFornecedor').val();
                
                //Envia a requisicao GET para o BD deletar o fornecedor
                $.get("ExcluirFornecedor?cnpj="+cnpjFornecedor, function(resposta) {
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
        <h1>Lista de Fornecedor</h1>
        
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>

        <table>
            <thead>
                <th>Nome</th>
                <th>Email</th>
                <th>CPF</th>
                <th>CNPJ</th>
                <th>Tipo Fornecedor</th>
                <th>Telefone</th>
                <th>Endereco</th>
                <th>Numero</th>
                <th>Complemento</th>
                <th>Bairro</th>
                <th>Cidade</th>
                <th>UF</th>
                <th>CEP</th>
                <th>Data Cadastro</th>
            </thead>
            <tbody>
                <c:forEach var="fornecedor" items="${listaFornecedor}">
                    <tr>
                        <td>${fornecedor.nome}</td>
                        <td>${fornecedor.email}</td>
                        <td>${fornecedor.cpf}</td>
                        <td>${fornecedor.cnpj}</td>
                        <td>${fornecedor.tipoFornecedor}</td>
                        <td>${fornecedor.telefone}</td>
                        <td>${fornecedor.endereco}</td>
                        <td>${fornecedor.numero}</td>
                        <td>${fornecedor.complemento}</td>
                        <td>${fornecedor.bairro}</td>
                        <td>${fornecedor.cidade}</td>
                        <td>${fornecedor.uf}</td>
                        <td>${fornecedor.cep}</td>
                        <td>${fornecedor.dataCadastro}</td>
                        <td><a href="AtualizarFornecedor?cnpj=${fornecedor.cnpj}"><button type="button" class="btn btn-primary">Atualizar</button></a></td>
                        <td><button type="button" class="btn btn-primary" onclick="mostrarModalExclusao('${fornecedor.cnpj}', '${fornecedor.nome}')">Excluir</button></td>
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
                    Confirma a exclusão do fornecedor <label id="nomeFornecedor"></label> ?
                    <input id="cnpjFornecedor" hidden="true"/>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                  <button type="button" class="btn btn-primary" onclick="excluirFornecedor()">Confirmar</button>
                </div>
              </div>
            </div>
          </div>
        
        <a href="index.jsp"><button type="button" class="btn btn-primary">Voltar</button></a>
    </body>
</html>
