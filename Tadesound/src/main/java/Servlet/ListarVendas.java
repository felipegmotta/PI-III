package Servlet;

import Utils.Utils;
import DAO.VendaDAO;
import java.util.List;
import java.io.IOException;
import Model.VendaProdutos;
import Model.VendaServicos;
import Model.VendaClientes;
import Model.VendaLojas;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarVendas extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tipoConsulta = request.getParameter("tipoConsulta");
        String idConsulta = request.getParameter("idConsulta");        
        String nomeConsulta = request.getParameter("nomeConsulta");        

        try {
            switch (tipoConsulta) {
                case "Produto":
                    List<VendaProdutos> listaVendasProdutos = VendaDAO.getVendasProdutos(idConsulta, nomeConsulta);
                    request.setAttribute("listaVendas", listaVendasProdutos);
                    break;
                case "Servico":
                    List<VendaServicos> listaVendasServicos = VendaDAO.getVendasServicos(idConsulta, nomeConsulta);
                    request.setAttribute("listaVendas", listaVendasServicos);
                    break;
                case "Cliente":
                    List<VendaClientes> listaVendasClientes = VendaDAO.getVendasClientes(idConsulta, nomeConsulta);
                    request.setAttribute("listaVendas", listaVendasClientes);
                    break;
                case "Loja":
                    List<VendaLojas> listaVendasLojas = VendaDAO.getVendasLojas(idConsulta, nomeConsulta);
                    request.setAttribute("listaVendas", listaVendasLojas);
                    break;
                default:
                    break;
            }
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/gerencia/listaVendas.jsp");
        requestDispatcher.forward(request, response);
    }
}
