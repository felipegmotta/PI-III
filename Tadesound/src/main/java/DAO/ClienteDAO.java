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
    
    public static List<Cliente> getClientes() {
        List<Cliente> listaClientes = new ArrayList();
        
        try {
            System.out.println("GETTING CLIENTES");
            Connection con = ConexaoBD.getConexao();
            String query = "Select * from cliente";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
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
                listaClientes.add(new Cliente(nome, email, cpf, dataNascimento, telefone, endereco, numero, complemento, bairro, cidade, uf, cep, dataCadastro));
            }
        } catch (SQLException ex) {
            System.out.println("Nao foi possivel estabelecer uma conexao com o banco de dados.");
        }
        
        return listaClientes;
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
    
}
