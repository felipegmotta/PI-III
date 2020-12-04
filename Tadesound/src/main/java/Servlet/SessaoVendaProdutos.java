package Servlet;

import Model.SessaoVendaProdutosModel;
import java.util.List;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SessaoVendaProdutos extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sessao = request.getSession();
        
        String limparSessao = request.getParameter("limparSessao");
        
        //Caso tenha que limpar a sessao
        if (limparSessao != null) {
            sessao.setAttribute("listaProdutosSessao", null);
            return;
        }
        
        int idProduto = Integer.parseInt(request.getParameter("idProduto"));
        String nomeProduto = request.getParameter("nomeProduto");
        String categoriaProduto = request.getParameter("categoriaProduto");
        int quantidadeProduto = Integer.parseInt(request.getParameter("quantidadeProduto"));
        String precoProdutoFormatado = request.getParameter("precoProdutoFormatado");
        String precoTotal = request.getParameter("precoTotal");
        
        SessaoVendaProdutosModel sessaoProdutos = new SessaoVendaProdutosModel(idProduto, nomeProduto, categoriaProduto, quantidadeProduto, precoProdutoFormatado, precoTotal);
        
        List<SessaoVendaProdutosModel> listaProdutosSessao = null;
        if (sessao.getAttribute("listaProdutosSessao") == null) {
            listaProdutosSessao = new ArrayList<>();
        } else {
            listaProdutosSessao = (List<SessaoVendaProdutosModel>) sessao.getAttribute("listaProdutosSessao");
        }
        
        listaProdutosSessao.add(sessaoProdutos);
        
        sessao.setAttribute("listaProdutosSessao", listaProdutosSessao);
    }
}
