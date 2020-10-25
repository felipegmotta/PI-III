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
        <link rel="stylesheet" href="css/crudProduto.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Atualizar Produto</title>
        
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
                console.log("estou para ennviar o post");
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
                $('#msgToast').html("Atualizacao do produto <b>${produto.nome}</b> realizada com sucesso!");
                $('.toast').toast('show');
            }
            
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "<b>Erro ao atualizar produto: ${produto.nome}</b></br>";
                msgExibir = msgExibir.concat(msgErro);
                $('#msgToast').html(msgExibir);
                $('.toast').toast('show');
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
            <div class="container-logo">
                <a href="02_menuInicial.jsp"><img src="img/Logo.png" class="logo" 
                    alt="Logo da Tadesound"></a>
            </div>
            <h1>MANUTENÇÃO</h1>
            <div class="info">
                <h3><b>consulta . cadastro . manutenção</b></h3>
            </div>
        </header>
                
        <div class="lft-container">            
            <a href="ListarProdutos"><img src="img/IconeProduto.png" 
                class="icone" alt="Ícone de produto"></a>
            <a href="cadastrarServico.jsp"><img src="img/IconeServico.png" 
                class="icone" alt="Ícone de serviço"></a>
            <a href="ListarClientes"><img src="img/IconeClientes.png" 
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
                <h1>Atualizar Produto</h1>
                <a href="ListarProdutos"><img src="img/IconePesquisar.png" 
                    class="btn-manter1" alt="Ícone para a página de listagem de produtos"></a>
                <a href="cadastrarProduto.jsp"><img src="img/IconeAdicionar2.png" 
                    class="btn-manter2" alt="Ícone para a página de cadastro de produtos"></a>
            </div>
                <h3>${produto.nome}</h3>
            
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
                    <a href="ListarProdutos"><button type="button" class="btn-cancelar">Cancelar</button></a>
                    <button type="button" class="btn-cadastrar" onclick="validarFormulario()">Atualizar</button>
                </div>

                <div class="container-toast">
                    <div class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
                        <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        <div>
                            <div class="toast-body">
                                <span id="msgToast"></span>
                            </div>
                        </div>
                    </div>
                </div>                               
            </form>            
        </div>
    </body>
</html>
