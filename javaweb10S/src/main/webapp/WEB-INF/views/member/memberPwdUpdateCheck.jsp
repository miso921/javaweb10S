<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<title>memberPwdUpdateCheck.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/> 
	<style>
	  .container, h2 {font-family: 'EF_watermelonSalad';}
		.w3-button:hover {color: beige;}
		.bnts {font-weight: bold;}
		h2 {font-weight: bolder;}
		td {margin-left:auto;margin-right:auto;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<P><br /></P>
<div class="container text-center">	
	<h2 class="text-center">비밀번호 확인</h2>
	<hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
	<!-- <form method="get" action="memberPwdUpdate"> -->
	<form method="post">
		<table class="table table-borderless">
			<tr>
				<td class="td" style="text-align: center;">
					<label for="pwd" class="mr-4" style="font-weight:bold">현재 비밀번호</label>
					<input type="password" id="pwd" name="pwd" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="bnts">
					<input type="submit" value="회원정보확인" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="reset" value="다시입력" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMypage';" class="w3-button w3-round w3-red" />
				</td>
			</tr>
		</table>
		<input type="hidden" name="mid" value="${sMid}" />
	</form>
</div>	
<P><br /></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>