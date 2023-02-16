<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
여긴 상품 상세보기 페이지입니다.
${itemDTO.item_name}
<a class="text-muted fs-6" href="">
<img src="${itemDTO.item_img}" class="card-img border" alt="..." width="500" height="500">
</a>
</body>
</html>