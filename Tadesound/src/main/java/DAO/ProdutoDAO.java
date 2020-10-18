/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import BD.ConexaoBD;
import Model.Produto;
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
public class ProdutoDAO {
    
    
    public static List<Produto> getProdutos() {
        
        List<Produto> listaProdutos = new ArrayList();
        
        try {
            Connection con = ConexaoBD.getConexao();
            String query = "Select * from produto";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
//              int idProduto = rs.getInt("idProduto");
                String nome = rs.getString("nome");
                String descricao = rs.getString("descricao");
                double preco = rs.getDouble("preco");
                String categoria = rs.getString("categoria");
                int quantidade = rs.getInt("quantidadeEstoque");
//                int idFornecedor = rs.getInt("idFornecedor");
//                int idLoja = rs.getInt("idLoja");
                String dataCadastro = rs.getString("dataCadastro");
                String ultimaAtualizacao = rs.getString("ultimaAtualizacao");
                
                listaProdutos.add(new Produto(quantidade, nome, descricao, preco, categoria, quantidade));
            }
        } catch (SQLException ex) {
            System.out.println("Nao foi possivel estabelecer uma conexao com o banco de dados.");            
        }
        
        return listaProdutos;
    }
    
    public static void addProdutos (Produto produto) throws SQLException {
        Connection con = ConexaoBD.getConexao();
        
        String query =  "INSERT INTO produto (nome, descricao, preco, categoria, quantidadeEstoque) VALUES (?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, produto.getNomeProduto());
        ps.setString(2, produto.getDescricaoProduto());
        ps.setDouble(3, produto.getPrecoProduto());
        ps.setString(4, produto.getCategoriaProduto());
        ps.setInt(5, produto.getQuantidadeProduto());
        
        /*
        Conversar com o time para saber se esses dados vem
        ps.setString(6, produto.getDataCadastro());
        ps.setString(7, produto.getUltimaAtualizacao());
        */
    
        ps.execute();
        
    }
}
