<%-- 
    Document   : alterarProduto
    Created on : 18/10/2020, 12:39:34
    Author     : Felipe
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%--<%@include file="header.jsp"%>--%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/crudCliente.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <title>Alterar Produto</title>
        
        <script type="text/javascript">
            function validarFormulario() {
                var msgErro = "";
                
                //Valida o Nome
                if ($('#nome').val().search("[0-9]+") !== -1) {
                    msgErro += "O Campo \"Nome\" nao deve possuir numeros.</br>";
                }
                //Valida o Email
                if ($('#descricao').val().search("@") !== -1) {
                    msgErro += "O Campo \"Descricao\" esta incorreto.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    alterarProdutoBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar um POST para o servlet atualizar o produto no BD
            function alterarProdutoBD() {
                console.log("estou para ennviar o post")
                $.ajax({
                    type: "POST",
                    url: "AtualizarProduto",
                    data: {'idProduto': ${produto.idProduto},
                           'nome': $('#nome').val(),
                           'descricao': $('#descricao').val(),
                           'preco': $('#preco').val(),
                           'categoria': $('#categoria').val(),
                           'quantidadeEstoque': $('#quantidadeEstoque').val(),
                           'idFornecedor': $('#idFornecedor').val(),
                           'idLoja': $('#idLoja').val()},
                    dataType: "text",
                    success: exibeMensagemSucesso()
                   });
            }
            
            //Exibe um toast de sucesso
            function exibeMensagemSucesso() {
                $('#msgToast').html("Atualizacao do produto: ${produto.nome} realizada com sucesso!");
//                $('#toast').toast('show');
            }
            
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "Erro ao atualizar produto: ${produto.nome}</br>";
                msgExibir = msgExibir.concat(msgErro);
                $('#msgToast').html(msgExibir);
//                $('#toast').toast('show');
            }
            
            //Event Listener para formatacao de campos
            document.addEventListener('DOMContentLoaded', () => {
            for (const el of document.querySelectorAll("[placeholder][data-slots]")) {
                const pattern = el.getAttribute("placeholder"),
                    slots = new Set(el.dataset.slots || "_"),
                    prev = (j => Array.from(pattern, (c,i) => slots.has(c)? j=i+1: j))(0),
                    first = [...pattern].findIndex(c => slots.has(c)),
                    accept = new RegExp(el.dataset.accept || "\\d", "g"),
                    clean = input => {
                        input = input.match(accept) || [];
                        return Array.from(pattern, c =>
                            input[0] === c || slots.has(c) ? input.shift() || c : c
                        );
                    },
                    format = () => {
                        const [i, j] = [el.selectionStart, el.selectionEnd].map(i => {
                            i = clean(el.value.slice(0, i)).findIndex(c => slots.has(c));
                            return i<0? prev[prev.length-1]: back? prev[i-1] || first: i;
                        });
                        el.value = clean(el.value).join``;
                        el.setSelectionRange(i, j);
                        back = false;
                    };
                let back = false;
                el.addEventListener("keydown", (e) => back = e.key === "Backspace");
                el.addEventListener("input", format);
                el.addEventListener("focus", format);
                el.addEventListener("blur", () => el.value === pattern && (el.value=""));
            }});
        </script>
    </head>
    <body>
        <header>
            <h1>Manutenção</h1>
            <div class="info">
                <h2>consulta . cadastro . manutenção</h2>
            </div>
        </header>
        
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>
        
        <div class="lft-container">
            <img src="img/IconeProduto.png" class="icone" alt="Ícone de produto">
            <img src="img/IconeServico.png" class="icone" alt="Ícone de serviço">
            <img src="img/IconeProdutos.png" class="icone" alt="Ícone de produtos">
            <img src="img/IconeFornecedor.png" class="icone" alt="Ícone de fornecedor">
            <img src="img/IconeFilial.png" class="icone" alt="Ícone de filial">
            <img src="img/IconeFuncionario.png" class="icone" alt="Ícone de funcionário">
        </div>
        
        <div class="rgt-container">
            <h1>Atualizar Produto: ${produto.nome}</h1>
            
            <form method="POST">
                <div class="campos-container">
                    <div class="nome">
                        <label for="nome">Nome</label>
                        <input id="nome" name="nome" minlength="3" maxlength="255" required="required" value="${produto.nome}"/><br/>
                    </div>

                    <div class="descricao">
                        <label for="descricao">Descricao</label>
                        <input id="descricao" name="descricao" minlength="3" maxlength="255" required="required" value="${produto.descricao}"/><br/>
                    </div>

                    <div class="preco">
                        <label for="preco">Preco</label>
                        <input type="text" id="preco" name="preco" required="required" value="${produto.preco}"/><br/>
                    </div>

                    <div class="categoria">
                        <label for="categoria">Categoria</label>
                        <select id="categoria" name="categoria" value="${produto.categoria}">
                            <option value="1">Cordas</option>
                            <option value="2">Grande Porte</option>
                        </select>
                    </div>

                    <div class="quantidadeEstoque">
                        <label for="quantidadeEstoque">Quantidade em Estoque</label>
                        <input id="quantidadeEstoque" type="number" name="quantidadeEstoque" required="required" value="${produto.quantidadeEstoque}"/><br/>
                    </div>

                    <div class="fornecedor">
                        <label for="fornecedor">Fornecedor</label>
                        <select id="idFornecedor" name="fornecedor" value="${produto.idFornecedor}">
                            <option value="1">Velvet</option>
                            <option value="2">Yamaha</option>
                        </select>
                    </div>

                    <div class="loja">
                        <label for="loja">Loja</label>
                        <select id="idLoja" name="loja" value="${produto.idLoja}">
                            <option value="1">Campos Elisios</option>
                            <option value="2">Interlagos</option>
                        </select>
                    </div>
                    
                <div class="botao-container">
                    <button type="button" onclick="validarFormulario()">Cadastrar</button>
                </div>
                
                <a href="index.jsp"><button type="button" class="btn btn-primary">Voltar</button></a>
            </form>            
        </div>
    </body>
</html>