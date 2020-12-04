package Servlet;

import Model.Venda;
import DAO.VendaDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarVenda extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        String valorTotal = request.getParameter("valorTotal").replaceAll("([^\\w\\*])", "");
        int quantidadeItens = Integer.parseInt(request.getParameter("quantidadeItens"));
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        int idFuncionario = Integer.parseInt(request.getParameter("idFuncionario"));
        String dataProgramada = request.getParameter("dataProgramada");
        if (dataProgramada != null) {
            dataProgramada = dataProgramada.replaceAll("([^\\w\\*])", "");
        }

        try {
            int idVenda;
            
            if (tipo.contains("Servico")) {
                idVenda = VendaDAO.addVenda(new Venda(tipo, valorTotal, quantidadeItens, idCliente, idFuncionario, dataProgramada));
            } else {
                idVenda = VendaDAO.addVenda(new Venda(tipo, valorTotal, quantidadeItens, idCliente, idFuncionario));
            }
            
            //Envia o idVenda via response
            PrintWriter out = response.getWriter();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(idVenda);
            out.flush();   
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            String msgErro = ex.getMessage();
            request.setAttribute("msgErro", msgErro);

            RequestDispatcher requestDispatcher = request
                    .getServletContext().getRequestDispatcher("/erro.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
