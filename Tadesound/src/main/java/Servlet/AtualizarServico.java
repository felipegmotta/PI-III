package Servlet;

import Utils.Utils;
import Model.Servico;
import DAO.ServicoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AtualizarServico extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idServico = Integer.parseInt(request.getParameter("idServico"));
        
        Servico servico = null;

        try {
            servico = ServicoDAO.getServico(idServico);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
                
        request.setAttribute("servico", servico);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/atualizarServicoBackoffice.jsp");
        requestDispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("dentro do krl do post");
        int idServico = Integer.parseInt(request.getParameter("idServico"));
        String nome = request.getParameter("nome");
        String preco = request.getParameter("preco");
        int grauComplexidade = Integer.parseInt(request.getParameter("grauComplexidade")); //Remove todos os caracteres especiais
        int duracaoMinutos = Integer.parseInt(request.getParameter("duracaoMinutos"));
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));

        Servico servico = new Servico(idServico, nome, preco, grauComplexidade, duracaoMinutos, idLoja);
        
        try {
            //Atualiza os dados do cliente no BD
            ServicoDAO.updateServico(servico);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
    }

}
