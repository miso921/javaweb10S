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
  <title>밥먹자</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <style>
		.container, h4, h3 {font-family:'SUITE-Regular';}
	</style>
</head>
  <script>
	  'use strict';
	  
	  function dibsCheck(idx) {
	  	// location.href = "${ctp}/recipe/recipeDibs?idx=${idx}";  // 일반처리... 아래는 aJax처리
	  	
	  	$.ajax({
	  		type  : "post",
	  		url   : "${ctp}/recipe/recipeDibs",
	  		data  : {idx : idx},
	  		success : function(res) {
	  			if(res == 1){
		  			alert("레시피가 찜한 목록에 추가되었습니다.");
		  			$("#heartIcon").html("<i class='xi-check xi-2x' alt='찜하기'></i>");
	  			}
	  			else if(res == 0) {
	  				alert("레시피 찜하기가 취소되었습니다.");
		  			$("#heartIcon").html("<i class='xi-heart-o xi-2x' alt='찜하기'></i>");
	  			}
	  		},
	  		error : function() {
	  			alert("전송 오류!");
	  		}
	  	});
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="row">
    <div class="col p-3 text-center" style="border:1px solid #ccc">
		  <!-- 상품메인 이미지 -->
		  <div>
		    <img src="${ctp}/recipe/${fn:split(vo.file,'/')[0]}" width="100%" />
		  </div>
		</div>
		<div class="col p-3 text-center">
		  <!-- 레시피 기본정보 -->
		  <div id="iteminfor">
		  	<h3><font color="brown" class="font-weight-bold">요리명&nbsp;|&nbsp;</font>${vo.foodName}</h3>
		  	<h3><font color="brown" class="font-weight-bold">난이도&nbsp;|&nbsp;</font><span style="margin-right:72px;">${vo.star}</span></h3>
		  	<h3><font color="brown" class="font-weight-bold">조리시간&nbsp;|&nbsp;</font><span style="margin-right:10px;">${vo.cookTime}</span></h3>
		  	<!-- <span class="heart">
    			<span id="heartIcon">♥</span>
    			<input type="range" name="love" onclick="toggleHeart()" value="0" />
				</span> -->
				<%-- <a href="javascript:dibsCheck(${vo.idx})">
          <c:if test="${sSw == '1'}"><font color="#f00" size="5">♥</font></c:if>
          <c:if test="${sSw != '1'}"><font color="#000" size="5">♥</font></c:if>
        </a> --%>
				<a href="javascript:dibsCheck(${vo.idx})">
          <span id="heartIcon"><i class="xi-heart-o xi-2x" alt="찜하기"></i></span>
        </a>
		  </div>
		  <br/>
		  <div class="text-right p-2 text-center">
		    <input type="button" value="돌아가기" onclick="location.href='${ctp}/recipe/recipeList';" class="btn btn-warning"/>
		  </div>
		</div>
  </div>
  <br/><br/>
  <!-- 상품 상세설명 보여주기 -->
  <div id="content" class="text-center"><br/>
  	<img src="${ctp}/recipe/${fn:split(vo.file,'/')[1]}" width="900px;">	
  </div>
</div>
<p><br/></p>
</body>
</html>