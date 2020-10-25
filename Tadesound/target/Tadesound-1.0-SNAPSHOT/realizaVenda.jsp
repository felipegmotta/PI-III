<%-- 
    Document   : listaClientes
    Created on : 10/10/2020, 12:03:30
    Author     : Felipe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Venda</title>
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
                    
                    //Desabilita o toast, caso haja
                    $('#toast').toast('hide');
                }
                
                //Desabilita o modal
                $('#modalProduto').modal('hide');
            }
            
            function atualizaValorCompra(precoProduto, quantidadeProduto) {
                //Captura o valor atual da compra
                valorAtual = document.getElementById('valorCompra').innerText.replace("Valor Compra: R$", "").replaceAll(".", "").replaceAll(",", ".");
                
                //Transforma valores em int
                valorAtual = parseInt(valorAtual);
                precoProduto = parseInt(precoProduto);
                quantidadeProduto = parseInt(quantidadeProduto);
                
                //Calcula o valor total e salva o valor total no HTML
                valorTotal = valorAtual+precoProduto*quantidadeProduto;
                $('#valorTotal').val(valorTotal);
                
                //Formata o valor total e atualiza o valor da compra
                valorTotalFormatado = numberToCurrency(valorTotal); /* R$2.500,00 */
                document.getElementById('valorCompra').innerText = "Valor Compra: " + valorTotalFormatado;
            }
            
            function limparCarrinho() {
                //Limpa os itens do carrinho
                $('#tabelaCarrinho').html("");
                
                //Limpa o valor total do carrinho
                document.getElementById('valorCompra').innerText = "Valor Compra: R$0,00";
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
                           'quantidadeProdutos': $('#quantidadeProdutos').val(),
                           'idCliente': $('#clienteEscolhido').val(),
                           'idFuncionario': "1"},
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
                    var valorTotalProduto = document.getElementById("tabelaCarrinho").children[i].children[5].innerText.replaceAll("R$ ", "").replaceAll(".", "").replaceAll(",", ".");
                    
                    $.ajax({
                    type: "POST",
                    url: "CadastrarItensVenda",
                    data: {'idVenda': idVenda,
                           'idProduto': idProduto,
                           'quantidadeProduto': quantidadeProduto,
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
        <h1>Realizar Venda</h1>
        
        <div id="toast" class="toast" role="alert" aria-live="polite" aria-atomic="true" data-delay="10000">
            <div role="alert" aria-live="assertive" aria-atomic="true">
                <span id="msgToast"></span>
            </div>
        </div>
        
        <h1>Selecionar Cliente</h1>
        <!--Tabela de Cliente-->
        <table>
            <thead>
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
                        <td><button type="button" class="btn btn-primary" onclick="escolherCliente('${cliente.idCliente}', '${cliente.nome}')">Escolher Cliente</button></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        
        <h1>Selecionar Produto</h1>
        <!--Tabela de Produtos-->
        <table>
            <thead>
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
                        <td hidden="true">${produto.idProduto}</td>
                        <td>${produto.nome}</td>
                        <td>${produto.descricao}</td>
                        <td id='precoProduto${produto.idProduto}'>0,00</td>
                        <td>${produto.categoria}</td>
                        <td>${produto.quantidadeEstoque}</td>
                        <td>${produto.idFornecedor}</td>
                        <td>${produto.idLoja}</td>
                        <td>${produto.dataCadastro}</td>
                        <td><button type="button" class="btn btn-primary" onclick="mostraModalEscolheQuantidadeProduto('${produto.idProduto}', '${produto.nome}', '${produto.categoria}', '${produto.preco}')">Adicionar ao Carrinho</button></td>
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
        
        <h1>Carrinho</h1>
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
                
            </tbody>
        </table>
        
        <!--Guardar o status atual da compra-->
        <span id="statusCompra">
            <h5 id="valorCompra">Valor Compra: R$0,00</h5>
            <h5 id="clienteCompra">Cliente: </h5>
            <input hidden="true" id="clienteEscolhido"/>
            <input hidden="true" id="valorTotal"/>
            <input hidden="true" id="quantidadeProdutos"/>
        </span>
        
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
                  <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                  <button type="button" class="btn btn-primary" onclick="adicionarProdutoAoCarrinho()">Confirmar</button>
                </div>
              </div>
            </div>
        </div>
        
        <button type="button" class="btn btn-primary" onclick="limparCarrinho()">Limpar Carrinho</button>
        <button type="button" class="btn btn-primary" onclick="validaVenda()">Finalizar</button>
    </body>
</html>
