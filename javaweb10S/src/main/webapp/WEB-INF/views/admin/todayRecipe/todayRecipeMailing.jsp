<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>todayRecipeMailing.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
	 h2, h4 {font-family:'EF_watermelonSalad';font-weight:bold;}
	 .container {font-family:'SUITE-Regular';font-weight:bold;font-size:16px;}
	</style>
	<script>
		'use strict';
		
		// 전체 선택
		$(function() {
			$("#checkAll").click(function() {
				if($("#checkAll").prop("checked")) {
					$(".chk").prop("checked",true);
				}
				else {
					$(".chk").prop("checked",false);
				}
			});
		});
		
		// 선택한 이메일을 #mail에 출력하기
		function mCheck() {
			let selectedEmails = [];
			let checkboxes = document.getElementsByClassName("chk");
			
			for(let i=0; i<checkboxes.length; i++)  {
				if(checkboxes[i].checked) {
					let email = checkboxes[i].parentNode.nextElementSibling.textContent;
					selectedEmails.push(email);
				}
			}
			document.getElementById("mail").value = selectedEmails.join(",");
			$('#myModal').modal('hide');
		}
		
		// 이메일과 보낼 소식지 발송 처리 
		function fCheck() {
			let mail = $("#mail").val();
			let selectedLetter = $("#newsLetter").val();
			
			$.ajax({
				type : "GET",
				url  : "${ctp}/admin/todayRecipe/todayRecipeSend",
				data : {mail : mail, selectedLetter : selectedLetter},
				success : function(res) {
					if(res == 1) {
						alert("소식지가 발송되었습니다!");
						location.reload();
					}
					else if(res == 0) {
						alert("구독하지 않는 이메일이 있습니다!\n다시 한번 확인하세요!");
						location.reload();
					}
				},
				error : function() {
					alert("전송오류!");
				}
			});
		}
		
	</script>
</head>
<body>
<p><br/></p>
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">오늘의레시피 발송</h2>
  <hr style="border:2px solid #937062;margin-left:auto;margin-right:auto;" width="40%" />
  <!-- <form name="myform" method="post" enctype="multipart/form-data"> -->
  <form name="myform" method="post">
	  <table class="table table-borderless">
			<tr>
				<td style="text-align: center;">
					<label for="mail" class="mr-4" style="font-weight:bold;">이메일</label>
					<input type="email" id="mail" name="mail" class="w3-input w3-border w3-round-xlarge mr-2" required style="width: 220px; margin: 0 auto; display: inline-block;" />
					<button type="button" class="w3-button w3-border w3-border-black w3-round" data-toggle="modal" data-target="#myModal">주소록</button>
				</td>
			</tr>
			<tr>
				<td style="text-align:center;">
					<label for="newsLetter" class="" style="font-weight:bold;margin-left:-350px;">발송 소식지</label>
						<select id="newsLetter" name="newsLetter" style="width:250px;height:40px;margin-left:428px;margin-top:-40px;" class="w3-input w3-border w3-round-xlarge">
			    		<option value="" disabled selected>발송할 소식지를 선택하세요</option>
								<c:forEach var="vo" items="${vos}" varStatus="st">
					    		<option value="${vo.title}/${vo.article}">${vo.title}&nbsp;|&nbsp;${fn:substring(vo.issueDate,0,10)}</option>
		    				</c:forEach>
		    		</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="발송" onclick="fCheck()" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="reset" value="재입력" class="w3-button w3-border w3-border-brown w3-round" />
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminContent';" class="w3-button w3-round w3-red" />
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>

<!-- The Modal (주소록) -->
<div class="modal" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">

      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title text-center">주 소 록</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <!-- Modal body -->
      <div class="modal-body">
	      <table class="table table-hover">
			    <tr class="table-dark text-dark">
			      <th>
			      	<input type="checkbox" id="checkAll">
					    <label for="checkAll">전체</label>
			      </th>
			      <th>이메일</th>
				    <th>별명</th>
			    </tr>
			    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
			    <c:forEach var="subVO" items="${subVOS}" varStatus="st">
		      	<tr>
			        <td>
			       	 <input type="checkbox" class="chk" name="chk" id="chk" value="${subVO.idx}" />
			       	 <label for="chk">${curScrStartNo}</label>
			        </td>
			        <td>${subVO.mail}</td>
					    <td>${subVO.nickName}</td>
			      </tr>
			      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
			    </c:forEach>
			    <tr><td colspan="4" class="m-0 p-0"></td></tr>
			  </table>
		  </div>

      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="w3-button w3-round w3-red" onclick="mCheck()">확인</button>
      </div>

    </div>
  </div>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>