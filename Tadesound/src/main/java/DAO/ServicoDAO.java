package DAO;

import BD.ConexaoBD;
import Model.Servico;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ServicoDAO {
    
    public static List<Servico> getServicos() throws SQLException {
        List<Servico> listaServicos = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM servico";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
        
        while (rs.next()) {
            int idServico = rs.getInt("idServico");
            String nome = rs.getString("nome");
            String preco = rs.getString("preco");
            String grauComplexidade = rs.getString("grauComplexidade");
            int duracaoMinutos = rs.getInt("duracaoMinutos");
            int idLoja = rs.getInt("idLoja");
            String dataCadastro = rs.getString("dataCadastro");
            listaServicos.add(new Servico(idServico, nome, preco, grauComplexidade, duracaoMinutos, idLoja, dataCadastro));
        }
        
        return listaServicos;
    }
    
    public static Servico getProduto(int idServico) throws SQLException {   
        Servico servico = null;
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM produto WHERE idProduto = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setInt(1, idServico);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String nome = rs.getString("nome");
            String preco = rs.getString("preco");
            String grauComplexidade = rs.getString("grauComplexidade");
            int duracaoMinutos = rs.getInt("duracaoMinutos");
            int idLoja = rs.getInt("idLoja");
            String dataCadastro = rs.getString("dataCadastro");
            servico = new Servico(idServico, nome, preco, grauComplexidade, duracaoMinutos, idLoja, dataCadastro);
        }
        
        return servico;
    }
    
    public static void addServico(Servico servico) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "INSERT INTO servico (nome, preco, grauComplexidade, duracaoMinutos, idLoja) VALUES (?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, servico.getNome());
        ps.setString(2, servico.getPreco());
        ps.setString(3, servico.getGrauComplexidade());
        ps.setInt(4, servico.getDuracaoMinutos());
        ps.setInt(5, servico.getIdLoja());
        
        ps.execute();
    }
    
    public static void updateProduto(Servico servico) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "UPDATE servico SET nome=?, preco=?, grauComplexidade=?, duracaoMinutos=?, idLoja=? WHERE idProduto=?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, servico.getNome());
        ps.setString(2, servico.getPreco());
        ps.setString(3, servico.getGrauComplexidade());
        ps.setInt(4, servico.getDuracaoMinutos());
        ps.setInt(5, servico.getIdLoja());
        
        ps.execute();
    }
    
    public static void deleteServico(int idServico) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "DELETE FROM servico WHERE idServico=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setInt(1, idServico);
        
        ps.execute();
    }
}
