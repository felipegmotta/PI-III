package Servlet;

import Utils.Utils;
import Model.Produto;
import java.util.List;
import DAO.ProdutoDAO;
import Model.Fornecedor;
import DAO.FornecedorDAO;
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
        List<Fornecedor> listaFornecedores = null;
        
        try {
            listaProdutos = ProdutoDAO.getProdutos();
            listaFornecedores = FornecedorDAO.getFornecedores();
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaProdutos", listaProdutos);
        request.setAttribute("listaFornecedores", listaFornecedores);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/backoffice/listaProdutos.jsp");
        requestDispatcher.forward(request, response);
    }
}
