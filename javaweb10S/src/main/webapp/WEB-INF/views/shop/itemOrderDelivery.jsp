<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>itemOrderDelivery.jsp</title>
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
		.deliChk {font-family: 'RIDIBatang';}
		#hr1 {border:2px solid #937062;margin-left:auto;margin-right:auto;width:100%;}
		.oi {color:#937062;font-size:20px;}
		.odi {font-size:17px;font-weight:bold;}
		.xi-truck {
   		margin: auto;
    	display: block;
		}
  </style>
</head>
<body>
<div class="container">
<br />
<i class="xi-truck xi-5x text-center"></i><br />
	<h2 class="text-center deliChk">| 배송조회 |</h2>
	<br /><hr id="hr1" /><br />
	<table class="table-borderless" style="margin:auto;">
		<tr>
			<th class="oi">주문자 | </th>
			<td class="odi">${vo.mid}</td>
		</tr>
		<tr>
			<th class="oi">연락처 | </th>
			<td class="odi">${vo.tel}</td>
		</tr>
		<tr>
			<th class="oi">주소 | </th>
			<td class="odi">${vo.address}</td>
		</tr>
		<tr>
			<th class="oi">배송메세지 | </th>
			<td class="odi"> &nbsp;${vo.message}</td>
		</tr>
		<tr>
			<th class="oi">결제수단 | </th>
			<td class="odi">${payMethod} (${fn:substring(vo.payment,1,fn:length(vo.payment))})</td>
		</tr>
		<tr>
			<th class="oi">주문번호 | </th>
			<td class="odi">${vo.orderNum}</td>
		</tr>
	</table>
	<br /><hr />
  <p class="text-center"><input type="button" value="창닫기" onclick="window.close()" class="w3-button w3-ripple w3-brown w-10"/></p>
  <br />
</div>
</body>
</html>