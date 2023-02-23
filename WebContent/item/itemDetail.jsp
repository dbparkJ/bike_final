<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
   <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>

<head>
<meta charset="UTF-8">
	<script src="..\static\app\js\itemRecommand.js"></script>
	<link rel="stylesheet" href="../static/app/css/item_detail.css">
</head>
<body>
<div class="justify-content-between d-flex" style="height: 0%;">
<div class="container pt-3">
   <div>
      <%-- 기존상품정보,리뷰 --%>
      <div class="card text-center bg-white">
        <div class="card-body">
           <div id="img-title">
            <img src="${itemDTO.item_img}" class="img-thumbnail" width="500" height="550" align="left">
           </div>
      
          <div id="title_form" class="card-text bg-white border-white pt-2">
             <c:if test = "${itemDTO.item_delivery_fee==0}">
               <span id="delivery" class="text-muted font-weight-bold">무료배송</span><br>
            </c:if>
            <c:if test = "${itemDTO.item_delivery_fee!=0}">
               <span class="text-muted"> </span><br>
            </c:if>
             <span id="name">${itemDTO.item_name}</span>
          </div>

         <div id="content">
             <div class="pt-2 pb-3">
                <span> ${itemDTO.item_category}</span>
             </div>
             <hr>
             <div class="card-text pt-5 lh-base">
                <c:choose>
                   <%-- 전기자전거의 카테고리 --%>
                   <c:when test = "${fn:contains(itemDTO.item_category, '전기')}">
                     <span>출시 : ${itemDTO.release_y}년형</span>
                      <span class="text-muted">|</span>
                      <span>최고속도 : ${itemDTO.max_speed_km}Km</span>
                      <span class="text-muted">|</span> 
                      <span>주행거리 : ${itemDTO.mileage_km}Km</span><br>
                      
                     <span>등판각도 : ${itemDTO.back_angle_do}도</span>
                     <span class="text-muted">|</span>
                      <span>기어 : ${itemDTO.gear_dan}단</span>
                      <span class="text-muted">|</span>
                      <span>바퀴 : ${itemDTO.wheel_inch}인치</span><br>
                      
                      <span>무게 : ${itemDTO.weight_kg}kg</span>
                      <span class="text-muted">|</span>
                      <span>변속기 : ${itemDTO.gearbox}</span><br> 
                      
                      <span>서스펜션 : ${itemDTO.suspension}</span>
                      <span class="text-muted">|</span>
                      <span>브레이크 : ${itemDTO.brake}</span><br>
                      
                      <span>핸들타입 : ${itemDTO.handle_type}</span>
                      <span class="text-muted">|</span>
                      <span>특징 : ${itemDTO.feature}</span>
                      <span class="text-muted">|</span>
                      <span>모터출력 : ${itemDTO.motor_output_w}W</span><br>
                      
                      
                      <span>배터리용량 : ${itemDTO.battery_cap_ah}Ah</span>
                      <span class="text-muted">|</span>
                      <span>배터리전압 : ${itemDTO.battery_vol_v}V</span>
                      <span class="text-muted">|</span>
                      <span>충전시간 : ${itemDTO.charge_time_h}시간</span><br>
                      
                      <span>프레임 : ${itemDTO.frame}</span>
                      <span class="text-muted">|</span>
                      <span>안장 : ${itemDTO.saddle}</span>
                      <span class="text-muted">|</span>
                      <span>종류 : ${itemDTO.type}</span>
                  </c:when>
                  
                  <%-- 전기자전거 이외에 카테고리 --%>
                  <c:otherwise>
                      <span>출시 : ${itemDTO.release_y}년형</span>
                      <span class="text-muted">|</span>
                      <span>최고속도 : ${itemDTO.max_speed_km}Km</span>
                      <span class="text-muted">|</span> 
                      <span>주행거리 : ${itemDTO.mileage_km}Km</span><br>
                      
                     <span>등판각도 : ${itemDTO.back_angle_do}도</span>
                     <span class="text-muted">|</span>
                      <span>기어 : ${itemDTO.gear_dan}단</span>
                      <span class="text-muted">|</span>
                      <span>바퀴 : ${itemDTO.wheel_inch}인치</span><br>
                      
                      <span>무게 : ${itemDTO.weight_kg}kg</span>
                      <span class="text-muted">|</span>
                      <span>변속기 : ${itemDTO.gearbox}</span><br> 
                      
                      <span>서스펜션 : ${itemDTO.suspension}</span>
                      <span class="text-muted">|</span>
                      <span>브레이크 : ${itemDTO.brake}</span><br>
                      
                      <span>핸들타입 : ${itemDTO.handle_type}</span>
                      <span class="text-muted">|</span>
                      <span>특징 : ${itemDTO.feature}</span><br>
                      
                      <span>프레임 : ${itemDTO.frame}</span>
                      <span class="text-muted">|</span>
                      <span>안장 : ${itemDTO.saddle}</span>
                      <span class="text-muted">|</span>
                      <span>종류 : ${itemDTO.type}</span>
                   </c:otherwise>
                </c:choose>
             </div>
             <br>
          </div>
          
          <div id="buttonForm" class=" card-footer bg-white border-white">
             <span class="card-text h3 font-weight-bold"><fmt:formatNumber value="${itemDTO.item_price}" type="number"/>원</span><br>
             <div class="pt-2">
                <a href="${itemDTO.url}" class="btn btn-dark" id="button" target="_blank" rel="noopener noreferrer">구매하러가기</a>
             </div>
          </div>
       </div>
       
       <%-- 리뷰 --%>
       <div class="pt-6 pb-3" id="star">
       <div id= "review_form">
          <span class="h5">리뷰수</span><span class="font-weight-bold" id="font_size">(${itemDTO.item_num})</span>&nbsp;&nbsp;
          <span class="h5">사용자 총 평점 </span><span class="font-weight-bold" id="font_size">${itemDTO.item_avg_star} / 5</span>
       </div>
       <div id="review_card">
          <c:forEach var="review" items="${reviewList}">
             <div class="card bg-white border-white">
                   <div class="card-header bg-white border-white" id="header">
                      <span class="me-3">
                         <img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">
                         ${review.review_star}
                      </span>
                      <span class="text-muted">|</span>&nbsp;&nbsp;
                      <span class="pt-5">${review.review_nickname}</span>&nbsp;&nbsp;
                      <span class="text-muted">|</span>&nbsp;&nbsp;
                      <span>${review.review_date}</span>
                   </div>
                   <div class="card-body bg-white border-white">
                      <div class="card-text text-break" id="middle">
                        <span class="fs-6">${review.review_content}</span>
                     </div>
                  </div>
                  <hr>
            </div>
         </c:forEach>
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
             <a class="page-link" href="${ctxpath}/item/itemDetail.do?item_id=${itemDTO.item_id}&pageNum=${startPage-10}" tabindex="-1" aria-disabled="true"><span class="text-dark">◁</span></a>
          </c:if>
          <%-- 페이지처리 --%>
          <c:forEach var="i" begin="${startPage}" end="${endPage}">
             <li class="page-item"><a class="page-link" href="${ctxpath}/item/itemDetail.do?item_id=${itemDTO.item_id}&pageNum=${i}"><span class="text-dark">${i}</span></a></li>
          </c:forEach>
          <li class="page-item">
            <%-- 다음블럭 --%>
            <c:if test="${endPage<pageCount}">
            <a class="page-link" href="${ctxpath}/item/itemDetail.do?item_id=${itemDTO.item_id}&pageNum=${startPage+10}"><span class="text-dark">▷</span></a>
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
</div>
<!-- ai상품비교 -->
<div class="row sticky-top ml-5 pt-5" style="padding:50px">
<div class="col">
   <c:forEach var="recommandItem" items="${recommandItemList}">
             <div class="card" style="width: 10rem;">
              <img src="${recommandItem.item_img}" class="card-img-top ml-3" alt="..." style="width:120px; height:120px;">
              <div class="card-body">
                <p class="card-title text-truncate" id="name_font">${recommandItem.item_name}</p>
                <p class="card-text fs-6 fw-bold"><fmt:formatNumber value="${recommandItem.item_price}" type="number"/>원</p>
                <p class="card-text fs-6"><img src="../static/app/img/star (2).png" width="18" height="20" class="pb-1 me-2">${recommandItem.item_avg_star}/5</p>
                <a href="${ctxpath}/item/compare.do?myItemId=${itemDTO.item_id}&recommandItemId=${recommandItem.item_id}" class="btn btn-dark" >AI 비교하기</a>
             </div>
          </div>
   </c:forEach>
</div>
</div>
</body>
</html>