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
        <link rel="stylesheet" href="../../css/crudServicoBackoffice.css">
        <link rel="stylesheet" href="../../css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Cadastrar Serviço</title>  
        
        <script type="text/javascript">
            function validarFormulario() {
                var msgErro = "";
                
                //Valida o Nome
                if ($('#nome').val().search("[0-9]+") !== -1) {
                    msgErro += "O Campo \"Nome\" nao deve possuir numeros.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    cadastrarServicoBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar o servico
            function cadastrarServicoBD() {
                $.ajax({
                    type: "POST",
                    url: "../../CadastrarServico",
                    data: {'nome': $('#nome').val(),
                           'preco': $('#preco').val(),
                           'grauComplexidade': $('#grauComplexidade').val(),
                           'duracaoMinutos': $('#duracaoMinutos').val(),
                           'idLoja': "1"},
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
                <a href="02_menuInicial.jsp"><img src="../../img/Logo.png" class="logo" 
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
            <a href="../../ListarProdutos"><img src="../../img/IconeProduto.png" 
                class="icone" alt="Ícone de produto"></a>
            <a href="../../ListarServicos"><img src="../../img/IconeServico.png" 
                class="icone" alt="Ícone de serviço"></a>
            <a href="../../ListarFornecedores"><img src="../../img/IconeFornecedor.png" 
                class="icone" alt="Ícone de fornecedor"></a>
        </div>
        
        <div class="rgt-container">            
            <div class="container-titulo">
                <h1>Adicionar Serviço</h1>
                <a href="../../ListarServicos"><img src="../../img/IconePesquisar.png" 
                    class="btn-manter1" alt="Ícone para a página de listagem de serviços"></a>
            </div>
            
            <form method="POST">
                <div class="campos-container">
                    <div class="nome">
                        <label for="nome">Nome</label>
                        <input id="nome" name="nome" minlength="3" maxlength="255" required="required"/><br/>
                    </div>

                    <div class="preco">
                        <label for="preco">Preco</label>
                        <input type="text" id="preco" name="preco" required="required"/><br/>
                    </div>

                    <div class="grauComplexidade">
                        <label for="grauComplexidade">Grau de Complexidade</label>
                        <input id="grauComplexidade" type="number" name="grauComplexidade" required="required"/><br/>
                    </div>

                    <div class="duracaoMinutos">
                        <label for="duracaoMinutos">Duracao em minutos</label>
                        <input id="duracaoMinutos" type="number" name="duracaoMinutos" required="required"/><br/>
                    </div>
                    
                <div class="botao-container">
                    <a href="index.jsp"><button type="button" class="btn-cancelar">Cancelar</button></a>
                    <button type="button" class="btn-cadastrar" onclick="validarFormulario()">Cadastrar</button>
                </div>
            </form>            
        </div>
    </body>
</html>
