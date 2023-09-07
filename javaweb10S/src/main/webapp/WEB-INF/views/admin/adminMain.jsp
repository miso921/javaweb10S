<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>밥먹자</title>
	<link rel="stylesheet" href="${ctp}/font/font.css"/>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
      var data = google.visualization.arrayToDataTable([
        ['가입일', '회원 수'],
        <c:forEach var="vo" items="${vos}">
       	 [${vo.startDate},${vo.startMemberCnt}],
        </c:forEach>
      ]);

      var options = {
        chart: {
          title: '회원가입 날짜별 통계',
          subtitle: '날짜별 회원가입 수',
        }
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script>
	<style>
	/* reset */
	html,body{width:100%;height:100%;}
	body{font-family:'Pretendard-Regular';}
	</style>
</head>
	<frameset cols="200px,*">
		<frame src="${ctp}/admin/adminLeft" name="adminLeft" frameborder="0" />
		<frame src="${ctp}/admin/adminContent" name="adminContent" frameborder="0" />
	</frameset>
</head>
<body>
	<h2>회원가입 통계</h2>
  <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
</body>
</html>	
	
