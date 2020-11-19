package Servlet;

import Utils.*;
import Model.Fornecedor;
import DAO.FornecedorDAO;
import Model.Produto;
import DAO.ProdutoDAO;
import java.util.List;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarProduto extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Fornecedor> listaFornecedores = null;

        try {
            listaFornecedores = FornecedorDAO.getFornecedores();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaFornecedores", listaFornecedores);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/cadastrarProduto.jsp");
        requestDispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nome = request.getParameter("nome");
        String descricao = request.getParameter("descricao");
        String preco = request.getParameter("preco").replaceAll("([^\\w\\*])", ""); //Remove todos os caracteres especiais
        String categoria = request.getParameter("categoria");
        int quantidadeEstoque = Integer.parseInt(request.getParameter("quantidadeEstoque").replaceAll("([^\\w\\*])", ""));
        int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor").replaceAll("([^\\w\\*])", ""));
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        
        try {
            ProdutoDAO.addProduto(new Produto(nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja));
            response.sendRedirect("sucesso.jsp");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
