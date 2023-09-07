<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>adminContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/font/font.css"/>
  <style>
  	h2 { font-family: 'EF_watermelonSalad';font-weight:bold;}
  </style>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!--   <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        let data = google.visualization.arrayToDataTable([
            ['일자',  '유입 수'],
            <c:forEach items="${vos}" var="member">
                ['${member.startDate}', ${member.visitCount}],
            </c:forEach>
        ]);

      let options = {
	      chart: {
	        title: '회원가입 날짜별 통계(20일)',
	        /* subtitle: '날짜별 회원가입 수', */
	      },
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
		
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script> -->
  <script>
	  const config = {
		  type: 'bar',
		  data: data,
		  options: {
		    scales: {
		      y: {
		        beginAtZero: true
		      }
		    }
		  },
		};
	  
	  const labels = Utils.months({count: 7});
	  const data = {
	    labels: labels,
	    datasets: [{
	      label: '회원 유입 통계',
	      data: [65, 59, 80, 81, 56, 55, 40],
	      backgroundColor: [
	        'rgba(255, 99, 132, 0.2)',
	        'rgba(255, 159, 64, 0.2)',
	        'rgba(255, 205, 86, 0.2)',
	        'rgba(75, 192, 192, 0.2)',
	        'rgba(54, 162, 235, 0.2)',
	        'rgba(153, 102, 255, 0.2)',
	        'rgba(201, 203, 207, 0.2)'
	      ],
	      borderColor: [
	        'rgb(255, 99, 132)',
	        'rgb(255, 159, 64)',
	        'rgb(255, 205, 86)',
	        'rgb(75, 192, 192)',
	        'rgb(54, 162, 235)',
	        'rgb(153, 102, 255)',
	        'rgb(201, 203, 207)'
	      ],
	      borderWidth: 1
	    }]
	  };
  </script>
	<style>
		/* #c {
			background-size: cover;
		} */
	</style>
</head>
<body>
<p><br /></p>
<div class='container'>
<h2>회원가입 통계</h2>
  <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
</div>
<p><br /></p>
</body>
</html>