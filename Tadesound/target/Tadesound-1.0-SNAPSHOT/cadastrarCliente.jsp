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
            <div class="nome">
                <label for="nome">Nome</label>
                <input name="nome"/><br/>
            </div>
            
            <div class="email">
                <label for="email">Email</label>
                <input name="email"/><br/>
            </div>
            
            <div class="cpf">
                <label for="cpf">CPF</label>
                <input name="cpf"/><br/>
            </div>
                
            <div class="dataNascimento">
                <label for="dataNascimento">Data Nascimento</label>
                <input name="dataNascimento" type="text" placeholder="DD/MM/YYYY"/><br/>
            </div>
                
            <div class="telefone">
                <label for="telefone">Telefone</label>
                <input name="telefone"/><br/>
            </div>
                
            <div class="endereco">
                <label for="endereco">Endereco</label>
                <input name="endereco"/><br/>
            </div>
                
            <div class="numero">
                <label for="numero">Numero</label>
                <input name="numero"/><br/>
            </div>
                
            <div class="complemento">
                <label for="complemento">Complemento</label>
                <input name="complemento"/><br/>
            </div>
                
            <div class="bairro">
                <label for="bairro">Bairro</label>
                <input name="bairro"/><br/>
            </div>
            
            <div class="cidade">
                <label for="cidade">Cidade</label>
                <input name="cidade"/><br/>
            </div>
                
            <div class="uf">
                <label for="uf">UF</label>
                <input name="uf"/><br/>
            </div>
                
            <div class="cep">
                <label for="cep">CEP</label>
                <input name="cep"/><br/>
            </div>
                
            <button type="submit">Cadastrar</button>
        </form>
    </body>
</html>
