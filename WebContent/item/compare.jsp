<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="../static/app/css/compare.css">
</head>
<body>

<div class="card bg-white border-white">
	<div align="center" id="top">
		<div id="img" class="card">
		  <a href="${MyItem.url}">
		  <img src="${MyItem.getItem_img()}" width="550" height="550">
		  </a>
		  <div class="card-body">
		    <p class="card-text fs-4 fw-bold">${MyItem.item_name}</p>
		  </div>
		</div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<div id="img" class="card">
		  <a href="${CompareItem.url}">
		  <img src="${CompareItem.getItem_img()}" width="550" height="550">
		  </a>
		  <div class="card-body">
		    <p class="card-text fs-4 fw-bold">${CompareItem.item_name}</p>
		  </div>
		</div>
	</div>
	
	<div id="menu">
		<span id="menu-name">내구성</span>
		<hr id="hr1">
		<div align="center">
			<div id="menu-img" class="card border-white bg-white">
			  <div>
			  	<img src="bike.png" height="230" width="230" >
			  </div>
			  <div class="card-body">
			    <span class="fs-5">최대속도</span><br>
			    <span class="fs-5">${MyItem.max_speed_km}km</span><br><br>
			    
			    <span class="fs-5">무게</span><br>
			    <span class="fs-5">${MyItem.weight_kg}kg</span><br><br>
			    
			    <c:choose>
			    	<c:when test = "${fn:contains(MyItem.frame, '알루미늄')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">반응성이 좋은 알루미늄</span><br><br>
					</c:when>
					
					<c:when test = "${fn:contains(MyItem.frame, '스틸')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">강도 특성이 뛰어난 스틸</span><br><br>
					</c:when>
					
					<c:when test = "${fn:contains(MyItem.frame, '카본')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">승차감이 좋은 카본</span><br><br>
					</c:when>
					
					<c:when test = "${fn:contains(MyItem.frame, '크로몰리')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">탄성이 좋은 크로몰리</span><br><br>
					</c:when>
					
					<c:otherwise>
						<span class="fs-5">프레임</span><br>
						<span class="fs-5">-</span><br><br>
					</c:otherwise>
				</c:choose>
				
				<span class="fs-5">변속기</span><br>
			    <span class="fs-5">${MyItem.gearbox}</span><br><br>
			    
			  </div>
			</div>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<div id="menu-img" class="card border-white bg-white">
			  <img src="bike.png" height="230" width="230">
			  <div class="card-body">
			    <span class="fs-5">최대속도</span><br> 
			    <span class="fs-5">${CompareItem.max_speed_km}km</span><br><br>
			    
			    <span class="fs-5">무게</span><br>
			    <span class="fs-5">${CompareItem.weight_kg}kg</span><br><br>
			    
   			    <c:choose>
			    	<c:when test = "${fn:contains(CompareItem.frame, '알루미늄')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">반응성이 좋은 알루미늄</span><br><br>
					</c:when>
					
					<c:when test = "${fn:contains(CompareItem.frame, '스틸')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">강도 특성이 뛰어난 스틸</span><br><br>
					</c:when>
					
					<c:when test = "${fn:contains(CompareItem.frame, '카본')}">
					    <span class="fs-5">프레임</span><br>
					    <span class="fs-5">승차감이 좋은 카본</span><br><br>
					</c:when>
					
					<c:otherwise>
						<span class="fs-5">프레임</span><br>
						<span class="fs-5">-</span><br><br>
					</c:otherwise>
				</c:choose>
				
				<span class="fs-5">변속기</span><br>
			    <span class="fs-5">${CompareItem.gearbox}</span><br><br>
			    
			  </div>
			</div>
		</div>
	</div>
</div>

<div class="hstack gap-3" style="width=500px;">
	<div>
    	<canvas id="myChart" style="display: block; height: 450; width: 450;"></canvas>
    	<canvas id="recommandChart" style="display: block; height: 450; width: 450;"></canvas>
    </div>
</div>



<script>
// 우선 컨텍스트를 가져옵니다. 
   var labels=['가격','평균별점','기어(단)','바퀴(inch)','무게(kg)']
   var type='radar'

   var myData=${MyItemChartData}
   var recommandData=${CompareItemChartData}
   
   var myLabels=${MyItemChartLabel}
   var recommandLabel=${CompareItemChartLabel}
   
   var myData={
           labels: myLabels,
              datasets: [{
                label: 'Selected item',
                data: myData,
                fill: true,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgb(255, 99, 132)',
                pointBackgroundColor: 'rgb(255, 99, 132)',
                pointBorderColor: '#fff',
                pointHoverBackgroundColor: '#fff',
                pointHoverBorderColor: 'rgb(255, 99, 132)'
              }]
      }
   var recommandData={
           labels: recommandLabel,
              datasets: [{
                   label: 'Recommanded Item',
                   data: recommandData,
                   fill: true,
                   backgroundColor: 'rgba(54, 162, 235, 0.2)',
                   borderColor: 'rgb(54, 162, 235)',
                   pointBackgroundColor: 'rgb(54, 162, 235)',
                   pointBorderColor: '#fff',
                   pointHoverBackgroundColor: '#fff',
                   pointHoverBorderColor: 'rgb(54, 162, 235)'
                 }]
      }
      
   

   var myConfig = {
      type: type,
      data: myData
   };
   
   var recommandConfig = {
         type: type,
         data: recommandData
      };
   
   
   
   
   var ctx1 = document.getElementById("myChart").getContext("2d");
   var myRadar1 = new Chart(ctx1, myConfig);
   
   var ctx2 = document.getElementById("recommandChart").getContext("2d");
   var myRadar2 = new Chart(ctx2, recommandConfig);
   

/*
- Chart를 생성하면서, 
- ctx를 첫번째 argument로 넘겨주고, 
- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
*/
</script>
</body>
</html>