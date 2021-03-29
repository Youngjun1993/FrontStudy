package com.bitcamp.home;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexCommand implements CommandService {

	// CommandService overriding
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		return "index.jsp"; // 홈으로 보내기
	}

}
