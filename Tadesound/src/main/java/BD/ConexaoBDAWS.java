package BD;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ConexaoBDAWS {
    
    static {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConexaoBDAWS.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public static Connection getConexao() throws SQLException {
        String url = "jdbc:mysql://mysqlserver.cddpwyxvael3.us-east-1.rds.amazonaws.com:3306/dbtadesound?autoReconnect=true&useSSL=false";
        
        String user = "admin";
        String password = "adminadmin";
        
        return DriverManager.getConnection(url, user, password);
    }
}
