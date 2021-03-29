package com.bitcamp.home;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandService {
	// viewFile명 리턴				클라이언트->서버			서버->클라이언트
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException;
}
