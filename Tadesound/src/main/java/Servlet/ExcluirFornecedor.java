package Servlet;

import Utils.Utils;
import DAO.FornecedorDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExcluirFornecedor extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idFornecedor = Integer.parseInt(request.getParameter("idFornecedor"));
        
        //Realiza o delete no banco
        try {
            FornecedorDAO.deleteFornecedor(idFornecedor);
            response.getWriter().print(true);
        } catch (SQLException ex) {
            response.getWriter().print(false);
        }
    }

}
