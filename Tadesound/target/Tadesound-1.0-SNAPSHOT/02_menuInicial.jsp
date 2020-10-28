<%-- 
    Document   : menu
    Created on : 18/10/2020, 15:19:54
    Author     : Denise Trevizo 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/02_menuInicial.css">
        <title>Tadesound</title>
    </head>
    
    <body>
        <header>
            <a href="01_paginaInicial.jsp"><img src="img/HeaderMenuInicial.png" 
                class="logo" alt="Cabeçalho do menu inicial"></a>
        </header>        
        
        <div class="navbar">
            <a href="cadastrarCliente.jsp"><img src="img/IconeRelatorio.png" 
                class="icone" alt="Ícone para a tela de relatórios"></a>
            <a href="cadastrarCliente.jsp"><img src="img/IconeCrud3.png" 
                class="icone" alt="Ícone para a tela de CRUD"></a>
            <a href="ListarProdutosEClientes"><img src="img/IconeCaixa.png" 
                class="icone" alt="Ícone para a tela de caixa"></a>
        </div>
        
        <footer>
            <img src="img/Footer.png" class="info" alt="Rodapé">                            
        </footer>  
    </body>
</html>
