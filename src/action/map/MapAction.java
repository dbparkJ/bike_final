package action.map;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.format.TextStyle;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import map.MapDAO;
import map.corseDTO.CorseList;
import map.storeDTO.NaverStoreReview;
import weatherDTO.WeatherRain;
import weatherDTO.WeatherTemp;
import map.*;
import command.CommandAction;

public class MapAction implements CommandAction{

	@Override
	public String requestPro(HttpServletRequest request, HttpServletResponse response) throws Throwable {
		
		List<CorseList> CorseList = null;
		List<WeatherRain> RainList = null;
		List<WeatherTemp> TempList = null;
		
		MapDAO mapDAO = MapDAO.getDao(); 
		
		
		DateFormat newFormat = new SimpleDateFormat("MM-dd (E)", Locale.KOREA);
		Calendar onedaysAfter = Calendar.getInstance();
		Calendar twodaysAfter = Calendar.getInstance();
		Calendar threedaysAfter = Calendar.getInstance();
		Calendar fourdaysAfter = Calendar.getInstance();
		Calendar fivedaysAfter = Calendar.getInstance();
		
		onedaysAfter.setTime(new Date());
		twodaysAfter.setTime(new Date());
		threedaysAfter.setTime(new Date());
		fourdaysAfter.setTime(new Date());
		fivedaysAfter.setTime(new Date());
		
		onedaysAfter.add(Calendar.DATE, 1);
		twodaysAfter.add(Calendar.DATE, 2);
		threedaysAfter.add(Calendar.DATE, 3);
		fourdaysAfter.add(Calendar.DATE, 4);
		fivedaysAfter.add(Calendar.DATE, 5);
		
		CorseList=mapDAO.getCorseList();
		RainList=mapDAO.getRainList();
		TempList=mapDAO.getTempList();
		
		request.setAttribute("onedaysAfter", newFormat.format(onedaysAfter.getTime()));
		request.setAttribute("twodaysAfter", newFormat.format(twodaysAfter.getTime()));
		request.setAttribute("threedaysAfter", newFormat.format(threedaysAfter.getTime()));
		request.setAttribute("fourdaysAfter", newFormat.format(fourdaysAfter.getTime()));
		request.setAttribute("fivedaysAfter", newFormat.format(fivedaysAfter.getTime()));

		request.setAttribute("singleCorseList", CorseList);
		request.setAttribute("RainList", RainList);
		request.setAttribute("TempList", TempList);
		return "/corse/corse.jsp";
	}

}
