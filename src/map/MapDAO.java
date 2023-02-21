/*
 * 맵 관련 로직
 */
package map;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import db.DBConnection;
import item.ItemDAO;
import item.ItemDTO;
import map.corseDTO.BikeRealTime;
import map.corseDTO.CorseList;
import map.corseDTO.CorseMaxMinLatLon;
import map.corseDTO.RepairShop;
import map.corseDTO.Toilet;
import map.storeDTO.KakaoStore;
import map.storeDTO.NaverStore;
import map.storeDTO.NaverStoreReview;
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
			String cloudRainSnow = "흐리고 비/눈";
			String manyCloudRainSnow = "구름많고 비/눈";
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
						
						if(rs.getString("condition_1_am").equals(cloudRainSnow)) {
							dto.setCondition_1_am("흐리고 비-눈");
						}else if(rs.getString("condition_1_am").equals(manyCloudRainSnow)) {
							dto.setCondition_1_am("구름많고 비-눈");
						}else {
							dto.setCondition_1_am(rs.getString("condition_1_am"));
						}
						if(rs.getString("condition_2_am").equals(cloudRainSnow)) {
							dto.setCondition_2_am("흐리고 비-눈");
						}else if(rs.getString("condition_2_am").equals(manyCloudRainSnow)) {
							dto.setCondition_2_am("구름많고 비-눈");
						}else {
							dto.setCondition_2_am(rs.getString("condition_2_am"));
						}
						if(rs.getString("condition_3_am").equals(cloudRainSnow)) {
							dto.setCondition_3_am("흐리고 비-눈");
						}else if(rs.getString("condition_3_am").equals(manyCloudRainSnow)) {
							dto.setCondition_3_am("구름많고 비-눈");
						}else {
							dto.setCondition_3_am(rs.getString("condition_3_am"));
						}
						if(rs.getString("condition_4_am").equals(cloudRainSnow)) {
							dto.setCondition_4_am("흐리고 비-눈");
						}else if(rs.getString("condition_4_am").equals(manyCloudRainSnow)) {
							dto.setCondition_4_am("구름많고 비-눈");
						}else {
							dto.setCondition_4_am(rs.getString("condition_4_am"));
						}
						if(rs.getString("condition_5_am").equals(cloudRainSnow)) {
							dto.setCondition_5_am("흐리고 비-눈");
						}else if(rs.getString("condition_5_am").equals(manyCloudRainSnow)) {
							dto.setCondition_5_am("구름많고 비-눈");
						}else {
							dto.setCondition_5_am(rs.getString("condition_5_am"));
						}
						if(rs.getString("condition_1_pm").equals(cloudRainSnow)) {
							dto.setCondition_1_pm("흐리고 비-눈");
						}else if(rs.getString("condition_1_pm").equals(manyCloudRainSnow)) {
							dto.setCondition_1_pm("구름많고 비-눈");
						}else {
							dto.setCondition_1_pm(rs.getString("condition_1_pm"));
						}
						if(rs.getString("condition_2_pm").equals(cloudRainSnow)) {
							dto.setCondition_2_pm("흐리고 비-눈");
						}else if(rs.getString("condition_2_pm").equals(manyCloudRainSnow)) {
							dto.setCondition_2_pm("구름많고 비-눈");
						}else {
							dto.setCondition_2_pm(rs.getString("condition_2_pm"));
						}
						if(rs.getString("condition_3_pm").equals(cloudRainSnow)) {
							dto.setCondition_3_pm("흐리고 비-눈");
						}else if(rs.getString("condition_3_pm").equals(manyCloudRainSnow)) {
							dto.setCondition_3_pm("구름많고 비-눈");
						}else {
							dto.setCondition_3_pm(rs.getString("condition_3_pm"));
						}
						if(rs.getString("condition_4_pm").equals(cloudRainSnow)) {
							dto.setCondition_4_pm("흐리고 비-눈");
						}else if(rs.getString("condition_4_pm").equals(manyCloudRainSnow)) {
							dto.setCondition_4_pm("구름많고 비-눈");
						}else {
							dto.setCondition_4_pm(rs.getString("condition_4_pm"));
						}
						if(rs.getString("condition_5_pm").equals(cloudRainSnow)) {
							dto.setCondition_5_pm("흐리고 비-눈");
						}else if(rs.getString("condition_5_pm").equals(manyCloudRainSnow)) {
							dto.setCondition_5_pm("구름많고 비-눈");
						}else {
							dto.setCondition_5_pm(rs.getString("condition_5_pm"));
						}
						dto.setUpdateTime(rs.getDate("updateTime").toLocalDate());
						rainList.add(dto); 
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
		public List<NaverStore> getNaverStoreList(String corseName,Double minlon,Double maxlon,Double minlat,Double maxlat){
			JSONArray naverStoreList = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from (select * from naver_store"
						+ " where REGEXP_SUBSTR(addr,'[^ ]+',1,2)"
						+ " in (select DISTINCT REGEXP_SUBSTR(addr,'[^ ]+',1,2)"
						+ " test from corse where name=?)"
						+ "and lon>? and lon<? "
						+ "and lat>? and lat<? "
						+ "order by DBMS_RANDOM.RANDOM) where rownum<=50");
				pstmt.setString(1, corseName);
				pstmt.setDouble(2, minlon);
				pstmt.setDouble(3, maxlon);
				pstmt.setDouble(4, minlat);
				pstmt.setDouble(5, maxlat);
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
		
		public List<KakaoStore> getKakaoStoreList(String corseName,Double minlon,Double maxlon,Double minlat,Double maxlat){
			JSONArray kakaoStoreList = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from (select * from kakao_store"
						+ " where REGEXP_SUBSTR(addr,'[^ ]+',1,2)"
						+ " in (select DISTINCT REGEXP_SUBSTR(addr,'[^ ]+',1,2)"
						+ " test from corse where name=?)"
						+ "and lon>? and lon<? "
						+ "and lat>? and lat<? "
						+ "order by DBMS_RANDOM.RANDOM) where rownum<=50");
				pstmt.setString(1, corseName);
				pstmt.setDouble(2, minlon);
				pstmt.setDouble(3, maxlon);
				pstmt.setDouble(4, minlat);
				pstmt.setDouble(5, maxlat);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("store_id", rs.getInt("store_id"));
					obj.put("store_name", rs.getString("store_name"));
					obj.put("addr", rs.getString("addr"));
					obj.put("lat", rs.getDouble("lat"));
					obj.put("lon", rs.getDouble("lon"));
					obj.put("kakao_star_avg", rs.getInt("kakao_star_avg"));
					obj.put("kakao_review_num", rs.getString("kakao_review_num"));
					obj.put("kakao_url", rs.getString("kakao_url"));
					obj.put("cate_b", rs.getString("cate_b"));
					obj.put("cate_c", rs.getString("cate_c"));
					
					kakaoStoreList.add(obj);
				}
			}catch(Exception ex){
				System.out.println("getKakaoStoreList()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}
			return kakaoStoreList;
		}
		
//----------------------------------------------------------------------------------------------------------------
		
		public List<Toilet> getToiletList(String corseName,Double minlon,Double maxlon,Double minlat,Double maxlat){
			JSONArray toiletList = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from toilet"
						+ " where REGEXP_SUBSTR(addr,'[^ ]+',1,3)"
						+ " in (select DISTINCT REGEXP_SUBSTR(addr,'[^ ]+',1,3)"
						+ " test from corse where name=?)"
						+ "and lon>? and lon<? "
						+ "and lat>? and lat<? ");
				pstmt.setString(1, corseName);
				pstmt.setDouble(2, minlon);
				pstmt.setDouble(3, maxlon);
				pstmt.setDouble(4, minlat);
				pstmt.setDouble(5, maxlat);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("name", rs.getString("name"));
					obj.put("addr", rs.getString("addr"));
					obj.put("lat", rs.getDouble("lat"));
					obj.put("lon", rs.getDouble("lon"));
					
					toiletList.add(obj);
				}
			}catch(Exception ex){
				System.out.println("getToiletList()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}
			return toiletList;
		}
		public List<RepairShop> getRepairShopList(String corseName,Double minlon,Double maxlon,Double minlat,Double maxlat){
			JSONArray repairShopList = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from repair_shop"
						+ " where REGEXP_SUBSTR(addr,'[^ ]+',1,2)"
						+ " in (select DISTINCT REGEXP_SUBSTR(addr,'[^ ]+',1,2)"
						+ " test from corse where name=?)"
						+ "and lon>? and lon<? "
						+ "and lat>? and lat<? "
						+ " and rownum<=50");
				pstmt.setString(1, corseName);
				pstmt.setDouble(2, minlon);
				pstmt.setDouble(3, maxlon);
				pstmt.setDouble(4, minlat);
				pstmt.setDouble(5, maxlat);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("name", rs.getString("name"));
					obj.put("addr", rs.getString("addr"));
					obj.put("lat", rs.getDouble("lat"));
					obj.put("lon", rs.getDouble("lon"));
					
					repairShopList.add(obj);
				}
			}catch(Exception ex){
				System.out.println("getRepairShopList()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}
			return repairShopList;
		}
		
		public List<BikeRealTime> getBikeRealTimeList(Double minlon,Double maxlon,Double minlat,Double maxlat){
			JSONArray repairShopList = new JSONArray();
			try {
				con = DBConnection.getInstance().getConnection();
				pstmt = con.prepareStatement("select * from(select * from bike_real_time"
						+ " where lon>? and lon<? "
						+ "and lat>? and lat<? order by DBMS_RANDOM.RANDOM)where rownum<=50 ");
				//select * from (select b.station_id, a.addr, b.lat, b.lon, b.updatetime from bike_real_time b inner join bike_master a on b.station_id = a.station_id) where REGEXP_SUBSTR(addr,'[^ ]+',1,2) in (select DISTINCT REGEXP_SUBSTR(addr,'[^ ]+',1,2)test from corse where name='대흥-구로역')
				pstmt.setDouble(1, minlon);
				pstmt.setDouble(2, maxlon);
				pstmt.setDouble(3, minlat);
				pstmt.setDouble(4, maxlat);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JSONObject obj = new JSONObject();
					obj.put("station_id", rs.getString("station_id"));
					obj.put("station_name", rs.getString("station_name"));
					obj.put("racktocnt", rs.getString("racktocnt"));
					obj.put("biketocnt", rs.getString("biketocnt"));
					obj.put("lat", rs.getDouble("lat"));
					obj.put("lon", rs.getDouble("lon"));
					
					repairShopList.add(obj);
				}
			}catch(Exception ex){
				System.out.println("getBikeRealTimeList()예외:"+ex);
			}finally{
				try{
					if(stmt!=null){stmt.close();}
					if(rs!=null){rs.close();}
					if(pstmt!=null){pstmt.close();}
					if(con!=null){con.close();}
				} catch (Exception exx) {}
			}
			return repairShopList;
		}
//----------------------------------------------------------------------------------------------------------------
		public List<NaverStoreReview> getNaverStoreReview(Integer store_id){
		    JSONArray naverReviewList = new JSONArray();
		    try {
		        con = DBConnection.getInstance().getConnection();
		        pstmt = con.prepareStatement("select * from naver_store_review where store_id =?");
		        pstmt.setDouble(1, store_id);
		        rs=pstmt.executeQuery();

		        while(rs.next()) {
		            JSONObject obj = new JSONObject();
		            obj.put("naver_nickname", rs.getString("naver_nickname"));
		            obj.put("naver_date", rs.getString("naver_date"));

		            String naverContent = rs.getString("naver_content");
		            if (rs.wasNull()) {
		                obj.put("naver_content", "정보없음");
		            } else {
		                obj.put("naver_content", naverContent);
		            }

		            Double naverStar = rs.getDouble("naver_star");
		            if (rs.wasNull()) {
		                obj.put("naver_star", "별점미제공");
		            } else {
		                obj.put("naver_star", naverStar);
		            }
		            
		            naverReviewList.add(obj);
		        }
		    } catch(Exception ex){
		        System.out.println("getNaverStoreReview()예외:"+ex);
		    } finally {
		        try {
		            if(stmt!=null){stmt.close();}
		            if(rs!=null){rs.close();}
		            if(pstmt!=null){pstmt.close();}
		            if(con!=null){con.close();}
		        } catch (Exception exx) {}
		    }
		    return naverReviewList;
		}
//----------------------------------------------------------------------------------------------------------------
		public NaverStore getSingleNaverStoreInfo(Integer store_id) {
			NaverStore dto=new NaverStore();
			 try{
				 con = DBConnection.getInstance().getConnection();
				 pstmt = con.prepareStatement("select * from naver_store where store_id="+store_id);
				 rs=pstmt.executeQuery();
				 
				 while(rs.next()){
					 dto.setStore_id(rs.getInt("store_id"));
					 dto.setStore_name(rs.getString("store_name"));
					 dto.setCate_c(rs.getString("cate_c"));
					 dto.setNaver_url(rs.getString("naver_url"));
				 } // while-end
				 
			 }catch(Exception ex){
				 System.out.println("getItem() 예외 : "+ex);
			 }finally{
				 try{
					 if(rs != null){rs.close();}
					 if(stmt != null){stmt.close();}
					 if(con != null){con.close();}
					 
				 }catch(Exception exx){}
			 } // finally-end
			return dto;
		}
		
		public List<NaverStore> getNaverStoreAIRecommand(Integer store_id){
			JSONArray recommandList = new JSONArray();
			HttpClient client = HttpClient.newHttpClient();
	        HttpRequest request = HttpRequest.newBuilder()
	            .uri(URI.create("http://192.168.0.146:5000/recommandNaverStore?store_id="+store_id))
	            .header("Content-Type", "application/json")
	            .GET()
	            .build();
	        try {
	            HttpResponse<String> response = client.send(request, BodyHandlers.ofString());
	            String responseBody = response.body();
	            
	            JSONParser parser = new JSONParser();
	            JSONObject jsonObject = (JSONObject) parser.parse(responseBody);
	            
	            Integer result1 = Integer.parseInt(jsonObject.get("result1").toString());
	            Integer result2 = Integer.parseInt(jsonObject.get("result2").toString());
	            Integer result3 = Integer.parseInt(jsonObject.get("result3").toString());
	            Integer result4 = Integer.parseInt(jsonObject.get("result4").toString());
	            Integer result5 = Integer.parseInt(jsonObject.get("result5").toString());
	            
	            MapDAO mapDAO=MapDAO.getDao(); 
				NaverStore item_1=mapDAO.getSingleNaverStoreInfo(result1);
				NaverStore item_2=mapDAO.getSingleNaverStoreInfo(result2);
				NaverStore item_3=mapDAO.getSingleNaverStoreInfo(result3);
				NaverStore item_4=mapDAO.getSingleNaverStoreInfo(result4);
				NaverStore item_5=mapDAO.getSingleNaverStoreInfo(result5);
				
				System.out.println(item_1);
				
				JSONObject obj = new JSONObject();
				
	            obj.put("store_id_1", item_1.getStore_id());
	            obj.put("store_name_1", item_1.getStore_name());
	            obj.put("cate_c_1", item_1.getCate_c());
	            obj.put("naver_url_1", item_1.getNaver_url());
//	            obj.put("naver_img_url_1", item_1.getNaver_img_url());
	            obj.put("store_id_2", item_2.getStore_id());
	            obj.put("store_name_2", item_2.getStore_name());
	            obj.put("cate_c_2", item_2.getCate_c());
	            obj.put("naver_url_2", item_2.getNaver_url());
//	            obj.put("naver_img_url_2", item_2.getNaver_img_url());
	            obj.put("store_id_3", item_3.getStore_id());
	            obj.put("store_name_3", item_3.getStore_name());
	            obj.put("cate_c_3", item_3.getCate_c());
	            obj.put("naver_url_3", item_3.getNaver_url());
//	            obj.put("naver_img_url_3", item_3.getNaver_img_url());
	            obj.put("store_id_4", item_4.getStore_id());
	            obj.put("store_name_4", item_4.getStore_name());
	            obj.put("cate_c_4", item_4.getCate_c());
	            obj.put("naver_url_4", item_4.getNaver_url());
//	            obj.put("naver_img_url_4", item_4.getNaver_img_url());
	            obj.put("store_id_5", item_5.getStore_id());
	            obj.put("store_name_5", item_5.getStore_name());
	            obj.put("cate_c_5", item_5.getCate_c());
	            obj.put("naver_url_5", item_5.getNaver_url());
//	            obj.put("naver_img_url_5", item_5.getNaver_img_url());
				
	            recommandList.add(obj);
				
	        } catch (Exception e) {
	            System.out.println("Error: " + e.getMessage());
	        }
			return recommandList;
		}
}//class-end
