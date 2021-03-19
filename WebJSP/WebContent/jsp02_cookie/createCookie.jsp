<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	document.cookie = "food=pizza;path=/;expires=2021";
	document.cookie = "notice=test";
</script>
</head>
<body>
	<button onclick="location.href='/WebJSP/jsp02_cookie/cookieView.jsp'">쿠키 확인하러가기</button>
</body>
</html>
<%
	//jsp에서 사용자 컴퓨터에 쿠키값 저장하기.
	//						변수, 데이터
	Cookie coo = new Cookie("userid","zerojunee");
	coo.setMaxAge(10*60);//쿠키의 소멸 주기(60 : 초단위/ -1:세션이끝나면 지워라 / 0: 즉시 지워라)
	response.addCookie(coo);
%>