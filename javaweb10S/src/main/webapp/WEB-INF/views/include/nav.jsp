<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!-- <link rel="stylesheet" href="styles.css" media="screen"> -->
<style>
	.nav-item {font-family:'SUITE-Regular';font-weight:bold;}
	.nav-link, #navbardrop {font-size:1.5em;}
	a {color:black;}
	.dropdown-item {font-size:1.3em;}
	.nav-link:hover {
		cursor:pointer;
	}
	.nav-link {margin:0 10 0 10;}
	 #recipe {margin-left:280px;}
	.navbar {
		height:80px;
	}
</style>
<!-- Navbar -->
<nav class="navbar navbar-expand-sm">
  <ul class="navbar-nav">
	  <!-- Dropdown -->
	  <!-- <li class="nav-item dropdown">
	    <a class="nav-link" id="navbardrop" data-toggle="dropdown">
	      레시피
	    </a>
	    <div class="dropdown-menu">
	      <a class="dropdown-item" href="#">전체</a>
	      <a class="dropdown-item" href="#">나라</a>
	      <a class="dropdown-item" href="#">테마</a>
	    </div>
	  </li> -->
  	<!-- Links -->
    <li class="nav-item">
      <a id="recipe" class="nav-link" href="${ctp}/recipe/recipeList">레시피</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}">요리이야기</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/todayRecipe/todayRecipeList">오늘의레시피</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/shop/itemList">가게</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${ctp}/inquiry/inquiryList">문의</a>
    </li>
  </ul>
</nav>
<hr />