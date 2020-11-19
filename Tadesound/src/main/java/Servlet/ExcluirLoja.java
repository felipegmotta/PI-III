package Servlet;

import DAO.LojaDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExcluirLoja extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        
        //Realiza o delete no banco
        try {
            LojaDAO.deleteLoja(idLoja);
            response.getWriter().print(true);
        } catch (SQLException ex) {
            response.getWriter().print(false);
        }
    }

}
