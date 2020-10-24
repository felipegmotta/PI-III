/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import BD.ConexaoBD;
import Model.Loja;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Edu Franco
 */
public class LojaDAO {
    
    public static List<Loja> getLoja() throws SQLException {
        List<Loja> listaLojas = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM loja";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            String nome = rs.getString("nome");
            String telefone = rs.getString("telefone");
            String endereco = rs.getString("endereco");
            int numero = rs.getInt("numero");
            
        }
        
//        while (rs.next()) {
//            String nome = rs.getString("nome");
//            String email = rs.getString("email");
//            String cpf = rs.getString("cpf");
//            String dataNascimento = rs.getString("dataNascimento");
//            String telefone = rs.getString("telefone");
//            String endereco = rs.getString("endereco");
//            int numero = rs.getInt("numero");

//            listaClientes.add(new Cliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep, dataCadastro));
//        }
//        
//        return listaClientes;
    }
    
}
