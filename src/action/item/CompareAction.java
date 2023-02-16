package action.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import item.*;
import command.CommandAction;


public class CompareAction implements CommandAction{
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		ItemDTO MyItem=new ItemDTO();
		ItemDTO CompareItem=new ItemDTO();
		
		ItemDAO itemDAO=ItemDAO.getDao();
		
		MyItem=itemDAO.getItem(1);
		CompareItem=itemDAO.getItem(3);
		
		request.setAttribute("CompareItem", CompareItem);
		request.setAttribute("MyItem", MyItem);
		
		return "/item/compare.jsp";
	}
}
