<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" />

<c:forEach var="RainList" items="${RainList}" varStatus="status">
	<div class="row sticky-top mr-4" style="width:8%; height: 95%;">
	
		<div class="col">
			<div class="card" style="width: 9rem;">
			<hr class="ml-3" style="width: 6.5rem;">
				<div class="row">
					<div class="hstack gap-2 ml-1">
						<img src="../static/app/img/weather/${RainList.condition_1_am}.png" class="mx-4" style="width:32px; height:32px;">
						<img src="../static/app/img/weather/${RainList.condition_1_pm}.png" class="mr-5" style="width:32px; height:32px;">
					</div>
				</div>
				<div class="card-body ml-1">
					<span class="card-text-sm-3">${TempList[status.index].ltemp_1}℃</span> &nbsp;&nbsp;&nbsp;
					<span class="card-text-sm-3">${TempList[status.index].htemp_1}℃</span><br>
					<span class="card-text-sm-3 ml-1">${RainList.rain_1_am}%</span> &nbsp;&nbsp;
					<span class="card-text-sm-3 ml-1">${RainList.rain_1_pm}%</span><br>
					<span class="card-titler">${onedaysAfter}</span><br>
					<hr>
				</div>
			</div>
			<div class="card" style="width: 9rem;">
				<div class="row">
					<div class="hstack gap-2 ml-1">
						<img src="../static/app/img/weather/${RainList.condition_2_am}.png" class="mx-4" style="width:32px; height:32px;">
						<img src="../static/app/img/weather/${RainList.condition_2_pm}.png" class="mr-2" style="width:32px; height:32px;">
					</div>
				</div>
				<div class="card-body ml-1">
					<span class="card-text-sm-3">${TempList[status.index].ltemp_2}℃</span> &nbsp;&nbsp;&nbsp;
					<span class="card-text-sm-3">${TempList[status.index].htemp_2}℃</span><br>
					<span class="card-text-sm-3 ml-1">${RainList.rain_2_am}%</span> &nbsp;&nbsp;
					<span class="card-text-sm-3 ml-1">${RainList.rain_2_pm}%</span><br>
					<span class="card-titler">${twodaysAfter}</span><br>
					<hr>
				</div>
			</div>
			<div class="card" style="width: 9rem;">
				<div class="row">
					<div class="hstack gap-2 ml-1">
						<img src="../static/app/img/weather/${RainList.condition_3_am}.png" class="mx-4" style="width:32px; height:32px;">
						<img src="../static/app/img/weather/${RainList.condition_3_pm}.png" class="mr-2" style="width:32px; height:32px;">
					</div>
				</div>
				<div class="card-body ml-1">
					<span class="card-text-sm-3">${TempList[status.index].ltemp_3}℃</span> &nbsp;&nbsp;&nbsp;
					<span class="card-text-sm-3">${TempList[status.index].htemp_3}℃</span><br>
					<span class="card-text-sm-3 ml-1">${RainList.rain_3_am}%</span> &nbsp;&nbsp;
					<span class="card-text-sm-3 ml-1">${RainList.rain_3_pm}%</span><br>
					<span class="card-titler">${threedaysAfter}</span><br>
					<hr>
				</div>
			</div>
			<div class="card" style="width: 9rem;">
				<div class="row">
					<div class="hstack gap-2 ml-1">
						<img src="../static/app/img/weather/${RainList.condition_4_am}.png" class="mx-4" style="width:32px; height:32px;">
						<img src="../static/app/img/weather/${RainList.condition_4_pm}.png" class="mr-2" style="width:32px; height:32px;">
					</div>
				</div>
				<div class="card-body ml-1">
					<span class="card-text-sm-3">${TempList[status.index].ltemp_4}℃</span> &nbsp;&nbsp;&nbsp;
					<span class="card-text-sm-3">${TempList[status.index].htemp_4}℃</span><br>
					<span class="card-text-sm-3 ml-1">${RainList.rain_4_am}%</span> &nbsp;&nbsp;
					<span class="card-text-sm-3 ml-1">${RainList.rain_4_pm}%</span><br>
					<span class="card-titler">${fourdaysAfter}</span><br>
					<hr>
				</div>
			</div>
			<div class="card" style="width: 9rem;">
				<div class="row">
					<div class="hstack gap-2 ml-1">
						<img src="../static/app/img/weather/${RainList.condition_5_am}.png" class="mx-4" style="width:32px; height:32px;">
						<img src="../static/app/img/weather/${RainList.condition_5_pm}.png" class="mr-2" style="width:32px; height:32px;">
					</div>
				</div>
				<div class="card-body ml-1">
					<span class="card-text-sm-3">${TempList[status.index].ltemp_5}℃</span> &nbsp;&nbsp;&nbsp;
					<span class="card-text-sm-3">${TempList[status.index].htemp_5}℃</span><br>
					<span class="card-text-sm-3">${RainList.rain_5_am}%</span> &nbsp;&nbsp;
					<span class="card-text-sm-3">${RainList.rain_5_pm}%</span><br>
					<span class="card-titler">${fivedaysAfter}</span><br>
					<hr>
				</div>
			</div>
			
			
		</div>
	</div>	
</c:forEach>