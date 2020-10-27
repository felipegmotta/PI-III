package Servlet;

import Utils.Utils;
import Model.Venda;
import java.util.List;
import DAO.VendaDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarVendas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipoConsulta = request.getParameter("tipoConsulta");
        
        List<Venda> listaVendas = null;
        
        try {
            if (tipoConsulta == "Produto") {
                listaVendas = VendaDAO.getVendasProdutos();
            } else if (tipoConsulta == "Cliente") {
                listaVendas = VendaDAO.getVendasClientes();
            } else if (tipoConsulta == "Loja"){
                listaVendas = VendaDAO.getVendasLojas();
            } else {
                listaVendas = VendaDAO.getVendas();
            }
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaVendas", listaVendas);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/listaVendas.jsp");
        requestDispatcher.forward(request, response);
    }
}
