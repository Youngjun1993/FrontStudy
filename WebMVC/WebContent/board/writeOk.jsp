<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 글등록 성공시 화면 -->
<c:if test ="${result>0}">
	<script>
		location.href="<%=request.getContextPath()%>/board/list.do";
	</script>
</c:if>
<!-- 글등록 실패시 화면 -->
<c:if test="${result<=0}">
	<script>
		history.back();
	</script>
</c:if>