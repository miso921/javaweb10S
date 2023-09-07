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
	 h2 {font-family:'EF_watermelonSalad';font-weight:bold;}
	 .container {font-family:'SUITE-Regular';font-weight:bold;}
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
    
 		// 자료 올리기(등록처리)
    function fCheck() {
    	let fName1 = $("#thumbnail").val();
    	let fName2 = $("#detail").val();
    	let maxSize = 1024 * 1024 * 30;	// 최대 30MByte 허용
    	
    	if(fName1.trim() == "") {
    		alert("대표사진을 선택하세요.");
    		return false;
    	}
    	else if(fName2.trim() == "") {
    		alert("상세내용 파일을 선택하세요.");
    		return false;
    	}
    	
    	// 파일 사이즈 처리..
    	let fileSize = 0;
    	
    	if(fName1 != "" || fName2 != "") {
    		fileSize += document.getElementById('thumbnail').files[0].size;
    		fileSize += document.getElementById('detail').files[0].size;
    	}

    	let ext1 = fName1.substring(fName1.lastIndexOf(".")+1).toUpperCase();
    	let ext2 = fName2.substring(fName2.lastIndexOf(".")+1).toUpperCase();

    	if(ext1 != "JPG" && ext1 != "JPEG" && ext1 != "GIF" && ext1 != "PNG" && ext2 != "JPG" && ext2 != "JPEG" && ext2 != "GIF" && ext2 != "PNG") {
    		alert("업로드 가능한 파일은 'jpg/jpeg/gif/png' 파일입니다.");
    		return false;
    	}
    	
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 30MByte입니다.");
    		return false;
    	}
    	else {
    		// alert("파일사이즈 : " + fileSize);
	    	myform.fileSize.value = fileSize;
	    	myform.submit();
    	}
    }
 
 
    function priceCheck() {
    	let price = $("#price").val();
    	let discountRate = $("#discountRate").val();
    	
    	$("#discount").val(parseInt(price) - (parseInt(price) * parseInt(discountRate) / 100));
    }
    
    const drawStar = (target) => {
		  const starSpan = document.querySelector('.star span');
		  starSpan.style.width = target.value * 10 + '%';
		  
			const starWidth = target.value * 10; // 별점 값에 따라 필요한 데이터 추출
  	};
  </script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container">
  <h2 class="text-center">레시피 등록</h2>
  <hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
  <!-- <form name="myform" method="post" enctype="multipart/form-data"> -->
  <form name="myform" method="post" enctype="multipart/form-data">
  	<table class="table table-borderless">
			<tr>
				<td style="text-align: center;">
					<label for="part" class="mr-4" style="font-weight:bold;margin-left:-260px;">분류</label>
						<select id="part" name="part" class="w3-input w3-border w3-round-xlarge text-center" style="width:100px;margin-left:453px;margin-top:-35px;" autofocus required>
				    	<option value="메인요리">메인요리</option>
				    	<option value="모임요리">모임요리</option>
				    	<option value="반찬">반찬</option>
				    	<option value="간식">간식</option>
				    	<option value="외국요리">외국요리</option>
		    		</select>
					<!-- <input type="text" id="title" name="title" class="w3-input w3-border w3-round-xlarge" autofocus required style="width: 220px; margin: 0 auto; display: inline-block;" /> -->
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="text" style="font-weight:bold;">요리명</label>
					<input type="text" id="foodName" name="foodName" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="text" style="font-weight:bold;">대표사진</label>
					<input type="file" id="thumbnail" name="fName" class="form-control-file border w3-input w3-border w3-round-xlarge" accept=".jpg,.jpeg,.gif,.png" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					<div>(업로드 가능파일:jpg, jpeg, gif, png)</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="text" style="font-weight:bold;margin-left:-100px;margin-right:30px;">난이도</label>
					<span class="star">
		      	★★★★★
		  		<span>★★★★★</span>
		  		<input type="range" name="star" oninput="drawStar(this)" value="5" step="1" min="0" max="10">
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="cookTime" style="font-weight:bold;">조리시간</label>
					<input type="text" id="cookTime" name="cookTime" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="file" style="font-weight:bold;">상세내용</label>
					<input type="file" id="detail" name="fName" class="form-control-file border w3-input w3-border w3-round-xlarge" accept=".jpg,.jpeg,.gif,.png" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					<div>(업로드 가능파일:jpg, jpeg, gif, png)</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="item" style="font-weight:bold;">재료명</label>
					<input type="text" id="item" name="item" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="openSw" class="mr-3" style="font-weight:bold;">공개여부</label>
						<input type="radio" id="openSw" name="openSw" value="OK" checked />&nbsp;공개&nbsp;
	          <input type="radio" id="openSw" name="openSw" value="NO" />&nbsp;비공개
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="등록" onclick="fCheck()" class="w3-button w3-border w3-border-green w3-round" />
					<input type="reset" value="재입력" class="w3-button w3-border w3-border-purple w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminContent';" class="w3-button w3-round w3-red" />
					<input type="hidden" id="fileSize" value="fileSize" />
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