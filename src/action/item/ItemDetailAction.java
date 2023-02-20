package action.item;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import command.CommandAction;
import item.*;
public class ItemDetailAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
			
			  //아이템의정보
			  Integer item_id = Integer.parseInt(request.getParameter("item_id"));
			
			  ItemDAO itemDAO=ItemDAO.getDao(); 
			  ItemDTO itemDTO=itemDAO.getItem(item_id);
			
			  List<ItemDTO> recommandItemList = itemDAO.getAIRecommand(item_id);
			
			  //아이템의리뷰정보
			  String pageNum=request.getParameter("pageNum");
			
			  // pageNum이 null이면 무조건 1페이지
		      if(pageNum==null){
		         pageNum="1";
		      }
		      
		      int currentPage=Integer.parseInt(pageNum);
		      int pageSize=10;
		      
		      int startRow=(currentPage-1)*pageSize+1; // 페이지의 시작 행을 구한다 
		      int endRow=currentPage*pageSize; // 페이지의 끝행
		      
		      int review_count=0;
		      int pageBlock=10;
		      
		      List<Item_reviewDTO> reviewList = null;
		      review_count = itemDAO.getReviewCount(item_id);
			  // 리뷰있으면
		      if(review_count>0){ 
		    	  reviewList = itemDAO.getItemReview(item_id, startRow, endRow);
		         }
		      // 리뷰없으면
		      else{
		    	  reviewList = Collections.emptyList(); // 빈리스트
		      }//else-end
		      
		      int pageCount=review_count/pageSize+(review_count%pageSize==0?0:1);
				
		      int startPage=(int)(currentPage/pageBlock)*10+1;
			  int endPage=startPage+pageBlock-1;
			  
			  request.setAttribute("startPage",new Integer(startPage));
			  request.setAttribute("endPage",new Integer(endPage));
			  request.setAttribute("currentPage",new Integer(currentPage));
				
			  request.setAttribute("startRow",new Integer(startRow));
			  request.setAttribute("endRow",new Integer(endRow));
				
			  request.setAttribute("pageBlock",new Integer(pageBlock));
			  request.setAttribute("pageCount",new Integer(pageCount));
				
			  request.setAttribute("review_count",new Integer(review_count));
			  request.setAttribute("pageSize",new Integer(pageSize));
				
			  request.setAttribute("recommandItemList", recommandItemList);
			  request.setAttribute("reviewList",reviewList);

			  request.setAttribute("itemDTO",itemDTO);
		      
			  return "/item/itemDetail.jsp";
	}

}
