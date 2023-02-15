<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body class="mx-5 pt-5">
	<div class="pb-5">
		<div class="container-md pt-5">
			<div class="pb-5">
				<div class="row row-cols-1 row-cols-md-4 g-5 bg-light">
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
									<a class="text-muted fs-6" href="${items.url}">구매하러가기</a>
									<a class="text-muted fs-6" href="상품비교화면페이지">상품비교하러가기</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>