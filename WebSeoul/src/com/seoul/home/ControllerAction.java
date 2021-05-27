package com.seoul.home;

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
     
	HashMap<String, CommandService> map = new HashMap<String, CommandService>();
    public ControllerAction() {
        super();
    }
    public void init(ServletConfig config) throws ServletException {
    	String propFileName = config.getInitParameter("proConfig");
    	
    	Properties prop = new Properties();
    	try {
    		FileInputStream fis = new FileInputStream(propFileName);
    		prop.load(fis); 		
    	}catch(Exception e) {
    		System.out.println("프로퍼티 객체생성 에러 발생~~");
    		e.printStackTrace();
    	}
    	try {
    		Enumeration keyList = prop.propertyNames();
    		
    		while(keyList.hasMoreElements()) {
    			String key = (String)keyList.nextElement();
    			String commandName = prop.getProperty(key);
    			System.out.println(key + "와" +commandName);
    			
    			Class classObject = Class.forName(commandName);
    			CommandService service = (CommandService)classObject.getDeclaredConstructors()[0].newInstance();
    			map.put(key, service);
    			
    		}
    	}catch(Exception e) {
    		System.out.println("프로퍼티의 내용을 맵객체 변환 중 에러~~");
    		e.printStackTrace();
    	}
    	
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String uriMapping = uri.substring(ctx.length());
		CommandService command = map.get(uriMapping);
		String viewFileName = command.precessStart(request, response);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewFileName);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
