<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>



<body>



<img src="${CompareItem.getItem_img()}">
<img src="${MyItem.getItem_img()}">
${ MyItem.getChartData().size()}

<div style="width:400px; height:400px; float:left;">
    <canvas id="myChart"></canvas>
    안녕
</div>

<div style="width:400px; height:400px; float:left;">
    <canvas id="recommandChart"></canvas>
    안녕2
</div>

<script>
// 우선 컨텍스트를 가져옵니다. 
	var type='radar';
	var labels=['가격','평균별점','기어(단)','바퀴(inch)','무게(kg)'];
	if (${ MyItem.getChartData().size()}>5){
		labels.push("최고속도(km)");
		labels.push("주행거리(km)");
		labels.push("모터출력(km)");
		labels.push("배터리용량(km)");
		labels.push("배터리전압(km)");
		labels.push("충전시간()");
	}
	var myData={
			  labels: labels,
				  datasets: [{
				    label: 'Selected item',
				    data: [65, 59, 90, 81, 56, 55, 40],
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
			  labels: labels,
				  datasets: [{
					    label: 'Recommanded Item',
					    data: [null, 48, 40, 19, 96, 27, 100],
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

</body>
</html>