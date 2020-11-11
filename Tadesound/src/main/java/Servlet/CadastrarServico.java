package Servlet;

import Utils.*;
import Model.Servico;
import DAO.ServicoDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarServico extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nome = request.getParameter("nome");
        String preco = request.getParameter("preco");
        String grauComplexidade = request.getParameter("grauComplexidade").replaceAll("([^\\w\\*])", ""); //Remove todos os caracteres especiais
        int duracaoMinutos = Integer.parseInt(request.getParameter("duracaoMinutos"));
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        
        System.out.println(nome);
        System.out.println(preco);
        System.out.println(grauComplexidade);
        System.out.println(duracaoMinutos);
        System.out.println(idLoja);
        
        try {
            ServicoDAO.addServico(new Servico(nome, preco, grauComplexidade, duracaoMinutos, idLoja));
            response.sendRedirect("sucesso.jsp");
            System.out.println("sucessoooo");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
