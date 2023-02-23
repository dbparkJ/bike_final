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
   
                  
       $('#nearInfo').removeClass('d-none');
       $('#station').removeClass('d-none');
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
	$('#chart').css('background-color', 'rgba(255, 255, 255, 0.7)')
	
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
function drwaingNaverMarker(data){

  for(var i=0; i<data.length; i++){
	var imageSize = new kakao.maps.Size(40, 40);
	var imageSrc = "../static/app/img/"+data[i].cate_b+".png";
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var content = '<div class="card py-2 mx-2" style="width: 18rem;">'+

      '<img class="ms-2"src="../static/app/img/'+data[i].cate_b+'.png" style="width:256px; height:256px;">'+'<span class="ms-1">'+data[i].store_name+'</span>'+
      '<p>식당분류 : '+data[i].cate_c+'</p>'+
      '<span>주소</span><br>'+
      '<span>'+data[i].addr+'</span>'+
      '<p>별점 : '+data[i].naver_star_avg+'</p>'+
      '<p>분류 : '+data[i].cate_c+'</p>'+
      
      //버튼에 data[i] 배열을 담아준다.
      '<button type="button" class="btn btn-outline btn-primary " data-toggle="modal" data-target="#wtf"'+
      'data-storename="' + data[i].store_name + '"'+
      'data-addr="'+data[i].addr+'"'+
      'data-naver_star_avg="'+data[i].naver_star_avg+'"'+
      'data-naver_review_num="'+data[i].naver_review_num+'"'+
      'data-category="'+data[i].cate_c+'"'+
      'data-naver_url="'+data[i].naver_url+'"'+
      'data-naver_img_url="'+data[i].naver_img_url+'"'+
      'data-category_b="'+data[i].cate_b+'"'+
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
function drwaingKakaoMarker(data){

  for(var i=0; i<data.length; i++){
	var imageSize = new kakao.maps.Size(40, 40);
	var imageSrc = "../static/app/img/"+data[i].cate_b+".png";
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
    var content = '<div class="card py-2 mx-2" style="width: 18rem;">'+

      '<img class="ms-2"src="../static/app/img/'+data[i].cate_b+'.png" style="width:256px; height:256px;">'+'<span class="ms-1">'+data[i].store_name+'</span>'+
      '<p>식당분류 : '+data[i].cate_c+'</p>'+
      '<span>주소</span><br>'+
      '<span>'+data[i].addr+'</span>'+
      '<p>별점 : '+data[i].kakao_star_avg+'</p>'+
      '<p>분류 : '+data[i].cate_c+'</p>'+
      
      //버튼에 data[i] 배열을 담아준다.
      '<button type="button" class="btn btn-outline btn-primary " data-toggle="modal" data-target="#wtf"'+
      'data-storename="' + data[i].store_name + '"'+
      'data-addr="'+data[i].addr+'"'+
      'data-kakao_star_avg="'+data[i].kakao_star_avg+'"'+
      'data-kakao_review_num="'+data[i].kakao_review_num+'"'+
      'data-category="'+data[i].cate_c+'"'+
      'data-kakao_url="'+data[i].kakao_url+'"'+
      'data-kakao_img_url="'+data[i].kakao_img_url+'"'+
      'data-category_b="'+data[i].cate_b+'"'+
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
    openKakaoModal();
}

function openNaverModal(){
	
	$('#wtf').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
	    var storename = button.data('storename');
	    var addr = button.data('addr');
	    var naver_star_avg = button.data('naver_star_avg');
	    var naver_url = button.data('naver_url');
	    var category = button.data('category');
	    var store_id = button.data('store_id');
	    var naver_img_url = button.data('naver_img_url');
	    var category_b = button.data('category_b');
	    var modal = $(this);
	    //타이틀
	    modal.find('.modal-header').html(
		'<h2 class="modal-title display-6 ms-3" id="exampleModalLabel">'+storename+'</h2>'+
		'<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>'
		);
	    modal.find('#store_info').html(
			'<span class="fs-5">'+category+'</span><br><br>'+
			'<span class="text-break fs-5">주소</span><br>'+
			'<span class="text-break fs-6">'+addr+'</span><br><br>'+
			'<span class="fs-5">리뷰평점 : '+naver_star_avg+'</span><br><br>'
		);
		
	    //이미지
	    modal.find('#main_img').html(
			'<img src="'+naver_img_url+'" class="figure-img img-thumbnail rounded" alt="../static/app/img/'+category_b+'.png" style="width : 300px; height:280px;">'+
			'<figcaption class="figure-caption text-end me-3"><a href="'+naver_url+'" target="_blank" rel="noopener noreferrer" class="text-reset">상세보기</a></figcaption>'
		);
	    getNaverReview(store_id,modal);
		getNaverStoreAIRecommand(store_id,modal);
  });
}
function openKakaoModal(){
	
	$('#wtf').on('show.bs.modal', function (event) {
		var button = $(event.relatedTarget);
	    var storename = button.data('storename');
	    var addr = button.data('addr');
	    var kakao_star_avg = button.data('kakao_star_avg');
	    var kakao_url = button.data('kakao_url');
	    var category = button.data('category');
	    var store_id = button.data('store_id');
	    var kakao_img_url = button.data('kakao_img_url');
	    var category_b = button.data('category_b');
	    var modal = $(this);
	    //타이틀
	    modal.find('.modal-header').html(
		'<h2 class="modal-title display-6 ms-3" id="exampleModalLabel">'+storename+'</h2>'+
		'<button type="button" class="btn-close" data-dismiss="modal" aria-label="Close"></button>'
		);
	    modal.find('#store_info').html(
			'<span class="fs-5">'+category+'</span><br><br>'+
			'<span class="text-break fs-5">주소</span><br>'+
			'<span class="text-break fs-6">'+addr+'</span><br><br>'+
			'<span class="fs-5">리뷰평점 : '+kakao_star_avg+'</span><br><br>'
		);
		
	    //이미지
	    modal.find('#main_img').html(
			'<img src="'+kakao_img_url+'" class="figure-img img-thumbnail rounded" alt="../static/app/img/'+category_b+'.png" style="width : 300px; height:280px;">'+
			'<figcaption class="figure-caption text-end me-3"><a href="'+kakao_url+'" target="_blank" rel="noopener noreferrer" class="text-reset">상세보기</a></figcaption>'
		);
	    getKakaoReview(store_id,modal);
		getKakaoStoreAIRecommand(store_id,modal);
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
						'<div class="card-header shadow-sm">'+
							data[i].naver_nickname+
						'</div>'+
						'<div class="card-body shadow-sm">'+
							'<h5 class="card-title"></h5>'+
							'<p class="card-text text-break">'+data[i].naver_content+'</p>'+
						'</div>'+
						'<div class="card-footer text-muted text-end bg-white border-white shadow-sm">'+
							'<span class="me-3"><img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">'+data[i].naver_star+'</span> &nbsp;'+
							'<span>'+data[i].naver_date+'</span>'+
						'</div>'+
						'</div>'
						);
					}
				}
			});
}
function getKakaoReview(store_id,modal){
	$.ajax({
            type : "GET",
            url : "../json/kakaoReivew.jsp?store_id="+store_id,
            dataType : "JSON",
            success : function(data){
				modal.find('#review').empty();
				for(var i=0; i<data.length; i++){
					modal.find('#review').append(
						'<div class="card">'+
						'<div class="card-header shadow-sm">'+
							data[i].kakao_nickname+
						'</div>'+
						'<div class="card-body shadow-sm">'+
							'<h5 class="card-title"></h5>'+
							'<p class="card-text text-break">'+data[i].kakao_content+'</p>'+
						'</div>'+
						'<div class="card-footer text-muted text-end bg-white border-white shadow-sm">'+
							'<span class="me-3"><img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">'+data[i].kakao_star+'</span> &nbsp;'+
							'<span>'+data[i].kakao_date+'</span>'+
						'</div>'+
						'</div>'
						);
					}
				}
			});
}
function getNaverStoreAIRecommand(store_id,modal){
	modal.find('#aiRecommand').empty();
	modal.find('#aiRecommand').append(
		'<div class="spinner-border" role="status">'+
			'<span class="visually-hidden"></span>'+
		'</div>'
	);
	$.ajax({
            type : "GET",
            url : "../json/naverStoreAIRecommand.jsp?store_id="+store_id,
            dataType : "JSON",
            success : function(data){
				modal.find('#aiRecommand').empty();
				modal.find('#aiRecommand').append(
					'<p class="me-3 pb-1 fs-5">'+
						'AI추천 맛집'+
					'</p>'+
					'<div class="row border pt-2 me-2">'+
						'<a class="col" href="'+data[0].naver_url_1+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].naver_img_url_1+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_1+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].naver_url_2+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].naver_img_url_2+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_2+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].naver_url_3+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].naver_img_url_3+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_3+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].naver_url_4+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].naver_img_url_4+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_4+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].naver_url_5+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].naver_img_url_5+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_5+'</figcaption>'+
							'</figure>'+
						'</a>'+
					'</div>'
				);
			}
			});
}
function getKakaoStoreAIRecommand(store_id,modal){
	modal.find('#aiRecommand').empty();
	modal.find('#aiRecommand').append(
		'<div class="spinner-border" role="status">'+
			'<span class="visually-hidden"></span>'+
		'</div>'
	);
	$.ajax({
            type : "GET",
            url : "../json/kakaoStoreAIRecommand.jsp?store_id="+store_id,
            dataType : "JSON",
            success : function(data){
				modal.find('#aiRecommand').empty();
				modal.find('#aiRecommand').append(
					'<p class="me-3 pb-1 fs-5">'+
						'AI추천 맛집'+
					'</p>'+
					'<div class="row border pt-2 me-2">'+
						'<a class="col" href="'+data[0].kakao_url_1+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].kakao_img_url_1+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_1+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].kakao_url_2+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].kakao_img_url_2+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_2+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].kakao_url_3+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].kakao_img_url_3+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_3+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].kakao_url_4+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].kakao_img_url_4+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_4+'</figcaption>'+
							'</figure>'+
						'</a>'+
						'<a class="col" href="'+data[0].kakao_url_5+'" target="_blank" rel="noopener noreferrer">'+
							'<figure class="figure" style="width: 8rem;">'+
								'<img src="'+data[0].kakao_img_url_5+'" class="figure-img img-thumbnail rounded" alt="..." style="width:128px; height:128px;">'+
							'<figcaption class="figure-caption ms-1">'+data[0].store_name_5+'</figcaption>'+
							'</figure>'+
						'</a>'+
					'</div>'
				);
			}
			});
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
            }//1
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