package controller;

import java.io.FileInputStream;
import java.io.IOException;
//Map, HsahMap
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import command.CommandAction; //인터페이스

//컨트롤러 = 서블릿
public class ControllerDispatcher extends HttpServlet{
	//변수
	private Map map=new HashMap(); 
	
	//init() : 초기화 작업
	public void init(ServletConfig config) throws ServletException{
		String path=config.getServletContext().getRealPath("/");
		//WEB-INF/command.properties 작성하고 등록
		
		//web.xml에 컨트롤러 등록
		String pros=path+config.getInitParameter("proFile");
		Properties pp=new Properties();
		FileInputStream ff=null;
		
		try{
			ff=new FileInputStream(pros);
			pp.load(ff);
		}catch(Exception ex){
			System.out.println("파일 읽기 Error"+ex);
		}finally{
			try{
				if(ff!=null){
					ff.close();
				}
			}catch(Exception ex2){}
		}//finally()_end
		
		Iterator keyIter=pp.keySet().iterator();
		
		while(keyIter.hasNext()){
			String key=(String)keyIter.next(); //board/writeForm.do
			String className=pp.getProperty(key); //action.board.WriteFormAction
			
			try{
				Class commandClass=Class.forName(className); // ~~Action을 클래스로 만든다
				Object commandObject=commandClass.newInstance(); //클래스 객체 생성을 해준다
				
				map.put(key, commandObject);
			}catch(Exception ex){
				System.out.println("properties 파일 내용을 클래스로 만드는 중 Error" + ex);
			}
		}//while-end
		
	}//init()-end
	//--------------------------------------------------------------------------------
	// 웹 브라우저에서 요청시 get,post
	//--------------------------------------------------------------------------------
	public void doGet(HttpServletRequest request,HttpServletResponse response)
	throws IOException,ServletException{
		reqPro(request,response); //메서드 호출
	}//doGet()-end
	
	public void doPost(HttpServletRequest request,HttpServletResponse response)
			throws IOException,ServletException{
		reqPro(request,response); //메서드 호출
	}//doPost()-end
	
	//--------------------------------------------------------------------------------
	//사용자 정의 메서드
	private void reqPro(HttpServletRequest request,HttpServletResponse response)
	throws IOException,ServletException{
		String view="";
		CommandAction commandAction=null;
		
		try{
			String uri=request.getRequestURI();
			if(uri.indexOf(request.getContextPath())==0){
				uri=uri.substring(request.getContextPath().length()); //board/writeForm.do
			}//if()-end
			commandAction=(CommandAction)map.get(uri);
			view=commandAction.requestPro(request, response); // "/board/writeForm.jsp"
			
		}catch(Throwable ex){
			throw new ServletException(ex);
		}
		request.setAttribute("CONTENT", view);
		RequestDispatcher rd=request.getRequestDispatcher("/template/template.jsp");
		rd.forward(request, response);
	}
}//class-end