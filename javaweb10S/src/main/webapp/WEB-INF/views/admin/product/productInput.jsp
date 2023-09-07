<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>productInput.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
		.container {font-family:'SUITE-Regular';}
		h2 {font-family:'EF_watermelonSalad';}
	</style>
  <script>
    'use strict';
    
    function fCheck() {
    	let fName1 = document.getElementById('thumbnail').files[0];
    	let fName2 = document.getElementById('content').files[0];
    	let maxSize = 1024 * 1024 * 20; // 최대 20MByte 허용
    	
    	  if(!fName1 || !fName2) {
    		alert("업로드할 파일을 선택하세요!");
    		return false;
    	}
    	
    	// 파일 사이즈 처리
    	let ext1 = fName1.name.substring(fName1.name.lastIndexOf(".")+1).toUpperCase();
    	let ext2 = fName2.name.substring(fName2.name. lastIndexOf(".")+1).toUpperCase();
    	
    	if(ext1 != "JPG" && ext1 != "JPEG" && ext1 != "GIF" && ext1 != "PNG" && ext2 != "JPG" && ext2 != "JPEG" && ext2 != "GIF" && ext2 != "PNG") {
    		alert("업로드 가능한 파일은 'jpg/jpeg/gif/png'확장자 파일입니다.");
    		return false;
    	}
    	if(fName1.size > maxSize || fName2.size > maxSize) {
    		alert("파일의 최대 허용 용량은 20MByte입니다.");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
    
    function priceCheck() {
    	let price = $("#price").val();
    	let discountRate = $("#discountRate").val();
    	
    	let discountedPrice = parseInt(price) - (parseInt(price) * parseInt(discountRate) / 100);
    	discountedPrice -= discountedPrice % 100; // 10의 자리와 1의 자리를 0으로 만들기 위해 100으로 나눈 나머지를 빼줌
    	
    	$("#discount").val(discountedPrice);
    }
  </script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container">
  <h2 class="text-center"><b>상품등록</b></h2>
  <hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
  <form name="myform" method="post" enctype="multipart/form-data">
	  <table class="table table-borderless">
			<tr>
				<td style="text-align: center;">
					<label for="part" class="mr-4" style="font-weight:bold;margin-left:-260px;">분류</label>
						<select id="part" name="part" class="w3-input w3-border w3-round-xlarge text-center" style="width:100px;margin-left:453px;margin-top:-35px;" autofocus required>
				    	<option value="신선식품">신선식품</option>
				    	<option value="가공식품">가공식품</option>
				    	<option value="주방용품">주방용품</option>
		    		</select>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="productName" style="font-weight:bold;">상품명</label>
					<input type="text" id="productName" name="productName" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="text" style="font-weight:bold;">상품가격</label>
					<input type="text" id="price" name="price" class="form-control-file border w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:18px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="discountRate" style="font-weight:bold;">할인율</label>
		  		<input type="number" name="discountRate" id="discountRate" onblur="priceCheck()" class="w3-input w3-border w3-round-xlarge" style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;">
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="discount" style="font-weight:bold;">할인가격</label>
					<input type="text" id="discount" name="discount" class="w3-input w3-border w3-round-xlarge" required readonly style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="thumbnail" style="font-weight:bold;">대표사진</label>
					<input type="file" id="thumbnail" name="fName1" class="form-control-file border w3-input w3-border w3-round-xlarge" accept=".jpg,.jpeg,.gif,.png" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					<div>&nbsp;&nbsp;(업로드 가능파일:jpg, jpeg, gif, png)</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="content" style="font-weight:bold;">상세내용</label>
					<input type="file" id="content" name="fName2" class="form-control-file border w3-input w3-border w3-round-xlarge" required accept=".jpg,.jpeg,.gif,.png" style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					<div>&nbsp;&nbsp;(업로드 가능파일:jpg, jpeg, gif, png)</div>
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="text" style="font-weight:bold;">재료명</label>
					<input type="text" id="ingredient" name="ingredient" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="openSw" style="font-weight:bold;">공개여부</label>
						<input type="radio" id="openSw" name="openSw" value="OK" checked />공개 &nbsp;
	          <input type="radio" id="openSw" name="openSw" value="NO" />비공개
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