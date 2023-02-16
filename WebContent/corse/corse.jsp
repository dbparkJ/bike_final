<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
	<head>
		<meta charset="UTF-8">
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
								<div class="d-grid">
									<button class="btn btn-outline-white" keyword = "${singleCorse.name}" onclick="PaintingLine(this.getAttribute('keyword'))">${singleCorse.name}</button>
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
								<button class="btn btn-outline-white" onclick="">수리점</button>
								<button class="btn btn-outline-white" onclick="">화장실</button>
							</div>
						</li>
					</ul>
				</div>
				<div class="py-2 ">
					<button class="btn btn-danger" onclick="RentBikeRecentInfoList()"> 따릉이 정류소</button>
				</div>
			</div>
			<div class="justify-content-between d-flex pb-3" style="height: 60%;">
				<div class="border ms-5"id="map" style="width:85%; height: 100%;"></div>
				<c:forEach var="RainList" items="${RainList}" varStatus="status">
					<div class="row sticky-top" style="width:11.5%; height: 100%;">
						<h5> 주간날씨 </h5>
						<div class="col-5">
							<div class="card" style="width: 10rem;">
								<div class="row">
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_1_am eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_am eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_am eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_am eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_am eq '맑음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_am eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_1_pm eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_pm eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_pm eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_pm eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_pm eq '맑음'}">
												<img src="sunny.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_1_pm eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="card-body">
									<spam class="card-title text-center">${onedaysAfter}</spam><br>
									<spam class="card-text">최저기온 : ${TempList[status.index].ltemp_1}℃</spam><br>
									<spam class="card-text">최고기온 : ${TempList[status.index].htemp_1}℃</spam>
								</div>
							</div>
							<div class="card" style="width: 10rem;">
								<div class="row">
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_2_am eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_am eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_am eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_am eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_am eq '맑음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_am eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_2_pm eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_pm eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_pm eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_pm eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_pm eq '맑음'}">
												<img src="sunny.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_2_pm eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="card-body">
									<spam class="card-title text-center">${twodaysAfter}</spam><br>
									<spam class="card-text">최저기온 : ${TempList[status.index].ltemp_2}℃</spam><br>
									<spam class="card-text">최고기온 : ${TempList[status.index].htemp_2}℃</spam>
								</div>
							</div>
							<div class="card" style="width: 10rem;">
								<div class="row">
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_3_am eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_am eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_am eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_am eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_am eq '맑음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_am eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_3_pm eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_pm eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_pm eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_pm eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_pm eq '맑음'}">
												<img src="sunny.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_3_pm eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="card-body">
									<spam class="card-title text-center">${threedaysAfter}</spam><br>
									<spam class="card-text">최저기온 : ${TempList[status.index].ltemp_3}℃</spam><br>
									<spam class="card-text">최고기온 : ${TempList[status.index].htemp_3}℃</spam>
								</div>
							</div>
							<div class="card" style="width: 10rem;">
								<div class="row">
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_4_am eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_am eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_am eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_am eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_am eq '맑음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_am eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_4_pm eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_pm eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_pm eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_pm eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_pm eq '맑음'}">
												<img src="sunny.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_4_pm eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="card-body">
									<spam class="card-title text-center">${fourdaysAfter}</spam><br>
									<spam class="card-text">최저기온 : ${TempList[status.index].ltemp_4}℃</spam><br>
									<spam class="card-text">최고기온 : ${TempList[status.index].htemp_4}℃</spam>
								</div>
							</div>
							<div class="card" style="width: 10rem;">
								<div class="row">
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_5_am eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_am eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_am eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_am eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_am eq '맑음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_am eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
									<div class="col">
										<c:choose>
											<c:when test="${RainList.condition_5_pm eq '흐림'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_pm eq '흐리고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_pm eq '구름많고 비/눈'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_pm eq '구름많음'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_pm eq '맑음'}">
												<img src="sunny.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
											<c:when test="${RainList.condition_5_pm eq '흐리고 비'}">
												<img src="cloudy.jpg" class="card-img-top img-fluid" style="width:60px; height:60px;">
											</c:when>
										</c:choose>
									</div>
								</div>
								<div class="card-body">
									<spam class="card-title text-center">${fivedaysAfter}</spam><br>
									<spam class="card-text">최저기온 : ${TempList[status.index].ltemp_5}℃</spam><br>
									<spam class="card-text">최고기온 : ${TempList[status.index].htemp_5}℃</spam>
								</div>
							</div>
							
						</div>
					</div>	
				</c:forEach>
			</div>
			<div class="border ms-5" style="width:30%;height:35%">
				<canvas id="myChart"></canvas>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17d6d1b98aeed31a6b874f4a6fd6d957"></script>    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<script type="text/javascript" src="${ctxpath}/static/app/js/paintingMap.js"></script>
</html>