package Servlet;

import Utils.Utils;
import Model.Cliente;
import Model.Produto;
import Model.Usuario;
import java.util.List;
import DAO.ClienteDAO;
import DAO.ProdutoDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListarProdutosEClientes extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cliente> listaClientes = null;
        List<Produto> listaProdutos = null;
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        
        //Captura as informacoes dessa sessao
        HttpSession sessao = httpRequest.getSession();
        
        //Captura o usuario logado nessa sessao
        Usuario usuario = (Usuario) sessao.getAttribute("usuario");
        
        try {
            listaClientes = ClienteDAO.getClientes();
            listaProdutos = ProdutoDAO.getProdutos(usuario.getIdLoja());
        } catch (Exception ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
    
        request.setAttribute("listaClientes", listaClientes);
        request.setAttribute("listaProdutos", listaProdutos);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/vendas/realizaVenda.jsp");
        requestDispatcher.forward(request, response);
    }
}
