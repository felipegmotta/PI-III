<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/realizaVenda.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Venda de Produto</title>
        
        <script type="text/javascript">  
            function escolherCliente(idCliente, nomeCliente) {
                //Adiciona o id do cliente escolhido num span do carrinho
                $('#clienteEscolhido').val(idCliente);
                
                //Atualiza o cliente da compra
                document.getElementById("clienteCompra").innerText = "Cliente: " + nomeCliente;
            }
            
            function mostraModalEscolheQuantidadeProduto(idProduto, nomeProduto, categoriaProduto, precoProduto) {
                $('#idProduto').val(idProduto);
                $('#nomeProduto').val(nomeProduto);
                $('#categoriaProduto').val(categoriaProduto);
                $('#precoProduto').val(precoProduto);
                
                $('#modalProduto').modal('show');
            }
            
            function adicionarProdutoAoCarrinho() {
                //Captura as informacoes do produto atual
                var idProduto = $('#idProduto').val();
                var nomeProduto = $('#nomeProduto').val();
                var categoriaProduto = $('#categoriaProduto').val();
                var quantidadeProduto = $('#quantidadeProduto').val();
                var precoProduto = $('#precoProduto').val();
                var precoProdutoFormatado = numberToCurrency(precoProduto);
                var precoTotal = numberToCurrency(precoProduto*quantidadeProduto);
                
                //Caso a quantidade do produto tenha sido inserida de forma invalida
                if (parseInt(quantidadeProduto) <= 0 || quantidadeProduto === "") {
                    exibeMensagemErro("Quantidade invalida.");
                } else {
                    //Captura os itens atuais que estao no carrinho
                    var itensNoCarrinho = $('#tabelaCarrinho').html();

                    //Adiciona o novo item no carrinho
                    $('#tabelaCarrinho').html(itensNoCarrinho + "<tr>" + "<td hidden='true'>" + idProduto + "</td>" +
                                                       "<td>" + "Produto" + "</td>" + 
                                                       "<td>" + nomeProduto + "</td>" +
                                                       "<td>" + categoriaProduto + "</td>" +
                                                       "<td>" + quantidadeProduto + "</td>" +
                                                       "<td>" + precoProdutoFormatado + "</td>" +
                                                       "<td>" + precoTotal + "</td>" + "</tr>");

                    //Atualiza o valor total da compra
                    atualizaValorCompra(precoProduto, quantidadeProduto);
                    
                    //Adiciona o produto na sessao do usuario
                    adicionaProdutoSessao(idProduto, nomeProduto, categoriaProduto, quantidadeProduto, precoProdutoFormatado, precoTotal);
                    
                    //Desabilita o toast, caso haja
                    $('#toast').toast('hide');
                }
                
                //Desabilita o modal
                $('#modalProduto').modal('hide');
            }
            
            function atualizaValorCompra(precoProduto, quantidadeProduto) {
                //Captura o valor atual da compra
                valorAtual = document.getElementById('valorCompra').innerText.replaceAll("Total: R$", "").replaceAll(".", "").replaceAll(",00", ".");
                
                //Captura o valor do produto
                precoProduto = precoProduto.replaceAll(".00", "")
                precoProduto = precoProduto.replaceAll("R$Â", "").replaceAll(",00", "").replace(".", "")

                //Transforma valores em int
                valorAtual = parseFloat(valorAtual);
                precoProduto = parseFloat(precoProduto);
                quantidadeProduto = parseFloat(quantidadeProduto);
                
                //Calcula o valor total e salva o valor total no HTML
                valorTotal = valorAtual+precoProduto*quantidadeProduto;
                $('#valorTotal').val(valorTotal);
                
                //Formata o valor total e atualiza o valor da compra
                valorTotalFormatado = numberToCurrency(valorTotal); /* R$2.500,00 */
                document.getElementById('valorCompra').innerText = "Total: " + valorTotalFormatado;
            }
            
            function adicionaProdutoSessao(idProduto, nomeProduto, categoriaProduto, quantidadeProduto, precoProdutoFormatado, precoTotal) {
                //Envia a requisicao GET para o BD deletar o fornecedor
                $.get("SessaoVendaProdutos?idProduto="+idProduto+"&nomeProduto="+nomeProduto+"&categoriaProduto="+categoriaProduto+"&quantidadeProduto="+quantidadeProduto+"&precoProdutoFormatado="+precoProdutoFormatado+"&precoTotal="+precoTotal, function(resposta) {
                    
                });
            }            
            
            function limparCarrinho() {
                //Limpa os itens do carrinho
                $('#tabelaCarrinho').html("");
                
                //Limpa o valor total do carrinho
                document.getElementById('valorCompra').innerText = "Total: R$0,00";
                
                //Envia a requisicao GET para o Servlet retirar os produtos da sessao
                $.get("SessaoVendaProdutos?limparSessao=True", function() {
                });
            }
            
            function validaVenda() {
                var msgErro = "";
                
                //Valida se tem um cliente selecionado
                if ($('#clienteEscolhido').val() === "") {
                    msgErro += "Deve ser escolhido ao menos um cliente.</br>";
                }
                
                //Captura a quantidade de itens no carrinho, e salva no HTML
                var quantidadeItensCarrinho = document.getElementById("tabelaCarrinho").children.length;
                $('#quantidadeProdutos').val(quantidadeItensCarrinho);
                
                //Valida se a quantidade esta correta
                if (quantidadeItensCarrinho <= 0) {
                    msgErro += "Deve ser adicionado ao menos um item ao carrinho.</br>";
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
                    data: {'tipo': "Produto",
                           'valorTotal': $('#valorTotal').val(),
                           'quantidadeItens': $('#quantidadeProdutos').val(),
                           'idCliente': $('#clienteEscolhido').val(),
                           'idFuncionario': ${sessionScope.usuario.idFuncionario}},
                    dataType: "text",
                    success: function(response) {
                        cadatrarItensVendaBD(response)
                    }
                   });
            }
            
            //Essa funcao e responsavel por enviar o POST para o servlet cadastrar os itens da venda
            function cadatrarItensVendaBD(idVenda) {
                //Capturar a quantidade de itens no carrinho
                var quantidadeProdutosCarrinho = $('#quantidadeProdutos').val();
                var i = 0;
                
                //Para cada item do carrinho, cadastrar no BD de itensVenda
                while (i < quantidadeProdutosCarrinho) {
                    var idProduto = document.getElementById("tabelaCarrinho").children[i].children[0].innerText;
                    var quantidadeProduto = document.getElementById("tabelaCarrinho").children[i].children[4].innerText;
                    var valorTotalProduto = document.getElementById("tabelaCarrinho").children[i].children[6].innerText.replaceAll("R$ ", "").replaceAll(".", "").replaceAll(",", ".");
                    
                    $.ajax({
                        type: "POST",
                        url: "CadastrarItensVenda",
                        data: {'tipo': "Produto",
                               'idVenda': idVenda,
                               'idItem': idProduto,
                               'quantidadeItens': quantidadeProduto,
                               'valorTotalProduto': valorTotalProduto},
                        dataType: "text"
                    });
                   
                    i++;
                }
                exibeMensagemSucesso();
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
            <h1>Venda de Produto</h1>
            
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
                                        alt="Ãcone para selecionar cliente" 
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

                
                <h2>Selecionar Produto</h2>
                <div class="campos-container1">
                    
                    <!--Tabela de Produtos-->
                    <table cellspacing="0" cellpadding="1" border="1" width="300">
                        <table>
                            <thead>
                                <th class="filler">Fill</th>
                                <th hidden="true">idProduto</th>
                                <th>Nome</th>
                                <th>Descricao</th>
                                <th>Preco</th>
                                <th>Categoria</th>
                                <th>Quantidade em Estoque</th>
                                <th>Codigo Fornecedor</th>
                                <th>Codigo Loja</th>
                                <th>Data Cadastro</th>                            
                            </thead>
                            <tbody>
                                <c:forEach var="produto" items="${listaProdutos}">
                                    <tr>
                                        <td><img src="img/IconeAdicionar.png" class="btn-selecionar" style="cursor: pointer;"
                                        alt="icone para adicionar produto ao carrinho" 
                                        onclick="mostraModalEscolheQuantidadeProduto('${produto.idProduto}', '${produto.nome}', '${produto.categoria}', '${produto.preco}')"></td>                                        
                                        <td hidden="true">${produto.idProduto}</td>
                                        <td>${produto.nome}</td>
                                        <td>${produto.descricao}</td>
                                        <td id='precoProduto${produto.idProduto}'>0,00</td>
                                        <td>${produto.categoria}</td>
                                        <td>${produto.quantidadeEstoque}</td>
                                        <td>${produto.idFornecedor}</td>
                                        <td>${produto.idLoja}</td>
                                        <td>${produto.dataCadastro}</td>                                        
                                    </tr>

                                <script>
                                    //Formata o campo de preco corretamente para exibicao
                                    var precoProdutoAtual = ${produto.preco}
                                    var precoProdutoFormatado = numberToCurrency(precoProdutoAtual);
                                    $('#precoProduto${produto.idProduto}').html(precoProdutoFormatado);
                                </script>
                            </c:forEach>
                            </tbody>
                        </table>
                    </table>
                </div>
                
                <h2 class="carrinho">Carrinho</h2>
                <div class="total">
                    <!--Guardar o status atual da compra-->
                    <span id="statusCompra">
                        <h5 id="valorCompra">Total: R$0,00</h5>
                        <h5 id="clienteCompra">Cliente: </h5>
                        <input hidden="true" id="clienteEscolhido"/>
                        <input hidden="true" id="valorTotal"/>
                        <input hidden="true" id="quantidadeProdutos"/>
                    </span>
                </div>
                
                <div class="campos-container2">
                    <table cellspacing="0" cellpadding="1" border="1" width="300">
                        <!--Tabela do carrinho-->
                        <table>
                            <thead>
                            <th hidden="true">idProduto</th>
                            <th>Tipo</th>
                            <th>Nome</th>
                            <th>Categoria</th>
                            <th>Quantidade</th>
                            <th>Preco Unidade</th>
                            <th>Total</th>
                            </thead>
                            <tbody id="tabelaCarrinho">
                                <!--Caso tenha algum item na sessao-->
                                <c:forEach var="produto" items="${sessionScope.listaProdutosSessao}">
                                    <tr>
                                        <td hidden="true">${produto.idProduto}</td>
                                        <td>Produto</td>
                                        <td>${produto.nome}</td>
                                        <td>${produto.categoria}</td>
                                        <td>${produto.quantidadeProduto}</td>
                                        <td>${produto.preco}</td>
                                        <td>${produto.precoTotalProduto}</td>
                                        
                                        <script>
                                            atualizaValorCompra('${produto.preco}', '${produto.quantidadeProduto}');
                                        </script>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </table>                    
                </div>
                        
                <div class="total">
                    <div class="modal fade" id="modalProduto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">Escolher quantidade</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    Escolha a quantidade do produto: 
                                    <input id="quantidadeProduto" type="number"/>
                                    <input id="idProduto" hidden="true"/>
                                    <input id="nomeProduto" hidden="true"/>
                                    <input id="categoriaProduto" hidden="true"/>
                                    <input id="precoProduto" hidden="true"/>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn-cancelar" data-dismiss="modal">Cancelar</button>
                                    <button type="button" class="btn-confirmar" onclick="adicionarProdutoAoCarrinho()">Confirmar</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="botao-container">
                <button type="button" class="btn-cancelar" onclick="limparCarrinho()">Limpar Carrinho</button>
                <button type="button" class="btn-confirmar" onclick="validaVenda()">Finalizar</button>
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
        </div>
    </body>
</html>
