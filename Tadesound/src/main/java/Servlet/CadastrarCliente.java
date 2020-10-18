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
        System.out.println("dentro do post");
        
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
        
        System.out.println(nome);
        System.out.println(email);
        System.out.println(cpf);
        System.out.println(dataNascimento);
        System.out.println(telefone);
        System.out.println(endereco);
        System.out.println(numero);
        System.out.println(complemento);
        System.out.println(bairro);
        System.out.println(cidade);
        System.out.println(uf);
        System.out.println(cep);
        
        try {
            ClienteDAO.addCliente(new Cliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep));
            response.sendRedirect("sucesso.jsp");
            System.out.println("sucessoooo");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
