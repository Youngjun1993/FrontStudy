package com.seoul.home;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandService {
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException;
}
