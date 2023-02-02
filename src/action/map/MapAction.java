package action.map;

import java.util.List;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import map.MapDAO;
import map.CorseListDTO;
import command.CommandAction;

public class MapAction implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		List<CorseListDTO> CorseList = null;
		MapDAO corseDAO = MapDAO.getDao();
		
		CorseList=corseDAO.getCorseList();
		
		request.setAttribute("singleCorseList", CorseList);
		return "/corse/corse.jsp";
	}

}
