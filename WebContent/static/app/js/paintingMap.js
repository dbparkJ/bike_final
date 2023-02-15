/*
 *    지도,그래프를 그리기
 */
var mapContainer = document.getElementById('map'), 
mapOption = { 
	        center: new kakao.maps.LatLng(37.57593830595383, 126.81177519319424), // 지도의 중심좌표
	        level: 9 // 지도의 확대 레벨
	    };  
var map = new kakao.maps.Map(mapContainer, mapOption);
var latlon_AVG = [];

var polyline = null;
var path = []; /*위경도를 그리기위한 전역변수*/
var elevList = []; /*고도 그래프를 그리기위한 전역변수*/
var lating =[]; /* 마커의 위경도*/
var title =[]; /*마커의 이름*/
var imageSize = new kakao.maps.Size(24, 35); // 마커 이미지의 이미지 크기 입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
var singlecorsename =''
var naverStoreMarkers =[];

/*마커 이미지주소*/

function PaintingLine(keyword){
	if(latlon_AVG!=null){
		latlon_AVG=[];
		deletematzipmarkers()
		singlecorsename=''
	}
		$.ajax({
		type : "GET",
        url:"../json/corseDatabase_json.jsp?keyword="+keyword,
        dataType:"JSON",
        success: function(data){
					removemap(polyline);
					removegraph(elevList);
					resetMap(keyword);
		        	drawingLine(data);
					polyline.setMap(map);
					creatgraph(data,keyword);
					singlecorsename=keyword
					console.log(singlecorsename)
	        		}
     	});
}

function resetMap(keyword){
	$.ajax({
		type : "GET",
        url:"../json/moveMap.jsp?keyword="+keyword,
        dataType:"JSON",
        success: function(data){
			var bounds = new kakao.maps.LatLngBounds();			
			var moveLatLon = [
				new kakao.maps.LatLng(data[0].LAT_AVG,data[0].LON_AVG),
				new kakao.maps.LatLng(data[0].LAT_MIN,data[0].LON_MIN),
				new kakao.maps.LatLng(data[0].LAT_MAX,data[0].LON_MAX)
			]
			latlon_AVG = [data[0].LON_AVG,data[0].LAT_AVG,data[0].LON_MIN,data[0].LON_MAX,data[0].LAT_MIN,data[0].LAT_MAX];
			for(var i=0; i<moveLatLon.length; i++){
				bounds.extend(moveLatLon[i])
			}
			map.setBounds(bounds);
			}
     	});
}

function drawingLine(data){
	for(var i=0; i<data.length; i++){
    		path.push(new kakao.maps.LatLng(data[i].lat,data[i].lon))
	}
	polyline = 	new kakao.maps.Polyline({
				    path: path, // 선을 구성하는 좌표배열 입니다
				    strokeWeight: 5, // 선의 두께 입니다
				    strokeColor: 'red', // 선의 색깔입니다
				    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
				    strokeStyle: 'dashdot', // 선의 스타일입니다
				    endArrow : true
				});
}

let myLine;//전역변수로 선언
function creatgraph(data,keyword){
	elevList = [];
	if (myLine != undefined){//이미 있으면 myLine 삭제
		myLine.destroy();
	}

	for(var i=0; i<data.length; i++){
		elevList.push(data[i].elev)
	}
	window.chartColors = {
		red: 'rgb(255, 99, 132)',
	};
	var config = {
		type: 'line',
		data: {
			labels: elevList,
			datasets: [{
				label: "(m)",
				backgroundColor: window.chartColors.red,
				borderColor: window.chartColors.red,
				data: elevList,
				fill: false,
			}]
		},
		options: {
			responsive: true,
			title:{
				display:true,
				text: keyword + " 코스"
			},
			tooltips: {
				mode: 'index',
				intersect: false,
			},
			elements:{
				point:{radius:1}
			},
			hover: {
				mode: 'X',
				intersect: true
			},
			scales: {
				xAxes: [{
					display: false,
					scaleLabel: {
						display: false,
						labelString: 'seq'
					}
				}],
				yAxes: [{
					display: true,
					scaleLabel: {
						display: true,
					},
				}]
				}
		}
	};
	
	var ctx = document.getElementById("myChart").getContext("2d");
	var myLine = new Chart(ctx, config);	
}

function removemap(polyline){
	if(polyline != null){
		polyline.setMap(null);
		polyline=null;
		path = [];
	}
}

function removegraph(elevList){
	if(elevList != null){
		elevList =[];
			}
}

/*-----------------------------------------------------------------------------------------------------------*/
function deletematzipmarkers(){
	 for (var i = 0; i < naverStoreMarkers.length; i++) {
	    	naverStoreMarkers[i].setMap(null);
    	}
	naverStoreMarkers=[];
    
}

function drwaingMatzipMarker(data){
	for(var i=0; i<data.length; i++){
		var	marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
	    	});
		
	        /*kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker));*/
    		/*kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); */
    		naverStoreMarkers.push(marker);
	}
}

function naverStoreList(singlecorsename,latlon_AVG){
	console.log('진입',singlecorsename)
	if(naverStoreMarkers.length > 0) {
		deletematzipmarkers()
	}else {
		$.ajax({
				type : "GET",
				url : "../json/naverStoreList.jsp?&corseName="+singlecorsename+
				"&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
				"&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
				dataType : "JSON",
				success : function(data){
					drwaingMatzipMarker(data)
				}
		})
	}
}

function kakaoStoreList(singlecorsename,latlon_AVG){
	console.log('진입',singlecorsename)
	if(naverStoreMarkers.length > 0) {
		deletematzipmarkers()
	}else {
		$.ajax({
				type : "GET",
				url : "../json/kakaoStoreList.jsp?&corseName="+singlecorsename+
				"&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
				"&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
				dataType : "JSON",
				success : function(data){
					drwaingMatzipMarker(data)
				}
		})
	}
}