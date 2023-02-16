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
		String pageNum=request.getParameter("pageNum");
		
		if(pageNum==null){
			pageNum="1";
		}
		
		int currentPage=Integer.parseInt(pageNum);
		int pageSize=10;
		
		int startRow=(currentPage-1)*pageSize+1; // 페이지의 시작 행을 구한다 
		int endRow=currentPage*pageSize; // 페이지의 끝행
		
		int count=0;
		int pageBlock=10;
		List<ItemDTO> itemlist = null;
		
		ItemDAO itemDAO=ItemDAO.getDao();
		count=itemDAO.getCount();
		System.out.println(count);
		if(count>0){ // 글이있으면...
			itemlist=itemDAO.newitem(startRow,endRow); // 1~ 10 , 11~ 20
			
		}else{ // 글이없으면...
			itemlist=Collections.EMPTY_LIST;
			
		} // else-end
		
		int pageCount=count/pageSize+(count%pageSize==0?0:1);
		
		int startPage=(int)(currentPage/pageBlock)*10+1;
		int endPage=startPage+pageBlock-1;
		
		// jsp에서 사용 할 속성설정
		request.setAttribute("startPage",new Integer(startPage));
		request.setAttribute("endPage",new Integer(endPage));
		request.setAttribute("currentPage",new Integer(currentPage));
		
		request.setAttribute("startRow",new Integer(startRow));
		request.setAttribute("endRow",new Integer(endRow));
		
		request.setAttribute("pageBlock",new Integer(pageBlock));
		request.setAttribute("pageCount",new Integer(pageCount));
		
		request.setAttribute("count",new Integer(count));
		request.setAttribute("pageSize",new Integer(pageSize));
		
		request.setAttribute("itemlist",itemlist);
		return "/item/itemMain.jsp";
	}

}
