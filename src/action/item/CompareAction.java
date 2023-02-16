package action.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import item.*;
import command.CommandAction;


public class CompareAction implements CommandAction{
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		int myItemId=Integer.parseInt(request.getParameter("item_id"));
		
		ItemDTO MyItem=new ItemDTO();
		ItemDTO CompareItem=new ItemDTO();
		
		ItemDAO itemDAO=ItemDAO.getDao();
		
		MyItem=itemDAO.getItem(myItemId);
		CompareItem=itemDAO.getItem(3);
		
		System.out.println(myItemId);
		
		request.setAttribute("CompareItem", CompareItem);
		request.setAttribute("MyItem", MyItem);
		
//		List<Float> test=MyItem.getChartData();
//		for(float data: test) {
//			System.out.println(data);
//		}
//		
		
		return "/item/compare.jsp";
	}
}
