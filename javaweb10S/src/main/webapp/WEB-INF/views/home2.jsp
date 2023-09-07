<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
	<title>Home.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<link rel="stylesheet" href="${ctp}/resources/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/resources/css/owl.theme.default.min.css">
	<script src="${ctp}/resources/js/owl.carousel.js"></script> 
	<script src="${ctp}/resources/js/owl.carousel.min.js"></script>
  <style>
		.item {
			width: 150px;
			margin: 5px;
		}
	</style>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
<!-- logo -->
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<!-- nav -->
<jsp:include page="/WEB-INF/views/include/nav.jsp" />

<!-- silde show -->
<jsp:include page="/WEB-INF/views/include/slide.jsp" />

<!-- Page content -->
<!-- <div class="container"> -->
	<div class="owl-carousel owl-theme">
	  <div class="item"><img src="${ctp}/resources/images/la.jpg" /></div>
	  <div class="item"><img src="${ctp}/resources/images/la.jpg" /></div>
	  <div class="item"><img src="${ctp}/resources/images/la.jpg" /></div>
	</div>
<!-- </div> -->

<!-- footer -->
<jsp:include page="/WEB-INF/views/include/footer.jsp" />

	<script>
		$('.owl-carousel').owlCarousel({
		    stagePadding: 75,
		    loop:true,
		    margin:0,
		    nav:true,
		    autoplay:true,
		    autoplayTimeout:2000,
		    responsive:{
		        0:{
		            items:1
		        },
		        600:{
		            items:3
		        },
		        1000:{
		            items:5
		        }
		    }
		})
	</script>
</body>
</html>
