<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../static/app/css/item_main.css">
</head>
<body>
	<%-- 검색어입력폼 --%>
	<form name="searchForm" class="d-flex" role="search">
		<div class="d-inline-flex p-2 bd-highlight">
			<input class="form-control me-2" name="keyword2" id="keyword2" type="search" placeholder="Search" aria-label="Search">
		</div>
		<a href="${ctxpath}/item/itemMain.do?keyword2=${keyword2}">
			<button class="btn btn-outline-success" type="submit">Search</button>
		</a>
	</form>
    
	<c:if test="${null ne keyword2}">
    <p align="center" class="h5"><font size="+6">'${keyword2}'</font>에 대한 검색결과</p>
	</c:if>
	<div class="pb-5">
		<div class="container-md pt-5">
		<c:if test="${null ne keyword2 && '' ne keyword2}"><button type="button" onclick="location.href='${ctxpath}/item/itemMain.do'">전체</button><p class="fw-bold">총 ${count}건</p>
		</c:if>
		<c:if test="${null ne keyword2 && '' eq keyword2}"><button type="button" onclick="location.href='${ctxpath}/item/itemMain.do'">전체</button><p class="fw-bold">총 0건</p>
		</c:if>
			<div class="pb-5">					
				<div class="row row-cols-1 row-cols-md-4 g-5 bg-light">
						<%-- 상품이 없을때 --%>
						<c:if test="${count== 0 || '' eq keyword2}">
						<span class="card-text fs-5 text-center">검색된 상품이 없습니다</span>
						</c:if>
						
						<%-- 상품이 있을때 --%>
						<c:if test="${count>0 && '' ne keyword2}">
							<c:forEach var="items" items="${itemlist}">
								<a href="${ctxpath}/item/itemDetail.do?item_id=${items.item_id}" class="items">
								<div class="col">
									<div class="card h-100">
										<img src="${items.item_img}" class="card-img border" alt="...">
										<div class="card-body">
											<div class="pb-auto">
												<%-- 배송비가없다면 --%>
												<c:if test = "${items.item_delivery_fee==0}">
													<span class="text-muted text-muted fw-bold" id="font_size">무료배송</span><br>
												</c:if>
												<c:if test = "${items.item_delivery_fee!=0}">
													<span class="text-muted text-muted fw-bold" id="font_size"> </span><br>
												</c:if>
												<span class="card-text fs-8" id="item_name_font">${items.item_name}</span><br>
											</div>
											<div class="">
												<div class="d-flex flex-row-reverse">
													<span class="card-text fs-4 fw-bold"><fmt:formatNumber value="${items.item_price}" type="number"/>원</span><br>
												</div>
												<div class="d-flex flex-row-reverse">
													<span class="text-muted"><img src ="star (2).png" width="15" height="15"> ${items.item_avg_star}/5</span>
												</div>
											</div>

										</div>
									</div>
								</div>
								</a>
							</c:forEach>
						</c:if>
				 </div>
				 	
			</div>
		</div>
		
	   <c:if test="${count>0 && '' ne keyword2}">
		<%-- 페이지 --%>		
		<nav aria-label="Page navigation example">
  		 <ul class="pagination justify-content-center">
  		 	<%-- 에러방지 --%>
			<c:if test="${endPage>pageCount}">
				<c:set var="endPage" value="${pageCount}"/>
			</c:if>
		    <%-- 이전블럭 --%>
		    <c:if test="${startPage>10}">
		    	<a class="page-link" href="${ctxpath}/item/itemMain.do?pageNum=${startPage-10}${keywordParameter}" tabindex="-1" aria-disabled="true">◁</a>
		    </c:if>
		    <%-- 페이지처리 --%>
		    <c:forEach var="i" begin="${startPage}" end="${endPage}">
		    	<li class="page-item"><a class="page-link" href="${ctxpath}/item/itemMain.do?pageNum=${i}${keywordParameter}">${i}</a></li>
		    </c:forEach>
		    <li class="page-item">
		      <%-- 다음블럭 --%>
		      <c:if test="${endPage<pageCount}">
		      <a class="page-link" href="${ctxpath}/item/itemMain.do?pageNum=${startPage+10}${keywordParameter}">▷</a>
		      </c:if>
		    </li>
  		</ul>
	   </nav>
	   </c:if>
	</div>
</body>
</html>