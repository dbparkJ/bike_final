<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div align="center">
		<div id="img" class="card" style="width: 18rem;">
		  <img src="${CompareItem.getItem_img()}" class="card-img-top">
		  <div class="card-body">
		    <p class="card-text">${CompareItem.item_name}</p>
		  </div>
		</div>
		<div id="img" class="card" style="width: 18rem;">
		  <img src="${MyItem.getItem_img()}" class="card-img-top" alt="...">
		  <div class="card-body">
		    <p class="card-text">${MyItem.item_name}</p>
		  </div>
		</div>
	</div>
	
	<div id="menu1">
		<span id="menu1-name">내구성</span>
		<hr id="hr1">
		<div id="menu1-img">
			<img src="bike.png" height="200" width="200">
		</div>
	</div>
</div>
<div class="hstack gap-3" style="width=500px;">
	<div id="chart">
    	<canvas id="myChart"></canvas>
    	<canvas id="recommandChart"></canvas>
    </div>
</div>
	<div align="center">
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