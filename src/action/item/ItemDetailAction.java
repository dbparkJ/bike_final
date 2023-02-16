package action.item;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import command.CommandAction;
import item.*;
public class ItemDetailAction implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
				Integer item_id = Integer.parseInt(request.getParameter("item_id"));
				
				ItemDAO itemDAO=ItemDAO.getDao(); 
				ItemDTO itemDTO=itemDAO.getItem(item_id);
				
				request.setAttribute("item_id", item_id);
				request.setAttribute("itemDTO",itemDTO);
		return "/item/itemDetail.jsp";
	}

}
