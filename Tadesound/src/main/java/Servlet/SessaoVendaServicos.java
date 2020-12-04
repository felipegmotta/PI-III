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
            sessao.setAttribute("listaServicosSessao", null);
            return;
        }
        
        int idServico = Integer.parseInt(request.getParameter("idServico"));
        String nomeServico = request.getParameter("nomeServico");
        int duracaoMinutos = Integer.parseInt(request.getParameter("duracaoMinutos"));
        int grauComplexidade = Integer.parseInt(request.getParameter("grauComplexidade"));
        String valorTotal = request.getParameter("valorTotal");
        String dataProgramada = request.getParameter("dataProgramada");
        
        SessaoVendaServicosModel sessaoServicos = new SessaoVendaServicosModel(idServico, nomeServico, duracaoMinutos, grauComplexidade, valorTotal, dataProgramada);
        
        List<SessaoVendaServicosModel> listaServicosSessao = null;
        if (sessao.getAttribute("listaServicosSessao") == null) {
            listaServicosSessao = new ArrayList<>();
        } else {
            listaServicosSessao = (List<SessaoVendaServicosModel>) sessao.getAttribute("listaServicosSessao");
        }
        
        listaServicosSessao.add(sessaoServicos);
        System.out.println("adicionei");
        sessao.setAttribute("listaServicosSessao", listaServicosSessao);
    }
}
