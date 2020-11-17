<%-- 
    Document   : alterarLoja
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
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Atualizar Loja</title>
        
        <script type="text/javascript">
            function validarFormulario() {
                var msgErro = "";
                
                //Valida o Nome
                if ($('#nome').val().search("[0-9]+") !== -1) {
                    msgErro += "O Campo \"Nome\" nao deve possuir numeros.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    alterarLojaBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar um POST para o servlet atualizar o loja no BD
            function alterarLojaBD() {
                console.log("estou para ennviar o post");
                $.ajax({
                    type: "POST",
                    url: "AtualizarLoja",
                    data: {'idLoja': ${loja.idLoja},
                           'nome': $('#nome').val(),
                           'telefone': $('#telefone').val(),
                           'endereco': $('#endereco').val(),
                           'numero': $('#numero').val(),
                           'complemento': $('#complemento').val(),
                           'bairro': $('#bairro').val(),
                           'cidade': $('#cidade').val(),
                           'uf': $('#uf').val(),
                           'cep': $('#cep').val()},
                    dataType: "text",
                    success: exibeMensagemSucesso()
                   });
            }
            
            //Exibe um toast de sucesso
            function exibeMensagemSucesso() {
                $('#msgToast').html("Atualizacao do loja <b>${loja.nome}</b> realizada com sucesso!");
                $('.toast').toast('show');
            }
            
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "<b>Erro ao atualizar loja: ${loja.nome}</b></br>";
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
            <a href="ListarLojas"><img src="img/IconeProduto.png" 
                class="icone" alt="Ícone de Produto"></a>
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
                <h1>Atualizar Loja</h1>
                <a href="ListarLojas"><img src="img/IconePesquisar.png" 
                    class="btn-manter1" alt="Ícone para a página de listagem de lojas"></a>
                <a href="cadastrarLoja.jsp"><img src="img/IconeAdicionar2.png" 
                    class="btn-manter2" alt="Ícone para a página de cadastro de lojas"></a>
            </div>
                <h3>${loja.nome}</h3>
            
            <form method="POST">
                <div class="campos-container">
                    <div class="nome">
                        <label for="nome">Nome</label>
                        <input id="nome" name="nome" minlength="3" maxlength="255" required="required" value="${loja.nome}"/><br/>
                    </div>

                    <div class="telefone">
                        <label for="telefone">Telefone</label>
                        <input id="telefone" name="telefone" placeholder="(__) _____-____" data-slots="_" required="required" value="${loja.telefone}"/><br/>
                    </div>

                    <div class="endereco">
                        <label for="endereco">Endereco</label>
                        <input id="endereco" name="endereco" maxlength="255" required="required" value="${loja.endereco}"/><br/>
                    </div>

                    <div class="numero">
                        <label for="numero">Numero</label>
                        <input id="numero" name="numero" type="number" maxlength="5" value="${loja.numero}"/><br/>
                    </div>

                    <div class="complemento">
                        <label for="complemento">Complemento</label>
                        <input id="complemento" name="complemento" required="required" maxlength="255" value="${loja.complemento}"/><br/>
                    </div>

                    <div class="bairro">
                        <label for="bairro">Bairro</label>
                        <input id="bairro" name="bairro" required="required" maxlength="255" value="${loja.bairro}"/><br/>
                    </div>

                    <div class="cidade">
                        <label for="cidade">Cidade</label>
                        <input id="cidade" name="cidade" required="required" maxlength="255" value="${loja.cidade}"/><br/>
                    </div>

                    <div class="uf">
                        <label for="uf">UF</label>
                        <input id="uf" name="uf" required="required" maxlength="2" value="${loja.uf}"/><br/>
                    </div>

                    <div class="cep">
                        <label for="cep">CEP</label>
                        <input id="cep" name="cep" placeholder="_____-___" data-slots="_" required="required" value="${loja.cep}"/><br/>
                    </div>

                <div class="botao-container">
                    <a href="ListarLojas"><button type="button" class="btn-cancelar">Cancelar</button></a>
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
