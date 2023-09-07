<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryInput.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script type="text/javascript">
	  const drawStar = (target) => {
		  const starSpan = document.querySelector('.star span');
		  starSpan.style.width = target.value * 10 + '%';
		  
			const starWidth = target.value * 10; // 별점 값에 따라 필요한 데이터 추출
		};
	</script>
	<style type="text/css">
	  th {
	    background-color: #ddd;
	    text-align: center;
	  }
    .imgs_wrap {
        width: 600px;
        margin-top: 50px;
    }
    .imgs_wrap img {
        max-width: 200px;
    }
    	 .star {
	    position: relative;
	    font-size: 2rem;
	    color: #ddd;
	  }
	  .star span {
	    width: 0;
	    position: absolute; 
	    left: 0;
	    color: orange;
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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/logo.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<form name="myForm" method="post" enctype="multipart/form-data">
		<br/>
		<table class="table table-bordered">
			<tr>
				<td colspan="2" class="text-center" style="background-color:#BDBDBD;font-size:20px;">후기</td>
			</tr>
			<tr>
				<th>별점</th>
				<td>
					<span class="star">
		      	★★★★★
		  		<span>★★★★★</span>
		  		<input type="range" name="star" oninput="drawStar(this)" value="5" step="1" min="0" max="10" />
				</td>
			</tr>
			<tr> 
				<th>상품명</th>
				<td>${vo.productName}</td>
			</tr>
			<tr> 
				<th>내용</th>
				<td><textarea class="form-control" name="content" required></textarea></td>
			</tr>
			<tr>
				<th>사진첨부</th>
				<td>
					<input type="file" id="file" name="file" class="form-control-file border w3-input w3-border w3-round-xlarge" accept=".jpg,.jpeg,.gif,.png" multiple style="width: 250px; margin: 0 auto; margin-left:20px; display: inline-block;" />
					<div>(업로드 가능파일:jpg, jpeg, gif, png)</div>
				</td>
			</tr>
			<!-- <tr> 
				<th>이미지</th>
				<td>
					input type="file"에서의 name은 DB명과 VO이름은 같은 이름을 사용하지만 이곳에서의 name은 다르게 줘야 한다.
					<input type="file" multiple="multiple" name="file" id="file" accept=".zip,.jpg,.gif,.png"/><br/><br/>
					<input type="file" name="file" id="file" accept=".zip,.jpg,.jpeg,.gif,.png"/><br/><br/>
					- 파일 형식은 zip,jpg,jpeg,gif,png만 허용합니다.
				</td>
			</tr> -->
			<%-- <c:if test="${!empty vo.fSName}">
				<tr><th class="m-0 p-0"></th><td class="m-0 p-0"><span class="imgs_wrap"> &nbsp; - 선택하신 이미지가 출력됩니다.</span></td></tr>
			</c:if> --%>
		</table>
		<div class="text-center">
			<input type="submit" value="등록" class="w3-button w3-ripple w3-brown"/> &nbsp;
	    <input type="reset" value="재입력" class="w3-button w3-border w3-border-brown w3-round"/> &nbsp;
	    <input type="button" value="돌아가기" onclick="location.href='${ctp}/item/itemList?pag=${pageVo.pag}';" class="w3-button w3-border w3-border-black w3-round"/>
		</div>
		<p><br/></p>
		<input type="hidden" name="mid" value="${sMid}"/>
		<input type="hidden" name="productIdx" value="${vo.idx}"/>
		<input type="hidden" name="productName" value="${vo.productName}"/>
	</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>