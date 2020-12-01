<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%--<%@include file="header.jsp"%>--%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../../css/crudFornecedor.css">
        <link rel="stylesheet" href="../../css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Cadastrar Fornecedor</title>
        
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
                //Valida CPF e CNPJ
                if (!$('#cpf').val() === "" && !$('#cnpj').val() === "") {
                    msgErro += "Deve ser preenchido somente o campo \"CPF\" ou somente o campo \"CNPJ\".</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    cadastrarFornecedorBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar o fornecedor
            function cadastrarFornecedorBD() {
                $.ajax({
                    type: "POST",
                    url: "../../CadastrarFornecedor",
                    data: {'nome': $('#nome').val(),
                           'cpf': $('#cpf').val(),
                           'cnpj': $('#cnpj').val(),
                           'telefone': $('#telefone').val(),
                           'email': $('#email').val(),
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
                $('#toast').toast('show');
                
                //Limpa o valor dos campos
                $('#nome').val("");
                $('#email').val("");
                $('#cpf').val("");
                $('#cnpj').val("");
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
                var msgExibir = "Erro ao cadastrar fornecedor:</br>";
                msgExibir = msgExibir.concat(msgErro);
                $('#msgToast').html(msgExibir);
                $('#toast').toast('show');
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
                <a href="02_menuInicial.jsp"><img src="../../img/Logo.png" class="logo" 
                    alt="Logo da Tadesound"></a>
            </div>
            <h1>CADASTRO</h1>
            <div class="info">
                <h3><b>consulta . cadastro . manutenção</b></h3>
            </div>
        </header>
        
        <div class="lft-container">            
            <!--Verifica o cargo do usuario, para determinar a exibicao do menu lateral-->
            <c:if test="${sessionScope.usuario.admin}">
                <a href="/Tadesound/protected/backoffice/cadastrarProduto.jsp"><img src="../../img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="../../img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarCliente.jsp"><img src="../../img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="../../img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarLoja.jsp"><img src="../../img/IconeFilial.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFuncionario.jsp"><img src="../../img/IconeFuncionario.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.gerente}">
                <a href="/Tadesound/protected/backoffice/cadastrarProduto.jsp"><img src="../../img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="../../img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarCliente.jsp"><img src="../../img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="../../img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarLoja.jsp"><img src="../../img/IconeFilial.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFuncionario.jsp"><img src="../../img/IconeFuncionario.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.vendedor}">
                <a><img src="../../img/IconeProduto_desabilitado.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a><img src="../../img/IconeServico_desabilitado.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a href="/Tadesound/protected/vendas/cadastrarCliente.jsp"><img src="../../img/IconeClientes.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a><img src="../../img/IconeFornecedor_desabilitado.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a><img src="../../img/IconeFilial_desabilitado.png" 
                    class="icone" alt="Ícone de filial"></a>
                <a><img src="../../img/IconeFuncionario_desabilitado.png" 
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
            <c:if test="${sessionScope.usuario.backoffice}">
                <a href="/Tadesound/protected/backoffice/cadastrarProduto.jsp"><img src="../../img/IconeProduto.png" 
                    class="icone" alt="Ícone de produto"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarServico.jsp"><img src="../../img/IconeServico.png" 
                    class="icone" alt="Ícone de serviço"></a>
                <a><img src="../../img/IconeClientes_desabilitado.png" 
                    class="icone" alt="Ícone de clientes"></a>
                <a href="/Tadesound/protected/backoffice/cadastrarFornecedor.jsp"><img src="../../img/IconeFornecedor.png" 
                    class="icone" alt="Ícone de fornecedor"></a>
                <a><img src="../../img/IconeFilial_desabilitado.png"
                    class="icone" alt="Ícone de filial"></a>
                <a><img src="../../img/IconeFuncionario_desabilitado.png"
                    class="icone" alt="Ícone de funcionário"></a>
            </c:if>
        </div>
                
        <div class="rgt-container">
            <div class="container-titulo">
                <h1>Cadastrar Fornecedor</h1>
                <a href="../../ListarFornecedores"><img src="../../img/IconePesquisar.png" 
                    class="btn-manter1" alt="Ícone para a página de listagem de fornecedor"></a>
                <a href="atualizarFornecedor.jsp"><img src="../../img/IconeEditar.png" 
                    class="btn-manter2" alt="Ícone para a página de manutenção de fornecedor"></a>
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
                        <input id="cpf" name="cpf" placeholder="___.___.___-__" data-slots="_"/><br/>
                    </div>

                    <div class="cnpj">
                        <label for="cnpj">CNPJ</label>
                        <input id="cnpj" name="cnpj" placeholder="__.___.___/____-__" data-slots="_"/><br/>
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
          
                    <a href="index.jsp"><button type="button" class="btn-cancelar">Cancelar</button></a>
                    <button type="button" class="btn-cadastrar" onclick="validarFormulario()">Cadastrar</button>
                </div>              
            </form>            
        </div>
        
    </body>
</html>
