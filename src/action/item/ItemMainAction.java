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
		  request.setCharacterEncoding("utf-8"); 
	      
	      String pageNum=request.getParameter("pageNum");
	      
	      String keyword=""; // 빈키워드
	      String keyword2 = request.getParameter("keyword2");
	      
	      // pageNum이 null이면 무조건 1페이지
	      if(pageNum==null){
	         pageNum="1";
	      }
	      
	      int currentPage=Integer.parseInt(pageNum);
	      int pageSize=12;
	      
	      int startRow=(currentPage-1)*pageSize+1; // 페이지의 시작 행을 구한다 
	      int endRow=currentPage*pageSize; // 페이지의 끝행
	      
	      int count=0;
	      int pageBlock=10;
	      
	      List<ItemDTO> itemlist = null;
	      
	      ItemDAO itemDAO=ItemDAO.getDao();
	      count = itemDAO.getCount();
	      
	      //상품이 있으면
	      if(count>0){
	         if(keyword2 != null){
	               itemlist=itemDAO.newitem(startRow,endRow,keyword2);
	               count=itemDAO.getSearchCount(keyword2);
	         }else{
	            //검색어를 입력하지않았다면 keyword는 그냥 빈값으로 들어간다.
	            itemlist=itemDAO.newitem(startRow,endRow,keyword);   
	         }
	      //상품이 없으면
	      }else{
	         itemlist=Collections.emptyList(); // 빈리스트
	      }//else-end
		
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		
		int startPage=(int)(currentPage/pageBlock)*10+1;
		int endPage=startPage+pageBlock-1;
		
		String keywordParameter = keyword2 == null ? null : "&keyword2=" + keyword2;
		
		request.setAttribute("startPage",new Integer(startPage));
		request.setAttribute("endPage",new Integer(endPage));
		request.setAttribute("currentPage",new Integer(currentPage));
		
		request.setAttribute("startRow",new Integer(startRow));
		request.setAttribute("endRow",new Integer(endRow));
		
		request.setAttribute("pageBlock",new Integer(pageBlock));
		request.setAttribute("pageCount",new Integer(pageCount));
		
		request.setAttribute("count",new Integer(count));
		request.setAttribute("pageSize",new Integer(pageSize));

		request.setAttribute("keyword2", keyword2);
		request.setAttribute("keywordParameter", keywordParameter);

		request.setAttribute("itemlist",itemlist);
		return "/item/itemMain.jsp";
	}

}
