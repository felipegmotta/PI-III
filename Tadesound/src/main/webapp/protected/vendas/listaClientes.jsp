<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/listaClientes.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <title>Consulta de Clientes</title>
        
        <script type="text/javascript">
            function mostrarModalExclusao(cpfCliente, nomeCliente){
                $('#nomeCliente').html(nomeCliente);
                $('#cpfCliente').val(cpfCliente);
                $('#modalExclusao').modal('show');
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
                <a href="/Tadesound/protected/backoffice/cadastrarProduto.jsp"><img src="img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarLoja.jsp"><img src="img/IconeFilial.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFuncionario.jsp"><img src="img/IconeFuncionario.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.gerente}">
                <a href="/Tadesound/protected/backoffice/cadastrarProduto.jsp"><img src="img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarLoja.jsp"><img src="img/IconeFilial.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFuncionario.jsp"><img src="img/IconeFuncionario.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.vendedor}">
                <a><img src="img/IconeProduto_desabilitado.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a><img src="img/IconeServico_desabilitado.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/vendas/cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a><img src="img/IconeFornecedor_desabilitado.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a><img src="img/IconeFilial_desabilitado.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a><img src="img/IconeFuncionario_desabilitado.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.backoffice}">
                <a href="/Tadesound/protected/backoffice/cadastrarProduto.jsp"><img src="img/IconeProduto.png" 
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
                <h1>Consultar Cliente</h1>
                <a href="protected/vendas/cadastrarCliente.jsp"><img src="img/IconeAdicionar.png" 
                    class="btn-manter1" alt="Ícone para a página de cadastro de clientes"></a>
            </div>

            <div class="campos-container">
                <table cellspacing="0" cellpadding="1" border="1" width="300">
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
                            <th class="filler">Fill</th>
                            <th class="filler">Fill</th>
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
                                    <td><a href="AtualizarCliente?cpf=${cliente.cpf}">
                                        <img src="img/IconeEditar2.png" class="btn-manter2" 
                                        alt="Ícone para a página de manutenção de clientes"></a></td>
                                    <td><img src="img/IconeExcluir.png" class="btn-manter3" style="cursor: pointer;" 
                                        onclick="mostrarModalExclusao('${cliente.cpf}', '${cliente.nome}')"
                                        alt="Ícone para exclusão de cliente"></td>
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
                                    Confirma a exclusão do cliente <label id="nomeCliente"></label>?
                                    <input id="cpfCliente" hidden="true"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn-confirmar" onclick="excluirCliente()">Confirmar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </table>
            </div>
        </div>
    </body>
</html>
