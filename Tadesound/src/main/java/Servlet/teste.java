package Servlet;

import BD.ConexaoBDAWS;
import java.sql.Connection;
import java.sql.SQLException;

public class teste {
    public static void main(String[] args) throws SQLException {
        Connection con = ConexaoBDAWS.getConexao();
    }
    
}
