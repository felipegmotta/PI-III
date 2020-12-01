package Servlet;

import Model.SessaoVendaServicosModel;
import java.util.List;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessaoVendaServicos extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessao = request.getSession();
        
        String limparSessao = request.getParameter("limparSessao");
        
        //Caso tenha que limpar a sessao
        if (limparSessao != null) {
            sessao.setAttribute("listaServicos", null);
            return;
        }
        
        int idServico = Integer.parseInt(request.getParameter("idServico"));
        String nomeServico = request.getParameter("nomeServico");
        int grauComplexidade = Integer.parseInt(request.getParameter("grauComplexidade"));
        int duracaoMinutos = Integer.parseInt(request.getParameter("duracaoMinutos"));
        
        SessaoVendaServicosModel sessaoServicos = new SessaoVendaServicosModel(idServico, nomeServico, grauComplexidade, duracaoMinutos);
        
        List<SessaoVendaServicosModel> listaServicos = null;
        if (sessao.getAttribute("listaServicos") == null) {
            listaServicos = new ArrayList<>();
        } else {
            listaServicos = (List<SessaoVendaServicosModel>) sessao.getAttribute("listaServicos");
        }
        
        listaServicos.add(sessaoServicos);
        
        sessao.setAttribute("listaServicos", listaServicos);
    }
}
