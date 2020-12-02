package Servlet;

import Utils.*;
import Model.Cliente;
import DAO.ClienteDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarCliente extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {        
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf").replaceAll("([^\\w\\*])", ""); //Remove todos os caracteres especiais
        String dataNascimento = request.getParameter("dataNascimento").replaceAll("([^\\w\\*])", "");
        String telefone = request.getParameter("telefone").replaceAll("([^\\w\\*])", "");
        String endereco = request.getParameter("endereco");
        int numero = Integer.parseInt(request.getParameter("numero"));
        String complemento = request.getParameter("complemento");
        String bairro = request.getParameter("bairro");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep").replaceAll("([^\\w\\*])", "");
        
        try {
            ClienteDAO.addCliente(new Cliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep));
            response.sendRedirect("sucesso.jsp");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
