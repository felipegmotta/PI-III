<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/telaLogin.css">
        <title>Menu</title>
    </head>
    <body>       
        
        <!--Caso tenha dado algum erro de login-->
        <c:if test="${param.erro == 'userNotFound'}">
            <div class="alert alert-danger" role="alert">
                <h3 style="color:#ff8f06; font-family: Calibri">Usuario e/ou senha incorreto(s)!</h3>
            </div>
        </c:if>
        
        <!--Caso o usuario nao tenha permissao-->
        <c:if test="${param.erro == 'accessForbidden'}">
            <div class="alert alert-danger" role="alert">
                Voce nao tem permissao para acessar a ferramenta desejada. Efetue o login com outro usuario.
            </div>
        </c:if>
        
        <!--Caso o usuario nao esteja logado, ou o acesso tenha expirado-->
        <c:if test="${param.erro == 'sessionExpired'}">
            <div class="alert alert-danger" role="alert">
                O seu acesso expirou, por favor realize o login novamente.
            </div>
        </c:if>
        
        <div class="container">
            <img src="img/BaseBackground.jpg" class="background" 
                alt="Imagem de fundo da Tadesound">
        </div> 

        <form action="EfetuaLogin" method="POST">
            <div class="form-group">
                <h1 style="font-family: Calibri">Login</h1>
                </br>
                <label style="font-family: Calibri">Usuário</label>
                <input name="login" class="form-control" required>
                </br>
                </br>
                <label style="font-family: Calibri">Senha</label>
                <input type="password" name="senha" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary" style="font-family: Calibri">Logar</button>
        </form>
        <footer>
            <img src="img/Footer.png" class="info" alt="Rodapé">                            
        </footer>
    </body>
</html>