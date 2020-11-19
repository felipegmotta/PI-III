package Servlet;

import Utils.Utils;
import Model.Fornecedor;
import java.util.List;
import DAO.FornecedorDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarFornecedores extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Fornecedor> listaFornecedores = null;

        try {
            listaFornecedores = FornecedorDAO.getFornecedores();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaFornecedores", listaFornecedores);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/listaFornecedores.jsp");
        requestDispatcher.forward(request, response);
    }
}
