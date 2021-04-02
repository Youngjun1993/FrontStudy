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


@WebServlet("/*.do")
public class ControllerAction extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// 매핑주소와 실행할 Command 객체를 보관할 맵
	HashMap<String, CommandService> map = new HashMap<String, CommandService>();
       
    public ControllerAction() {
        super();
        
    }

	public void init(ServletConfig config) throws ServletException {
		// properties 파일명을 web.xml에서 가져오기
		String propertiesFileName  = config.getInitParameter("proConfig");
		
		Properties prop = new Properties();
		try {
			// 파일읽어오기
			FileInputStream fis = new FileInputStream(propertiesFileName);
			// urlMapping.properties 파일내용을 읽어와서 prop(properties객체)로 넘겨주기
			prop.load(fis);
			// prop에 넘겨진 내용은 key , value 모두 string이다.
		} catch(Exception e) {
			System.out.println("프로퍼티 객체 생성 에러 발생!!");
			e.printStackTrace();
		} 
		try {
			// properties의 키 목록 구하기
			Enumeration keyList = prop.propertyNames(); // /*.do /index.do
			
			while(keyList.hasMoreElements()) {
				String key = (String)keyList.nextElement();
				// key에 대한 command 클래스명 가져오기
				String commandName = prop.getProperty(key); // com.bitcamp.home.IndexCommand
				System.out.println(key+"와"+commandName);
				
				// 문자열을 객체로 생성하여 Map 추가
				Class classObject = Class.forName(commandName);
				CommandService service = (CommandService)classObject.getDeclaredConstructors()[0].newInstance();
				map.put(key, service);
			}
		} catch(Exception e) {
			System.out.println("프로퍼티의 내용을 맵객체로 변환 중 에러 발생!!!");
			e.printStackTrace();
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 접속자의 url 주소 알아내기
		String uri = request.getRequestURI(); // /WebMVC/index.do
		String ctx = request.getContextPath(); // /WebMVC
		System.out.println("URI="+uri+", CTX="+ctx);
		// ctx길이 이후부터 끝까지 출력하면 value값이 됨~
		String uriMapping = uri.substring(ctx.length());
		CommandService command = map.get(uriMapping);
		String viewFileName = command.precessStart(request, response);
		
		// 뷰파일로 이동하기
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewFileName);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

/*
  클래스를 실행하기위해 web xml 에 매핑
 */