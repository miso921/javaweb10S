<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>밥먹자</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="${ctp}/resources/font/font.css">
	<link rel="stylesheet" href="${ctp}/resources/css/common.css">
	<link rel="stylesheet" href="${ctp}/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/resources/css/owl.theme.default.min.css">
	<script src="${ctp}/resources/js/owl.carousel.js"></script> 
	<script src="${ctp}/resources/js/owl.carousel.min.js"></script>
	<style>
		.item {
			width: 300px;
			heigth: 200px;
		}
		.container {font-family:'EF_watermelonSalad';font-weight:bolder;}
	</style>
</head>
<body>
<!-- logo -->
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<!-- silde show -->
<jsp:include page="/WEB-INF/views/include/slide.jsp" />
===
<c:set var="cnt" value="0"/>
  <c:forEach var="i"  begin="1" end="4">
	  <div class="row">
	    <c:forEach begin="1" end="2">
	      <div class="col mt-3 mb-5">
				    <a href="${ctp}/recipe/recipeContent?idx=${recipeVOS[cnt].idx}">
					    <div class="border" style="width:300px; height: 350px;">
					      <c:set var="file" value="${fn:split(recipeVOS[cnt].file,'/')}"/>
					      <div class="card-body text-left">
					        <span id="en" class="card-text"><font color="black">${recipeVOS[cnt].foodName}</font></span>
					        <br /><font size="3em" color="black" id="ed">분류&nbsp;|&nbsp;${recipeVOS[cnt].part}</font>
					        <br /><font size="3em" color="black" id="ed">난이도&nbsp;|&nbsp;${recipeVOS[cnt].star}</font>
					        <br /><font size="3em" color="black" id="ed">조리시간&nbsp;|&nbsp;${recipeVOS[cnt].cookTime}</font>
					      </div>
					    </div>
				    </a>
				  </div>
				  <c:set var="cnt" value="${cnt + 1}"/>
		  </c:forEach>
	  </div>
  </c:forEach>
===
<div class="w3-container">
  <div class="w3-card-4" style="width:50%">
    <div class="item"><a href="${ctp}/recipeGo?file=${homeImages[0]}"><img src="${ctp}/recipe/${homeImages[0]}" /></a></div>
    <div class="item"><a href="${ctp}/recipeGo?file=${homeImages[1]}"><img src="${ctp}/recipe/${homeImages[1]}" /></a></div>
    <div class="item"><a href="${ctp}/recipeGo?file=${homeImages[2]}"><img src="${ctp}/recipe/${homeImages[2]}" /></a></div>
    <div class="w3-container w3-center">
    <c:forEach var="recipeVO" items="${recipeVOS}">
      <p>${vo.foodName}</p>
    </c:forEach>
    </div>
  </div>
</div>
===

<div class="container">
	<div class="text-right">레시피></div>
	<div class="owl-carousel owl-theme">
    <div class="item"><a href="${ctp}/recipeGo?file=${homeImages[0]}"><img src="${ctp}/recipe/${homeImages[0]}" /></a></div>
    <div class="item"><a href="${ctp}/recipeGo?file=${homeImages[1]}"><img src="${ctp}/recipe/${homeImages[1]}" /></a></div>
    <div class="item"><a href="${ctp}/recipeGo?file=${homeImages[2]}"><img src="${ctp}/recipe/${homeImages[2]}" /></a></div>
	</div>
	<div class="text-right">상품></div>
	<div class="owl-carousel owl-theme">
    <div class="item"><img src="${ctp}/resources/images/paris.jpg" /></div>
    <div class="item"><img src="${ctp}/resources/images/paris.jpg" /></div>
    <div class="item"><img src="${ctp}/resources/images/paris.jpg" /></div>
	</div>
</div>
<p><br /><p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
<script>
	$('.owl-carousel').owlCarousel({
	    stagePadding: 75,
	    loop:true,
	    margin:200,
	    padding:200,
	    nav:true,
	    autoplay:true,
	    autoplayTimeout:0,
	    responsive:{
	        0:{
	            items:1
	        },
	        600:{
	            items:4
	        },
	        1000:{
	            items:5
	        }
	    }
	})
</script>
</body>
</html>
