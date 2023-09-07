<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<title>memberFindMid.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/> 
	<script>
		'use strict';
		
		let str = '';
		function fCheck() {
			let name = $("#name").val();
			let email = $("#mail").val();
			
			$.ajax({
				type : "post",
				url : "${ctp}/member/memberFindMid",
				data : {name:name , email:email},
				success : function(res) {
					if(res == 0) {
						alert("존재하지 않는 회원정보입니다.\n다시 한번 확인해주세요!");
					}
					else {
						str = '<table class="table table-borderless">';
						str += '<tr>';
						str +=	'<td class="td" style="text-align: center;">';
						str +=	'<label for="name" class="mr-4" style="font-weight:bold">아이디 검색결과✔</label>';
						str +=	'<font color="red" size="5em"><b>'+res+'</b></font>';
						str += '</td>';
						str += '</tr>';
						$("#demo").html(str);
					}
				},
				error : function() {
					alert("전송 오류!");
				}
			}); 
		}
	</script>
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
	<h2 class="text-center">아이디 찾기</h2>
	<form name="myform">
		<table class="table table-borderless">
			<tr>
				<td class="td" style="text-align: center;">
					<label for="name" class="mr-4" style="font-weight:bold">성명</label>
					<input type="text" id="name" name="name" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td class="td" style="text-align: center;">
					<label for="mail" class="mr-3" style="font-weight:bold">이메일</label>
					<input type="email" id="mail" name="mail" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td colspan="2" class="bnts">
					<input type="button" value="아이디찾기" onclick="fCheck()" class="w3-button w3-border w3-border-green w3-round" />
					<input type="reset" value="다시입력" class="w3-button w3-border w3-border-purple w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLoginJoin';" class="w3-button w3-round w3-red" />
				</td>
			</tr>
		</table>
	</form>
  <div>
    <span id="demo"></span>
  </div>
</div>	
<P><br /></P>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>