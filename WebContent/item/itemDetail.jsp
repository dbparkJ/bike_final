<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
     
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="..\static\app\js\itemRecommand.js"></script>
<link rel="stylesheet" href="../static/app/css/item_detail.css">

</head>
<body>
<div class="container-md pt-4">
	<div>
		<%-- 기존상품정보,리뷰 --%>
		<div class="card text-center bg-white">
		  <div class="card-body">
		  	<div class="px-5">
				<img src="${itemDTO.item_img}" class="rounded float-start" alt="..." width="500" height="550" align="left">
			</div>
			<div id="content">
			    <div class="card-text">
			    	<div>
				    	<c:if test = "${itemDTO.item_delivery_fee==0}">
							<span id="delivery" class="text-muted fw-bold px-2">무료배송</span><br>
						</c:if>
						<c:if test = "${itemDTO.item_delivery_fee!=0}">
							<span class="text-muted fw-bold"> </span><br>
						</c:if>
					</div>
					<div class="pt-2">
			    		<span class="h5 px-2" id="name">${itemDTO.item_name}</span>
			    	</div>
			    	<div class="pt-2">
			    		<span class="card-text px-2 fs-4 fw-bold"><fmt:formatNumber value="${itemDTO.item_price}" type="number"/>원</span><br>
			    		<span class="px-2"> ${itemDTO.item_category}</span>
			    	</div>
			    </div>
			    
			    <div class="card-text pt-3">
			    	<span class="px-2">출시 : ${itemDTO.release_y}년형 <font size="+1"><b>|</b></font> 최고속도 : ${itemDTO.max_speed_km}Km <font size="+1"><b>|</b></font> 주행거리 : ${itemDTO.mileage_km}Km <font size="+1"><b>|</b></font> 등판각도 : ${itemDTO.back_angle_do} <font size="+1"><b>|</b></font>
			    	 기어 : ${itemDTO.gear_dan}단</span><br> 
			    	<span class="px-2">바퀴 : ${itemDTO.wheel_inch}인치 <font size="+1"><b>|</b></font> 무게 : ${itemDTO.weight_kg}kg <font size="+1"><b>|</b></font> 변속기 : ${itemDTO.gearbox} <font size="+1"><b>|</b></font> 브레이크 : ${itemDTO.brake}</span><br>
			    	<span class="px-2">핸들타입 : ${itemDTO.handle_type} <font size="+1"><b>|</b></font> 특징 : ${itemDTO.feature} <font size="+1"><b>|</b></font> 모터출력 : ${itemDTO.motor_output_w}W</span><br>
			    	<span class="px-2">배터리용량 : ${itemDTO.battery_cap_ah}Ah <font size="+1"><b>|</b></font> 배터리전압 : ${itemDTO.battery_vol_v}V  <font size="+1"><b>|</b></font> 충전시간 : ${itemDTO.charge_time_h}시간 <font size="+1"><b>|</b></font> 서스펜션 : ${itemDTO.suspension}</span><br>
			    	<span class="px-2">프레임 : ${itemDTO.frame} <font size="+1"><b>|</b></font> 안장 : ${itemDTO.saddle} <font size="+1"><b>|</b></font> 종류 : ${itemDTO.type}</span>
			    </div>
		    </div>
		    
		    <div id="buttonForm">
		    	<a href="${itemDTO.url}" class="btn btn-dark" id="button" target="_blank" rel="noopener noreferrer">구매하러가기</a>
		    </div>
	    </div>
	    
	    <%-- 리뷰 --%>
	    <div class="pt-6 pb-3" id="star">
	    	<div class="px-5">
	    		<span class="fs-4 fw-bold" id="font_size">리뷰(${itemDTO.item_num})</span>
	    	</div>
	    <div>
    	<div id="review_card">
	    	<c:forEach var="review" items="${reviewList}">
		    	<div class="card">
				    	<div class="card-header bg-white border-black" id="header">
				    		<span class="pt-5">${review.review_nickname}</span>
				    	</div>
			    		<div class="card-body">
			    			<h5 class="card-title"></h5>
			    			<div class="card-text text-break" id="middle">
								<span class="fs-6">${review.review_content}</span>
							</div>
						</div>
						<div class="card-footer bg-white border-white" id="bottom">
							<span class="me-3"><img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">${review.review_star}</span> &nbsp;<span>${review.review_date}</span>
						</div>
				</div>
			</c:forEach>
		</div>
	  </div>
	</div>
		
	<%-- 리뷰페이지 --%>
	<div class="bg-white border-white">
		<c:if test="${review_count>0}">
		<%-- 페이지 --%>		
		<nav aria-label="Page navigation example">
	 		 <ul class="pagination justify-content-center">
	 		 	<%-- 에러방지 --%>
			<c:if test="${endPage>pageCount}">
				<c:set var="endPage" value="${pageCount}"/>
			</c:if>
		    <%-- 이전블럭 --%>
		    <c:if test="${startPage>10}">
		    	<a class="page-link" href="${ctxpath}/item/itemDetail.do?item_id=${itemDTO.item_id}&pageNum=${startPage-10}" tabindex="-1" aria-disabled="true">◁</a>
		    </c:if>
		    <%-- 페이지처리 --%>
		    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		    	<li class="page-item"><a class="page-link" href="${ctxpath}/item/itemDetail.do?item_id=${itemDTO.item_id}&pageNum=${i}">${i}</a></li>
		    </c:forEach>
		    <li class="page-item">
		      <%-- 다음블럭 --%>
		      <c:if test="${endPage<pageCount}">
		      <a class="page-link" href="${ctxpath}/item/itemDetail.do?item_id=${itemDTO.item_id}&pageNum=${startPage+10}">▷</a>
		      </c:if>
		    </li>
	 		</ul>
	   </nav>
	   </c:if>
	   
	   <c:if test="${review_count==0}">
	   	<div class="pb-4">
	   		<hr width="95%">
	    	<br>
			<span class="fs-5">리뷰가 없습니다.</span>
		</div>
	   </c:if>
	</div>
  </div>
 </div>
</div>

<%-- ai상품비교 --%>
<div class="row">
	<c:forEach var="recommandItem" items="${recommandItemList}">
			<div class="col">
		    	<div class="card">
				  <img src="${recommandItem.item_img}" class="card-img-top" alt="...">
				  <div class="card-body">
				    <p class="card-title" id="name_font">${recommandItem.item_name}</p>
				    <p class="card-text fs-6 fw-bold"><fmt:formatNumber value="${recommandItem.item_price}" type="number"/>원</p>
				    <p class="card-text fs-6"><img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">${recommandItem.item_avg_star}/5</p>
				    <a href="${ctxpath}/item/compare.do?myItemId=${itemDTO.item_id}&recommandItemId=${recommandItem.item_id}" class="btn btn-dark" >AI 비교하기</a>
				 </div>
			 </div>
		</div>
   </c:forEach>
 </div>
</body>
</html>