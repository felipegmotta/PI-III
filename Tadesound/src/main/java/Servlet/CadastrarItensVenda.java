package Servlet;

import Utils.*;
import DAO.VendaDAO;
import Model.ItensVenda;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarItensVenda extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("dentro do post");
        
        int idVenda = Integer.parseInt(request.getParameter("idVenda"));
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        int quantidadeProduto = Integer.parseInt(request.getParameter("quantidadeProduto"));
        String valorTotalProduto = request.getParameter("valorTotalProduto");

        System.out.println(idVenda);
        System.out.println(idProduto);
        System.out.println(quantidadeProduto);
        System.out.println(valorTotalProduto);
        
        try {
            VendaDAO.addItensVenda(new ItensVenda(idVenda, idProduto, quantidadeProduto, valorTotalProduto));
            response.sendRedirect("sucesso.jsp");
            System.out.println("Sucesso!");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
