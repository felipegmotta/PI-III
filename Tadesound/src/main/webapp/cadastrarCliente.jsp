<%-- 
    Document   : cadastrarCliente
    Created on : 10/10/2020, 17:19:36
    Author     : Felipe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cadastrar Cliente</title>
    </head>
    <body>
        <h1>Cadastro</h1>
        <form action="CadastrarCliente" method="POST">
            <p>Nome</p>
            <input name="nome"/><br/>
            <p>Email</p>
            <input name="email"/><br/>
            <p>CPF</p>
            <input name="cpf"/><br/>
            <p>Data Nascimento</p>
            <input name="dataNascimento"/><br/>
            <p>Telefone</p>
            <input name="telefone"/><br/>
            <p>Endereco</p>
            <input name="endereco"/><br/>
            <p>Numero</p>
            <input name="numero"/><br/>
            <p>Complemento</p>
            <input name="complemento"/><br/>
            <p>Bairro</p>
            <input name="bairro"/><br/>
            <p>Cidade</p>
            <input name="cidade"/><br/>
            <p>UF</p>
            <input name="uf"/><br/>
            <p>CEP</p>
            <input name="cep"/><br/>
            
            <button type="submit">Cadastrar</button>
        </form>
    </body>
</html>
