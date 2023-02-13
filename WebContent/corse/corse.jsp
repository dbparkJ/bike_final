<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<html>
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<div class="ms-5 py-auto">
			<div class="row gx-5" style="width: 100%; height: 100%;">
				<div class="col">
					<div class="p-1 border bg-light" style="width: 100%; height: 100%;">
						<div class="btn-group ms-3">
							<div class="py-2 text-white">
								<button type="button" class="btn btn-danger dropdown-toggle me-3" data-bs-toggle="dropdown" aria-expanded="false">
										코스 선택
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
							<div class="py-2 ms-3 text-white">
								<button type="button" class="btn btn-danger dropdown-toggle me-3" data-bs-toggle="dropdown" aria-expanded="false">
										주변 정보
								</button>
								<ul class="dropdown-menu dropdown-menu-light">
									<li>
										<div class="d-grid gap-2">
											<button class="btn btn-outline-white" onclick="">네이버 맛집</button>
											<button class="btn btn-outline-white" onclick="">카카오 맛집</button>
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
						<div class="mx-3 pb-3">
							<div class="border"id="map" style="width:100%;height:60%;"></div>
						</div>
						<div class="container-md ms-5">
							<div class="border pt-2 mx-4" style="width:77%;height:33%">
								<canvas id="myChart"></canvas>
							</div>
						</div>
					</div>
				</div>
				<div class="col">
					<div class="p-1 border bg-light" style="width: 100%; height: 100%;">
						
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=17d6d1b98aeed31a6b874f4a6fd6d957"></script>    
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<script type="text/javascript" src="${ctxpath}/static/app/js/paintingMap.js"></script>
</html>