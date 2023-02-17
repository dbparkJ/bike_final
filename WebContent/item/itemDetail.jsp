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
<script>
</script>
</head>
<body>
여긴 상품 상세보기 페이지입니다.
${itemDTO.item_id}

<a class="text-muted fs-6" href="/item/itemDetail.do">
<img src="${itemDTO.item_img}" class="card-img border" alt="..." width="250" height="250">
</a>

	<div class="row">
		<c:forEach var="recommandItem" items="${recommandItemList}">
					<div class="col">
				    	<div class="card">
						  <img src="${recommandItem.item_img}" class="card-img-top" alt="...">
						  <div class="card-body">
						    <h5 class="card-title">${recommandItem.item_name}</h5>
						    <p class="card-text"><fmt:formatNumber value="${recommandItem.item_price}" type="number"/>원</p>
						    <p class="card-text">${recommandItem.item_avg_star}/5</p>
						    <a href="${ctxpath}/item/compare.do?myItemId=${itemDTO.item_id}&recommandItemId=${recommandItem.item_id}" class="btn btn-primary" >AI 비교하기</a>
						 </div>
					 </div>
				</div>
		</c:forEach>
  </div>
</body>
</html>