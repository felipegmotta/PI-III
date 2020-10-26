/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlet;

import Utils.Utils;
import DAO.LojaDAO;
import Model.Loja;
import java.io.IOException;
import java.sql.SQLException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Edu Franco
 */
@WebServlet(name = "AtualizarLoja", urlPatterns = {"/AtualizarLoja"})
public class AtualizarLoja extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idLoja = Integer.parseInt(request.getParameter("idLoja"));
        System.out.println("to no get " + idLoja);
        
        Loja loja = null;
        
        try {
            loja = LojaDAO.getLoja(idLoja);
        } catch (SQLException ex) {
            Utils.exibeTelaErro(ex, request, response);
        }
        
        System.out.println(loja.getNomeLoja());
        
        request.setAttribute("loja", loja);
        RequestDispatcher requestDispatcher = getServletContext()
                .getRequestDispatcher("/atualizarLoja.jsp");
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
//        String ultimaAtualizacao = request.getParameter("ultimaAtualizacao");
        
        System.out.println(nome);
        System.out.println(telefone);
        System.out.println(endereco);
        System.out.println(numero);
        System.out.println(complemento);
        System.out.println(bairro);
        System.out.println(cidade);
        System.out.println(uf);
        System.out.println(cep);
//        System.out.println(ultimaAtualizacao);
        
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

