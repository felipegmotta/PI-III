package Servlet;

import Utils.Utils;
import Model.Cliente;
import java.util.List;
import DAO.ClienteDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarClientes extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cliente> listaClientes = null;
        
        try {
            listaClientes = ClienteDAO.getClientes();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaClientes", listaClientes);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/listaClientes.jsp");
        requestDispatcher.forward(request, response);
    }
}
