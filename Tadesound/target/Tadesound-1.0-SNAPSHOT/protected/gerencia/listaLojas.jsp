<%-- 
    Document   : listaLojas
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
        <link rel="stylesheet" href="css/listaClientes.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <title>Consulta de Lojas</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(idLoja, nomeLoja){
                $('#nomeLoja').html(nomeLoja);
                $('#idLoja').val(idLoja);
                $('#modalExclusao').modal('show');
            }
            
            //Funcao responsavel por excluir a loja
            function excluirLoja() {
                var idLoja = $('#idLoja').val();
                
                //Envia a requisicao GET para o BD deletar o loja
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
        
        <!--
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>
        -->
        
        <div class="lft-container">            
            <a href="ListarLojas"><img src="img/IconeProduto.png" 
                class="icone" alt="Ícone de Produto"></a>
            <a><img src="img/IconeServico.png" 
                class="icone" alt="Ícone de serviço"></a>
            <a href="ListarClientes"><img src="img/IconeClientes.png" 
                class="icone" alt="Ícone de clientes"></a>
            <a><img src="img/IconeFornecedor.png" 
                class="icone" alt="Ícone de fornecedor"></a>
            <a><img src="img/IconeFilial.png" 
                class="icone" alt="Ícone de filial"></a>
            <a><img src="img/IconeFuncionario.png" 
                class="icone" alt="Ícone de funcionário"></a>
        </div>
        
        <div class="rgt-container">
            <div class="container-titulo">
                <h1>Consultar Loja</h1>
                <a href="protected/backoffice/cadastrarLoja.jsp"><img src="img/IconeAdicionar.png" 
                    class="btn-manter1" alt="Ícone para a página de cadastro de lojas"></a>
            </div>

            <div class="campos-container">
                <table cellspacing="0" cellpadding="1" border="1" width="300">
                    <table>
                        <thead>
                            <th>idLoja</th>
                            <th>Nome</th>
                            <th>Telefone</th>
                            <th>Endereco</th>
                            <th>Numero</th>
                            <th>Complemento</th>
                            <th>Bairro</th>
                            <th>Cidade</th>
                            <th>UF</th>
                            <th>CEP</th>
                            <th>Data Cadastro</th>
                            <th class="Fill" style='width:1%'></th>
                            <th class="Fill" style='width:1%'></th>
                        </thead>
                        <tbody>
                            <c:forEach var="loja" items="${listaLojas}">
                                <tr>
                                    <td>${loja.idLoja}</td>
                                    <td>${loja.nome}</td>
                                    <td>${loja.telefone}</td>
                                    <td>${loja.endereco}</td>
                                    <td>${loja.numero}</td>
                                    <td>${loja.complemento}</td>
                                    <td>${loja.bairro}</td>
                                    <td>${loja.cidade}</td>
                                    <td>${loja.uf}</td>
                                    <td>${loja.cep}</td>
                                    <td>${loja.dataCadastro}</td>
                                    <td><a href="AtualizarLoja?idLoja=${loja.idLoja}">
                                        <img src="img/IconeEditar2.png" class="btn-manter2" 
                                        alt="Ícone para a página de manutenção de lojas"></a></td>
                                    <td><img src="img/IconeExcluir.png" class="btn-manter3" style="cursor: pointer;" 
                                        onclick="mostrarModalExclusao('${loja.idLoja}', '${loja.nome}')"
                                        alt="Ícone para exclusão de loja"></td>
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
                                    Confirma a exclusão da Loja <label id="nomeLoja"></label>?
                                    <input id="idLoja" hidden="true"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn-confirmar" onclick="excluirLoja()">Confirmar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </table>
            </div>
        </div>
    </body>
</html>
