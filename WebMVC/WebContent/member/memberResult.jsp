<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${result==1}">
	<!-- 가입시 -->
	<script>
		location.href = "<%=request.getContextPath()%>/member/login.do";
	</script>
</c:if>
<c:if test="${result==0}">
	<!-- 가입실패시 -->
	<script>
		alert("로그인 실패하였습니다.");
		history.back(); <!-- 이와 같이 보내야 폼에 입력했던 값들이 그대로 남아있게 된다. -->
	</script>
</c:if>