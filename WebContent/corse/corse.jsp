<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="StyleSheet" type="text/css" href="../static/app/css/map.css">
	</head>
	<body>
		<jsp:include page="/module/modal.jsp" flush="false"/>
		<div class="border bg-light" style="width: 100%; height: 100%;">
<div class="btn-group ms-5">
	<div class="py-2 text-white">
		<button type="button" class="btn btn-danger dropdown-toggle me-3" data-bs-toggle="dropdown" aria-expanded="false">
				코스 선택
		</button>
		<ul class="dropdown-menu dropdown-menu-light">
			<li><a class="dropdown-item">서울근교</a></li>
			<li><hr class="dropdown-divider"></li>
			<li>
				<c:forEach var="singleCorse" items="${singleCorseList}">
					<div class="card" style="width: 18rem;">
					  <img src="${singleCorse.item_img}" class="card-img-top" alt="...">
					  <div class="card-body">
					    <h5 class="card-title">Card title</h5>
					    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
					    <a href="#" class="btn btn-primary">Go somewhere</a>
					  </div>
					</div>	
				</c:forEach>
			</li>
		</ul>
	</div>
	<div class="py-2 ms-3 text-white">
		<button type="button" class="btn btn-danger dropdown-toggle me-3" data-bs-toggle="dropdown" aria-expanded="false">
				주변 정보
		</button>
		<ul class="dropdown-menu dropdown-menu-light">
			<li>
				<div class="d-grid gap-2">
					<button class="btn btn-outline-white" onclick="naverStoreList(singlecorsename,latlon_AVG)">네이버 맛집</button>
					<button class="btn btn-outline-white" onclick="kakaoStoreList(singlecorsename,latlon_AVG)">카카오 맛집</button>
					<button class="btn btn-outline-white" onclick="repairShopList(singlecorsename,latlon_AVG)">수리점</button>
					<button class="btn btn-outline-white" onclick="toiletList(singlecorsename,latlon_AVG)">화장실</button>
				</div>
			</li>
		</ul>
	</div>
	<div class="py-2 ">
		<button class="btn btn-danger" onclick="bikeRealTimeList(latlon_AVG)"> 따릉이 정류소</button>
	</div>
</div>
			<div class="justify-content-between d-flex" style="height: 93%;">
				<div class="border"id="map" style="width:88%; height: 100%;"></div>
				<div class="navigation">
				</div>
				 <div class="category">
					 <div class="border" style="width:100%;height:100%">
						<canvas id="myChart"></canvas>
					</div>
				 </div>
				<jsp:include page="weather.jsp" flush="false"/>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17d6d1b98aeed31a6b874f4a6fd6d957"></script>    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<script type="text/javascript" src="${ctxpath}/static/app/js/paintingMap.js"></script>
</html>