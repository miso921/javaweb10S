<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<style>
	.box-wrap {
		height: 90px;
	}
 	.box-obj {
		flex-direction: row;
		flex-wrap: wrap;
		display: flex;
		align-items: center;
		justify-content: center;
	} 
	#i1, #i2, #i3, #i4, #i5, #i6 {color: black;}
	#i1:hover, #i2:hover, #i3:hover, #i4:hover, #i5:hover, #i6:hover {color:ba55d3;}
	@media (min-width: 250px;) {
	  #searchForm {
	    margin-left:100px;
	 	 }
	}
</style>
<script type="text/javascript">
	function handleSubmit(event) {
	    event.preventDefault(); // 폼 제출 기본 동작 취소 	
	  	searchForm.submit();
	    document.getElementById("searchForm").reset(); // 폼 리셋
	  }
</script>
<!-- Logo -->
<div class="box-wrap">
	<div class="box-wrap">
		<div class="box-obj mt-3">
		  <div> <!--  style="margin-right: auto;" -->
		    <a href="http://49.142.157.251:9090/javaweb10S/"><img src="${ctp}/resources/images/eatLogo.png" width="200px" height="auto" class="mr-5" /></a>
		  </div>
		  
		  <form id="searchForm" name="searchForm" method="post" onsubmit="handleSubmit(event)" action="${ctp}/member/itemSearch">
		  	<input type="text" id="searchString" name="searchString" class="w3-input w3-border w3-round-xlarge mr-3" style="width:250px;" />
		  </form>
		  
		  <a href="javascript:searchCheck()"><i class="xi-search xi-2x mr-5" id="i1"></i></a>
		  <c:if test="${empty sMid}">
		  	<a href="${ctp}/member/memberLoginJoin"><i class="xi-lock xi-2x mr-4" id="i2"></i></a>
		  </c:if>
		  <c:if test="${!empty sMid}">
		  	<a href="${ctp}/member/memberLogout"><i class="xi-unlock xi-2x mr-4" id="i3"></i></a>
		  	<a href="${ctp}/member/memberMypage"><i class="xi-user xi-2x mr-4" id="i4"></i></a>
		  </c:if>
		  	<a href="${ctp}/shop/itemCart"><i class="xi-cart xi-2x mr-4" id="i5"></i></a>
		  <c:if test="${sLevel == 0}">
		  	<a href="${ctp}/admin/adminMain"><i class="xi-cog xi-2x" id="i6"></i></a>
		  </c:if>
		</div>
	</div>	
</div>	