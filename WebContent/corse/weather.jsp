<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" />

<c:forEach var="RainList" items="${RainList}" varStatus="status">
	<div class="row sticky-top" style="width:11.5%; height: 100%;">
		<div class="col">
		<h5 class="text-center"> 주간날씨 </h5>
			<div class="card" style="width: 10rem;">
				<div class="row">
					<div class="hstack">
						<c:choose>
							<c:when test="${RainList.condition_1_am eq '흐림'}">
								<img src="cloudy.jpg" class="ms-2" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_am eq '흐리고 비/눈'}">
								<img src="cloudy.jpg" class="ms-2" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_am eq '구름많고 비/눈'}">
								<img src="cloudy.jpg" class="ms-2" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_am eq '구름많음'}">
								<img src="cloudy.jpg" class="ms-2" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_am eq '맑음'}">
								<img src="cloudy.jpg" class="ms-2" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_am eq '흐리고 비'}">
								<img src="cloudy.jpg" class="ms-2" style="width:60px; height:60px;">
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${RainList.condition_1_pm eq '흐림'}">
								<img src="cloudy.jpg" class="" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_pm eq '흐리고 비/눈'}">
								<img src="cloudy.jpg" class="" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_pm eq '구름많고 비/눈'}">
								<img src="cloudy.jpg" class="" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_pm eq '구름많음'}">
								<img src="cloudy.jpg" class="" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_pm eq '맑음'}">
								<img src="sunny.jpg" class="" style="width:60px; height:60px;">
							</c:when>
							<c:when test="${RainList.condition_1_pm eq '흐리고 비'}">
								<img src="cloudy.jpg" class="" style="width:60px; height:60px;">
							</c:when>
						</c:choose>
					</div>
				</div>
				<div class="card-body text-end">
					<span class="card-text">${TempList[status.index].ltemp_1}℃/${TempList[status.index].htemp_1}℃</span><br>
					<span>${RainList.rain_1_am}%/${RainList.rain_1_pm}%</span><br>
					<span class="card-titler">${onedaysAfter}</span><br>
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
				<div class="card-body text-end">
					<span class="card-text">${TempList[status.index].ltemp_2}℃/${TempList[status.index].htemp_2}℃</span><br>
					<span>${RainList.rain_2_am}%/${RainList.rain_2_pm}%</span><br>
					<span class="card-titler">${twodaysAfter}</span><br>
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