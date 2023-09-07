<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>todayRecipeSubApli.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
	 h2 {font-family:'EF_watermelonSalad';font-weight:bold;}
	 .container, h2 {font-family: 'EF_watermelonSalad';}
	 .w3-button:hover {color: beige;}
	 .bnts {font-weight: bold;}
	 h2 {font-weight: bolder;}
	 td {margin-left:auto;margin-right:auto;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-3">오늘의레시피 구독 신청</h2>
  <form name="myform" method="post">
	  <table class="table table-borderless">
			<tr>
				<td class="td" style="text-align: center;">
					<label for="mail" class="mr-2" style="font-weight:bold">이메일</label>
					<input type="email" id="mail" name="mail" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td class="td" style="text-align: center;">
					<label for="nickName" class="mr-4" style="font-weight:bold">별명</label>
					<input type="text" id="nickName" name="nickName" class="w3-input w3-border w3-round-xlarge required" style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr class="text-center">
				<td colspan="2" class="bnts">
					<input type="submit" value="확인" class="w3-button w3-border w3-border-green w3-round" />
					<input type="reset" value="재입력" class="w3-button w3-border w3-border-purple w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/todayRecipe/todayRecipeList';" class="w3-button w3-round w3-red" />
				</td>
			</tr>
		</table>
  </form>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>