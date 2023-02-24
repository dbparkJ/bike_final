package db;
 
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.SQLException;
 
public class DBConnection{
	private static DBConnection orclDbc;
	private DBConnection() {}
    
    public static DBConnection getInstance(){
    	if(orclDbc==null) {
    		orclDbc = new DBConnection();
    	}
    	return orclDbc;
    }
        
    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection con = null;
        try {
        	Class.forName("oracle.jdbc.driver.OracleDriver");        
//        	String user = "지정한 userid"; 
//        	String pw = "db password";
//        	String url = "jdbc:oracle:thin:@db이름?TNS_USER name = 지갑 경로";
//        	
            String user = "admin"; 
            String pw = "Ejwhgdmsvmfhwprxm1";
            String url = "jdbc:oracle:thin:@FinalProject_medium?TNS_ADMIN=D:/Wallet_FinalProject";
            
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