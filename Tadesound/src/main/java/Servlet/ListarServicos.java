package Servlet;

import Utils.Utils;
import Model.Servico;
import java.util.List;
import DAO.ServicoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarServicos extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Servico> listaServicos = null;
        
        try {
            listaServicos = ServicoDAO.getServicos();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaServicos", listaServicos);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/listaServicos.jsp");
        requestDispatcher.forward(request, response);
    }
}
