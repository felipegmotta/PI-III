<%-- 
    Document   : index
    Created on : 10/10/2020, 11:17:30
    Author     : Felipe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="../header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
    </head>
    <body> 
        <h1>Menu</h1>
        
        <!--Permissoes para admin-->
        <c:if test="${sessionScope.usuario.admin}">
            <a href="../ListarLojas">Listar Lojas</a><br/>
            <a href="gerencia/cadastrarLoja.jsp">Cadastrar Lojas</a><br/>
            <a href="../ListarClientes">Listar Clientes</a><br/>
            <a href="vendas/cadastrarCliente.jsp">Cadastrar Clientes</a><br/>
            <a href="../ListarProdutos">Listar Produtos</a><br/>
            <a href="../CadastrarProduto">Cadastrar Produtos</a><br/>
            <a href="../ListarServicos">Listar Servicos</a><br/>
            <a href="backoffice/cadastrarServico.jsp">Cadastrar Servicos</a><br/>
            <a href="../ListarFornecedores">Listar Fornecedores</a><br/>
            <a href="backoffice/cadastrarFornecedor.jsp">Cadastrar Fornecedores</a><br/>
            <a href="../ListarProdutosEClientes">Realizar Venda</a><br/>
            <a href="../ListarServicosEClientes">Realizar Venda de Servicos</a><br/>
            <a href="gerencia/listaVendas.jsp">Relatorio de Vendas</a><br/>
        </c:if>
    
        <!--Permissoes para gerente-->
        <c:if test="${sessionScope.usuario.gerente}">
            <a href="../ListarLojas">Listar Lojas</a><br/>
            <a href="gerencia/cadastrarLoja.jsp">Cadastrar Lojas</a><br/>
            <a href="../ListarClientes">Listar Clientes</a><br/>
            <a href="vendas/cadastrarCliente.jsp">Cadastrar Clientes</a><br/>
            <a href="../ListarProdutos">Listar Produtos</a><br/>
            <a href="../CadastrarProduto">Cadastrar Produtos</a><br/>
            <a href="../ListarServicos">Listar Servicos</a><br/>
            <a href="backoffice/cadastrarServico.jsp">Cadastrar Servicos</a><br/>
            <a href="../ListarFornecedores">Listar Fornecedores</a><br/>
            <a href="backoffice/cadastrarFornecedor.jsp">Cadastrar Fornecedores</a><br/>
            <a href="../ListarProdutosEClientes">Realizar Venda</a><br/>
            <a href="../ListarServicosEClientes">Realizar Venda de Servicos</a><br/>
            <a href="gerencia/listaVendas.jsp">Relatorio de Vendas</a><br/>
        </c:if>    
        
        <!--Permissoes para backoffice-->  
        <c:if test="${sessionScope.usuario.backoffice}">
            <a href="../ListarProdutos">Listar Produtos</a><br/>
            <a href="../CadastrarProduto">Cadastrar Produtos</a><br/>
            <a href="../ListarServicos">Listar Servicos</a><br/>
            <a href="backoffice/cadastrarServico.jsp">Cadastrar Servicos</a><br/>
            <a href="../ListarFornecedores">Listar Fornecedores</a><br/>
            <a href="backoffice/cadastrarFornecedor.jsp">Cadastrar Fornecedores</a><br/>
        </c:if>
        
        <!--Permissoes para vendedor-->
        <c:if test="${sessionScope.usuario.vendedor}">
            <a href="../ListarClientes">Listar Clientes</a><br/>
            <a href="vendas/cadastrarCliente.jsp">Cadastrar Clientes</a><br/>
            <a href="../ListarProdutosEClientes">Realizar Venda</a><br/>
            <a href="../ListarServicosEClientes">Realizar Venda de Servicos</a><br/>
        </c:if>

        <br/>
        <br/>
        <a href="../EfetuaLogout">Sair</a><br/>
    </body>
</html>
