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
            int idLoja = rs.getInt("idLoja");
            String nome = rs.getString("nome");
            String telefone = rs.getString("telefone");
            String endereco = rs.getString("endereco");
            int numero = rs.getInt("numero");
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String uf = rs.getString("uf");
            String cep = rs.getString("cep");
            String dataCadastro = rs.getString("dataCadastro");
            
            listaLojas.add(new Loja(idLoja, nome, endereco, numero, bairro, complemento, cidade, uf, cep, telefone, dataCadastro));
        }
        return listaLojas;
    }
    
    public static Loja getLoja (int idLoja) throws SQLException {
        Loja loja = null;
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM loja WHERE idLoja = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, idLoja);
        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            String nome = rs.getString("nome");
            String telefone = rs.getString("telefone");
            String endereco = rs.getString("endereco");
            int numero = rs.getInt("numero");
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String uf = rs.getString("uf");
            String cep = rs.getString("cep");
            String dataCadastro = rs.getString("dataCadastro");
            
            loja = new Loja(nome, endereco, numero, bairro, complemento, cidade, uf, cep, telefone, dataCadastro);            
        }
        return loja;        
    }

    public static void addLoja(Loja loja) throws SQLException {
        Connection con = ConexaoBD.getConexao();
        
        String query = "INSERT INTO loja (nome, telefone, numero, complemento, bairro, cidade, uf, cep, dataCadastro) VALUES (?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement (query);
        
        ps.setString(1, loja.getNomeLoja());
        ps.setString(2, loja.getTelefone());
        ps.setString(3, loja.getEndereco());
        ps.setInt(4, loja.getNumeroLoja());
        ps.setString(5, loja.getComplemento());
        ps.setString(6, loja.getBairro());
        ps.setString(7, loja.getCidade());
        ps.setString(8, loja.getUf());
        ps.setString(9, loja.getCep());
        ps.setString(10, loja.getDataCadastro());
        
        ps.execute();        
    }
    
    public static void updateLoja (Loja loja) throws SQLException {
        Connection con = ConexaoBD.getConexao();
        
        String query = "UPDATE loja SET nome=?, telefone=?, endereco=?, numero=?, complemento=?, bairro =?, cidade=?, uf=?, cep=?, dataCadastro=? WHERE idLoja=?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, loja.getNomeLoja());
        ps.setString(2, loja.getTelefone());
        ps.setString(3, loja.getEndereco());
        ps.setInt(4, loja.getNumeroLoja());
        ps.setString(5, loja.getComplemento());
        ps.setString(6, loja.getBairro());
        ps.setString(7, loja.getCidade());
        ps.setString(8, loja.getUf());
        ps.setString(9, loja.getCep());
        ps.setString(10, loja.getDataCadastro());
        
        ps.execute();  
    }
    
    public static void deleteLoja (Loja loja) throws SQLException {
        Connection con = ConexaoBD.getConexao();
        
        String query = "DELETE FROM loja WHERE nome=?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, loja.getNomeLoja());
        
        ps.execute();  
    }
}