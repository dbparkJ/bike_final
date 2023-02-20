package item;

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

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import db.DBConnection;
import item.*;
import map.corseDTO.CorseList;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.http.HttpResponse.BodyHandlers;


public class ItemDAO { 
	private static ItemDAO instance=new ItemDAO();
	
	private ItemDAO(){}
	
	public static ItemDAO getDao(){
		return instance;
	}
	
	Connection con=null;
	Statement stmt=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	/*
	 * 새상품 리스트화
	 */
	public List<ItemDTO> newitem(int start, int cnt, String keyword){ 
		List<ItemDTO> list = null;

		try{
			con = DBConnection.getInstance().getConnection();
			
			//검색어가 없으면
			if(keyword.equals(null) || keyword.equals("") || keyword.length()<1){
				pstmt=con.prepareStatement("SELECT * FROM(SELECT ROWNUM AS RNUM, T1.* FROM new_item_info T1)"
						 + "WHERE RNUM BETWEEN ? AND ?");

				pstmt.setInt(1,start);
				pstmt.setInt(2,cnt);
			
			//검색어가 있으면
			}else{
				pstmt=con.prepareStatement("SELECT *\r\n"
						+ "  FROM (\r\n"
						+ " SELECT ROW_NUMBER() OVER (ORDER BY item_id) NUM\r\n"
						+ "             , A.*\r\n"
						+ "          FROM (select * from new_item_info  where item_name like '%"+keyword+"%') A\r\n"
						+ "         ORDER BY item_id\r\n"
						+ "        ) \r\n"
						+ " WHERE NUM BETWEEN ? AND ?");
				
				pstmt.setInt(1,start);
				pstmt.setInt(2,cnt);
							
			}//else-end

			rs=pstmt.executeQuery();
			
			if(rs.next()){
				list = new ArrayList<ItemDTO>();
				
				do {
				ItemDTO dto = new ItemDTO();
				
				dto.setItem_id(rs.getInt("item_id"));
				dto.setItem_name(rs.getString("item_name"));
				dto.setItem_img(rs.getString("item_img"));
				dto.setUrl(rs.getString("url"));
				dto.setItem_price(rs.getInt("item_price"));
				dto.setItem_avg_star(rs.getFloat("item_avg_star"));
				dto.setItem_delivery_fee(rs.getInt("item_delivery_fee"));
				
				list.add(dto);
			}while (rs.next());
		} 
		}catch(Exception ex){
			System.out.println("newitem 예외 : "+ex);
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
				if(pstmt!=null){
					pstmt.close();
				}
				if(con!=null){
					con.close();
				}
				if(stmt!=null) {
					stmt.close();
				}
			}catch(Exception ex2){}
		}//finally-end
		
		return list;
	}//newitem()-end
	
	/*
	 * 상품갯수, 페이지, 블럭처리에 필요함
	 */
	public int getCount(){
		int cnt=0;
		
		try{
			con = DBConnection.getInstance().getConnection();
						
			pstmt=con.prepareStatement("select count(*) from new_item_info"); // 상품갯수조회
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				cnt=rs.getInt(1); // 1 필드번호
			}
			
		}catch(Exception ex){
			System.out.println("getCount()예외 : "+ex);
		}finally{
			try{
				if(rs != null){rs.close();}
				if(pstmt != null){pstmt.close();}
				if(con != null){con.close();}
				
			}catch(Exception ex2){}
		} // finally-end
		return cnt; // 총 상품갯수
	} // getCount()-end
	public int getSearchCount(String keyword){
		int cnt=0;
		
		try{
			con = DBConnection.getInstance().getConnection();
						
			pstmt=con.prepareStatement("SELECT count(*) FROM(SELECT ROWNUM AS RNUM, T1.* FROM new_item_info T1) "
					+ "where item_name like '%"+keyword+"%'"); // 상품갯수조회
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				cnt=rs.getInt(1); // 1 필드번호
			}
			
		}catch(Exception ex){
			System.out.println("getSearchCount()예외 : "+ex);
		}finally{
			try{
				if(rs != null){rs.close();}
				if(pstmt != null){pstmt.close();}
				if(con != null){con.close();}
				
			}catch(Exception ex2){}
		} // finally-end
		
		return cnt; // 검색한 후의 상품갯수
	} // getSearchCount()-end

	
	//============================================================================================================
	/*
	 * 아이템 정보 가져옴
	 */
	
	//아이템 정보 가져오는 리스트(아이템 상세보기/비교할 아이템 가져올 때 사용)
	public ItemDTO getItem(Integer item_id){
		ItemDTO dto=new ItemDTO();
		 
		 try{
			 con = DBConnection.getInstance().getConnection();
			 pstmt = con.prepareStatement("select * from new_item_info where item_id="+item_id);
			 rs=pstmt.executeQuery();
			 
			 while(rs.next()){
				 dto.setItem_id(rs.getInt("ITEM_ID"));
				 dto.setItem_name(rs.getString("ITEM_NAME"));
				 dto.setItem_img(rs.getString("ITEM_IMG"));
				 dto.setItem_price(rs.getInt("ITEM_PRICE"));
				 dto.setItem_avg_star(rs.getFloat("ITEM_AVG_STAR"));
				 dto.setItem_delivery_fee(rs.getInt("ITEM_DELIVERY_FEE"));
				 dto.setItem_category(rs.getString("ITEM_CATEGORY"));
				 dto.setItem_num(rs.getInt("ITEM_REVIEW_NUM"));
				 dto.setWish(rs.getInt("WISH"));
				 dto.setUrl(rs.getString("URL"));
				 dto.setMax_speed_km(rs.getInt("MAX_SPEED_KM"));
				 dto.setMileage_km(rs.getInt("MILEAGE_KM"));
				 dto.setBack_angle_do(rs.getInt("BACK_ANGLE_DO"));
				 dto.setGear_dan(rs.getInt("GEAR_DAN"));
				 dto.setWheel_inch(rs.getFloat("WHEEL_INCH"));
				 dto.setWeight_kg(rs.getFloat("WEIGHT_KG"));
				 dto.setGearbox(rs.getString("GEARBOX"));
				 dto.setBrake(rs.getString("BRAKE"));
				 dto.setHandle_type(rs.getString("HANDLE_TYPE"));
				 dto.setFeature(rs.getString("FEATURE"));
				 dto.setMotor_output_w(rs.getInt("MOTOR_OUTPUT_W"));
				 dto.setBattery_cap_ah(rs.getFloat("BATTERY_CAP_AH"));
				 dto.setBattery_vol_v(rs.getFloat("BATTERY_VOL_V"));
				 dto.setCharge_time_h(rs.getFloat("CHARGE_TIME_H"));
				 dto.setSuspension(rs.getString("SUSPENSION"));
				 dto.setFrame(rs.getString("FRAME"));
				 dto.setSaddle(rs.getString("SADDLE"));
				 dto.setType(rs.getString("TYPE"));
				 dto.setRelease_y(rs.getInt("RELEASE_Y"));
				 
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

	 } // getItem()-end
	
	public List<ItemDTO> getAIRecommand(Integer item_id){
		List<ItemDTO> recommandList = new ArrayList<>();
		HttpClient client = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create("http://192.168.0.146:5000/recommandItem?item_id="+item_id))

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
            
            ItemDAO itemDAO=ItemDAO.getDao(); 
			ItemDTO item_1=itemDAO.getItem(result1);
			ItemDTO item_2=itemDAO.getItem(result2);
			ItemDTO item_3=itemDAO.getItem(result3);
			ItemDTO item_4=itemDAO.getItem(result4);
			ItemDTO item_5=itemDAO.getItem(result5);
			
			recommandList.add(item_1);
			recommandList.add(item_2);
			recommandList.add(item_3);
			recommandList.add(item_4);
			recommandList.add(item_5);
			
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
		return recommandList;
	}

		/*
		 * 차트데이터 리스트화
		 */
		public List<ItemDTO> getChartDataList(int item_id){ 
			List<ItemDTO> chartDataList = null;
			try{
				con = DBConnection.getInstance().getConnection();	
				pstmt=con.prepareStatement("select item_category,item_price, item_avg_star, "
							+ "gear_dan,wheel_inch,weight_kg, motor_output_w,"
							+ "battery_cap_ah, battery_vol_v, charge_time_h "
							+ "from new_item_info where item_id=?");
				pstmt.setInt(1,item_id);
				rs=pstmt.executeQuery();
				if(rs.next()){
					chartDataList=new ArrayList<ItemDTO>();
					do{	
						ItemDTO dto=new ItemDTO();
						
						 dto.setItem_category(rs.getString("ITEM_CATEGORY"));
						 dto.setItem_price(rs.getInt("ITEM_PRICE"));
						 dto.setItem_avg_star(rs.getFloat("ITEM_AVG_STAR"));
						 dto.setGear_dan(rs.getInt("GEAR_DAN"));
						 dto.setWheel_inch(rs.getFloat("WHEEL_INCH"));
						 dto.setWeight_kg(rs.getFloat("WEIGHT_KG"));
						 dto.setMotor_output_w(rs.getInt("MOTOR_OUTPUT_W"));
						 dto.setBattery_cap_ah(rs.getFloat("BATTERY_CAP_AH"));
						 dto.setBattery_vol_v(rs.getFloat("BATTERY_VOL_V"));
						 dto.setCharge_time_h(rs.getFloat("CHARGE_TIME_H"));
						 
						 chartDataList.add(dto); 
					}while(rs.next());
				}//if-end
			}catch(Exception ex){
				System.out.println("getChartDataList 예외 : "+ex);
			}finally{
				try{
					if(rs!=null){
						rs.close();
					}
					if(pstmt!=null){
						pstmt.close();
					}
					if(con!=null){
						con.close();
					}
					if(stmt!=null) {
						stmt.close();
					}
				}catch(Exception ex2){}
			}//finally-end
			return chartDataList;
		}//getChartList()-end
		/*
		 *  전기자전거일 경우 radar chart 에서 쓰일 label 9개를,
		 *  아닐 경우 radar  chart에서 쓰일 label 5개를 반환해주는 dao 함수
		 */
		public List<String> getChartLabel(int item_id){ 
			List<String> labelList = null;
			try{
				con = DBConnection.getInstance().getConnection();	
				pstmt=con.prepareStatement("select item_category from new_item_info where item_id=?");
				pstmt.setInt(1,item_id);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					
					labelList = new ArrayList();
					
					labelList.add("'평균별점'");
					labelList.add("'기어(단)'");
					labelList.add("'바퀴(inch)'");
					labelList.add("'무게(kg)'");
					
					String myCategory=rs.getString("ITEM_CATEGORY");
					String electBikeCategory="스포츠/레저>자전거>자전거/MTB>전기자전거";
					
					if (myCategory.equals(electBikeCategory)) {
						
						labelList.add("'최고속도(km)'");
						labelList.add("'모터출력(W)'");
						labelList.add("'배터리용량(AH)'");
						labelList.add("'배터리전압(v)'");
						labelList.add("'충전시간(h)'");
					}//if-end
				}//if-rs.next()-end
			}catch(Exception ex){
				System.out.println("getChartLabel 예외 : "+ex);
			}finally{
				try{
					if(rs!=null){
						rs.close();
					}
					if(pstmt!=null){
						pstmt.close();
					}
					if(con!=null){
						con.close();
					}
					if(stmt!=null) {
						stmt.close();
					}
				}catch(Exception ex2){}
			}//finally-end
			return labelList;
		}//chartDataList()-end
	
	/*  
	 *  전기자전거일 경우 radar chart 에서 쓰일 data 9개를,
	 *  아닐 경우 radar  chart에서 쓰일 data 5개를 반환해주는 dao 함수
	 */
		public List<Float> getChartData(int item_id){ 
		List<Float> chartDataList = null;
		try{
			con = DBConnection.getInstance().getConnection();	
			pstmt=con.prepareStatement("select item_category,item_price, item_avg_star, "
					+ "gear_dan,wheel_inch,weight_kg,"
					+ "MAX_SPEED_KM,MILEAGE_KM, motor_output_w,"
					+ "battery_cap_ah, battery_vol_v, charge_time_h "
					+ "from new_item_info where item_id=?");
			pstmt.setInt(1,item_id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				chartDataList = new ArrayList();
				
				chartDataList.add(rs.getFloat("item_avg_star"));
				chartDataList.add((float)rs.getInt("GEAR_DAN"));
				chartDataList.add(rs.getFloat("WHEEL_INCH"));
				chartDataList.add(rs.getFloat("WEIGHT_KG"));
				
				String myCategory=rs.getString("ITEM_CATEGORY");
				String electBikeCategory="스포츠/레저>자전거>자전거/MTB>전기자전거";
			
	
				if (myCategory.equals(electBikeCategory)) {
	
					chartDataList.add((float)rs.getInt("MAX_SPEED_KM"));
					chartDataList.add((float)rs.getInt("MOTOR_OUTPUT_W")/10);
					chartDataList.add(rs.getFloat("BATTERY_CAP_AH"));
					chartDataList.add(rs.getFloat("BATTERY_VOL_V"));
					chartDataList.add(rs.getFloat("CHARGE_TIME_H"));
				}//if-end
			}//if-rs.next-end
		}catch(Exception ex){
			System.out.println("getChartData 예외 : "+ex);
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
				if(pstmt!=null){
					pstmt.close();
				}
				if(con!=null){
					con.close();
				}
				if(stmt!=null) {
					stmt.close();
				}
			}catch(Exception ex2){}
		}//finally-end
		return chartDataList;
	
	}//chartDataList()-end
	
	//==================================================================================================
	/*
	 * 아이템id에 따른 리뷰정보 출력 로직
	 */
	public List<Item_reviewDTO> getItemReview(Integer item_id, int start, int cnt){ 
		List<Item_reviewDTO> list = null;
		
		try{
			con = DBConnection.getInstance().getConnection();
	
			pstmt=con.prepareStatement("SELECT * FROM(SELECT ROWNUM AS RNUM, T1.* FROM new_item_review T1 WHERE item_id=?) "
										+ "where RNUM BETWEEN ? AND ? order by review_date desc");
			
			pstmt.setInt(1,item_id);
			pstmt.setInt(2,start);
			pstmt.setInt(3,cnt);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				list = new ArrayList<Item_reviewDTO>();
				
				do {
					Item_reviewDTO dto = new Item_reviewDTO();

					dto.setReview_content(rs.getString("review_content"));
					dto.setReview_star(rs.getInt("review_star"));
					dto.setReview_nickname(rs.getString("review_nickname"));
					dto.setReview_date(rs.getString("review_date"));
					
					list.add(dto);
					
			}while (rs.next());
		} 
		}catch(Exception ex){
			System.out.println("getItemReview 예외 : "+ex);
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
				if(pstmt!=null){
					pstmt.close();
				}
				if(con!=null){
					con.close();
				}
				if(stmt!=null) {
					stmt.close();
				}
			}catch(Exception ex2){}
		}//finally-end
		
		return list;
	}//getItemReview()-end
	
	/*
	 * 리뷰갯수, 페이지, 블럭처리에 필요함
	 */
	public int getReviewCount(Integer item_id){
		
		int cnt=0;
		
		try{
			con = DBConnection.getInstance().getConnection();
				
			pstmt=con.prepareStatement("select count(*) from new_item_review where item_id=?"); // 상품갯수조회
			
			pstmt.setInt(1,item_id);
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				cnt=rs.getInt(1); // 1 필드번호
			}
			
		}catch(Exception ex){
			System.out.println("getReviewCount()예외 : "+ex);
		}finally{
			try{
				if(rs != null){rs.close();}
				if(pstmt != null){pstmt.close();}
				if(con != null){con.close();}
				
			}catch(Exception ex2){}
		} // finally-end
		
		return cnt; // 총 리뷰갯수
		
	} // getReviewCount()-end
}