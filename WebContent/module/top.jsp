<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" />

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand fs-3 mx-5" href="${ctxpath}/main/viewMain.do">BIKEWAY</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
	<div class="collapse navbar-collapse">
		<ul class="navbar-nav me-auto mb-2 mb-lg-0">
			<li class="nav-item">
				<a class="nav-link active mx-2" aria-current="page" href="${ctxpath}/corse/corse.do">추천코스</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mx-2" href="${ctxpath}/item/itemMain.do">자전거 상품</a>
			</li>
			<li class="nav-item">
				<a class="nav-link mx-2" href="#">따릉이 수요예측</a>
			</li>
		</ul>
	</div>
  </div>
</nav>