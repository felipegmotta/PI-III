package DAO;

import Model.Venda;
import BD.ConexaoBD;
import Model.ItensVenda;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class VendaDAO {      
    
    public static int addVenda(Venda venda) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "INSERT INTO venda (tipo, valorTotal, quantidadeProdutos, idCliente, idFuncionario) VALUES (?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        
        ps.setString(1, venda.getTipo());
        ps.setString(2, venda.getValorTotal());
        ps.setInt(3, venda.getQuantidadeProdutos());
        ps.setInt(4, venda.getIdCliente());
        ps.setInt(5, venda.getIdFuncionario());
        
        ps.execute();
        
        int idVenda = 0;
        ResultSet generatedKeys = ps.getGeneratedKeys(); //Recupera o idVenda
        if (generatedKeys.next()) {
            idVenda = generatedKeys.getInt(1);
        } else {
            throw new SQLException("Falha ao obter o idVenda!");
        }
        
        return idVenda;
    }
    
    public static void addItensVenda(ItensVenda itensVenda) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "INSERT INTO itensVenda (idVenda, idProduto, quantidadeProduto, valorTotalProduto) VALUES (?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
        
        ps.setInt(1, itensVenda.getIdVenda());
        ps.setInt(2, itensVenda.getIdProduto());
        ps.setInt(3, itensVenda.getQuantidadeProduto());
        ps.setString(4, itensVenda.getValorTotalProduto());
        
        ps.execute();
        
        int idVenda = 0;
        ResultSet generatedKeys = ps.getGeneratedKeys(); //Recupera o idVenda
        if (generatedKeys.next()) {
            idVenda = generatedKeys.getInt(1);
        } else {
            throw new SQLException("Falha ao obter o idVenda!");
        }
    }
}