<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	/*가져온 cnt가 1일때, 로그인으로 보낸다.
	가져온 cnt가 0일때 로그인실패 알림, 이전페이지로 돌아감*/
%>

<c:if test="${result==1 }">
	<script>
		location.href="<%=request.getContextPath()%>/member/login.do";
	</script>
</c:if>
<c:if test="${result==0 }">
	<script>
		alert("로그인 실패하였습니다.");
		history.back();
	</script>
</c:if>