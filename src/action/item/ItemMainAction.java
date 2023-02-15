package action.item;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandAction;
import item.*;

public class ItemMainAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
				//리스트생성
				List<ItemDTO> itemlist = null; 
				//itemDAO를 사용하려고 변수에 저장
				ItemDAO itemDAO = ItemDAO.getDao();
				
				itemlist = itemDAO.newitem();
				
//				// 페이징처리
//				String pageNum=request.getParameter("pageNum");
//				if(pageNum == null){  //만약 페이지넘버가 없다면
//					pageNum="1";	 //페이지 넘버는 1
//				}//if-end
//				int currentPage=Integer.parseInt(pageNum);  //현재페이지는 정수로 변환한 페이지 넘버
//				int pageSize=10;  //페이지사이즈 10
//				int startRow=(currentPage-1)*pageSize+1;  //페이지의 시작행 구하기 (1~11, 12~21)
//				int start=startRow-1;
//				int endRow=currentPage*pageSize;  //마지막행은 페이지크기*현재페이지
//				int count=0;  //카운트인수 초기화
//				int pageBlock=10;  //블럭당 페이지는 10
//				
//				if(count>0){  //상품이 있으면
//					itemlist = itemDAO.newitem(); //dao의 getPList메서드로 리스트 채우기
//				}else{  //상품이 없으면
//					itemlist=Collections.emptyList();  //리스트는 빈 리스트
//				}//else-end
//
//				int pageCount=count/pageSize+(count%pageSize==0?0:1); 
//				int startPage=(int)(currentPage/pageBlock)*10+1;  // (현재페이지/블럭당페이지(12))*10+1 결과값이 시작페이지
//				int endPage=startPage+pageBlock-1;  // 시작페이지+블럭당 페이지-1 결과값은 마지막페이지
				
				request.setAttribute("itemlist",itemlist);
		return "/item/itemMain.jsp";
	}

}
