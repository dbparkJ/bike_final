<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctxpath" value="<%=request.getContextPath() %>" />
<html>
<body class="bg-dark">
 
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
	<div class="carousel-indicators">
		<button type="button" data-target="#carouselExampleIndicators" data-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
		<button type="button" data-target="#carouselExampleIndicators" data-slide-to="1" aria-label="Slide 2"></button>
		<button type="button" data-target="#carouselExampleIndicators" data-slide-to="2" aria-label="Slide 3"></button>
	</div>
	<div class="carousel-inner">
		<div class="carousel-item active" data-interval="10000">
			<img src="${ctxpath}/template/bike2.jpg" class="d-block w-100" alt="...">
		</div>
		<div class="carousel-item" data-interval="10000">
			<img src="${ctxpath}/template/bike3.jpg" class="d-block w-100" alt="...">
		</div>
		<div class="carousel-item" data-interval="10000">
			<img src="${ctxpath}/template/bike4.jpg" class="d-block w-100" alt="...">
		</div>
	</div>
	<button class="carousel-control-prev" type="button" data-target="#carouselExampleIndicators" data-slide="prev">
		<span class="carousel-control-prev-icon" aria-hidden="true"></span>
		<span class="visually-hidden"></span>
	</button>
	<button class="carousel-control-next" type="button" data-target="#carouselExampleIndicators" data-slide="next">
		<span class="carousel-control-next-icon" aria-hidden="true"></span>
		<span class="visually-hidden"></span>
	</button>
</div>
</body>
<jsp:include page="/module/bottom.jsp" flush="false"/>
</html>