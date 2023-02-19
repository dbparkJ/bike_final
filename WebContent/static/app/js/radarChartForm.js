/**
 * Rada chart 그리기
 */


function ridingData(data,riding_dt){
		$.ajax({
		type : "GET",
        url:"../json/dataScience_json.jsp?riding_dt="+riding_dt,
        dataType:"JSON",
        success: function(data){
				 drawRadarChart(data) // 내 주행거리 분석
	        		}
     	});
}


//======================================================
function drawRadarChart(data){
	var type='radar'
	var labels=['1','2','3','4','5','6','7','8','9','10','11']
	var myData={
			  labels: labels,
				  datasets: [{
				    label: 'Selected item',
				    data: [1,2,1,1,3,1,3,4,2,3,1],
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
	
}
/*
- Chart를 생성하면서, 
- ctx를 첫번째 argument로 넘겨주고, 
- 두번째 argument로 그림을 그릴때 필요한 요소들을 모두 넘겨줍니다. 
*/
