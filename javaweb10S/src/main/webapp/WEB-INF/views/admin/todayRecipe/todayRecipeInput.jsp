<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>todayRecipeInput.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
	 h2 {font-family:'EF_watermelonSalad'; font-weight:bold;}
	 label {font-family:'SUITE-Regular'; font-weight:bold;font-size:16px;}
	 .container {font-weight:bold;}
	 .star {
	    position: relative;
	    font-size: 2rem;
	    color: #ddd;
	  }
	  .star span {
	    width: 0;
	    position: absolute; 
	    left: 0;
	    color: red;
	    overflow: hidden;
	    pointer-events: none;
	  }
	  .star input {
	    width: 100%;
	    height: 100%;
	    position: absolute;
	    left: 0;
	    opacity: 0;
	    cursor: pointer;
	  }
	</style>
	<script>
		'use strict';
		
		function fCheck() {
    	let fName = document.getElementById('article').files[0];
    	let maxSize = 1024 * 1024 * 20; // 최대 20MByte 허용
    	
    	  if(!fName) {
    		alert("업로드할 파일을 선택하세요!");
    		return false;
    	}
    	
    	// 파일 사이즈 처리
    	let ext = fName.name.substring(fName.name.lastIndexOf(".")+1).toUpperCase();
    	
    	if(ext != "JPG" && ext != "JPEG" && ext != "GIF" && ext != "PNG") {
    		alert("업로드 가능한 파일은 'jpg/jpeg/gif/png'확장자 파일입니다.");
    		return false;
    	}
    	if(fName.size > maxSize) {
    		alert("파일의 최대 허용 용량은 20MByte입니다.");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
	</script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">오늘의레시피 등록</h2>
  <hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="35%" />
  <!-- <form name="myform" method="post" enctype="multipart/form-data"> -->
  <form name="myform" method="post" enctype="multipart/form-data">
	  <table class="table table-borderless">
			<tr>
				<td style="text-align: center;">
					<label for="title" class="mr-4" style="font-weight:bold;margin-left:-30px;margin-right:-20px;">제목</label>
					<input type="text" id="title" name="title" class="w3-input w3-border w3-round-xlarge" autofocus required style="width: 220px; margin: 0 auto; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="file" style="font-weight:bold;">내용</label>
					<input type="file" id="article" name="fName" class="form-control-file border w3-input w3-border w3-round-xlarge" accept=".jpg,.jpeg,.gif,.png" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					<div>(업로드 가능파일:jpg, jpeg, gif, png)</div>
				</td>
			</tr>
			<tr>
				<td class="text-center">
					<label for="openSw" class="mr-3" style="font-weight:bold;margin-left:-130px;">공개여부</label>
					<input type="radio" id="openSw" name="openSw" value="OK" checked />&nbsp;공개&nbsp;
	     		<input type="radio" id="openSw" name="openSw" value="NO" />&nbsp;비공개
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="등록" onclick="fCheck()" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="reset" value="재입력" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminContent';" class="w3-button w3-round w3-red" />
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