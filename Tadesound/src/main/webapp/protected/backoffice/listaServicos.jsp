<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/listaClientes.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Consulta de Servicos</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(idServico, nomeServico){
                $('#nomeServico').html(nomeServico);
                $('#idServico').val(idServico);
                $('#modalExclusao').modal('show');
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
                <a href="paginaInicial.jsp"><img src="img/Logo.png" class="logo" 
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
                <h1>Consultar Servico</h1>
                <a href="protected/backoffice/cadastrarServico.jsp"><img src="img/IconeAdicionar.png" 
                    class="btn-manter1" alt="Ícone para a página de cadastro de servicos"></a>
            </div>

            <div class="campos-container">
                <table cellspacing="0" cellpadding="1" border="1" width="300">
                    <table>
                        <thead>
                            <th hidden="true">idServico</th>
                            <th>Nome</th>
                            <th>Preco</th>
                            <th>Grau Complexidade</th>
                            <th>Duracao em Minutos</th>
                            <th>Codigo Loja</th>
                            <th class="filler"></th>
                            <th class="filler"></th>
                        </thead>
                        <tbody>
                            <c:forEach var="servico" items="${listaServicos}">
                                <tr>
                                    <td hidden="true">${servico.idServico}</td>
                                    <td>${servico.nome}</td>
                                    <td>${servico.preco}</td>
                                    <td>${servico.grauComplexidade}</td>
                                    <td>${servico.duracaoMinutos}</td>
                                    <td>${servico.idLoja}</td>
                                    <td><a href="AtualizarServico?idServico=${servico.idServico}">
                                        <img src="img/IconeEditar2.png" class="btn-manter2" 
                                        alt="Ícone para a página de manutenção de produtos"></a></td>
                                    <td><img src="img/IconeExcluir.png" class="btn-manter3" style="cursor: pointer;" 
                                        onclick="mostrarModalExclusao('${servico.idServico}', '${servico.nome}')"
                                        alt="Ícone para exclusão de produto"></td>
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
                                Confirma a exclusão do servico <label id="nomeServico"></label>?
                                <input id="idServico" hidden="true"/>
                            </div>
                            <div class="modal-footer">
                              <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                              <button type="button" class="btn-confirmar" onclick="excluirServico()">Confirmar</button>
                            </div>
                          </div>
                        </div>
                      </div>
                </table>
            </div>
        </div>
    </body>
</html>
