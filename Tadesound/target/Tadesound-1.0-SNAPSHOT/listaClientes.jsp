<%-- 
    Document   : listaClientes
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
        <title>Lista de Clientes</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(cpfCliente, nomeCliente){
                $('#nomeCliente').html(nomeCliente);
                $('#cpfCliente').val(cpfCliente);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por atualizar o cliente
            function atualizarCliente(cpfCliente) {
                //Envia a requisicao GET para o BD atualizar o cliente
                $.get("AtualizarCliente?cpf="+cpfCliente, function(resposta) {
                    
                });
            }
            
            //Funcao responsavel por excluir o cliente
            function excluirCliente() {
                var cpfCliente = $('#cpfCliente').val();
                
                //Envia a requisicao GET para o BD deletar o cliente
                $.get("ExcluirCliente?cpf="+cpfCliente, function(resposta) {
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
        <h1>Lista de Clientes</h1>
        
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
                <th>Data Nascimento</th>
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
                <c:forEach var="cliente" items="${listaClientes}">
                    <tr>
                        <td>${cliente.nome}</td>
                        <td>${cliente.email}</td>
                        <td>${cliente.cpf}</td>
                        <td>${cliente.dataNascimento}</td>
                        <td>${cliente.telefone}</td>
                        <td>${cliente.endereco}</td>
                        <td>${cliente.numero}</td>
                        <td>${cliente.complemento}</td>
                        <td>${cliente.bairro}</td>
                        <td>${cliente.cidade}</td>
                        <td>${cliente.uf}</td>
                        <td>${cliente.cep}</td>
                        <td>${cliente.dataCadastro}</td>
                        <td><a href="AtualizarCliente?cpf=${cliente.cpf}"><button type="button" class="btn btn-primary">Atualizar</button></a></td>
                        <td><button type="button" class="btn btn-primary" onclick="mostrarModalExclusao('${cliente.cpf}', '${cliente.nome}')">Excluir</button></td>
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
                    Confirma a exclusão do cliente <label id="nomeCliente"></label> ?
                    <input id="cpfCliente" hidden="true"/>
                </div>
                <div class="modal-footer">
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                  <button type="button" class="btn btn-primary" onclick="excluirCliente()">Confirmar</button>
                </div>
              </div>
            </div>
          </div>
        
        <a href="index.jsp"><button type="button" class="btn btn-primary">Voltar</button></a>
    </body>
</html>
