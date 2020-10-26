package Servlet;

import Utils.*;
import Model.Venda;
import DAO.VendaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarVenda extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String tipo = request.getParameter("tipo");
        String valorTotal = request.getParameter("valorTotal");
        int quantidadeProdutos = Integer.parseInt(request.getParameter("quantidadeProdutos"));
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        int idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));
        
        try {
            int idVenda = VendaDAO.addVenda(new Venda(tipo, valorTotal, quantidadeProdutos, idCliente, idFuncionario));
            System.out.println("Sucesso!");
            
            //Envia o idVenda via response
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(idVenda);
            out.flush();   
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
