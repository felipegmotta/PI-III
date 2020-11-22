package DAO;

import BD.ConexaoBD;
import Model.Fornecedor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FornecedorDAO {
    
    public static List<Fornecedor> getFornecedores() throws SQLException {
        List<Fornecedor> listaFornecedores = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        
        String query = "SELECT * FROM fornecedor";
        PreparedStatement ps = con.prepareStatement(query);
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            int idFornecedor = rs.getInt("idFornecedor");
            String nome = rs.getString("nome");
            String cpf = rs.getString("cpf");
            String cnpj = rs.getString("cnpj");
            String CPFOuCNPJ = "";
            String telefone = rs.getString("telefone");
            String email = rs.getString("email");
            String endereco = rs.getString("endereco");
            int numero = Integer.parseInt(rs.getString("numero"));
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String uf = rs.getString("uf");
            String cep = rs.getString("cep");
            String dataCadastro = rs.getString("dataCadastro");
            
            if (cpf != null) {
                CPFOuCNPJ = cpf;
            } else {
                CPFOuCNPJ = cnpj;
            }
            
            listaFornecedores.add(new Fornecedor(idFornecedor, nome, CPFOuCNPJ, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep, dataCadastro));
        }
        
        return listaFornecedores;
    }
    
    public static Fornecedor getFornecedor(int idFornecedor) throws SQLException {   
        Fornecedor fornecedor = null;
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM fornecedor WHERE idFornecedor = ?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setInt(1, idFornecedor);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            String nome = rs.getString("nome");
            String cpf = rs.getString("cpf");
            String cnpj = rs.getString("cnpj");
            String CPFOuCNPJ = "";
            String telefone = rs.getString("telefone");
            String email = rs.getString("email");
            String endereco = rs.getString("endereco");
            int numero = Integer.parseInt(rs.getString("numero"));
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String uf = rs.getString("uf");
            String cep = rs.getString("cep");
            String dataCadastro = rs.getString("dataCadastro");
            
            if (cpf != null) {
                CPFOuCNPJ = cpf;
            } else {
                CPFOuCNPJ = cnpj;
            }
            
            fornecedor = new Fornecedor(idFornecedor, nome, CPFOuCNPJ, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep, dataCadastro);
        }

        return fornecedor;
    }
    
    public static void addFornecedor(Fornecedor fornecedor) throws SQLException {
        Connection con = ConexaoBD.getConexao();
        PreparedStatement ps = null;
        
        if (fornecedor.getCpf().equals("")) {
            String query = "INSERT INTO fornecedor (nome, cnpj, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(2, fornecedor.getCnpj());
        } else {
            String query = "INSERT INTO fornecedor (nome, cpf, telefone, email, endereco, numero, complemento, bairro, cidade, uf, cep) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
            ps = con.prepareStatement(query);
            ps.setString(2, fornecedor.getCpf());
        }

        ps.setString(1, fornecedor.getNome());
        ps.setString(3, fornecedor.getTelefone());
        ps.setString(4, fornecedor.getEmail());
        ps.setString(5, fornecedor.getEndereco());
        ps.setInt(6, fornecedor.getNumero());
        ps.setString(7, fornecedor.getComplemento());
        ps.setString(8, fornecedor.getBairro());
        ps.setString(9, fornecedor.getCidade());
        ps.setString(10, fornecedor.getUf());
        ps.setString(11, fornecedor.getCep());
        
        ps.execute();
    }
    
    public static void updateFornecedor(Fornecedor fornecedor) throws SQLException {
        Connection con = ConexaoBD.getConexao();
        PreparedStatement ps = null;
        
        if (fornecedor.getCpf() != null) {
            String query = "UPDATE fornecedor set nome=?, cpf=?, telefone=?, email=?, endereco=?, numero=?, complemento=?, bairro=?, cidade=?, uf=?, cep=? WHERE idFornecedor=?";
            ps = con.prepareStatement(query);
            ps.setString(2, fornecedor.getCpf());
        } else {
            String query = "UPDATE fornecedor set nome=?, cnpj=?, telefone=?, email=?, endereco=?, numero=?, complemento=?, bairro=?, cidade=?, uf=?, cep=? WHERE idFornecedor=?";
            ps = con.prepareStatement(query);
            ps.setString(2, fornecedor.getCnpj());
        }
                
        ps.setString(1, fornecedor.getNome());
        ps.setString(3, fornecedor.getTelefone());
        ps.setString(4, fornecedor.getEmail());
        ps.setString(5, fornecedor.getEndereco());
        ps.setInt(6, fornecedor.getNumero());
        ps.setString(7, fornecedor.getComplemento());
        ps.setString(8, fornecedor.getBairro());
        ps.setString(9, fornecedor.getCidade());
        ps.setString(10, fornecedor.getUf());
        ps.setString(11, fornecedor.getCep());
        ps.setInt(12, fornecedor.getIdFornecedor());
        
        ps.execute();
    }
    
    public static void deleteFornecedor(int idFornecedor) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "DELETE FROM fornecedor WHERE idFornecedor=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setInt(1, idFornecedor);
        
        ps.execute();
    }
}
