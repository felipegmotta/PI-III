<%-- 
    Document   : cadastrarCliente
    Created on : 10/10/2020, 17:19:36
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
        <title>Cadastrar Cliente</title>
        
        <script type="text/javascript">
            function validarFormulario() {
                var msgErro = "";
                
                //Valida o Nome
                if ($('#nome').val().search("[0-9]+") !== -1) {
                    msgErro += "O Campo \"Nome\" nao deve possuir numeros.</br>";
                }
                //Valida o Email
                if ($('#email').val().search("@") === -1) {
                    msgErro += "O Campo \"Email\" esta incorreto.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    cadastrarClienteBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar o cliente
            function cadastrarClienteBD() {
                $.ajax({
                    type: "POST",
                    url: "CadastrarCliente",
                    data: {'nome': $('#nome').val(),
                           'email': $('#email').val(),
                           'cpf': $('#cpf').val(),
                           'dataNascimento': $('#dataNascimento').val(),
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
                $('#msgToast').html("Cadastro realizado com sucesso!");
                //$('#toast').toast('show');
                
                //Limpa o valor dos campos
                $('#nome').val("");
                $('#email').val("");
                $('#cpf').val("");
                $('#dataNascimento').val("");
                $('#telefone').val("");
                $('#endereco').val("");
                $('#numero').val("");
                $('#complemento').val("");
                $('#bairro').val("");
                $('#cidade').val("");
                $('#uf').val("");
                $('#cep').val("");
            }
                        
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "Erro ao cadastrar cliente:</br>";
                msgExibir = msgExibir.concat(msgErro);
                $('#msgToast').html(msgExibir);
                //$('#toast').toast('show');
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
            }
        });
        </script>        
    </head>
    
    <body> 
        <header>
            <div class="container-logo">
                <a href="02_menuInicial.jsp"><img src="img/Logo.png" class="logo" 
                    alt="Logo da Tadesound"></a>
            </div>
            <h1>CADASTRO</h1>
            <div class="info">
                <h3><b>consulta . cadastro . manutenção</b></h3>
            </div>
        </header>
        
        <!--
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>
        -->
        
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
                <h1>Adicionar Cliente</h1>
                <a href="ListarClientes"><img src="img/IconePesquisar.png" 
                    class="btn-manter1" alt="Ícone para a página de listagem de clientes"></a>
                <a href="atualizarCliente.jsp"><img src="img/IconeEditar.png" 
                    class="btn-manter2" alt="Ícone para a página de manutenção de clientes"></a>
            </div>
            
            <form method="POST">
                <div class="campos-container">
                    <div class="nome">
                        <label for="nome">Nome</label>
                        <input id="nome" name="nome" minlength="3" maxlength="255" required="required"/><br/>
                    </div>

                    <div class="email">
                        <label for="email">Email</label>
                        <input id="email" name="email" required="required"/><br/>
                    </div>

                    <div class="cpf">
                        <label for="cpf">CPF</label>
                        <input id="cpf" name="cpf" placeholder="___.___.___-__" data-slots="_" required="required"/><br/>
                    </div>

                    <div class="dataNascimento">
                        <label for="dataNascimento">Data Nascimento</label>
                        <input id="dataNascimento" name="dataNascimento" placeholder="__/__/____" data-slots="_" required="required"/><br/>
                    </div>

                    <div class="telefone">
                        <label for="telefone">Telefone</label>
                        <input id="telefone" name="telefone" placeholder="(__) _____-____" data-slots="_" required="required"/><br/>
                    </div>

                    <div class="endereco">
                        <label for="endereco">Endereco</label>
                        <input id="endereco" name="endereco" maxlength="255" required="required"/><br/>
                    </div>

                    <div class="numero">
                        <label for="numero">Numero</label>
                        <input id="numero" name="numero" type="number" maxlength="5"/><br/>
                    </div>

                    <div class="complemento">
                        <label for="complemento">Complemento</label>
                        <input id="complemento" name="complemento" required="required" maxlength="255"/><br/>
                    </div>

                    <div class="bairro">
                        <label for="bairro">Bairro</label>
                        <input id="bairro" name="bairro" required="required" maxlength="255"/><br/>
                    </div>

                    <div class="cidade">
                        <label for="cidade">Cidade</label>
                        <input id="cidade" name="cidade" required="required" maxlength="255"/><br/>
                    </div>

                    <div class="uf">
                        <label for="uf">UF</label>
                        <input id="uf" name="uf" required="required" maxlength="2"/><br/>
                    </div>

                    <div class="cep">
                        <label for="cep">CEP</label>
                        <input id="cep" name="cep" placeholder="_____-___" data-slots="_" required="required"/><br/>
                    </div>
                </div>
                
                <div class="botao-container">
          
                    <a href="ListarClientes"><button type="button" class="btn-cancelar">Cancelar</button></a>
                    <button type="button" class="btn-cadastrar" onclick="validarFormulario()">Cadastrar</button>
                </div>              
            </form>            
        </div>
        
    </body>
</html>
