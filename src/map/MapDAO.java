/*
 * 맵 관련 로직
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
import map.corseDTO.CorseList;
import map.corseDTO.CorseMaxMinLatLon;
import map.storeDTO.NaverStore;
import weatherDTO.WeatherRain;
import weatherDTO.WeatherTemp;

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
		public List<CorseList> getCorseList(){
			List<CorseList> singleCorseList = null;
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select name from corse group by name");
				rs=pstmt.executeQuery();
				if(rs.next()){
					singleCorseList=new ArrayList<CorseList>();
					do{	
						CorseList dto=new CorseList();
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
		public List<CorseList> getCorseLatLon(String name){
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
		public List<CorseMaxMinLatLon> getCorseMaxMinLatLon(String name){
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
		/*
		 * 날씨 불러오는 로직
		 */
		
		// 강수확률 불러오는 리스트
		public List<WeatherRain> getRainList(){
			List<WeatherRain> rainList = null;
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from weather_rain where id = (select max(id) from weather_rain)");
				rs=pstmt.executeQuery();
				if(rs.next()){
					rainList=new ArrayList<WeatherRain>();
					do{	
						WeatherRain dto=new WeatherRain();
						dto.setRain_1_am(rs.getInt("rain_1_am"));
						dto.setRain_2_am(rs.getInt("rain_2_am"));
						dto.setRain_3_am(rs.getInt("rain_3_am"));
						dto.setRain_4_am(rs.getInt("rain_4_am"));
						dto.setRain_5_am(rs.getInt("rain_5_am"));
						dto.setRain_1_pm(rs.getInt("rain_1_pm"));
						dto.setRain_2_pm(rs.getInt("rain_2_pm"));
						dto.setRain_3_pm(rs.getInt("rain_3_pm"));
						dto.setRain_4_pm(rs.getInt("rain_4_pm"));
						dto.setRain_5_pm(rs.getInt("rain_5_pm"));
						dto.setCondition_1_am(rs.getString("condition_1_am"));
						dto.setCondition_2_am(rs.getString("condition_2_am"));
						dto.setCondition_3_am(rs.getString("condition_3_am"));
						dto.setCondition_4_am(rs.getString("condition_4_am"));
						dto.setCondition_5_am(rs.getString("condition_5_am"));
						dto.setCondition_1_pm(rs.getString("condition_1_pm"));
						dto.setCondition_2_pm(rs.getString("condition_2_pm"));
						dto.setCondition_3_pm(rs.getString("condition_3_pm"));
						dto.setCondition_4_pm(rs.getString("condition_4_pm"));
						dto.setCondition_5_pm(rs.getString("condition_5_pm"));
						dto.setUpdateTime(rs.getDate("updateTime").toLocalDate());
						rainList.add(dto); //***
					}while(rs.next());
				}//if-end
			}catch(Exception ex) {
				System.out.println("getRainList()예외:"+ex);
				ex.printStackTrace();
			}finally{
				try{
					if(rs!=null){rs.close();}
					if(stmt!=null){stmt.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}//finally
			return rainList;
		}//getRainList-end
		
		// 강수확률 불러오는 리스트
				public List<WeatherTemp> getTempList(){
					List<WeatherTemp> tempList = null;
					try {
						con = DBConnection.getInstance().getConnection();
						pstmt = con.prepareStatement("select * from weather_temp where id = (select max(id) from weather_temp)");
						rs=pstmt.executeQuery();
						if(rs.next()){
							tempList=new ArrayList<WeatherTemp>();
							do{	
								WeatherTemp dto=new WeatherTemp();
								dto.setLtemp_1(rs.getInt("Ltemp_1"));
								dto.setLtemp_2(rs.getInt("Ltemp_2"));
								dto.setLtemp_3(rs.getInt("Ltemp_3"));
								dto.setLtemp_4(rs.getInt("Ltemp_4"));
								dto.setLtemp_5(rs.getInt("Ltemp_5"));
								dto.setHtemp_1(rs.getInt("Htemp_1"));
								dto.setHtemp_2(rs.getInt("Htemp_2"));
								dto.setHtemp_3(rs.getInt("Htemp_3"));
								dto.setHtemp_4(rs.getInt("Htemp_4"));
								dto.setHtemp_5(rs.getInt("Htemp_5"));
								dto.setUpdateTime(rs.getDate("updateTime").toLocalDate());
								tempList.add(dto); //***
							}while(rs.next());
						}//if-end
					}catch(Exception ex) {
						System.out.println("getTempList()예외:"+ex);
						ex.printStackTrace();
					}finally{
						try{
							if(rs!=null){rs.close();}
							if(stmt!=null){stmt.close();}
							if(pstmt!=null){pstmt.close();}
							if(con!=null){con.close();}
						} catch (Exception exx) {}
					}//finally
					return tempList;
				}//getRainList-end
//----------------------------------------------------------------------------------------------------------------
		public List<NaverStore> getNaverStoreList(Double minlon,Double maxlon,Double minlat,Double maxlat){
			JSONArray naverStoreList = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from naver_store "
						+ "where lon>? and lon<? "
						+ "and lat>? and lat<? "
						+ "and rownum<=50");
				pstmt.setDouble(1, minlon);
				pstmt.setDouble(2, maxlon);
				pstmt.setDouble(3, minlat);
				pstmt.setDouble(4, maxlat);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("store_id", rs.getInt("store_id"));
					obj.put("store_name", rs.getString("store_name"));
					obj.put("addr", rs.getString("addr"));
					obj.put("lat", rs.getDouble("lat"));
					obj.put("lon", rs.getDouble("lon"));
					obj.put("naver_star_avg", rs.getInt("naver_star_avg"));
					obj.put("naver_review_num", rs.getString("naver_review_num"));
					obj.put("naver_url", rs.getString("naver_url"));
					obj.put("cate_b", rs.getString("cate_b"));
					obj.put("cate_c", rs.getString("cate_c"));
					
					naverStoreList.add(obj);
				}
			}catch(Exception ex){
				System.out.println("getNaverStoreList()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}
			return naverStoreList;
		}
}//class-end
