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
	 * 새상품 리스트화 아아아
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
