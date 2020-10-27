package Servlet;

import Utils.Utils;
import Model.Loja;
import DAO.LojaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarLojas extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        List<Loja> listaLojas = null;
        
        try {
            listaLojas = LojaDAO.getLojas();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaLojas", listaLojas);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/listaLojas.jsp");
        requestDispatcher.forward(request, response);
    }

}
