<%-- 
    Document   : listaFornecedoresBackoffice
    Created on : 10/10/2020, 12:03:30
    Author     : Felipe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="../../header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/listaFornecedoresBackoffice.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <title>Consulta de Fornecedors</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(idFornecedor, nomeFornecedor){
                $('#nomeFornecedor').html(nomeFornecedor);
                $('#idFornecedor').val(idFornecedor);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por excluir o fornecedor
            function excluirFornecedor() {
                var idFornecedor = $('#idFornecedor').val();
                
                //Envia a requisicao GET para o BD deletar o fornecedor
                $.get("ExcluirFornecedor?idFornecedor="+idFornecedor, function(resposta) {
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
            
            //Formata numero em currency
            function numberToCurrency(number) {
                //Cria um formatador de numeros
                var formatter = new Intl.NumberFormat('pt-BR', {
                  style: 'currency',
                  currency: 'BRL'});

                return formatter.format(number);
            }
        </script>
    </head>
    <body>
        <header>
            <div class="container-logo">
                <a href="02_menuInicial.jsp"><img src="img/Logo.png" class="logo" 
                    alt="Logo da Tadesound"></a>
            </div>
            <h1>CONSULTA</h1>
            <div class="info">
                <h3><b>consulta . cadastro . manutenção</b></h3>
            </div>
        </header>
        
        <div class="lft-container">            
            <a href="ListarProdutos"><img src="img/IconeProduto.png" 
                class="icone" alt="Ícone de produto"></a>
            <a href="ListarServicos"><img src="img/IconeServico.png" 
                class="icone" alt="Ícone de serviço"></a>
            <a href="ListarFornecedores"><img src="img/IconeFornecedor.png" 
                class="icone" alt="Ícone de fornecedor"></a>
        </div>
        
        <div class="rgt-container">
            <div class="container-titulo">
                <h1>Consultar Fornecedor</h1>
                <a href="protected/backoffice/cadastrarFornecedorBackoffice.jsp"><img src="img/IconeAdicionar.png" 
                    class="btn-manter1" alt="Ícone para a página de cadastro de fornecedors"></a>
            </div>

            <div class="campos-container">
                <table cellspacing="0" cellpadding="1" border="1" width="300">
                    <table>
                        <thead>
                            <th>idFornecedor</th>
                            <th>Nome</th>
                            <th>CPF</th>
                            <th>CNPJ</th>
                            <th>Telefone</th>
                            <th>Email</th>
                            <th>Endereco</th>
                            <th>Numero</th>
                            <th>Complemento</th>
                            <th>Bairro</th>
                            <th>Cidade</th>
                            <th>UF</th>
                            <th>CEP</th>
                            <th>Data Cadastro</th>
                            <th class="filler">Fill</th>
                            <th class="filler">Fill</th>
                        </thead>
                        <tbody>
                            <c:forEach var="fornecedor" items="${listaFornecedores}">
                                <tr>
                                    <td>${fornecedor.idFornecedor}</td>
                                    <td>${fornecedor.nome}</td>
                                    <td>${fornecedor.cpf}</td>
                                    <td>${fornecedor.cnpj}</td>
                                    <td>${fornecedor.telefone}</td>
                                    <td>${fornecedor.email}</td>
                                    <td>${fornecedor.endereco}</td>
                                    <td>${fornecedor.numero}</td>
                                    <td>${fornecedor.complemento}</td>
                                    <td>${fornecedor.bairro}</td>
                                    <td>${fornecedor.cidade}</td>
                                    <td>${fornecedor.uf}</td>
                                    <td>${fornecedor.cep}</td>
                                    <td>${fornecedor.dataCadastro}</td>
                                    <td><a href="AtualizarFornecedor?idFornecedor=${fornecedor.idFornecedor}">
                                        <img src="img/IconeEditar2.png" class="btn-manter2" 
                                        alt="Ícone para a página de manutenção de fornecedores"></a></td>
                                    <td><img src="img/IconeExcluir.png" class="btn-manter3" style="cursor: pointer;" 
                                        onclick="mostrarModalExclusao('${fornecedor.idFornecedor}', '${fornecedor.nome}')"
                                        alt="Ícone para exclusão de fornecedor"></td>
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
                                    Confirma a exclusão do Fornecedor <label id="nomeFornecedor"></label>?
                                    <input id="idFornecedor" hidden="true"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn-confirmar" onclick="excluirFornecedor()">Confirmar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </table>
            </div>
        </div>
    </body>
</html>
