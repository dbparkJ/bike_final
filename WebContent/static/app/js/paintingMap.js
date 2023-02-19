/*
 *    지도,그래프를 그리기
 */
//------------------------------------------------------------------------------------------------
/*
 * 지도를 불러오는데 필요한 전역변수 선언
 */
var mapContainer = document.getElementById('map'), 
mapOption = { 
           center: new kakao.maps.LatLng(37.57593830595383, 126.81177519319424), // 지도의 중심좌표
           level: 9 // 지도의 확대 레벨
       };  
var map = new kakao.maps.Map(mapContainer, mapOption);
//------------------------------------------------------------------------------------------------
var latlon_AVG = [];
var polyline = null;
var path = []; /*위경도를 그리기위한 전역변수*/
var elevList = []; /*고도 그래프를 그리기위한 전역변수*/
var lating =[]; /* 마커의 위경도*/
var title =[]; /*마커의 이름*/
let myLine;//전역변수로 선언
var singlecorsename ='';/*코스의 이름을 받아저장하기 위한 변수*/
var Markers =[];
var infowindow = null;
//------------------------------------------------------------------------------------------------
/**
 * 코스 라인을 그리기
 */
function PaintingLine(keyword){
   if(latlon_AVG!=null){
      latlon_AVG=[];
      removemarkers();
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
                 }
        });
}
/**
 * 맵의 중심을 알아서 최적화 해주는 함수
 */
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
   polyline =    new kakao.maps.Polyline({
                path: path, // 선을 구성하는 좌표배열 입니다
                strokeWeight: 5, // 선의 두께 입니다
                strokeColor: 'red', // 선의 색깔입니다
                strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                strokeStyle: 'solid', // 선의 스타일입니다
                endArrow : true
            });
}
//------------------------------------------------------------------------------------------------
/**
 * 그래프를 그리기
 */
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
         label : {
            display : false
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
               display: false,
               scaleLabel: {
                  display: false,
               },
            }]
            }
      }
   };
   var ctx = document.getElementById("myChart").getContext("2d");
   var myLine = new Chart(ctx, config);   
}
//------------------------------------------------------------------------------------------------
/**
 * remove 하는 함수
 */
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
function removemarkers(){
    for (var i = 0; i < Markers.length; i++) {
          Markers[i].setMap(null);
       }
   Markers=[];
}
//------------------------------------------------------------------------------------------------
/*function drwaingNaverMarker(data){
	var imageSize = new kakao.maps.Size(30, 30); // 마커 이미지의 이미지 크기 입니다
	var imageSrc = "../static/app/img/navermarker.png"; 
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
	for(var i=0; i<data.length; i++){
		var	marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
	        image : markerImage
	    	});
	    var infowindow = new kakao.maps.InfoWindow({
        	content: '<div class="py-2 mx-2">'+
        	'<p>'+data[i].store_name+'</p>'+
        	'<p>식당분류 : '+data[i].cate_c+'</p>'+
        	'<p>주소 : '+data[i].addr+'</p>'+
        	'<p>별점 : '+data[i].naver_star_avg+'</p>'+
        	'<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">'+
        	'Launch demo modal'+
        	'</button>'+
        	'</div>'
	        });
	        kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
	      	$('#exampleModal').on('show.bs.modal', function (event) {
			  var modal = $(this)
			  console.log(data[i].store_name)
			  // 모달 내용에 데이터 삽입
			  modal.find('.modal-body').html(
			    '<p>이름: ' + data[i].store_name + '</p>' +
			    '<p>이메일: ' + data[i].cate_c + '</p>' 
			  )
			});
    		kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow));
    		Markers.push(marker);
    		
	}
}*/

function drwaingNaverMarker(data){
  var imageSize = new kakao.maps.Size(30, 30);
  var imageSrc = "../static/app/img/navermarker.png";
  var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

  for(var i=0; i<data.length; i++){
    var content = '<div class="py-2 mx-2">'+
      '<p>'+data[i].store_name+'</p>'+
      '<p>식당분류 : '+data[i].cate_c+'</p>'+
      '<p>주소 : '+data[i].addr+'</p>'+
      '<p>별점 : '+data[i].naver_star_avg+'</p>'+
      '<p>분류 : '+data[i].cate_c+'</p>'+
      
      //버튼에 data[i] 배열을 담아준다.
      '<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal"'+
      'data-storename="' + data[i].store_name + '"'+
      'data-addr="'+data[i].addr+'"'+
      'data-naver_star_avg="'+data[i].naver_star_avg+'"'+
      'data-naver_review_num="'+data[i].naver_review_num+'"'+
      'data-category="'+data[i].cate_c+'"'+
      'data-naver_url="'+data[i].naver_url+'"'+
      'data-store_id="'+data[i].store_id+'"'+
      '>' +
      '상세보기' +
      '</button>' +
      
      '</div>';
    var marker = new kakao.maps.Marker({
      map: map,
      position: new kakao.maps.LatLng(data[i].lat,data[i].lon),
      image : markerImage
    });
    var infowindow = new kakao.maps.InfoWindow({
      content: content
    });
    kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow));
    Markers.push(marker);
  }
    openNaverModal();
}

function openNaverModal(){
		$('#exampleModal').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
        var storename = button.data('storename');
        var addr = button.data('addr');
        var naver_review_num = button.data('naver_review_num');
        var naver_star_avg = button.data('naver_star_avg');
        var naver_url = button.data('naver_url');
        var category = button.data('category');
        var store_id = button.data('store_id');
        var modal = $(this);
        //타이틀
        modal.find('.modal-header').html(
		'<h2 class="modal-title display-6 ms-3" id="exampleModalLabel">'+storename+'</h2>'+
		'<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>'
		);
        modal.find('#store_info').html(
			'<span class="fs-5">'+category+'</span><br><br>'+
			'<span class="text-break fs-5">주소</span><br>'+
			'<span class="text-break fs-6">'+addr+'</span><br><br>'+
			'<span class="fs-5">리뷰평점 : '+naver_star_avg+'</span><br><br>'+
			'<span class="fs-5">리뷰 : '+naver_review_num+'개</span>'
		);
		
        //이미지
        modal.find('#main_img').html(
			/*'<img src="'+naver_img_url+'" class="figure-img img-thumbnail rounded" alt="...">'*/
			'<img src="https://search.pstatic.net/common/?autoRotate=true&type=w560_sharpen&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20220118_268%2F1642494655979WNKBr_JPEG%2FKakaoTalk_20220117_152141415_07.jpg" class="figure-img img-thumbnail rounded" alt="...">'+
			'<figcaption class="figure-caption text-end me-1">#키워드1 #키워드2 #키워드3</figcaption>'+
			'<figcaption class="figure-caption text-end me-1"><a href="'+naver_url+'" target="_blank" rel="noopener noreferrer" class="text-reset">상세보기</a></figcaption>'
		);
        getNaverReview(store_id,modal);
		
      });
}

function getNaverReview(store_id,modal){
	$.ajax({
            type : "GET",
            url : "../json/naverReivew.jsp?store_id="+store_id,
            dataType : "JSON",
            success : function(data){
				modal.find('#review').empty();
				for(var i=0; i<data.length; i++){
					modal.find('#review').append(
						'<div class="card">'+
						'<div class="card-header">'+
							data[i].naver_nickname+
						'</div>'+
						'<div class="card-body">'+
							'<h5 class="card-title"></h5>'+
							'<p class="card-text text-break">'+data[i].naver_content+'</p>'+
						'</div>'+
						'<div class="card-footer text-muted text-end">'+
							'<span class="me-3"><img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">'+data[i].naver_star+'</span> &nbsp;'+
							'<span>'+data[i].naver_date+'</span>'+
						'</div>'+
						'</div>'
						);
					}
				}
			});
}



function drwaingKakaoMarker(data){
   var imageSize = new kakao.maps.Size(30, 30); // 마커 이미지의 이미지 크기 입니다
   var imageSrc = "../static/app/img/coffee-cup.png"; 
   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
   
   for(var i=0; i<data.length; i++){
      var   marker = new kakao.maps.Marker({
           map: map, // 마커를 표시할 지도
           position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
           image : markerImage
          });
      
           /*kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker));*/
          /*kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); */
          Markers.push(marker);
   }
}

function drwaingToiletMarker(data){
   var imageSize = new kakao.maps.Size(30, 30); // 마커 이미지의 이미지 크기 입니다
   var imageSrc = "../static/app/img/toilets.png"; 
   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
   for(var i=0; i<data.length; i++){
      var   marker = new kakao.maps.Marker({
           map: map, // 마커를 표시할 지도
           position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
           image : markerImage
          });
      
           /*kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker));*/
          /*kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); */
      Markers.push(marker);
   }
}
function repairShopMarker(data){
   var imageSize = new kakao.maps.Size(30, 30); // 마커 이미지의 이미지 크기 입니다
   var imageSrc = "../static/app/img/spanner.png"; 
   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
   for(var i=0; i<data.length; i++){
      var   marker = new kakao.maps.Marker({
           map: map, // 마커를 표시할 지도
           position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
           image : markerImage
          });
      
           /*kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker));*/
          /*kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); */
      Markers.push(marker);
   }
}
function bikeRealTimeMarker(data){
   var imageSize = new kakao.maps.Size(40, 40); // 마커 이미지의 이미지 크기 입니다
   var imageSrc = "../static/app/img/bike-parking.png"; 
   var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); // 마커 이미지를 생성합니다
   for(var i=0; i<data.length; i++){
      var   marker = new kakao.maps.Marker({
           map: map, // 마커를 표시할 지도
           position: new kakao.maps.LatLng(data[i].lat,data[i].lon), // 마커를 표시할 위치
           image : markerImage
          });
      
           /*kakao.maps.event.addListener(marker, 'click', makeOverListener(map, marker));*/
          /*kakao.maps.event.addListener(map, 'click', makeOutListener(infowindow)); */
      Markers.push(marker);
   }
}
//------------------------------------------------------------------------------------------------
function naverStoreList(singlecorsename,latlon_AVG){
   removemarkers()
   if(infowindow != null){
      infowindow.close();
   }else{
      $.ajax({
            type : "GET",
            url : "../json/naverStoreList.jsp?&corseName="+singlecorsename+
            "&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
            "&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
            dataType : "JSON",
            success : function(data){
               drwaingNaverMarker(data)
            }
      })
   }   
}

function kakaoStoreList(singlecorsename,latlon_AVG){
   removemarkers()
   if(infowindow != null){
      infowindow.close();
   }else{
      $.ajax({
            type : "GET",
            url : "../json/kakaoStoreList.jsp?&corseName="+singlecorsename+
            "&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
            "&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
            dataType : "JSON",
            success : function(data){
               drwaingKakaoMarker(data)
            }
      })
   }
}
function toiletList(singlecorsename,latlon_AVG){
   removemarkers()
   if(infowindow != null){
      infowindow.close();
   }else{
      $.ajax({
            type : "GET",
            url : "../json/toiletList.jsp?&corseName="+singlecorsename+
            "&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
            "&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
            dataType : "JSON",
            success : function(data){
               drwaingToiletMarker(data)
            }
      })
   }
}
function repairShopList(singlecorsename,latlon_AVG){
   removemarkers()
   if(infowindow != null){
      infowindow.close();
   }else{
      $.ajax({
            type : "GET",
            url : "../json/repairshop.jsp?&corseName="+singlecorsename+
            "&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
            "&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
            dataType : "JSON",
            success : function(data){
               repairShopMarker(data)
            }
      })
   }
}
function bikeRealTimeList(latlon_AVG){
   removemarkers()
   if(infowindow != null){
      infowindow.close();
   }else{
      $.ajax({
            type : "GET",
            url : "../json/bikeRealTime.jsp?&minlon="+latlon_AVG[2]+"&maxlon="+latlon_AVG[3]+
            "&minlat="+latlon_AVG[4]+"&maxlat="+latlon_AVG[5],
            dataType : "JSON",
            success : function(data){
               bikeRealTimeMarker(data)
            }
      })
   }
}
//------------------------------------------------------------------------------------------------
/**
 * 인포윈도우를 제어하는 함수
 */
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
//------------------------------------------------------------------------------------------------
function requestFlask(){
   $.ajax({
         type : "POST",
         url : "192.168.0.146:5000/recommandItem?item_id="+pass+"&cosine_weight="+pass
   })
}
//------------------------------------------------------------------------------------------------