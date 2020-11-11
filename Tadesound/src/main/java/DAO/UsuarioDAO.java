package DAO;

import BD.ConexaoBD;
import Model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    
    public static Usuario getUsuario(String login) throws SQLException {   
        Usuario usuario = null;
        
        Connection con = ConexaoBD.getConexao();
        String query = "SELECT usuario.idUsuario, usuario.senha, funcionario.idFuncionario, funcionario.nome, funcionario.cargo, usuario.dataCadastro FROM usuario INNER JOIN funcionario ON usuario.idFuncionario = funcionario.idFuncionario WHERE login = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, login);
        
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int idUsuario = rs.getInt("usuario.idUsuario");
            String senha = rs.getString("usuario.senha");
            String nome = rs.getString("funcionario.nome");
            String cargo = rs.getString("funcionario.cargo");
            int idFuncionario = rs.getInt("funcionario.idFuncionario");
            String dataCadastro = rs.getString("usuario.dataCadastro");
            usuario = new Usuario(idUsuario, nome, login, senha, cargo, idFuncionario, dataCadastro);
        }
        
        return usuario;
    }
}
