<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainSetting.jsp</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
	h2 {font-family:'EF_watermelonSalad';font-weight:bold;}
	.container {font-family:'SUITE-Regular';font-weight:bold;}
</style>
<script>
	/* function uploadImage() {
	  let file = document.getElementById("img").files[0];
	  let slideImg = document.getElementById("slideImg").value;
	  let itemImg = document.getElementById("itemImg").value;
	  let recipeImg = document.getElementById("recipeImg").value;
	  
	} */
	
	 function fCheck() {
     	let slideName = $("#slideName").val();
     	let todayRecipe = $("#todayRecipe").val();
     	let file = document.getElementById("file").files[0];
    	let maxSize = 1024 * 1024 * 20; // 최대 30MByte 허용
    	
  	  if(slideName == "" || slideName == null) {
	  		alert("슬라이드 위치를 선택하세요!");
	  		return false;
  		}
  	  if(todayRecipe == "" || todayRecipe == null) {
	  		alert("오늘의 레시피 글 제목을 입력하세요!");
	  		return false;
  		}
  	  else if(!file) {
	  		alert("업로드 할 파일을 선택하세요!");
	  		return false;
  	  }
    	
    	// 파일 사이즈 처리
    	let ext = file.name.substring(file.name.lastIndexOf(".")+1).toUpperCase();
    	
    	if(ext != "JPG" && ext != "JPEG" && ext != "GIF" && ext != "PNG") {
    		alert("업로드 가능한 파일은 'jpg/jpeg/gif/png'확장자 파일입니다.");
    		return false;
    	}
    	if(file.size > maxSize) {
    		alert("파일의 최대 허용 용량은 20MByte입니다.");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
   }
	
	// slideName에 사진이 있으면 demo에 출력하기
	function previewChange() {
		let slideName = document.getElementById("slideName");
		let slideNameVal = slideName.options[slideName.selectedIndex].value;
		
		// 선택한 셀렉트값의 슬라이드 이미지 가져오기
		if(slideNameVal !== "" && slideNameVal !== null) {
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/main/mainSettingAjax",
				data : {slideName : slideNameVal},
				success : function(sImg) {
					if(sImg != "") {
						let str = '<img src = "${ctp}/main/'+sImg+'" width="300px" height="200px" />';
						document.getElementById("demo").innerHTML = str;
					}
					else {
						document.getElementById("demo").innerHTML = "";
					}
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
	}
</script>
</head>
<body>
<p><br /></p>
<p><br /></p>
<div class="container">
	<h2 class="text-center">초기화면 슬라이드 이미지 등록</h2>
	<hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="50%" />
	<form name="myform" method="post" enctype="multipart/form-data">
	  <table class="table table-borderless">
			<tr>
				<td style="text-align: center;">
					<label for="slideName" class="mr-4" style="font-weight:bold;margin-left:-260px;">슬라이드 등록 위치</label>
						<select id="slideName" name="slideName" onchange="previewChange()" class="w3-input w3-border w3-round-xlarge text-center" style="width:100px;margin-left:480px;margin-top:-35px;" autofocus required>
							<option value="슬라이드1">슬라이드1</option>
							<option value="슬라이드2">슬라이드2</option>
							<option value="슬라이드3">슬라이드3</option>
		    		</select>
					<!-- <input type="text" id="title" name="title" class="w3-input w3-border w3-round-xlarge" autofocus required style="width: 220px; margin: 0 auto; display: inline-block;" /> -->
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="todayRecipe" style="font-weight:bold;">오늘의레시피 제목(이동할 소식지)</label>
					<input type="text" id="todayRecipe" name="todayRecipe" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="item" style="font-weight:bold;">슬라이드 이미지</label>
					<input type="file" id="file" name="file" class="w3-input w3-border w3-round-xlarge" required style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
				</td>
			</tr>
			<tr>
				<td style="text-align: center;">
					<label for="demo" style="font-weight:bold;">사진 미리보기</label>
					<span id="demo"></span>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="등록" onclick="fCheck()" class="w3-button w3-border w3-border-green w3-round" />
					<input type="reset" value="재입력" class="w3-button w3-border w3-border-purple w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminContent';" class="w3-button w3-round w3-red" />
				</td>
			</tr>
		</table>
	</form>
</div>	
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<p><br /></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>