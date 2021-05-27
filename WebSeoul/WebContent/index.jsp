<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.cutWord{
		white-space: nowrap;
		overflow: hidden;
		text-align: ellipsis;
	}
	#board>h1{
		text-align: center;
		height: 30px;
		line-height: 30px;
	}
	#board>ul>li{
		text-align:center;
		float:left;
		width: 15%;
		height:30px;
		line-height: 30px;
		border-bottom: 1px solid #000;
	}
	#board>ul>li:nth-child(6n+1), #board>ul>li:nth-child(6n+2){
		width:10%
	}
	#board>ul>li:nth-child(6n+3) {
		text-align:left;
		width: 35%;
	}
	#page{
		width:180px;
		margin:0 auto;
	}
	#page>li{
		text-align:center;
		width : 20px;
		height:20px;
		line-height:20px;
		float: left;
		margin:20px 0;
	}
	#page>li:first-child, #page>li:last-child {
		width:40px;
	}
</style>
<script>
	$(function(){
		$("#selectAll").change(function(){
			if($("#selectAll").is(":checked")){
				$("input[type=checkbox]").prop("checked", true);
			}else{
				$("input[type=checkbox]").prop("checked", false);
			}
		});
	});
</script>
<div id="con">
	<!-- bxSlider -->
	<ul id="slider">
		<li><a href="#"><img title="Seoul Music Festival" src="<%=request.getContextPath()%>/images/banner1.jpg" /></a></li>
		<li><a href="#"><img title="SIBAC 2019" src="<%=request.getContextPath()%>/images/banner2.jpg" /></a></li>
		<li><a href="#"><img title="2019서울전환도시 국제컨퍼런스" src="<%=request.getContextPath()%>/images/banner3.jpg" /></a></li>
		<li><a href="#"><img title="2019 다다다 발표대회" src="<%=request.getContextPath()%>/images/banner4.jpg" /></a></li>
		<li><a href="#"><img title="2019서울인공지능챗본론" src="<%=request.getContextPath()%>/images/banner5.jpg" /></a></li>
		<li><a href="#"><img title="서울차 없는 날" src="<%=request.getContextPath()%>/images/banner6.jpg" /></a></li>
		<li><a href="#"><img title="Zero 제로페이 미국 캐나다 이벤트" src="<%=request.getContextPath()%>/images/banner7.jpg" /></a></li>
	</ul>
	
	<div id="board">
		<h1>자유게시판</h1>
		<ul class="clearfix">
			<li><input type="checkbox" name="selectAll" id="selectAll">전체선택</li>
			<li>번호</li>
			<li>제목</li>
			<li>작성자</li>
			<li>작성일</li>
			<li>조회수</li>
			
			<c:forEach var="vo" items="${list}">
				<li><input type="checkbox"></li>
				<li>${vo.no}</li>
				<li class="cutWord">${vo.subject }</li>
				<li>${vo.userid }</li>
				<li>${vo.writedate }</li>
				<li>${vo.hit }</li>
			</c:forEach>
		</ul>
		<div>
			<ul id="page" class="clearfix">
				<c:if test="${pageVO.pageNum>1}">
					<li><a href="<%=request.getContextPath()%>/index.do?pageNum=${pageVO.pageNum-1}">이전</a></li>
				</c:if>
				<c:forEach var="p" begin="${pageVO.startPageNum}" step="1" end="${pageVO.startPageNum + pageVO.onePageNum-1}">
					<c:if test="${p<=pageVO.totalPage}">
						<c:if test="${p==pageVO.pageNum}">
							<li style="background:#ddd"><a href="<%=request.getContextPath()%>/index.do?pageNum=${p}">${p}</a> </li>
						</c:if>
						<c:if test="${p!=pageVO.pageNum}">
							<li><a href="<%=request.getContextPath()%>/index.do?pageNum=${p}">${p}</a></li>
						</c:if>
					</c:if>
				</c:forEach>
				<c:if test="${pageVO.pageNum<pageVO.totalPage}">
					<li><a href="<%=request.getContextPath()%>/index.do?pageNum=${pageVO.pageNum+1}">다음</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
