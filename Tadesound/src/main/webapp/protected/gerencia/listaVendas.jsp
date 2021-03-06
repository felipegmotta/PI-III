<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="../../css/listaVenda.css">
        <link rel="stylesheet" href="../../css/bootstrap.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <title>Relatorio de Vendas</title>
        <script>
            //Funcao responsavel por atulizar o tipo da consulta
            function atualizarTipoConsulta(novoTipoConsulta) {
                $('#tipoConsulta').val(novoTipoConsulta);
                
                //Deixar selecionado esse tipo de consulta
                document.getElementById(novoTipoConsulta).checked = true;
                
                //Escolher esse, como o tipo de consulta da pagina
                $('#tipoConsulta').val(novoTipoConsulta);
            }
            
            function validaConsulta() {
                var tipoConsulta = $('#tipoConsulta').val();
                var idConsulta = $('#idConsulta').val();
                var nomeConsulta = $('#nomeConsulta').val();
                var msgErro = "";
                
                //Valida o tipo de consulta
                if (tipoConsulta === "") {
                    msgErro += "Deve ser selecionado ao menos um tipo de consulta.</br>";
                }
                //Valida se o campo de nome foi preenchido corretamente
                if (nomeConsulta.search("[0-9]+") !== -1) {
                    msgErro += "O campo nome nao deve conter numeros.</br>";
                }
                //Valida o id da Consulta
                if (idConsulta.length > 5) {
                    msgErro += "O campo de ID deve conter no maximo 5 caracteres.</br>";
                }
                
                //Caso nao contenha erros de preenchimento
                if (msgErro === "") {
                    consultarVenda(tipoConsulta, idConsulta, nomeConsulta);
                } else {
                    exibeMensagemErro(msgErro);
                }
            }
            
            //Funcao responsavel por atualizar o produto
            function consultarVenda(tipoConsulta, idConsulta, nomeConsulta) {                
                //Envia a requisicao GET para o BD atualizar o produto
                $.get("../../ListarVendas?tipoConsulta="+tipoConsulta+"&idConsulta="+idConsulta+"&nomeConsulta="+nomeConsulta, function(resposta) {
                    //A partir da nova pagina recebida atraves do response, substituir a pagina atual
                    document.documentElement.innerHTML = resposta;
                    
                    //Adicionar os headers da tabela de relatorio, dependendo do tipo da consulta
                    atualizaColunasTabela(tipoConsulta);
                    
                    //Atualizar a pagina para esse tipo de consulta
                    atualizarTipoConsulta(tipoConsulta);
                });
            }
            
            //Atualiza o relatorio
            function atualizaColunasTabela(tipoConsulta) {
                if (tipoConsulta === "Produto") {
                    //Adiciona as colunas da tabela para os casos de consulta de produto
                    $('#headTabelaRelatorio').html("<th>ID Loja</th>" +
                                                   "<th>ID Produto</th>" +
                                                   "<th>Nome Produto</th>" +
                                                   "<th>Valor Produto</th>" +
                                                   "<th>Quantidade Produto</th>" +
                                                   "<th>Total</th>" +
                                                   "<th>Data Venda</th>" +
                                                   "<th class='filler' style='width:1%'>Fill</th>");
                } else if (tipoConsulta === "Cliente") {
                    //Adiciona as colunas da tabela para os casos de consulta de cliente
                    $('#headTabelaRelatorio').html("<th>ID Cliente</th>" +
                                                   "<th>Nome Cliente</th>" +
                                                   "<th>ID Loja</th>" +
                                                   "<th>Nome Loja</th>" +
                                                   "<th>ID Venda</th>" +
                                                   "<th>Total</th>" +
                                                   "<th>Data Venda</th>" +
                                                   "<th class='filler' style='width:1%'>Fill</th>");
                } else if (tipoConsulta === "Loja") {
                    //Adiciona as colunas da tabela para os casos de consulta de loja
                    $('#headTabelaRelatorio').html("<th>ID Loja</th>" +
                                                   "<th>Nome Loja</th>" +
                                                   "<th>Total</th>" +
                                                   "<th>Porcentagem</th>" +
                                                   "<th class='filler' style='width:1%'>Fill</th>");
                } else {
                    //Adiciona as colunas da tabela para os casos de consulta de servicos
                    $('#headTabelaRelatorio').html("<th>ID Loja</th>" +
                                                   "<th>ID Servico</th>" +
                                                   "<th>Nome Servico</th>" +
                                                   "<th>Grau Complexidade</th>" +
                                                   "<th>Duracao Minutos</th>" +
                                                   "<th>Valor Servico</th>" +
                                                   "<th>Data Contratacao</th>" +
                                                   "<th class='filler' style='width:1%'>Fill</th>");
                }
            }
            
            //Exibe um toast de erro, com os erros ocorridos
            function exibeMensagemErro(msgErro) {
                var msgExibir = "<b>Erro ao extrair relatorio</b></br>";
                msgExibir = msgExibir.concat(msgErro);
                
                $('#msgToast').html(msgExibir);
                $('.toast').toast('show');
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
                <a href="paginaInicial.jsp"><img src="../../img/Logo.png" class="logo" 
                    alt="Logo da Tadesound"></a>
            </div>
            <h1>RELATÓRIO</h1>
            <div class="info">
                <h3><b>produto . cliente . loja</b></h3>
            </div>
        </header>

        <div class="lft-container">      
            <a href="listaVendas.jsp"><img src="../../img/IconeVendas.png" 
                class="icone" alt="Ícone de relatório de vendas"></a>
            <a href="../../ListarProdutos"><img src="../../img/IconeProduto.png" 
                class="icone" alt="Ícone de produto"></a>
            <a href="../../ListarClientes"><img src="../../img/IconeClientes.png" 
                class="icone" alt="Ícone de clientes"></a>
            <a><img src="../../img/IconeFilial.png" 
                class="icone" alt="Ícone de filial"></a>
        </div>
        
        <div class="rgt-container">
            <div class="container-titulo">
                <h1>Consultar Vendas</h1>
            </div>
            
            <div class="campos-container">
                <div class="campos-container1">
                    <!--checkbox para o tipo de consulta-->
                    <div class="tipo-container">
                        <h2>Tipo de Relatório</h2>
                        <input type="radio" id="Produto" name="tipoConsulta" value="Produto" onchange="atualizarTipoConsulta('Produto')">
                        <label for="tipoConsulta">Produto</label><br>
                        
                        <input type="radio" id="Servico" name="tipoConsulta" value="Servico" onchange="atualizarTipoConsulta('Servico')">
                        <label for="tipoConsulta">Servico</label><br>

                        <input type="radio" id="Cliente" name="tipoConsulta" value="Cliente" onchange="atualizarTipoConsulta('Cliente')">
                        <label for="tipoConsulta">Cliente</label><br>

                        <input type="radio" id="Loja" name="tipoConsulta" value="Loja" onchange="atualizarTipoConsulta('Loja')">
                        <label for="tipoConsulta">Loja</label><br>
                    </div>
                    
                    <!--Inputs para filtro da consulta-->
                    <div class="filtro-container">
                        <h2>Filtro de Consulta</h2>
                        <div>
                            <label for="idConsulta">Id Consulta</label>
                            <input type="number" id="idConsulta" name="idConsulta">
                        </div>
                        <div>
                            <label for="nomeConsulta">Nome</label>
                            <input id="nomeConsulta" name="nomeConsulta">
                        </div>
                    </div>
                </div>

                <div class="campos-container2">
                    <table cellspacing="0" cellpadding="1" border="1" width="300">
                        <table>
                            <thead id="headTabelaRelatorio">
                                <th class="filler" style="width:1%">Fill</th>
                            </thead>

                            <tbody id="bodyTabelaRelatorio">
                                <c:forEach var='consulta' items='${listaVendas}'>
                                    <!--Para relatorios de cliente-->
                                    <c:if test="${consulta.tipoVenda == 'Cliente'}">
                                        <tr>
                                            <td>${consulta.idCliente}</td>
                                            <td>${consulta.nomeCliente}</td>
                                            <td>${consulta.idLoja}</td>
                                            <td>${consulta.nomeLoja}</td>
                                            <td>${consulta.idVenda}</td>
                                            <td>${consulta.valorTotal}</td>
                                            <td>${consulta.dataVenda}</td>
                                        </tr>
                                    </c:if>
                                    
                                    <!--Para relatorios de produto-->
                                    <c:if test="${consulta.tipoVenda == 'Produto'}">
                                        <tr>
                                            <td>${consulta.idLoja}</td>
                                            <td>${consulta.idProduto}</td>
                                            <td>${consulta.nomeProduto}</td>
                                            <td>${consulta.valorProduto}</td>
                                            <td>${consulta.quantidadeTotalProduto}</td>
                                            <td>${consulta.valorTotal}</td>
                                            <td>${consulta.dataVenda}</td>
                                        </tr>
                                    </c:if>
                                    
                                    <!--Para relatorios de servico-->
                                    <c:if test="${consulta.tipoVenda == 'Servico'}">
                                        <tr>
                                            <td>${consulta.idLoja}</td>
                                            <td>${consulta.idServico}</td>
                                            <td>${consulta.nomeServico}</td>
                                            <td>${consulta.grauComplexidade}</td>
                                            <td>${consulta.duracaoMinutos}</td>
                                            <td>${consulta.valorServico}</td>
                                            <td>${consulta.dataVenda}</td>
                                        </tr>
                                    </c:if>
                                    
                                    <!--Para relatorios de loja-->
                                    <c:if test="${consulta.tipoVenda == 'Loja'}">
                                        <tr>
                                            <td>${consulta.idLoja}</td>
                                            <td>${consulta.nomeLoja}</td>
                                            <td>${consulta.valorTotal}</td>
                                            <td>${consulta.valorTotalPorcentagem}</td>
                                        </tr>
                                    </c:if>
                                </c:forEach>   
                            </tbody>
                        </table>
                    </table>
                </div>
            </div>
            
            <!--Guardar o status atual da compra-->
            <span id="statusConsulta">
                <input hidden="true" id="tipoConsulta"/>
            </span>
            
            <div class="botao-container">
                <button type="button" class="btn-confirmar" onclick="validaConsulta()">Gerar Relatorio</button>
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
        </div>
    </body>
</html>
