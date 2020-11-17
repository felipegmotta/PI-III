package Servlet;

import Utils.*;
import Model.Loja;
import DAO.LojaDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarLoja extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String nome = request.getParameter("nome");
        String endereco = request.getParameter("endereco");
        int numero = Integer.parseInt(request.getParameter("numero"));
        String bairro = request.getParameter("bairro");
        String complemento = request.getParameter("complemento");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep").replaceAll("([^\\w\\*])", "");
        String telefone = request.getParameter("telefone").replaceAll("([^\\w\\*])", "");
        System.out.println(telefone);
        
        
        try {
            LojaDAO.addLoja(new Loja(nome, endereco, numero, complemento, bairro, cidade, uf, cep, telefone));
            response.sendRedirect("sucesso.jsp");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
