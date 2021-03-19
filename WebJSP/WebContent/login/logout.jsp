<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//session 지우기
	session.invalidate();
	//지운 후 재로그인시 새로운 세션ID는 자동으로 할당된다.
	
	response.sendRedirect("/WebJSP"); //request.getContextPath()
	
%>