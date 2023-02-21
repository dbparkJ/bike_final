package action.item;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import item.*;
import command.CommandAction;


public class CompareAction implements CommandAction{
	
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		int recommandItemId=Integer.parseInt(request.getParameter("recommandItemId"));
		int myItemId=Integer.parseInt(request.getParameter("myItemId"));
		
		ItemDTO MyItem=new ItemDTO();
		ItemDTO CompareItem=new ItemDTO();
		
		List<String> MyItemChartLabel=null;
		List<String> CompareItemChartLabel=null;
		
		List<Float> MyItemChartData=null;
		List<Float> CompareItemChartData=null;

		
		ItemDAO itemDAO=ItemDAO.getDao();
		
		MyItem=itemDAO.getItem(myItemId);
		CompareItem=itemDAO.getItem(recommandItemId);
		
		MyItemChartLabel=itemDAO.getChartLabel(myItemId);
		CompareItemChartLabel=itemDAO.getChartLabel(recommandItemId);
		
		MyItemChartData=itemDAO.getChartData(myItemId);
		CompareItemChartData=itemDAO.getChartData(recommandItemId);
		
		request.setAttribute("CompareItem", CompareItem);
		request.setAttribute("MyItem", MyItem);
		request.setAttribute("CompareItemChartLabel", CompareItemChartLabel);
		request.setAttribute("MyItemChartLabel", MyItemChartLabel);
		request.setAttribute("CompareItemChartData", CompareItemChartData);
		request.setAttribute("MyItemChartData", MyItemChartData);
		
		
		return "/item/compare.jsp";
	}
}
