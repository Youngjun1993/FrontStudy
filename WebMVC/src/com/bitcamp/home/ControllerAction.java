package com.bitcamp.home;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// * : 현재 이사이트는 어떤URL으로 접속하던 무조건
@WebServlet("/*.do")
public class ControllerAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//매핑주소와 실행할 Command객체를 보관할 맵
    HashMap<String, CommandService> map = new HashMap<String, CommandService>();
    public ControllerAction() {
        super();
    }
    
	public void init(ServletConfig config) throws ServletException {
		//properties파일명을 web.xml에서 가져오기
		String propertiesFilename = config.getInitParameter("proConfig");
		
		Properties prop = new Properties(); // key:String, value:String
		try {
			FileInputStream fis = new FileInputStream(propertiesFilename);
			//urlMapping.properties파일의 내용을 읽어와 properties객체로 대입한다.
			prop.load(fis);
		}catch(Exception e) {
			System.out.println("프로퍼티 객체 생성 에러 발생-->" + e.getMessage());
		}
		////////////////////////////////////////////////////////////////////////
		try {
			//properties의 키목록 구하기
			Enumeration keyList = prop.propertyNames(); // /*.do	/index.do
			
			while(keyList.hasMoreElements()) {
				//key에 대한 커멘드 클래스명을 가져온다.
				String key = (String)keyList.nextElement();
				String commandName = prop.getProperty(key); // com.bitcamp.home.IndexCommand
				System.out.println(key +"=>"+commandName);
				
				//문자열을 객체로 생성하여 Map추가
				Class classObject = Class.forName(commandName);
				CommandService service = (CommandService)classObject.getDeclaredConstructors()[0].newInstance();
				map.put(key, service);
			}
			
		}catch(Exception e) {
			System.out.println("프로퍼티의 내용을 맵객체로 변환 에러 -->" + e.getMessage());
		}
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//접속자의 url주소를 알아낸다.
		String uri = request.getRequestURI(); // /WebMVC/index.do
		String ctx = request.getContextPath(); // /WebMVC
		System.out.println("uri=>"+uri);
		System.out.println("ctx=>"+ctx);
		
		String urlMapping = uri.substring(ctx.length()); // /index.do
		
		CommandService command = map.get(urlMapping);
		
		String viewFilename = command.processStart(request, response);
		
		//뷰파일로 이동하기
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewFilename);
		dispatcher.forward(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response); //post방식으로 넘어와도 실행은 doGet으로 실행 넘기기
	}

}
