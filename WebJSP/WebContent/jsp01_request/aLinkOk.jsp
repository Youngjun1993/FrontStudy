<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	//클라이언트의 정보를 서버로 가져오기
    	String username = request.getParameter("username");
    	int num = Integer.parseInt(request.getParameter("num")); // 네트웍을 통해넘어오는 데이터는 무조건 문자로 넘어온다.
    	String tel = request.getParameter("tel");
    	
    	System.out.println("이름="+username);
    	System.out.println("번호="+num);
    	System.out.println("전화번호="+tel);
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	이름: <%=username %><br/>
	번호: <%=num %><br/>
	연락처: <%=tel %><br/>
</body>
</html>