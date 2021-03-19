<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
    <%
    	request.setCharacterEncoding("UTF-8");//한글 깨짐현상 방지
    
    	String username = request.getParameter("username");
    	String tel = request.getParameter("tel");
    	String addr = request.getParameter("addr");
    	String gender = request.getParameter("gender");
    	
    	String[] hobby = request.getParameterValues("hobby");
    	String[] local = request.getParameterValues("local");
    	
    	String intro = request.getParameter("intro");
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 이름 : <%=username %><br/>
 연락처 : <%=tel %><br/>
 주소 : <%=addr %><br/>
 성별 : <%=gender %><br/>
 관심분야 : <%=Arrays.toString(hobby) %><br/>
 지역 :
 <%
 	for(int i=0; i<local.length; i++){
 		out.write(local[i]+", ");
 	}
 %><br/>
 intro : <%=intro %>
 <hr />
 <h1>이전페이지 parameter이름을 알 수 있다.</h1>
 <ol>
	 <%
	 	//가져오는 속성값의 속성명(name)을 가져온다.(순서 없이 가져옴)
	 	Enumeration<String> e = request.getParameterNames();
	 	while(e.hasMoreElements()){
	 		out.write("<li>"+e.nextElement()+"</li>");
	 	}
	 %>
 </ol>
 <ol>
	 <%
	 	//가져오는 속성값의 속성명(name)을 가져온다.(순서 없이 가져옴)
	 	Enumeration<String> e2 = request.getParameterNames();
	 	while(e2.hasMoreElements()){
 	 %> 
	 	<li><%=e2.nextElement() %></li>
 	 <%
	 	}
	 %>
 </ol>
 <ul>
 	<li>접속자의 컴퓨터 ip : <%=request.getRemoteAddr() %></li>
 	<li>인코딩 코드값 : <%=request.getCharacterEncoding() %></li>
 	<li>ContentType : <%=request.getContentType() %></li>
 	<li>전송방식 : <%=request.getMethod() %></li>
 	<li>프로토콜 : <%=request.getProtocol() %></li>
 	<li>URI : <%=request.getRequestURI() %> -> WebJSP/jsp01_request/formOk.jsp</li>
	<li>contextPath : <%=request.getContextPath() %>->/WebJSP</li>
	<li>서버이름 : <%=request.getServerName() %></li>
	<li>port : <%=request.getServerPort() %></li>
	<!-- 아래는 파일 업로드시 자주 사용하는 메소드다, getRealPath(해당 경로안에(저장??)) -->
	<li>절대주소 : <%=request.getServletContext().getRealPath("/img") %></li> <!--  //getRealPath는 이파일이 실행된 실제 경로를 표시하라는 의미다. "/"는 현재 경로에서 라는 의미다-->
 </ul>
 
</body>
</html>