package Servlet;

import Model.Cliente;
import DAO.ClienteDAO;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
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
        String numeroStr = request.getParameter("numero");
        int numero = Integer.parseInt(numeroStr);
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
        
        //Valida informacoes inputadas pelo usuario
        //String msgErro = validaDadosInseridosCliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep);
        
        //Caso tenha preenchido algo errado 
//        if (msgErro != null) {
//            request.setAttribute("msgErro", msgErro);
//            
//            RequestDispatcher requestDispatcher = getServletContext()
//                .getRequestDispatcher("/erro_cadastro.jsp");
//            requestDispatcher.forward(request, response);
//            
//            return;
//        }
        
        try {
            ClienteDAO.addCliente(new Cliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep));
            response.sendRedirect("sucesso.jsp");
        } catch (Exception ex) {
            Logger.getLogger(CadastrarCliente.class.getName()).log(Level.SEVERE, null, ex);
            
            String msgErro = ex.getMessage();
            request.setAttribute("msgErro", msgErro);
            
            RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/erro_cadastro.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
