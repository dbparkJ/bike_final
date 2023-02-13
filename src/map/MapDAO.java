/*
 * 코스 관련 로직
 */
package map;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import db.DBConnection;

public class MapDAO {
		
	private static MapDAO instance=new MapDAO();
		
		private MapDAO(){}
		
		public static MapDAO getDao(){
			return instance;
		}
		
		Connection con=null;
		Statement stmt=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		
		/*
		 * 코스의 관련된 로직처리
		 */
//----------------------------------------------------------------------------------------------------------------	
		/*
		 * 코스이름을 가져와서 list로 반환해주는 로직
		 */
		public List<CorseListDTO> getCorseList(){
			List<CorseListDTO> singleCorseList = null;
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select name from corse group by name");
				rs=pstmt.executeQuery();
				if(rs.next()){
					singleCorseList=new ArrayList<CorseListDTO>();
					do{	
						CorseListDTO dto=new CorseListDTO();
						dto.setName(rs.getString("name"));
						singleCorseList.add(dto); //***
					}while(rs.next());
				}//if-end
			}catch(Exception ex) {
				System.out.println("getCorseList()예외:"+ex);
			}finally{
				try{
					if(rs!=null){rs.close();}
					if(stmt!=null){stmt.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}//finally
			return singleCorseList;
		}//getCorseList-end
		
		/*
		 * 웹에서 선택한 코스 이름을 인자로 코스 1개를 가져온다
		 */
		public List<CorseListDTO> getCorseLatLon(String name){
			JSONArray array = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("SELECT * FROM corse where name=? order by id");
				pstmt.setString(1, name);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JSONObject obj = new JSONObject();	// {}, JSON 객체 생성
			    	obj.put("corse_name", rs.getString("name"));	// obj.put("key","value")
			        obj.put("lon", rs.getDouble("lon"));
			        obj.put("lat", rs.getDouble("lat"));
			        obj.put("elev", rs.getDouble("elev"));
			        array.add(obj);	//작성한 JSON 객체를 배열에 추가
			    }
			}catch(Exception ex) {
				System.out.println("getCorseLatLon()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}//finally
			return array;
		}//getCorseLatLon-end
		
		/*
		 * 코스를 사각형으로 생각해 코스의 남서쪽 좌표와 중앙값, 북동쪽 좌표를 코스이름으로 가져오는 로직
		 * 코스를 바꿀때 지도에 한눈에 보여주기 위해 사용된다.
		 */
		public List<CorseMaxMinLatLonDTO> getCorseMaxMinLatLon(String name){
			JSONArray array = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("SELECT  MAX(LON) LON_MAX, MAX(LAT) LAT_MAX,\r\n"
						+ "        MIN(LON) LON_MIN, MIN(LAT) LAT_MIN,\r\n"
						+ "        AVG(LON) LON_AVG, AVG(LAT) LAT_AVG\r\n"
						+ "  FROM corse\r\n"
						+ "WHERE name =? GROUP BY name");
				pstmt.setString(1, name);
				rs=pstmt.executeQuery();

				while(rs.next()) {
					JSONObject obj = new JSONObject();	// {}, JSON 객체 생성
			    	obj.put("LON_MAX", rs.getDouble("LON_MAX"));	// obj.put("key","value")
			        obj.put("LAT_MAX", rs.getDouble("LAT_MAX"));
			        obj.put("LON_MIN", rs.getDouble("LON_MIN"));
			        obj.put("LAT_MIN", rs.getDouble("LAT_MIN"));
			        obj.put("LON_AVG", rs.getDouble("LON_AVG"));
			        obj.put("LAT_AVG", rs.getDouble("LAT_AVG"));			        
			        array.add(obj);	//작성한 JSON 객체를 배열에 추가
			    }
			}catch(Exception ex) {
				System.out.println("CorseMaxMinLatLon()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}//finally
			return array;
		}//CorseMaxMinLatLon-end
//----------------------------------------------------------------------------------------------------------------
}//class-end
