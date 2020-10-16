<%-- 
    Document   : erro
    Created on : 10/10/2020, 17:49:23
    Author     : Felipe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Erro</title>
    </head>
    <body>
        <h1>Nao foi possivel concluir a operacao</h1><br/>
        <c:set var="msgErro" value="${msgErro}"/>
        <c:set var="erros" value="${fn:split(msgErro, '   ')}"/> 
        <c:forEach items="${erros}" var="erroAtual"> 
            <p>${erroAtual}</p> 
        </c:forEach>
        <a href="cadastrarCliente.jsp">Voltar para o Cadastro</a>
        <a href="index.jsp">Voltar para o Menu</a>
    </body>
</html>
