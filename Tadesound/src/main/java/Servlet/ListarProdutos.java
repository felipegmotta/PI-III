package Servlet;

import Utils.Utils;
import Model.Produto;
import java.util.List;
import DAO.ProdutoDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ListarProdutos extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Produto> listaProdutos = null;
        
        try {
            System.out.println("manda la porra");
            listaProdutos = ProdutoDAO.getProdutos();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaProdutos", listaProdutos);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/listaProdutos.jsp");
        requestDispatcher.forward(request, response);
    }
}
