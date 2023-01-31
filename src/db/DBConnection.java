package db;
 
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;
 
public class DBConnection{
	private static DBConnection orclDbc;
	private DBConnection() {}
    
    public static DBConnection getInstacne(){
    	if(orclDbc==null) {
    		orclDbc = new DBConnection();
    	}
    	return orclDbc;
    }
        
    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;
        try {
            String user = "bike"; 
            String pw = "12345";
            String url = "jdbc:oracle:thin:@192.168.0.78/xe";
            
            Class.forName("oracle.jdbc.driver.OracleDriver");        
            con = DriverManager.getConnection(url, user, pw);
            
            System.out.println("Database에 연결되었습니다.\n");
            
        } catch (ClassNotFoundException cnfe) {
            System.out.println("DB 드라이버 로딩 실패 :"+cnfe.toString());
        } catch (SQLException sqle) {
            System.out.println("DB 접속실패 : "+sqle.toString());
        } catch (Exception e) {
            System.out.println("Unkonwn error");
            e.printStackTrace();
        }
        return con;     
    }
        
}