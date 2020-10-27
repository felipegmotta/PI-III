<%-- 
    Created on : 24/10/2020, 17:10:54
    Author     : Ygor
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%--<%@include file="header.jsp"%>--%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/crudServico.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <title>Cadastrar Serviço</title>  
        
        <script type="text/javascript">
            function validarFormulario() {
                var msgErro = "";
                
                //Valida o Nome
                if ($('#nome').val().search("[0-9]+") !== -1) {
                    msgErro += "O Campo \"Nome\" nao deve possuir numeros.</br>";
                }
                //Valida a descricao
                if ($('#descricao').val().search("[0-9]+") !== -1) {
                    msgErro += "O Campo \"Descricao\" esta incorreto.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    cadastrarServicoBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar o servico
            function cadastrarServico() {
                $.ajax({
                    type: "POST",
                    url: "cadastrarServico",
                    data: {'nome': $('#nome').val(),
                           'descricao': $('#descricao').val(),
                           'preco': $('#preco').val(),
                           'categoria': $('#categoria').val(),
                           'grauComplexidade': $('#grauComplexidade').val(),
                           'tipoServico': $('#tipoServico').val(),
                           'agendarServico': $('#agendarServico').val(),
                           'idServico': $('#idServico').val(),
                           'idLoja': $('#idLoja').val()},
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
                $('#descricao').val("");
                $('#preco').val("");
                $('#grauComplexidade').val("");
                $('#tipoServico').val("");
                $('#agendarServico').val("");
            }
            
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "Erro ao cadastrar serviço</br>";
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
            }});
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
            <a href="cadastrarProduto.jsp"><img src="img/IconeProduto.png" 
                class="icone" alt="Ícone de produto"></a>
            <a href="cadastrarServico.jsp"><img src="img/IconeServico.png" 
                class="icone" alt="Ícone de serviço"></a>
            <a href="cadastrarCliente.jsp"><img src="img/IconeClientes.png" 
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
                <h1>Adicionar Serviço</h1>
                <a href="listaServico.jsp"><img src="img/IconePesquisar.png" 
                    class="btn-manter1" alt="Ícone para a página de listagem de serviços"></a>
                <a href="atualizarServico.jsp"><img src="img/IconeEditar.png" 
                    class="btn-manter2" alt="Ícone para a página de manutenção de serviços"></a>
            </div>
            
            <form method="POST">
                <div class="campos-container">
                    <div class="nome">
                        <label for="nome">Nome</label>
                        <input id="nome" name="nome" minlength="3" maxlength="255" required="required"/><br/>
                    </div>

                    <div class="descricao">
                        <label for="descricao">Descricao</label>
                        <input id="descricao" name="descricao" minlength="3" maxlength="255" required="required"/><br/>
                    </div>

                    <div class="preco">
                        <label for="preco">Preco</label>
                        <input type="text" id="preco" name="preco" required="required"/><br/>
                    </div>

                    <div class="categoria">
                        <label for="categoria">Categoria</label>
                        <select id="categoria" name="categoria" value="cordas">
                            <option value="1">Cordas</option>
                            <option value="2">Sopro</option>
                        </select>
                    </div>

                    <div class="grauComplexidade">
                        <label for="grauComplexidade">Grau de Complexidade</label>
                        <input id="grauComplexidade" type="number" name="grauComplexidade" required="required"/><br/>
                    </div>

                    <div class="tipoServiço">
                        <label for="tipoServiço">Tipo de Serviço</label>
                        <select id="idServico" name="servico" value="tipo">
                            <option value="1">Afinação</option>
                            <option value="2">Manutenção</option>
                        </select>
                    </div>
                    
                    <div class="agendarServiço">
                        <label for="agendarServiço">Agendar Serviço</label>
                        <input id="agendarServiço" name="agendarServiço" placeholder="__/__/____" data-slots="_" required="required"/><br/>
                    </div>

                    <div class="loja">
                        <label for="loja">Loja</label>
                        <select id="idLoja" name="loja" value="camposElisios">
                            <option value="1">Campos Elisios</option>
                            <option value="2">Interlagos</option>
                        </select>
                    </div>
                    
                <div class="botao-container">
                    <a href="index.jsp"><button type="button" class="btn-cancelar">Cancelar</button></a>
                    <button type="button" class="btn-cadastrar" onclick="validarFormulario()">Cadastrar</button>
                </div>
            </form>            
        </div>
    </body>
</html>