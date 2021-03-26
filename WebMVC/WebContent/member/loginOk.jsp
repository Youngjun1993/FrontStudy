<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- jstl로 세션에 있는 값 가져와서 널값이 아니라면 로그인 성공 페이지로 이동 -->
<c:if test="${userid != null && username != null}">
	<script>
		location.href = "<%=request.getContextPath() %>/index.do";
	</script>
</c:if>
<!-- 로그인 실패시 이동될 페이지 설정 -->
<c:if test="${userid==null || username==null }">
	<script>
		history.back();
	</script>
</c:if>