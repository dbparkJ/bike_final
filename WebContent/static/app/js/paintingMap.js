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
var bikemarkers = [];
var matzipmarkers =[];
var imageSize = new kakao.maps.Size(24, 35); // 마커 이미지의 이미지 크기 입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다

/*마커 이미지주소*/

/**
 *  따릉이 API 최신정보
 */
function RentBikeRecentInfoList(){
	
	if(bikemarkers.length > 0) {
		deletebikemarkers()
	}else {
		$.ajax({
			type : "GET",
			url : "../json/rentBikeInfo_json.jsp",
			dataType : "JSON",
			success : function(data){
				drwaingBikeMarker(data)
			}
		})
	}
}// function-end


function drwaingBikeMarker(data){
	for(var i=0; i<data.length; i++){
		var	marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: new kakao.maps.LatLng(data[i].latlonList.lat,data[i].latlonList.lon), // 마커를 표시할 위치
	        title : data[i].stationName, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    	});
		var infowindow = new kakao.maps.InfoWindow({
        	content: '<div class="py-3 mx-4">'+
        	'<p>'+data[i].stationName+'</p>'+
        	'<p>잔여 거치대 : '+data[i].rackToCnt+'</p>'+
        	'<p>잔여 자전거 : '+data[i].bikeToCnt+'</p>'+
        	'<p> '+'</p>'+
        	'</div>'
        	});
        	kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
    		kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); 	
    		bikemarkers.push(marker);
	}
}

function drwaingMatzipMarker(data){
	for(var i=0; i<data.length; i++){
		var	marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
	    	});data[i].name,data[i].category,data[i].review
		var infowindow = new kakao.maps.InfoWindow({
        	content: '<div class="py-2 mx-2">'+
        	'<p>'+data[i].name+'</p>'+
        	'<p>식당분류 : '+data[i].category+'</p>'+
        	'<p>주소 : '+data[i].addr+'</p>'+
        	'<p>별점 : '+data[i].review+'</p>'+
        	'</div>'
        	
	        });
	        kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
    		kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); 
    		matzipmarkers.push(marker);
	}
}

function deletebikemarkers(){
	 for (var i = 0; i < bikemarkers.length; i++) {
	    	bikemarkers[i].setMap(null);
    	}
	bikemarkers=[];
    
}
function deletematzipmarkers(){
	 for (var i = 0; i < matzipmarkers.length; i++) {
	    	matzipmarkers[i].setMap(null);
    	}
	matzipmarkers=[];
    
}

function PaintingLine(keyword){
	if(latlon_AVG!=null){
		latlon_AVG=[];
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
					/*corseInfowindow()*/
					creatgraph(data,keyword);
	        		}
     	});
}

function resetMap(keyword){
	$.ajax({
		type : "GET",
        url:"../json/moveMap.jsp?keyword="+keyword,
        dataType:"JSON",
        success: function(data){
			console.log(data)
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
				    strokeStyle: 'solid', // 선의 스타일입니다
				    endArrow : true
				});
}

/*function corseInfowindow(){
	kakao.maps.event.addListener(polyline, 'mouseover', function(mouseEvent) {  
    var latlng = mouseEvent.latLng;
    console.log(latlng.toString());         
	});
	kakao.maps.event.addListener(polyline, 'click', function(mouseEvent) {  
    var latlng = mouseEvent.latLng;
    console.log(latlng.toString());         
	});
}*/

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
		orange: 'rgb(255, 159, 64)',
		yellow: 'rgb(255, 205, 86)',
		green: 'rgb(75, 192, 192)',
		blue: 'rgb(54, 162, 235)',
		purple: 'rgb(153, 102, 255)',
		grey: 'rgb(231,233,237)',
		mycolor : 'rgb(75, 192, 192)'
	};
	var config = {
		type: 'line',
		data: {
			labels: elevList,
			datasets: [{
				label: "고도",
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

function matzipList(latlon_AVG){
	if(matzipmarkers.length > 0) {
		deletematzipmarkers()
	}else {
		$.ajax({
				type : "GET",
				url : "../json/matZipList.jsp?&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+"&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
				dataType : "JSON",
				success : function(data){
					drwaingMatzipMarker(data)
					console.log(data)
				}
		})
	}
}

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
