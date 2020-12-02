<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/listaClientes.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <title>Consulta de Produtos</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(idProduto, nomeProduto){
                $('#nomeProduto').html(nomeProduto);
                $('#idProduto').val(idProduto);
                $('#modalExclusao').modal('show');
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
            <!--Verifica o cargo do usuario, para determinar a exibicao do menu lateral-->
            <c:if test="${sessionScope.usuario.admin}">
                <a href="/Tadesound/CadastrarProduto"><img src="img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/vendas/cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a href="/Tadesound/protected/gerencia/cadastrarLoja.jsp"><img src="img/IconeFilial.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a><img src="img/IconeFuncionario.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.gerente}">
                <a href="/Tadesound/CadastrarProduto"><img src="img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/vendas/cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a href="/Tadesound/protected/gerencia/cadastrarLoja.jsp"><img src="img/IconeFilial.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a><img src="img/IconeFuncionario_desabilitado.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.backoffice}">
                <a href="/Tadesound/CadastrarProduto"><img src="img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a><img src="img/IconeClientes_desabilitado.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a><img src="img/IconeFilial_desabilitado.png"
                    class="icone" alt="Ícone de filial"></a>
                <a><img src="img/IconeFuncionario_desabilitado.png"
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
        </div>
        
        <div class="rgt-container">
            <div class="container-titulo">
                <h1>Consultar Produto</h1>
                <a href="CadastrarProduto"><img src="img/IconeAdicionar.png" 
                    class="btn-manter1" alt="Ícone para a página de cadastro de produtos"></a>
            </div>

            <div class="campos-container">
                <table cellspacing="0" cellpadding="1" border="1" width="300">
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
                            <th class="filler">Fill</th>
                            <th class="filler">Fill</th>
                        </thead>
                        <tbody>
                            <c:forEach var="produto" items="${listaProdutos}">
                                <tr>
                                    <td>${produto.idProduto}</td>
                                    <td>${produto.nome}</td>
                                    <td>${produto.descricao}</td>
                                    <td id="valorProduto${produto.idProduto}">${produto.preco}</td>
                                    <td>${produto.categoria}</td>
                                    <td>${produto.quantidadeEstoque}</td>
                                    <td>${produto.idFornecedor}</td>
                                    <td>${produto.idLoja}</td>
                                    <td>${produto.dataCadastro}</td>
                                    <td><a href="AtualizarProduto?idProduto=${produto.idProduto}">
                                        <img src="img/IconeEditar2.png" class="btn-manter2" 
                                        alt="Ícone para a página de manutenção de produtos"></a></td>
                                    <td><img src="img/IconeExcluir.png" class="btn-manter3" style="cursor: pointer;" 
                                        onclick="mostrarModalExclusao('${produto.idProduto}', '${produto.nome}')"
                                        alt="Ícone para exclusão de produto"></td>
                                </tr>
                                
                                <script>
                                    //Formata o campo de preco corretamente para exibicao
                                    var precoProdutoFormatado = numberToCurrency(${produto.preco});
                                    $('#valorProduto${produto.idProduto}').html(precoProdutoFormatado);
                                </script>
                                
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
                                    Confirma a exclusão do Produto <label id="nomeProduto"></label>?
                                    <input id="idProduto" hidden="true"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn-confirmar" onclick="excluirProduto()">Confirmar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </table>
            </div>
        </div>
    </body>
</html>
