package Servlet;

import Utils.Utils;
import Model.Cliente;
import DAO.ClienteDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AtualizarCliente extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cpfCliente = request.getParameter("cpf");
        System.out.println("to no get " + cpfCliente);
        
        Cliente cliente = null;

        try {
            cliente = ClienteDAO.getCliente(cpfCliente);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        System.out.println(cliente.getNome());
        
        request.setAttribute("cliente", cliente);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/atualizarCliente.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
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
        
        //Cria um novo cliente com os dados atualizados
        Cliente cliente = new Cliente(idCliente, nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep);
        
        try {
            //Atualiza os dados do cliente no BD
            ClienteDAO.updateCliente(cliente);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
    }

}