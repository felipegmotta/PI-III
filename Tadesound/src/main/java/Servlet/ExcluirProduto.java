package Servlet;

import DAO.ProdutoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExcluirProduto extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        
        //Realiza o delete no banco
        try {
            ProdutoDAO.deleteProduto(idProduto);
            response.getWriter().print(true);
        } catch (SQLException ex) {
            response.getWriter().print(false);
        }
    }

}
