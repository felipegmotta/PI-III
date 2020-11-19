package DAO;

import BD.ConexaoBD;
import Model.Cliente;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {
    
    public static List<Cliente> getClientes() throws SQLException {
        List<Cliente> listaClientes = new ArrayList();
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM cliente";
        PreparedStatement ps = con.prepareStatement(query);
        ResultSet rs = ps.executeQuery();
//        System.out.println("dentro get");
        while (rs.next()) {
            int idCliente = rs.getInt("idCliente");
            String nome = rs.getString("nome");
            String email = rs.getString("email");
            String cpf = rs.getString("cpf");
            String dataNascimento = rs.getString("dataNascimento");
            String telefone = rs.getString("telefone");
            String endereco = rs.getString("endereco");
            int numero = rs.getInt("numero");
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String uf = rs.getString("uf");
            String cep = rs.getString("cep");
            String dataCadastro = rs.getString("dataCadastro");

            listaClientes.add(new Cliente(idCliente, nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep, dataCadastro));
        }
        
        return listaClientes;
    }
    
    public static Cliente getCliente(String cpfCliente) throws SQLException {   
        Cliente cliente = null;
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT * FROM cliente WHERE cpf = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, cpfCliente);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int idCliente = rs.getInt("idCliente");
            String nome = rs.getString("nome");
            String email = rs.getString("email");
            String cpf = rs.getString("cpf");
            String dataNascimento = rs.getString("dataNascimento");
            String telefone = rs.getString("telefone");
            String endereco = rs.getString("endereco");
            int numero = rs.getInt("numero");
            String complemento = rs.getString("complemento");
            String bairro = rs.getString("bairro");
            String cidade = rs.getString("cidade");
            String uf = rs.getString("uf");
            String cep = rs.getString("cep");
            cliente = new Cliente(idCliente, nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep);
        }
        
        return cliente;
    }
    
    public static void addCliente(Cliente cliente) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "INSERT INTO cliente (nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, cliente.getNome());
        ps.setString(2, cliente.getEmail());
        ps.setString(3, cliente.getCpf());
        ps.setString(4, cliente.getDataNascimento());
        ps.setString(5, cliente.getTelefone());
        ps.setString(6, cliente.getEndereco());
        ps.setInt(7, cliente.getNumero());
        ps.setString(8, cliente.getComplemento());
        ps.setString(9, cliente.getBairro());
        ps.setString(10, cliente.getCidade());
        ps.setString(11, cliente.getUf());
        ps.setString(12, cliente.getCep());
        
        ps.execute();
    }
    
    public static void updateCliente(Cliente cliente) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "UPDATE cliente SET nome=?, email=?, cpf=?, dataNascimento=?, telefone=?, endereco=?, numero=?, complemento=?, bairro=?, cidade=?, uf=?, cep=? WHERE idCliente=?";
        PreparedStatement ps = con.prepareStatement(query);
        
        ps.setString(1, cliente.getNome());
        ps.setString(2, cliente.getEmail());
        ps.setString(3, cliente.getCpf());
        ps.setString(4, cliente.getDataNascimento());
        ps.setString(5, cliente.getTelefone());
        ps.setString(6, cliente.getEndereco());
        ps.setInt(7, cliente.getNumero());
        ps.setString(8, cliente.getComplemento());
        ps.setString(9, cliente.getBairro());
        ps.setString(10, cliente.getCidade());
        ps.setString(11, cliente.getUf());
        ps.setString(12, cliente.getCep());
        ps.setInt(13, cliente.getIdCliente());
        
        ps.execute();
    }
    
    public static void deleteCliente(String cpfCliente) throws SQLException {
        Connection con = ConexaoBD.getConexao();
       
        String query = "DELETE FROM cliente WHERE cpf=?";
        PreparedStatement ps = con.prepareStatement(query);

        ps.setString(1, cpfCliente);
        
        ps.execute();
    }
}
