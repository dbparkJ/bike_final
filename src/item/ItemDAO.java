package item;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import db.DBConnection;
import item.*;


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
	public List<ItemDTO> newitem(int start, int cnt){ 
		List<ItemDTO> list = null;
		try{
			con = DBConnection.getInstance().getConnection();
			
			pstmt=con.prepareStatement("select * from new_item_info where rownum>=? and rownum<=?");
			
			pstmt.setInt(1,start-1); // 0에서부터 시작이기때문에 -1을 해준다
			pstmt.setInt(2,cnt); // 갯수
			
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
	 * 글갯수, 페이지, 블럭처리에 필요함
	 */
//-------------------------------------------------------------------------------------------
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
	 } // getStyleDetail()-end

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
		
		return cnt; // 총 글 갯수
	} // getCount()-end
	

}
