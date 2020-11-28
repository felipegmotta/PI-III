package Servlet;

import Utils.Utils;
import Model.Fornecedor;
import DAO.FornecedorDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AtualizarFornecedor extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor"));
        
        Fornecedor fornecedor = null;

        try {
            fornecedor = FornecedorDAO.getFornecedor(idFornecedor);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }

        request.setAttribute("fornecedor", fornecedor);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/atualizarFornecedorBackoffice.jsp");
        requestDispatcher.forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor"));
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
        
        Fornecedor fornecedor = new Fornecedor(idFornecedor, nome, CPFOuCNPJ, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep);
        
        try {
            //Atualiza os dados do cliente no BD
            FornecedorDAO.updateFornecedor(fornecedor);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
    }

}
