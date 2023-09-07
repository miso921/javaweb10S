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
	 <script>
	  'use strict';
	  
	  function dibsCheck(idx) {
	  	//location.href = "${ctp}/recipe/recipeDibs?idx="+idx;  // 일반처리... 아래는 aJax처리
	  	
	  	$.ajax({
	  		type  : "POST",
	  		url   : "${ctp}/recipe/recipeDibs",
	  		data  : {idx : idx},
	  		success : function(res) {
	  			if(res == 1){
		  			//alert("레시피가 찜한 목록에 추가되었습니다.");
		  			$("#heartIcon").html("<i class='xi-check xi-x'></i>");
	  			}
	  			else if(res == 0) {
	  				//alert("레시피 찜하기가 취소되었습니다.");
		  			$("#heartIcon").html("<i class='xi-heart-o xi-x'></i>");
	  			}
	  			//location.reload();
	  		},
	  		error : function() {
	  			alert("전송 오류!");
	  		}
	  	});
	  	
		}

	</script>
</head>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
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
	  	<h3>
	  		${recipeVO.foodName}
  			<a href="javascript:dibsCheck(${recipeVO.idx})">
        	<span id="heartIcon">
			  		<c:if test="${empty vo}"><i class="xi-heart-o xi-x"></i></c:if>
		  		  <c:if test="${!empty vo}"><i class="xi-check xi-x"></i></c:if>
      		</span>
      	</a>
  		</h3>
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