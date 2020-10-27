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
        <link rel="stylesheet" href="css/listaClientes.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <title>Relatorio de Vendas</title>
        <script>
            //Funcao responsavel por atualizar o produto
            function consultarVenda(tipoConsulta) {
                //Envia a requisicao GET para o BD atualizar o produto
                $.get("ListarVendas?tipoConsulta="+tipoConsulta, function(resposta) {
                    document.documentElement.innerHTML = resposta;
                });
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
            <h1>RELATORIO</h1>
            <div class="info">
                <h3><b>consulta</b></h3>
            </div>
        </header>

        <div class="lft-container">            
            <a href="cadastrarProduto.jsp"><img src="img/IconeProduto.png" 
                class="icone" alt="Ícone de produto"></a>
            <a href="cadastrarServico.jsp"><img src="img/IconeServico.png" 
                class="icone" alt="Ícone de serviço"></a>
            <a href="cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
                class="icone" alt="Ícone de clientes"></a>
            <a href="cadastrarFornecedor.jsp"><img src="img/IconeFornecedor.png" 
                class="icone" alt="Ícone de fornecedor"></a>
            <a href="cadastrarFilial.jsp"><img src="img/IconeFilial.png" 
                class="icone" alt="Ícone de filial"></a>
            <a href="cadastrarFuncionario.jsp"><img src="img/IconeFuncionario.png" 
                class="icone" alt="Ícone de funcionário"></a>
        </div>
        
        <div class="rgt-container">
            <div class="container-titulo">
                <h1>Consultar Vendas</h1>
                <a href="cadastrarCliente.jsp"><img src="img/IconeAdicionar.png" 
                    class="btn-manter1" alt="Ícone para a página de cadastro de clientes"></a>
            </div>
            
            <input type="radio" id="produto" name="tipoConsulta" value="Produto">
            <label for="tipoConsulta">Produto</label><br>
            
            <input type="radio" id="cliente" name="tipoConsulta" value="Cliente">
            <label for="tipoConsulta">Cliente</label><br>
            
            <input type="radio" id="loja" name="tipoConsulta" value="Loja">
            <label for="tipoConsulta">Loja</label><br>
            
            <div class="campos-container">
                <table cellspacing="0" cellpadding="1" border="1" width="300">
                    <table>
                        <thead>
                            <th>idFuncionario</th>
                        </thead>
                        <tbody>
                            
                            <c:forEach var="venda" items="${listaVendas}">
                                <tr>
                                    <td>${venda.idFuncionario}</td>
                                    <!--<td id='valorTotal${venda.idVenda}'>${venda.valorTotal}</td>-->
                                </tr>
                                
                                <script>
                                    //Formata o campo de preco corretamente para exibicao
                                    var valorTotalVendaAtual = ${venda.valorTotal}
                                    var valorTotalVendaAtualFormatado = numberToCurrency(valorTotalVendaAtual);
                                    $('#valorTotal${venda.idVenda}').html(valorTotalVendaAtualFormatado);
                                </script>
                                
                            </c:forEach>
                        </tbody>
                    </table>
                </table>
            </div>
            
            <button type="button" class="btn btn-primary" onclick="consultarVenda('asdads')">Gerar Relatorio</button>  
        </div>
    </body>
</html>
