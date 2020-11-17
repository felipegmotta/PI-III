package Servlet;

import Model.Loja;
import Utils.Utils;
import DAO.LojaDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;

public class AtualizarLoja extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        
        Loja loja = null;
        
        try {
            loja = LojaDAO.getLoja(idLoja);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        request.setAttribute("loja", loja);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/protected/gerencia/atualizarLoja.jsp");
        requestDispatcher.forward(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        String nome = request.getParameter("nome");
        String telefone = request.getParameter("telefone");
        String endereco = request.getParameter("endereco");
        int numero = Integer.parseInt(request.getParameter("numero"));
        String complemento = request.getParameter("complemento");
        String bairro = request.getParameter("bairro");
        String cidade = request.getParameter("cidade");
        String uf = request.getParameter("uf");
        String cep = request.getParameter("cep");
        
        //Cria uma nova loja com os dados atualizados
        Loja loja = new Loja(idLoja, nome, endereco, numero, bairro, complemento, cidade, uf, cep, telefone);
                
        try {
            //Atualiza os dados da loja no BD
            LojaDAO.updateLoja(loja);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
    }
}

