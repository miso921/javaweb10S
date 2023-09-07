<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>itemDibsList.jsp</title>
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		.container {font-family:'EF_watermelonSalad';}
		h2 {font-family:'SUITE-Regular';}
		.tg-daqm {font-size:22px;width:20;background-color:#cd9750;}
		.tg-wo29 {font-size:18px;width:20;vertical-align:'middle';}
		a:hover {text-decoration:none;color:black;}
	</style>
	<script>
		'use strict';
		
			//if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/recipe/dibsRecipeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
			
			function pageCheck() {
				let pageSize = document.getElementById("pageSize").value;
				location.href = "${ctp}/recipe/dibsRecipeList?pag=${pageVO.pag}&pageSize="+pageSize;
			}
			
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
			
			// 선택항목 레시피 삭제 처리
			function dibsRecipeDeleteCheck() {
				let ans = confirm("선택한 항목을 모두 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	  		let changeItems = "";
	  		for(let i=0; i<myform.chk.length; i++) {
	  			if(myform.chk[i].checked == true) changeItems += myform.chk[i].value + "/";
	  		}
	  		changeItems = changeItems.substring(0,changeItems.length-1);
	  		alert("changeItems :"+changeItems);
	  		//alert("선택된 항목의 목록값? " + changeItems);
	    	
	  		let query = {changeItems : changeItems};
	  		
	    	$.ajax({
	    		type   : "post",
	    		url    : "${ctp}/recipe/dibsRecipeSelectedDelete",
	    		data   : query,
	    		success:function() {
	    			if(changeItems != "" && res == 1) {
		  				alert("선택한 찜한레시피가 삭제되었습니다!");
		  				location.reload();
	    			}
	    			else alert("삭제할 찜한레시피를 선택해주세요!");
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("전송 오류~~");
		    	}
		    });
	    }
			
			// 개별항목 레시피 삭제
			function recipeDelete(idx) {
				let ans = confirm("선택한 찜한레시피를 삭제하시겠습니까?");
				if(!ans) return false;
				else {
					$.ajax({
						type  : "post",
						url   : "${ctp}/recipe/dibsRecipeDelete",
						data  : {recipeIdx : recipeIdx},
						success : function() {
							alert("선택한 찜한레시피가 삭제되었습니다!");
							location.reload();
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
<jsp:include page="/WEB-INF/views/include/logo.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container text-center">
	<form name="myform">
  <div class="row"></div>
  <hr/>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${vos}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${ctp}/recipe/recipeContent?idx=${vo.recipeIdx}">
            <img src="${ctp}/recipe/${fn:split(vo.file,'/')[0]}" width="200px" height="180px"/>
            <div><font color="brown"><b>요리명&nbsp;|&nbsp;&nbsp;</font>${vo.foodName}</b></div>
		       <%--  <span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-signal-3 xi-x"></i>${vo.star}</font></span>&nbsp;&nbsp;
		        <span><font size="3em" color="#9e9e9e" id="ed"><i class="xi-time-o xi-x"></i>${vo.cookTime}</font></span> --%>
          </a>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt % 3 == 0}">
      	</div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
    <div class="container">
      <c:if test="${fn:length(vos) == 0}"><h3>찜한 레시피가 없습니다.</h3></c:if>
    </div>
  </div>
  <hr/>
	  <%-- <div id="content">
	    <br>
	    <h2 class="text-center"><b>찜 한 레 시 피</b></h2>
	    <br>
	    <div class="row borderless m-0 p-0">
	      <div class="text-left mb-2">
	        <!-- 한페이지 분량처리 -->
	        <select name="pageSize" id="pageSize" onchange="pageCheck()" class="form-control-sm">
	          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
	          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
	          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
	          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
	          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
	        </select>
	      </div>
	      <div class="text-right ml-2">
	        <input type="button" value="삭제" id="recipeCheck" onclick="dibsRecipeDeleteCheck()" class="btn btn-outline-warning btn-sm mb-2">
	      </div>
	    </div>
	    
	    
	    
	    ====
	    <table class="table table-hover text-center bordered">
		    <tr class="table-dark text-dark">
		      <th>
		      	<input type="checkbox" id="checkAll" class="form-check-input mr-2">
				    <label for="checkAll">전체</label>
		      </th>
		      <th>레시피명</th>
		    </tr>
		    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
		    <c:forEach var="vo" items="${vos}" varStatus="st">
		      <tr>
		        <td>
		        	<input type="checkbox" class="chk" id="chk" name="chk" value="${vo.idx}" />
		        	<label for="chk">${curScrStartNo}</label>
		        </td>
		        <td class="text-left">
		          <a id="title" href="${ctp}/recipe/recipeContent?idx=${vo.recipeIdx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">
		         	 <img src="${fn:split(vo.file,'/')[0]}" width=90px; class="mb-2" />
		         	 <span><b><font color="brown">요리명&nbsp;|</font>&nbsp;&nbsp;${vo.foodName}</b></span>
		          </a>
		        </td>
		      </tr>
		      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
		    </c:forEach>
		    <tr><td colspan="4" class="m-0 p-0"></td></tr>
		  </table>
			=======	    
	    
	    
	    
	    
	    
			<table class="table table-bordered">
				<tr>
					<th id="all1" class="tg-daqm">
						<input type="checkbox" id="checkAll" class="form-check-input mr-2">
				    <label class="tg-daqm" for="checkAll">전체</label>
					</th>
			    <th id="name1" class="tg-daqm">레시피</th>
				</tr>
					<c:set var="curScrStartNo" value="${pageVO.curScrStartNo}" />
					<c:forEach var="vo" items="${vos}" varStatus="st">
			  	<tr>
			    	<td id="all2" class="tg-wo29">
				    	<input type="checkbox" class="chk" id="chk" name="chk" value="${vo.idx}" />
				    	<label for="chk">${curScrStartNo}</label>
			    	</td>
				    <td id="name2" class="tg-wo29">
				    	<a href="${ctp}/recipe/recipeContent?idx=${vo.recipeIdx}">
				    		<img src="${ctp}/recipe/${fn:split(vo.file,'/')[0]}" width=90px; class="mb-2" />
				    		<div><b><font color="brown">요리명&nbsp;|</font>&nbsp;&nbsp;${vo.foodName}</b></div>
				    	</a>	
			    	</td>
			   </tr>
			   <c:set var="curScrStartNo" value="${curScrStartNo - 1}" />
				 </c:forEach>	
			</table>
			
	    <!-- 블록 페이징 처리 -->
	    <div class="text-center m-4">
	      <ul class="pagination justify-content-center pagination-sm">
	        <c:if test="${pageVO.pag > 1}">
	          <li class="page-item">
	            <a class="page-link text-secondary" href="${ctp}/dibs/recipeDibsList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a>
	          </li>
	        </c:if>
	        <c:if test="${pageVO.curBlock > 0}">
	          <li class="page-item">
	            <a class="page-link text-secondary" href="${ctp}/dibs/recipeDibsList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a>
	          </li>
	        </c:if>
	        <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock * pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	          <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	            <li class="page-item active">
	              <a class="page-link text-white bg-secondary border-secondary" href="${ctp}/dibs/recipeDibsList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a>
	            </li>
	          </c:if>
	          <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	            <li class="page-item">
	              <a class="page-link text-secondary" href="${ctp}/dibs/recipeDibsList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a>
	            </li>
	          </c:if>
	        </c:forEach>
	        <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	          <li class="page-item">
	            <a class="page-link text-secondary" href="${ctp}/dibs/recipeDibsList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a>
	          </li>
	        </c:if>
	        <c:if test="${pageVO.pag < pageVO.totPage}">
	          <li class="page-item">
	            <a class="page-link text-secondary" href="${ctp}/dibs/recipeDibsList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a>
	          </li>
	        </c:if>
	      </ul>
	    </div>
	  </div> --%>
	</form>	
</div>
<p><br/></p>
</body>
</html>