package DAO;

import BD.ConexaoBD;
import Model.Produto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProdutoDAO {
    
    public static List<Produto> getProdutos() throws SQLException {
        List<Produto> listaProdutos = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM produto";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            int idProduto = rs.getInt("idProduto");
            String nome = rs.getString("nome");
            String descricao = rs.getString("descricao");
            String preco = rs.getString("preco");
            String categoria = rs.getString("categoria");
            int quantidadeEstoque = rs.getInt("quantidadeEstoque");
            int idFornecedor = rs.getInt("idFornecedor");
            int idLoja = rs.getInt("idLoja");
            String dataCadastro = rs.getString("dataCadastro");
            listaProdutos.add(new Produto(idProduto, nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja, dataCadastro));
        }
        
        return listaProdutos;
    }
    
    public static Produto getProduto(int idProduto) throws SQLException {   
        Produto produto = null;
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM produto WHERE idProduto = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, idProduto);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String nome = rs.getString("nome");
            String descricao = rs.getString("descricao");
            String preco = rs.getString("preco");
            String categoria = rs.getString("categoria");
            int quantidadeEstoque = rs.getInt("quantidadeEstoque");
            int idFornecedor = rs.getInt("idFornecedor");
            int idLoja = rs.getInt("idLoja");
            produto = new Produto(idProduto, nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja);
        }
        
        return produto;
    }
    
    public static void addProduto(Produto produto) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "INSERT INTO produto (nome, descricao, preco, categoria, quantidadeEstoque, idFornecedor, idLoja) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, produto.getNome());
        ps.setString(2, produto.getDescricao());
        ps.setString(3, produto.getPreco());
        ps.setString(4, produto.getCategoria());
        ps.setInt(5, produto.getQuantidadeEstoque());
        ps.setInt(6, produto.getIdFornecedor());
        ps.setInt(7, produto.getIdLoja());
        
        ps.execute();
    }
    
    public static void updateProduto(Produto produto) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "UPDATE produto SET nome=?, descricao=?, preco=?, categoria=?, quantidadeEstoque=?, idFornecedor=?, idLoja=? WHERE idProduto=?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, produto.getNome());
        ps.setString(2, produto.getDescricao());
        ps.setString(3, produto.getPreco());
        ps.setString(4, produto.getCategoria());
        ps.setInt(5, produto.getQuantidadeEstoque());
        ps.setInt(6, produto.getIdFornecedor());
        ps.setInt(7, produto.getIdLoja());
        ps.setInt(8, produto.getIdProduto());
        
        ps.execute();
    }
}
