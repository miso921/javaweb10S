<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminLeft.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<style>
		/* reset */
		html,body{width:100%;height:100%;}
		body{
			position:relative;
			color:#000;
			font-family:'Pretendard-Regular';
			font-weight:bolder;
			background-color:#95b995;
		}
		#collapseOne, #collapseTwo, #collapseThree {
			background-color:#c1cbd4;
		}
		a:hover {
			text-decoration: none;
		}
	</style>
</head>
<p><br /></p>
<body>
<div class="text-center card-hover" id="accordion">
  <h2><a href="${ctp}/admin/adminContent" target="adminContent"><font color="#212121"><b>관리자메뉴</b></font></a></h2>
  <hr/>
  <p><a href="${ctp}/" target="_top" style="color:black;"><i class="fa fa-home fa-lg"></i></a></p>
  <hr/>
  <p><a href="${ctp}/admin/member/adminMemberList" target="adminContent"><font size="4em;" color="black">회원관리</font></a></p>
  <hr/>
  <p><a href="${ctp}/admin/member/adminOrderList" target="adminContent"><font size="4em;" color="black">주문관리</font></a></p>
  <hr/>
  <p><a href="${ctp}/admin/inquiry/inquiryList" target="adminContent"><font size="4em;" color="black">문의관리</font></a></p>
  <hr/>
  <p><a href="${ctp}/admin/review/reviewList" target="adminContent"><font size="4em;" color="black">후기관리</font></a></p>
  <hr/>
  <p><a href="${ctp}/admin/main/mainSetting" target="adminContent"><font size="4em;" color="black">초기화면 설정</font></a></p>
  <hr/>
  <div class="card" style="border:none">
  	<div class="card-header m-0 pt-0 pb-3" style="background-color:#95b995;">
			<a class="card-link" data-toggle="collapse" href="#collapseOne">
				<font size="4em;" color="black">
					상품관리
				</font>	
			</a>  	
  	</div>
  	<div id="collapseOne" class="collapse" data-parent="#accordion">
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/product/productInput" target="adminContent"><font size="3em;" color="black">상품등록</font></a>
  		</div>
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/product/productOptionInput" target="adminContent"><font size="3em" color="black">옵션등록</font></a>
	  	</div>
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/product/productList" target="adminContent"><font size="3em" color="black">상품목록</font></a>
	  	</div>
	  </div>
  <div class="card" style="border:none">
  	<div class="card-header m-0 pt-3 pb-3" style="background-color:#95b995;">
			<a class="card-link" data-toggle="collapse" href="#collapseTwo">
				<font size="4em;" color="black">
					레시피관리
				</font>	
			</a>  	
  	</div>
  	<div id="collapseTwo" class="collapse" data-parent="#accordion">
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/recipe/recipeInput" target="adminContent"><font size="3em;" color="black">레시피등록</font></a>
  		</div>
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/recipe/recipeList" target="adminContent"><font size="3em" color="black">레시피목록</font></a>
	  	</div>
	  </div>
	  <div class="card" style="border:none">
  	<div class="card-header m-0 pt-3 pb-3" style="background-color:#95b995;">
			<a class="card-link" data-toggle="collapse" href="#collapseThree">
				<font size="4em;" color="black">
					오늘의레시피
				</font>	
			</a>  	
  	</div>
  	<div id="collapseThree" class="collapse" data-parent="#accordion">
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/todayRecipe/todayRecipeInput" target="adminContent"><font size="3em;" color="black">오늘의레시피 등록</font></a>
  		</div>
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/todayRecipe/todayRecipeList" target="adminContent"><font size="3em" color="black">오늘의레시피 목록</font></a>
	  	</div>
  		<div class="card-body m-2 p-1">
  			<a href="${ctp}/admin/todayRecipe/todayRecipeMailing" target="adminContent"><font size="3em" color="black">오늘의레시피 메일링</font></a>
	  	</div>
	  </div>
  </div>
</div>
</div>
</body>
<p><br /></p>
</html>