<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	#menu,footer{display:none;}
	#zipDiv{text-align: center;}
	#zipList>li {height: 60px;}
</style>
<script>
	$(function(){
		$("#zipFrm").submit(function() {
			if($("#doro").val()=="") {
				/*도로명 주소 미입력상태*/
				alert("도로명주소를 입력 후 검색하세요");
			} else {
				var url = "<%=request.getContextPath()%>/member/AjaxZipSearch.do";
				// $("#zipFrm").serialize(); : fds.jsp?num=12&user=fds < ?뒤 데이터를 만들어줌!
				var params = "doro="+$("#doro").val();
				$.ajax({
					url : url
					, data : params
					, success : function(result){ // 서버에서 가져온 데이터 result에 담김!
						var zipResult = result.split('<hr id="z"/>')
						$("#zipList").html(zipResult[1]);
					}, error : function() {
						console.log("주소 가져오기 실패!!");
					}
				});
			}
			return false;
			// 액션이 실행되지 않게 하기 위해 if나 else에 거칠시에 return false로 반환하도록한다.
		});
		
		// 페이지 로딩이 끝난 후 추가된 객체에 대한 이벤트 처리
		// .on(이벤트종류, 선택자, 실행문구)
		$(document).on('click', '#zipList>li', (function(){
			var zip = $(this).children('.zCode').text();
			var addr = $(this).children('.addr').text();
			// memberForm의 우편번호 자리에 우편번호 넣기
			opener.document.getElementById("zipcode").value = zip;
			opener.document.getElementById("addr").value = addr;
			window.close();
		}));
	});
</script>
<div id="zipDiv">
	<p>도로명 주소를 입력 후 우편번호를 검색하세요<br/>
	예) 백범로</p>
	<form method="get" id="zipFrm">
		도로명 주소 : <input type="text" name="doro" id="doro" />
		<input type="submit" value="주소검색" />
	</form>
</div>
	<hr />
	<ul id="zipList"></ul>
