package BD;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConexaoBD {
    
    static{
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConexaoBD.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static Connection getConexao() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/tadesound_bd";
        String user = "root";
        String password = "";
        
        return DriverManager.getConnection(url, user, password);
    }
}
