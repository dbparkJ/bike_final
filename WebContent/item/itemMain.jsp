<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
		${searchBtn}.click(function(){
			var keyword2 = ${keyword2}.val();
			var select = $('#serachForm option:selected').val();
			
		});
	</script>
</head>
<body>
	<form id="searchForm" name="serachForm" method="get">
    <table align="center">
      <tr>
        <td align="right" valign="bottom">
          <!-- <select id="category" name="category">
			  <option value="a">신상품순</option>
			  <option value="b">높은리뷰순</option>
			  <option value="c">낮은가격순</option>
			  <option value="d">높은가격순</option>
	      </select> -->
          <input type="text" name="keyword2" id="keyword2" size="30" placeholder="검색어를 입력하세요.">
			  <a href="${ctxpath}/item/itemMain.do?keyword2=${keyword2}?category=${category}">
 				<input type="image" id="searchBtn" src="data_applenews_emoji_update_2017_12.png" width="50px">
			  </a> 
          </td>
        </tr>
      </table>
    </form> 
	<div class="pb-5">
		<div class="container-md pt-5">
			<div class="pb-5">				
				<div class="row row-cols-1 row-cols-md-4 g-5 bg-light">
						<%-- 상품이 없을때 --%>
						<c:if test="${count==0}">
						등록된 상품이 없습니다.
						</c:if>
						<%-- 상품이 있을때  --%>
						<c:if test="${count>0}">

							<c:forEach var="items" items="${itemlist}">
								<div class="col">
									<div class="card h-100">
										<img src="${items.item_img}" class="card-img border" alt="...">
										<div class="card-body">
											<p class="card-text fs-5">${items.item_name}</p>
											<p class="card-text fs-5">리뷰${items.item_avg_star}/5</p>
										</div>
										<div class="text-end ">
											<p class="card-text fs-5"><fmt:formatNumber value="${items.item_price}" type="number"/>원</p>
											<p class="card-text fs-5">배송비<fmt:formatNumber value="${items.item_delivery_fee}" type="number"/>원</p>
										</div>
										<div class="card-footer text-end">
											<a class="text-muted fs-6" href="${ctxpath}/item/itemDetail.do?item_id=${items.item_id}">상세보기</a>
										</div>

									</div>
								</div>
							</c:forEach>
						</c:if>
				 </div>
			</div>
		</div>
			<%-- 페이지 테이블 --%>
			<table class="wid" align="center">
				<tr>
					<td align="center">
						<c:if test="${count>0}">
						
						<%-- 에러방지 --%>
						<c:if test="${endPage>pageCount}">
							<c:set var="endPage" value="${pageCount}"/>
						</c:if>
						
						<%-- 이전블럭 --%>
						<c:if test="${startPage>10}">
							<a href="${ctxpath}/item/itemMain.do?pageNum=${startPage-10}&keyword2=${keyword2}">[이전]</a>
						</c:if>
						
						<%-- 페이지처리 --%>
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<a href="${ctxpath}/item/itemMain.do?pageNum=${i}&keyword2=${keyword2}">[${i}]</a> <%-- 프로퍼티파일에서 입력한 경로 ... --%>
						</c:forEach>
						
						<%-- 다음블럭 --%>
						<c:if test="${endPage<pageCount}">
							<a href="${ctxpath}/item/itemMain.do?pageNum=${startPage+10}&keyword2=${keyword2}">[다음]</a>			
						</c:if>
						
						</c:if>
					</td>
				</tr>
			</table>
	</div>
</body>
</html>