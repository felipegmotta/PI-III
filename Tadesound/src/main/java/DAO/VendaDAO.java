package DAO;

import Model.Venda;
import BD.ConexaoBD;
import java.util.List;
import Model.ItensVenda;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Connection;
import Model.VendaProdutos;
import Model.VendaClientes;
import Model.VendaLojas;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class VendaDAO {      
    
    public static List<VendaClientes> getVendasClientes(String idConsulta, String nomeConsulta) throws SQLException {
        List<VendaClientes> listaVendasClientes = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT cliente.idCliente, cliente.nome, loja.idLoja, loja.nome, venda.idVenda, venda.valorTotal, venda.dataVenda FROM venda INNER JOIN cliente ON venda.idCliente = cliente.idCliente INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario INNER JOIN loja ON funcionario.idLoja = loja.idLoja";
        
        PreparedStatement ps = null;
        
        //Caso tenha que consultar por id
        if (!idConsulta.equals("")) {
            query += " WHERE cliente.idCliente = ?";
            
            ps = con.prepareStatement(query);
            ps.setString(1, idConsulta);
        } else if (!nomeConsulta.equals("")) {
            query += " WHERE cliente.nome like ?";
            
            ps = con.prepareStatement(query);
            ps.setString(1, nomeConsulta + "%");
        } else {
            ps = con.prepareStatement(query);
        }
        
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            int idCliente = rs.getInt("cliente.idCliente");
            String nomeCliente = rs.getString("cliente.nome");
            int idLoja = rs.getInt("loja.idLoja");
            String nomeLoja = rs.getString("loja.nome");
            int idVenda = rs.getInt("venda.idVenda");
            String valorTotal = rs.getString("venda.valorTotal");
            String dataVenda = rs.getString("venda.dataVenda");
            
            listaVendasClientes.add(new VendaClientes(idCliente, nomeCliente, idLoja, nomeLoja, idVenda, valorTotal, dataVenda));
        }
                
        return listaVendasClientes;
    }
    
    public static List<VendaProdutos> getVendasProdutos(String idConsulta, String nomeConsulta) throws SQLException {
        System.out.println("dentro de vendas produtos");
        List<VendaProdutos> listaVendasProdutos = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT produto.idProduto, produto.nome, produto.preco, itensVenda.quantidadeProduto, itensVenda.valorTotalProduto, funcionario.idLoja FROM venda INNER JOIN itensVenda ON venda.idVenda = itensVenda.idVenda INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario INNER JOIN produto ON itensVenda.idProduto = produto.idProduto";
        
        PreparedStatement ps = null;
        
        //Caso tenha que consultar por id
        if (!idConsulta.equals("")) {
            query += " WHERE produto.idProduto = ?";
            
            ps = con.prepareStatement(query);
            ps.setString(1, idConsulta);
        } else if (!nomeConsulta.equals("")) {
            query += " WHERE produto.nome like ?";
            
            ps = con.prepareStatement(query);
            ps.setString(1, nomeConsulta + "%");
        } else {
            ps = con.prepareStatement(query);
        }
        System.out.println(query);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            int idProduto = rs.getInt("produto.idProduto");
            String nomeProduto = rs.getString("produto.nome");
            String valorProduto = rs.getString("produto.preco");
            int quantidadeTotalProduto = rs.getInt("itensVenda.quantidadeProduto");
            String valorTotal = rs.getString("itensVenda.valorTotalProduto");
            int idLoja = rs.getInt("funcionario.idLoja");
            
            listaVendasProdutos.add(new VendaProdutos(idProduto, nomeProduto, valorProduto, quantidadeTotalProduto, valorTotal, idLoja));
        }
        
        return listaVendasProdutos;
    }
    
    public static List<VendaLojas> getVendasLojas(String idConsulta, String nomeConsulta) throws SQLException {
        List<VendaLojas> listaVendasLojas = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT loja.idLoja, loja.nome, SUM(venda.valorTotal) as valorTotal, CONCAT(ROUND(SUM(venda.valorTotal)*100/(SELECT SUM(valorTotal) FROM venda), 2), \"%\") AS valorTotalPorcentagem FROM venda INNER JOIN funcionario ON venda.idFuncionario = funcionario.idFuncionario INNER JOIN loja ON funcionario.idLoja = loja.idLoja";
        
        PreparedStatement ps = null;
        
        //Caso tenha que consultar por id
        if (!idConsulta.equals("")) {
            query += " WHERE loja.idLoja = ? GROUP BY loja.idLoja";
            
            ps = con.prepareStatement(query);
            ps.setString(1, idConsulta);
        } else if (!nomeConsulta.equals("")) {
            query += " WHERE loja.nome like ?";
            
            ps = con.prepareStatement(query);
            ps.setString(1, nomeConsulta + "%");
        } else {
            query += " GROUP BY loja.idLoja";
            ps = con.prepareStatement(query);
        }
        
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            int idLoja = rs.getInt("loja.idLoja");
            String nomeLoja = rs.getString("loja.nome");
            String valorTotal = rs.getString("valorTotal");
            String valorTotalPorcentagem = rs.getString("valorTotalPorcentagem");
            
            listaVendasLojas.add(new VendaLojas(idLoja, nomeLoja, valorTotal, valorTotalPorcentagem));
        }
                
        return listaVendasLojas;
    }
    
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
