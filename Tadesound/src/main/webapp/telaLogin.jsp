<%-- 
    Document   : index
    Created on : 10/10/2020, 11:17:30
    Author     : Felipe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu</title>
    </head>
    <body> 
        <h1>Login</h1>
        <!--Caso tenha dado algum erro de login-->
        <c:if test="${param.erro == 'userNotFound'}">
            <div class="alert alert-danger" role="alert">
                Usuario e/ou senha incorreto(s)!
            </div>
        </c:if>
        
        <!--Caso o usuario nao tenha permissao-->
        <c:if test="${param.erro == 'accessForbidden'}">
            <div class="alert alert-danger" role="alert">
                Voce nao tem permissao para acessar a ferramenta desejada. Efetue o login com outro usuario.
            </div>
        </c:if>
        
        <form action="EfetuaLogin" method="POST">
            <div class="form-group">
                <label>Login</label>
                <input name="login" class="form-control" required>
            </div>
            <div class="form-group">
                <label>Senha</label>
                <input type="password" name="senha" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Logar</button>
        </form>
    </body>
</html>
