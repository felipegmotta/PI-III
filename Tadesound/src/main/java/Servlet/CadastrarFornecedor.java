package Servlet;

import Utils.*;
import Model.Fornecedor;
import DAO.FornecedorDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CadastrarFornecedor extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nome = request.getParameter("nome");
        String cpf = request.getParameter("cpf").replaceAll("([^\\w\\*])", "");
        String cnpj = request.getParameter("cnpj").replaceAll("([^\\w\\*])", "");
        String CPFOuCNPJ = "";
        String telefone = request.getParameter("telefone").replaceAll("([^\\w\\*])", "");
        String email = request.getParameter("email");
        String endereco = request.getParameter("endereco");
        int numero = Integer.parseInt(request.getParameter("numero"));
        String complemento = request.getParameter("complemento");
        String bairro = request.getParameter("bairro");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep").replaceAll("([^\\w\\*])", "");
        
        if (cpf.length() > 1) {
            CPFOuCNPJ = cpf;
        } else {
            CPFOuCNPJ = cnpj;
        }
        
        try {
            FornecedorDAO.addFornecedor(new Fornecedor(nome, CPFOuCNPJ, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep));
            response.sendRedirect("sucesso.jsp");
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}
