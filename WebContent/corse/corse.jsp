<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
	<head>
		<meta charset="UTF-8">
		<link rel="StyleSheet" type="text/css" href="../static/app/css/map.css">
	</head>
	<body>
	<%-- 	<jsp:include page="/module/modal.jsp"/> --%>
		<div class="border" style="width: 100%; height: 100%;">
			<div class="justify-content-between d-flex" style="height: 95%;">
				<div class="border"id="map" style="width:88%; height: 100%;">
				<div style="position:absolute; z-index:3; left:0">
				<div class="btn-group">
					 <button class="btn btn-danger dropdown-toggle" type="button" data-toggle="dropdown">
                          코스 선택
                      </button>
                      <div class="dropdown-menu overflow-auto" style="height: 500px;">
	    	            <c:forEach var="singleCorse" items="${singleCorseList}">
			               <button class="dropdown-item" keyword = "${singleCorse.name}" onclick="PaintingLine(this.getAttribute('keyword'))">${singleCorse.name}</button> 
		           		 </c:forEach>
                      </div>
				</div>
				<div id="nearInfo" class="btn-group d-none">
                      <button type="button" class="btn btn-danger dropdown-toggle" data-toggle="dropdown">
						주변 정보
					  </button>
						<div class="dropdown-menu dropdown-menu-light"id="menu">
							<button class="dropdown-item" onclick="naverStoreList(singlecorsename,latlon_AVG)">네이버 맛집</button>
							<button class="dropdown-item" onclick="kakaoStoreList(singlecorsename,latlon_AVG)">카카오 맛집</button>
							<button class="dropdown-item" onclick="repairShopList(singlecorsename,latlon_AVG)">수리점</button>
							<button class="dropdown-item" onclick="toiletList(singlecorsename,latlon_AVG)">화장실</button>
						</div>
				 </div>
				<div id="station" class="btn-group d-none">
					<button class="btn btn-danger" onclick="bikeRealTimeList(latlon_AVG)"> 따릉이 정류소</button>
				</div>				 
				 </div>
				</div>
				 <div id="chart" class="category">
					<canvas id="myChart"></canvas>
				 </div>
				<jsp:include page="weather.jsp" flush="false"/>
			</div>
		</div>
		
		
		<div class="modal" id="wtf" tabindex="-1">
	<div class="modal-dialog modal-lg modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					 <div class="row">
					 	<div class="col ms-3" id="store_info">
					 	</div>
					 	<div class="col ms-5">
					 		<figure class="figure" id="main_img"style="width: 20rem;">
								<figcaption class="figure-caption text-end me-1">#키워드1 #키워드2 #키워드3</figcaption>
								<figcaption class="figure-caption text-end me-1"><a href="https://www.naver.com" target="_blank" rel="noopener noreferrer">상세보기</a></figcaption>
							</figure>
					 	</div>
					 </div>
				</div>
				<div class="border mx-3" id="review">
					
				</div>
			</div>
			<div class="modal-footer bg-light">
				<div class="container-center" id="aiRecommand">
				</div>
			</div>
		</div>
	</div>
</div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17d6d1b98aeed31a6b874f4a6fd6d957"></script>    
		<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
		<script type="text/javascript" src="${ctxpath}/static/app/js/paintingMap.js?ver=2"></script>
	</body>
</html>