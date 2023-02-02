<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body class="mx-5 py-5">
	
		<div class="container-md py-5">
			<div class="border bg-light py-4" style="width: 80%; height: 110%;">
				<div class="btn-group ms-4">
					<div class="py-2 text-white">
						<button type="button" class="btn btn-danger dropdown-toggle me-3" data-bs-toggle="dropdown" aria-expanded="false">
							코스
						</button>
						<ul class="dropdown-menu dropdown-menu-light">
							<li><a class="dropdown-item">서울근교</a></li>
							<li><hr class="dropdown-divider"></li>
							<li>
								<c:forEach var="singleCorse" items="${singleCorseList}">
									<div class="d-grid gap-2">
										<button class="btn btn-outline-white" keyword = "${singleCorse.name}" onclick="PaintingLine(this.getAttribute('keyword'))">${singleCorse.name}</button>
									</div>	
								</c:forEach>
							</li>
						</ul>
					</div>
					<div class="py-2">
						<button class="btn btn-danger" onclick="RentBikeRecentInfoList()"> 따릉이지도</button>
					</div>

					<div class="ms-3 py-2">
						<button class="btn btn-danger" onclick="matzipList(latlon_AVG)"> 주변 맛집</button>
					</div>

				</div>
				<div class="mx-4 pb-3">
	      			<div class="border"id="map" style="width:100%;height:50%;"></div>
				</div>
				<div class="border pt-2 mx-4" style="width:95%;height:40%">
				    <canvas id="myChart"></canvas>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17d6d1b98aeed31a6b874f4a6fd6d957"></script>    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<script type="text/javascript" src="${ctxpath}/static/app/js/paintingMap.js"></script>
</html>