<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
   #menu, footer{display:none;}
   #zipDiv{text-align:center;}
   #zipList>li{height: 40px;}
</style>
<script>
   $(function(){
      $("#zipFrm").submit(function(){
         if($("#doro").val()==""){//도로명을 입력하지 않은경우
            alert("도로명 주소를 입력후 검색하세요");
         }else{
            var url = "<%=request.getContextPath()%>/member/AjaxZipSearch.do";
            //             $("#zipFrm").seialize();
            var params = "doro="+$("#doro").val(); //$("").serialize();도 동일하게 할수있씀
            $.ajax({
               url: url,
               data : params,
               success: function(result){
                  var zipResult = result.split('<hr id="z"/>')
                  $("#zipList").html(zipResult[1]);
               },error:function(){
                  console.log("주소 못가져옴");
               }
            });
         }
         return false;
      });
      //페이지 로딩이 끝난 후 추가된 객체에 대한 이벤트 처리
      //			이벤트종류, 선택자
      $(document).on('click', '#zipList>li',function(){
    	  var zip = $(this).children('.zCode').text();
    	  var addr = $(this).children('.addr').text();
    	  opener.document.getElementById("zipcode").value = zip;
    	  opener.document.getElementById("addr").value = addr;
    	  window.close();
      });
   });
</script>
<div id="zipDiv">
<p>도로명 주소를 입력후 우편번호를 검색하세요....<br/>
   예) 신서로
</p>
   <form method="get" id="zipFrm">
      도로명 주소 : <input type="text" name="doro" id="doro"/>
               <input type="submit" value="주소검색"/>
   </form>
   
   <hr/>
   
   <ul id="zipList">
   	
   </ul>
</div>