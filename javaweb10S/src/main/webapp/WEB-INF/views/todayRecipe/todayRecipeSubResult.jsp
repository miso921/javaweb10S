<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>todayRecipeResult.jsp</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<style>
		container {font-family: 'EF_watermelonSalad';}
		#subOk {font-size: 30px;}
		#send {font-size: 18px;}
		#can {font-size: 15px;color:#db4455;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br /></p>
<div class="container text-center">
	<div><i class="xi-mail-o xi-4x"></i></div>
	<div id="subOk">구독 신청이<br />완료되었습니다</div><br /><hr style="width:50%;text-align:center;margin: 0px auto;" /><br />
	<div id="send"><font color=#db4455;>${mail}</font>&nbsp;로 소식지를 보내드리겠습니다.<br />감사합니다 : )</div>
	<div><input type="button" value="돌아가기" onclick="location.href='${ctp}/todayRecipe/todayRecipeList';" class="w3-button w3-round w3-red mt-4" /></div>
	<div id="can" class="mt-5">📌&nbsp;&nbsp;구독 취소는 문의게시판 혹은 고객센터에 연락주시기 바랍니다.</div>
</div>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>