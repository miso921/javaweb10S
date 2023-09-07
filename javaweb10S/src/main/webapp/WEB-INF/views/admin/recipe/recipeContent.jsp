<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>recipeContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <style>
		.container, h4, h3 {font-family:'RIDIBatang';}
	</style>
</head>
  <script>
	  'use strict';

	  function recipeDelete(idx) {
		  let ans = confirm("레시피를 삭제하시겠습니까?");
		  
		  if(!ans) location.reload();
		  else {
			 $.ajax({
				 type : "post",
				 url  : "${ctp}/admin/recipe/recipeDelete",
				 data : {idx : idx},
				 success : function() {
				 	alert("레시피가 삭제되었습니다!");
				 	location.href = "${ctp}/admin/recipe/recipeList";
				 },
				 error : function() {
					 alert("전송오류!");
				 }
			 }); 
		  }
	  }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="text-center p-2">
	  <input type="button" value="삭제" onclick="recipeDelete(${recipeVO.idx})" class="w3-button w3-border w3-border-brown w3-round w-25"/>
	  <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/recipe/recipeList';" class="w3-button w3-ripple w3-brown w-25"/>
	</div>
	<div class="row">
	  <div class="col p-3 text-center">
		  <!-- 상품메인 이미지 -->
		  <div>
		    <img src="${ctp}/recipe/${fn:split(recipeVO.file,'/')[0]}" width="650px;"/>
		  </div>
		</div>
	</div>	
	<!-- 레시피 기본정보 -->
	<div class="row">
	  <div class="col p-3 text-left" style="margin-left:230px;">
	  	<h3>${recipeVO.foodName}</h3>
	  	<font size="4em" color="#9e9e9e" style="margin-right:50px;"><i class="xi-signal-3 xi-x mt-2"></i>
	    <!-- 짝수 별 -->
	    <c:if test="${recipeVO.star%2 == 0}">
	    	<c:forEach begin="0" end="4" step="1" varStatus="st" >
	      	<c:if test="${st.index+1 <= recipeVO.star/2}">
	        	<span><img src="${ctp}/images/fullStar.png" width="25px;" /></span>
	        </c:if>
	        <c:if test="${st.index+1 > recipeVO.star/2}">
	        	<span><img src="${ctp}/images/emptyStar.png" width="25px;" /></span>
	        </c:if>
	      </c:forEach>
	    </c:if>
	    <!-- 홀수 별 -->
	    <c:if test="${recipeVO.star%2 != 0}">
	    	<c:set var="str" value="${(recipeVO.star-1)/2}" />
	    	<c:forEach begin="0" end="4" step="1" varStatus="st" >
	     		<c:if test="${st.index+1 <= str}">
	        	<span><img src="${ctp}/images/fullStar.png" width="25px;"/></span>
	        </c:if>
	        <c:if test="${st.index+1 == str+1}">
	        	<span><img src="${ctp}/images/halfStar.png" width="25px;"/></span>
	        </c:if>
	        <c:if test="${st.index+1 > str && st.index+1 != str+1}">
	       		<span><img src="${ctp}/images/emptyStar.png" width="25px;"/></span>
	        </c:if>
				</c:forEach>
	  	</c:if>
	  	</font>
	  	<div><font size="4em" color="#9e9e9e"><i class="xi-time-o xi-x mt-3"></i>&nbsp;${recipeVO.cookTime}</font></div>
	  </div>
	  <br/>
		</div>
	</div>
	<br/><br/>
	<!-- 상품 상세설명 보여주기 -->
	<div id="content" class="text-center"><br/>
		<img src="${ctp}/recipe/${fn:split(recipeVO.file,'/')[1]}">	
	</div>
<p><br/></p>
</body>
</html>