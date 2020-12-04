package Utils;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Utils {
    public static void exibeTelaErro(Exception ex, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(ex.getMessage());
        
        String msgErro = ex.getMessage();
        request.setAttribute("msgErro", msgErro);
            
        RequestDispatcher requestDispatcher = request
            .getRequestDispatcher("/erro.jsp");
        requestDispatcher.forward(request, response);
    }
    
    public static void exibeTelaSucesso(HttpServletResponse response) throws IOException {
        response.sendRedirect("sucesso.jsp");
    }
}
