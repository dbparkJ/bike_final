package db;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import db.DBConnection;
 
public class OracleTest 
{
    public static void main(String args[]) throws ClassNotFoundException
    {
        Connection conn = null; // DB연결된 상태(세션)을 담은 객체
        PreparedStatement pstm = null;  // SQL 문을 나타내는 객체
        ResultSet rs = null;  // 쿼리문을 날린것에 대한 반환값을 담을 객체
        
        try {
            // SQL 문장을 만들고 만약 문장이 질의어(SELECT문)라면
            // 그 결과를 담을 ResulSet 객체를 준비한 후 실행시킨다.
            String quary = "SELECT * FROM corse where name = '가오리코스' order by id";
            
            conn = DBConnection.getInstance().getConnection();
            pstm = conn.prepareStatement(quary);
            rs = pstm.executeQuery();
            
            System.out.println("ID	CORSE	위도	경도	고도");
            System.out.println("============================================");
            
            while(rs.next()){
            	Integer id = rs.getInt(1);
                String corse = rs.getString(2);
                float lon = rs.getFloat(3);
                float lat = rs.getFloat(4);
                float elev = rs.getFloat(5);
                
                
                String result = id+" "+corse+" "+lon+" "+lat+" "+elev;
                System.out.println(result);
            }
            
        } catch (SQLException sqle) {
            System.out.println("SELECT문에서 예외 발생");
            sqle.printStackTrace();
            
        }finally{
            // DB 연결을 종료한다.
            try{
                if ( rs != null ){rs.close();}   
                if ( pstm != null ){pstm.close();}   
                if ( conn != null ){conn.close(); }
            }catch(Exception e){
                throw new RuntimeException(e.getMessage());
            }
            
        }
    }
}