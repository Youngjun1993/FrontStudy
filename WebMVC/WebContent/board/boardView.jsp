<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	$(function(){
		$("#del").click(function(){
			if(confirm("글을 삭제하시겠습니까?")){
				location.href="<%=request.getContextPath()%>/board/boardDel.do?${delAddr}"; // 글번호, 아이디, 현재페이지, 검색키, 검색어
			}
		});
	});
</script>
<div class="container">
	<h1>글내용보기</h1>
	<ul>
		<li>번호 : ${vo.no}</li>
		<li>작성자 : ${vo.userid}</li>
		<li>등록일 : ${vo.writedate}, 조회수 : ${vo.hit}</li>
		<li>제목 : ${vo.subject}</li>
		<li>${vo.content}</li>
	</ul>
	<div>
		<!--														보고있던 페이지 번호																  -->
		<a href="<%=request.getContextPath()%>/board/list.do?pageNum=${pVO.pageNum}<c:if test="${pVO.searchWord != null && pVO.searchWord!=''}">&searchKey=${pVO.searchKey}&searchWord=${pVO.searchWord}</c:if>">글목록</a>
		<!-- jstl에서는 session에 있는 id를 그냥 불러올 수 있다. -->
		<c:if test="${userid==vo.userid}">
			<a href="<%=request.getContextPath()%>/board/boardEdit.do?${delAddr}">수정</a>
			<span id="del">삭제</span><!-- <a href="javascript:delCheck()">삭제</a>  -->
		</c:if>
	</div>
</div>