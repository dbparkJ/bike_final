<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
<head>
<meta charset="UTF-8">
<title>데모 그래프</title>
</head>
<body>
<script>
var labels=['가격','평균별점','기어(단)','바퀴(inch)','무게(kg)']
</script>


<div>
<img src="${CompareItem.getItem_img()}">
${CompareItem.getItem_name()}
</div>

<div>
${CompareItemChartLabel}
${CompareItemChartData }
</div>

<div>
<img src="${MyItem.getItem_img()}">
${MyItem.getItem_name()}
</div>


<div>
${MyItemChartLabel}
${MyItemChartData }
</div>




<div style="width:400px; height:400px; float:left;">
    <canvas id="myChart"></canvas>
</div>

<div style="width:400px; height:400px; float:left;">
    <canvas id="recommandChart"></canvas>
</div>

<script>
// 우선 컨텍스트를 가져옵니다. 
	var type='radar'

	var myData=${MyItemChartData }
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