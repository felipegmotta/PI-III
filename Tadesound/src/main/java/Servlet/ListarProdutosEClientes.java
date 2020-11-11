package Servlet;

import Utils.Utils;
import Model.Cliente;
import Model.Produto;
import java.util.List;
import DAO.ClienteDAO;
import DAO.ProdutoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarProdutosEClientes extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cliente> listaClientes = null;
        List<Produto> listaProdutos = null;
        
        try {
            listaClientes = ClienteDAO.getClientes();
            listaProdutos = ProdutoDAO.getProdutos();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaClientes", listaClientes);
        request.setAttribute("listaProdutos", listaProdutos);
        
        System.out.println(request.getContextPath() + "/protected/realizaVenda.jsp");
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/realizaVenda.jsp");
        requestDispatcher.forward(request, response);
    }
}
