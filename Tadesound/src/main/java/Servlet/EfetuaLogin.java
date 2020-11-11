package Servlet;

import Model.Usuario;
import DAO.UsuarioDAO;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EfetuaLogin extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String login = request.getParameter("login");
        String senha = request.getParameter("senha");
        
        try {
            Usuario usuario = UsuarioDAO.getUsuario(login);
            if (usuario != null && usuario.validarSenha(senha)) {
                HttpSession sessao = request.getSession();
                sessao.setAttribute("usuario", usuario);
                response.sendRedirect("protected/index.jsp");
            } else {
                response.sendRedirect("telaLogin.jsp?erro=userNotFound");
            }
        } catch (SQLException ex ) {
            String msgErro = ex.getMessage();
            request.setAttribute("msgErro", msgErro);

            RequestDispatcher requestDispatcher = request
                    .getServletContext().getRequestDispatcher("/erro.jsp");
            requestDispatcher.forward(request, response);
        }
    }
}
