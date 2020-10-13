package Servlet;

import Model.Cliente;
import DAO.ClienteDAO;
import java.io.IOException;
import java.sql.SQLException;
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
        String cpf = request.getParameter("cpf");
        String dataNascimento = request.getParameter("dataNascimento");
        String telefone = request.getParameter("telefone");
        String endereco = request.getParameter("endereco");
        String numeroStr = request.getParameter("numero");
        int numero = Integer.parseInt(numeroStr);
        String complemento = request.getParameter("complemento");
        String bairro = request.getParameter("bairro");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep");
        
        try {
            ClienteDAO.addCliente(new Cliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep));
            response.sendRedirect("sucesso.jsp");
        } catch (Exception ex) {
            Logger.getLogger(CadastrarCliente.class.getName()).log(Level.SEVERE, null, ex);
            
            String msgErro = ex.getMessage();
            request.setAttribute("msgErro", msgErro);
            
            RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/erro.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
