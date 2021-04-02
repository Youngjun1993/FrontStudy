package com.bitcamp.home.data;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bitcamp.home.CommandService;

public class MultiUploadCommand implements CommandService {

	@Override
	public String precessStart(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		return "/data/multiUploadForm.jsp";
	}

}
