package Servlet;

import Utils.Utils;
import Model.Cliente;
import Model.Servico;
import Model.Usuario;
import java.util.List;
import DAO.ClienteDAO;
import DAO.ServicoDAO;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ListarServicosEClientes extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Cliente> listaClientes = null;
        List<Servico> listaServicos = null;
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        
        //Captura as informacoes dessa sessao
        HttpSession sessao = httpRequest.getSession();
        
        //Captura o usuario logado nessa sessao
        Usuario usuario = (Usuario) sessao.getAttribute("usuario");
        int idLoja = usuario.getIdLoja();
        
        try {
            listaClientes = ClienteDAO.getClientes();
            listaServicos = ServicoDAO.getServicos(idLoja);
        } catch (Exception ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("listaClientes", listaClientes);
        request.setAttribute("listaServicos", listaServicos);
        
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/vendas/realizaVendaServicos.jsp");
        requestDispatcher.forward(request, response);
    }
}
