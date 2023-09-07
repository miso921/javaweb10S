<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberProfileUpload.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  	.container {font-family: "EF_watermelonSalad"; font-size:18px;};
  	h2 {font-family: "EF_watermelonSalad"; font-size:22px;};
  </style>
  <script>
    'use strict';
    
  	function profileUpload() {
  		let maxSize = 1024 * 1024 * 2; // 사진 최대용량은 2MByte
  		let fName = document.getElementById("fName").value;
  		let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase();
  		alert("fName"+fName);
  		if(fName.trim() == "") {
  			childform.photo.value = "pageContext.request.contextPath/member/noimage.jpg";
  		}
  		
  		let fileSize = document.getElementById("fName").files[0].size;
  		
  		if(ext != "JPG" && ext != "JPGE" && ext != "GIF" && ext != "PNG") {
  			alert("업로드 가능한 파일은 'JPG/JPGE/GIF/PNG' 파일입니다.");
  			return false;
  		}
  		else if(fName.indexOf(" ") != -1) {
  			alert("업로드 파일명에 공백을 포함할 수 없습니다!");
  			return false;
  		}
  		else if(fileSize > maxSize) {
  			alert("업로드 파일의 크기는 2MByte를 초과할 수 없습니다.");
  			return false;
  		}
  		else {
  			childForm.submit();
  		}
  	}
    
    
    // 취소를 누르면 noimage 사진 출력 처리X, 취소 누르면 창닫기O
    function closeCheck() {
    	window.close();
    	/* window.opener.document.getElementById("profileImage").innerHTML = "<img src=\"${ctp}/resources/data/member/noimage.jpg\" width=\"200px\" />"; */
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container text-center">
  <h2>프로필 사진 등록</h2>
  <form name="childForm" method="post" enctype="multipart/form-data">
  	<p>
  	  <input type="file" name="fName" id="fName" class="form-file border mr-1" />
  	  <input type="button" value="확인" onclick="profileUpload()" class="btn btn-success btn-sm mr-1" />
  	  <input type="button" value="취소" onclick="closeCheck()" class="btn btn-dark btn-sm" />
			<input type="hidden" name="photo" />
  	</p>
  </form>
</div>
<p><br/></p>
</body>
</html>