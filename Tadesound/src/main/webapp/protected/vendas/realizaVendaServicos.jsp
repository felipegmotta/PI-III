<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/realizaVendaServicos.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Venda de Serviço</title>
        
        <script type="text/javascript">  
            function escolherCliente(idCliente, nomeCliente) {
                //Adiciona o id do cliente escolhido num span do carrinho
                $('#clienteEscolhido').val(idCliente);
                
                //Atualiza o cliente da compra
                document.getElementById("clienteCompra").innerText = "Cliente: " + nomeCliente;
            }
            
            function mostraModalEscolheDataServico(idServico, nomeServico, grauComplexidade, duracaoMinutos, precoServico) {
                $('#idServico').val(idServico);
                $('#nomeServico').val(nomeServico);
                $('#grauComplexidade').val(grauComplexidade);
                $('#duracaoMinutos').val(duracaoMinutos);
                $('#precoServico').val(precoServico);
                
                $('#modalServico').modal('show');
            }
            
            function escolheServico() {
                //Captura as informacoes do servico atual
                var idServico = $('#idServico').val();
                var nomeServico = $('#nomeServico').val();
                var duracaoMinutos = $('#duracaoMinutos').val();
                var grauComplexidade = $('#grauComplexidade').val();
                var dataServico = $('#dataServico').val();
                var precoServico = $('#precoServico').val();
                
                //Atualiza valores da compra
                $('#servicoCompra').html("Servico: " + nomeServico);
                $('#dataProgramada').html("Data Programada: " + dataServico);
                
                //Atualiza o valor total da compra
                atualizaValorCompra(precoServico);

                //Adiciona o servico na sessao do usuario
                adicionaServicoSessao(idServico, nomeServico, duracaoMinutos, grauComplexidade, precoServicoFormatado, dataServico);

                //Desabilita o toast, caso haja
                $('#toast').toast('hide');
                
                //Desabilita o modal
                $('#modalServico').modal('hide');
            }
            
            function atualizaValorCompra(precoServico) {                
                //Captura o valor do servico
                precoServico = precoServico.replaceAll(".00", "")
                precoServico = precoServico.replaceAll("R$Â", "").replaceAll(",00", "").replace(".", "")

                $('#valorTotal').val(precoServico);
                
                //Formata o valor total e atualiza o valor da compra
                valorTotalFormatado = numberToCurrency(precoServico); /* R$2.500,00 */
                document.getElementById('valorCompra').innerText = "Total: " + valorTotalFormatado;
            }
            
            function adicionaServicoSessao(idServico, nomeServico, duracaoMinutos, grauComplexidade, precoTotal, dataProgramada) {
                //Envia a requisicao GET para o BD deletar o fornecedor
                $.get("SessaoVendaServicos?idServico="+idServico+"&nomeServico="+nomeServico+"&duracaoMinutos="+duracaoMinutos+"&grauComplexidade="+grauComplexidade+"&precoTotal="+precoTotal+"&dataProgramada="+dataProgramada, function(resposta) {
                    
                });
            }            
            
            function limparCarrinho() {
                //Limpa os itens do carrinho
                $('#tabelaCarrinho').html("");
                
                //Limpa o valor total do carrinho
                document.getElementById('valorCompra').innerText = "Total: R$0,00";
                
                //Envia a requisicao GET para o Servlet retirar os servicos da sessao
                $.get("CarrinhoServlet?limparSessao=True", function(resposta) {
                    
                });
            }
            
            function validaVenda() {
                var msgErro = "";
                
                //Valida se tem um cliente selecionado
                if ($('#clienteEscolhido').val() === "") {
                    msgErro += "Deve ser escolhido ao menos um cliente.</br>";
                }
                
                //Captura a data atual
                var dateObj = new Date();
                var diaHoje = dateObj.getUTCDate() - 1;
                var mesHoje = dateObj.getUTCMonth() + 1;
                var anoHoje = dateObj.getUTCFullYear();

                //Captura a data inputada
                var dataInputada = $('#dataServico').val();
                var arrayDataInputada = dataInputada.split("/");
                
                var diaInputado = arrayDataInputada[0];
                var mesInputado = arrayDataInputada[1];
                var anoInputado = arrayDataInputada[2];
                
                //Valida a data inputada
                if (diaInputado < diaHoje && mesInputado <= mesHoje) {
                    msgErro += "Por favor insira uma data valida: O dia escolhido deve ser maior que o dia atual.</br>";
                }
                if (mesInputado < mesHoje || mesInputado > 12) {
                    msgErro += "Por favor insira uma data valida: O mes escolhido deve ser maior que o mes atual e menor que 12.</br>";
                }
                if (anoInputado < anoHoje) {
                    msgErro += "Por favor insira uma data valida: O ano escolhido deve ser maior ou igual ao ano atual.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    cadatrarVendaBD();
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar a venda
            function cadatrarVendaBD() {
                $.ajax({
                    type: "POST",
                    url: "CadastrarVenda",
                    data: {'tipo': "Servico",
                           'valorTotal': $('#valorTotal').val(),
                           'quantidadeItens': 1,
                           'idCliente': $('#clienteEscolhido').val(),
                           'idFuncionario': ${sessionScope.usuario.idFuncionario},
                           'dataProgramada': $('#dataServico').val()},
                    dataType: "text",
                    success: function(response) {
                        cadatrarItensVendaBD(response);
                    }
                });
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar os itens da venda
            function cadatrarItensVendaBD(idVenda) {
                $.ajax({
                    type: "POST",
                    url: "CadastrarItensVenda",
                    data: {'tipo': "Servico",
                           'idVenda': idVenda,
                           'idItem': $('#idServico').val(),
                           'quantidadeItens': 1,
                           'valorTotalProduto': $('#valorTotal').val()},
                    dataType: "text"
                });
            }
            
            //Exibe um toast de sucesso
            function exibeMensagemSucesso() {
                $('#msgToast').html("Operacao realizada com sucesso!");
                $('#toast').toast('show');
            }
            
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "Erro ao realizar venda:</br>";
                msgExibir = msgExibir.concat(msgErro);
                
                $('#msgToast').html(msgExibir);
                $('#toast').toast('show');
            }
            
            //Formata numero em currency
            function numberToCurrency(number) {
                //Cria um formatador de numeros
                var formatter = new Intl.NumberFormat('pt-BR', {
                  style: 'currency',
                  currency: 'BRL'});
              
                return formatter.format(number);
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
                <a href="paginaInicial.jsp"><img src="img/Logo.png" class="logo" 
                    alt="Logo da Tadesound"></a>
            </div>
            <h1>VENDA</h1>
            <div class="info">
                <h3><b>produto . serviço</b></h3>
            </div>
        </header>
        
        <div class="lft-container">            
            <a href="ListarClientes"><img src="img/IconeClientes.png" 
                class="icone" alt="Ícone de clientes"></a>
            <a href="ListarProdutosEClientes"><img src="img/IconeCaixa.png" 
                class="icone" alt="Ícone de venda de produtos"></a>
            <a href="ListarServicosEClientes"><img src="img/IconeAgendar.png" 
                class="icone" alt="Ícone de venda de serviço"></a>
        </div>         
       
        <div class="rgt-container">
            <h1>Venda de Serviço</h1>          
            
            <div class="campos-container">                
                <h2>Selecionar Cliente</h2>
                <div class="campos-container1">
                    
                    <!--Tabela de Cliente-->
                    <table cellspacing="0" cellpadding="1" border="1" width="300">
                        <table>
                            <thead>
                                <th class="filler">Fill</th>
                                <th hidden="true">idCliente</th>
                                <th>Nome</th>
                                <th>Email</th>
                                <th>CPF</th>
                                <th>Data Nascimento</th>
                                <th>Telefone</th>
                                <th>Endereco</th>
                                <th>Numero</th>
                                <th>Complemento</th>
                                <th>Bairro</th>
                                <th>Cidade</th>
                                <th>UF</th>
                                <th>CEP</th>
                                <th>Data Cadastro</th>                                
                            </thead>
                            <tbody>
                                <c:forEach var="cliente" items="${listaClientes}">
                                    <tr>
                                        <td><img src="img/IconeFinalizar.png" class="btn-selecionar" style="cursor: pointer;" 
                                        alt="Ícone para selecionar cliente" 
                                        onclick="escolherCliente('${cliente.idCliente}', '${cliente.nome}')"></td>
                                        <td hidden="true">${cliente.idCliente}</td>
                                        <td>${cliente.nome}</td>
                                        <td>${cliente.email}</td>
                                        <td>${cliente.cpf}</td>
                                        <td>${cliente.dataNascimento}</td>
                                        <td>${cliente.telefone}</td>
                                        <td>${cliente.endereco}</td>
                                        <td>${cliente.numero}</td>
                                        <td>${cliente.complemento}</td>
                                        <td>${cliente.bairro}</td>
                                        <td>${cliente.cidade}</td>
                                        <td>${cliente.uf}</td>
                                        <td>${cliente.cep}</td>
                                        <td>${cliente.dataCadastro}</td>                                        
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </table>
                </div>

                <h2>Selecionar Serviço</h2>
                <div class="campos-container1">
                    
                    <!--Tabela de Servicos-->
                    <table cellspacing="0" cellpadding="1" border="1" width="300">
                        <table>
                            <thead>
                                <th class="filler">Fill</th>
                                <th hidden="true">idServico</th>
                                <th>Nome</th>
                                <th>Preco</th>
                                <th>Grau Complexidade</th>
                                <th>Duracao em Minutos</th>
                            </thead>
                            <tbody>
                                <c:forEach var="servico" items="${listaServicos}">
                                    <tr>
                                        <td><img src="img/IconeAdicionar.png" class="btn-selecionar" style="cursor: pointer;"
                                        alt="icone para adicionar servico ao carrinho" 
                                        onclick="mostraModalEscolheDataServico('${servico.idServico}', '${servico.nome}', '${servico.grauComplexidade}', '${servico.duracaoMinutos}', '${servico.preco}')"></td>                                        
                                        <td hidden="true">${servico.idServico}</td>
                                        <td>${servico.nome}</td>                                      
                                        <td id='precoServicoID${servico.idServico}'>${servico.preco}</td>                                      
                                        <td>${servico.grauComplexidade}</td>                                      
                                        <td>${servico.duracaoMinutos}</td>                                      
                                    </tr>
                                    
                                    <script>
                                        //Formata o campo de preco corretamente para exibicao
                                        var precoServicoAtual = ${servico.preco}
                                        var precoServicoFormatado = numberToCurrency(precoServicoAtual);
                                        $('#precoServicoID${servico.idServico}').html(precoServicoFormatado);
                                    </script>
                                </c:forEach>
                            </tbody>
                        </table>
                    </table>
                </div>
                
                <h2 class="carrinho">Carrinho</h2>
                <div class="campos-container2">
                    <div class="total">
                        <!--Guardar o status atual da compra-->
                        <span id="statusCompra">
                            <h5 id="valorCompra">Total: R$0,00</h5>
                            <h5 id="clienteCompra">Cliente: </h5>
                            <h5 id="servicoCompra">Serviço: </h5>
                            <h5 id="dataProgramada">Data Programada: </h5>
                        </span>
                    </div>
                    
                    <div class="modal fade" id="modalServico" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Escolher Data</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                
                                <div class="modal-body">
                                    Escolha a data de realizacao do servico: 
                                    <input id="dataServico" placeholder="__/__/____" data-slots="_" required="required"/>
                                    <input id="idServico" hidden="true"/>
                                    <input id="nomeServico" hidden="true"/>
                                    <input id="grauComplexidade" hidden="true"/>
                                    <input id="duracaoMinutos" hidden="true"/>
                                    <input id="precoServico" hidden="true"/>
                                    <input id="clienteEscolhido" hidden="true"/>
                                    <input id="valorTotal" hidden="true"/>
                                </div>
                                
                                <c:forEach var="servico" items="${sessionScope.listaServicosSessao}">
                                    <script>
                                        console.log("entrei")
                                        //Atualiza valores da compra
                                        $('#servicoCompra').html("Servico: " + ${servico.nomeServico});
                                        $('#dataProgramada').html("Data Programada: " + ${servico.dataProgramada});
                                        $('#idServico').val(${servico.idServico});
                                        $('#nomeServico').val(${servico.nomeServico});
                                        $('#grauComplexidade').val(${servico.grauComplexidade});
                                        $('#duracaoMinutos').val(${servico.duracaoMinutos});
                                        $('#valorTotal').val(${servico.valorTotal});
                                        $('#dataServico').val(${servico.dataProgramada});
                                    </script>
                                </c:forEach>
                                
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn-confirmar" onclick="escolheServico()">Confirmar</button>
                                </div>
                            </div>
                        </div>
                    </div> 
                </div>
            
                <div class="container-toast">
                    <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
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
                
                <div class="botao-container">
                    <button type="button" class="btn-cancelar" onclick="limparCarrinho()">Limpar Carrinho</button>
                    <button type="button" class="btn-confirmar" onclick="validaVenda()">Finalizar</button>
                </div>                       
            </div>
        </div>
    </body>
</html>
