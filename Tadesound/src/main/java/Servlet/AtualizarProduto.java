package Servlet;

import Utils.Utils;
import Model.Produto;
import DAO.ProdutoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AtualizarProduto extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        
        Produto produto = null;

        try {
            produto = ProdutoDAO.getProduto(idProduto);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
                
        request.setAttribute("produto", produto);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/atualizarProduto.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        String preco = request.getParameter("preco").replaceAll("([^\\w\\*])", ""); //Remove todos os caracteres especiais
        String categoria = request.getParameter("categoria");
        int quantidadeEstoque = Integer.parseInt(request.getParameter("quantidadeEstoque"));
        int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor"));
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        
        //Cria um novo cliente com os dados atualizados
        Produto produto = new Produto(idProduto, nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja);
        
        try {
            //Atualiza os dados do cliente no BD
            ProdutoDAO.updateProduto(produto);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
    }

}
