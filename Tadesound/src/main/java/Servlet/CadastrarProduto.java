package Servlet;

import Utils.*;
import Model.Produto;
import DAO.ProdutoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarProduto extends HttpServlet {
    
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

        System.out.println(nome);
        System.out.println(descricao);
        System.out.println(preco);
        System.out.println(categoria);
        System.out.println(quantidadeEstoque);
        System.out.println(idFornecedor);
        System.out.println(idLoja);
        
        try {
            ProdutoDAO.addProduto(new Produto(nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja));
            response.sendRedirect("sucesso.jsp");
            System.out.println("sucessoooo");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
