<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${ctxpath}/static/app/js/check.js"></script>

<div class="modal fade" id="login" tabindex="0" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable pt-1">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<h1 class="modal-title text-white fs-5" id="exampleModalLabel">로그인</h1>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body bg-light pt-3">
				<div class="container w-90">
					<form method="post" action="${ctxpath}/member/loginPro.do">
						<div class="form-group pt-2">
							<label for="floatingInputInvalid">이메일 주소</label>
							<div class="form-floating mb-3">
								<input type="email" name="email" id="email" class="form-control" placeholder="name@example.com" required="required">
								<label for="floatingInputInvalid">name@example.com</label>
							</div>
						</div>
						<div class="form-group pt-2">
							<label for="inputPassword">비밀번호</label>
							<div class="form-floating mb-3">
								<input type="password" name="pw" id="pw" class="form-control" placeholder="Password" required="required">
								<label for="inputPassword">Password</label>
							</div>
						</div>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end pt-3">
							<button class="btn btn-secondary" type="submit">로그인</button>
							<button type="button" class="btn btn-primary fs-6" data-bs-toggle="modal" data-bs-target="#membership">회원가입</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="modal fade" id="membership" tabindex="0" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable pt-1">
		<div class="modal-content">
			<div class="modal-header bg-dark">
				<h1 class="modal-title text-white fs-5" id="exampleModalLabel">회원가입</h1>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body bg-light pt-3">
				<div class="container w-90">
					<form method="post" action="${ctxpath}/member/inputPro.do">
						<div class="form-group pt-2">
							<label for="floatingInputInvalid">이메일</label>
							<div class="form-floating mb-3">
								<input type="email" name="email" id="email" class="form-control" placeholder="name@example.com" required="required">
								<label for="floatingInputInvalid">name@example.com</label>
								<input class="btn btn-outline-dark" type="button" value="email중복체크" onClick="emailCheck()">                
							</div>
						</div>
						<div class="form-group pt-2">
							<label for="inputPassword">비밀번호</label>
							<div class="form-floating mb-3">
								<input type="password" name="pw" id="pw" class="form-control" placeholder="Password" required="required">
								<label for="inputPassword">비밀번호</label>
							</div>
							<div class="form-floating mb-3">
								<input type="password" name="pw2" id="pw2" class="form-control" placeholder="Password" required="required">
								<label for="inputPassword">비밀번호 확인</label>
							</div>
						</div>
						<div class="form-group pt-2">
							<label for="inputPassword">이름</label>
							<div class="form-floating mb-3">
								<input type="text" name="name" id="name" class="form-control" placeholder="홍길동" required="required">
								<label for="floatingInputInvalid">홍길동</label>
							</div>
							<div class="form-floating mb-3">
								<input type="text" name="nickname" id="nickname" class="form-control" placeholder="홍길동" required="required">
								<label for="floatingInputInvalid">닉네임</label>
							</div>
						</div>
						<div class="form-group pt-2">
							<label for="inputPassword">주소</label>
							<div class="form-floating mb-3">
								<input readonly="readonly" type="text" name="zipcode" id="zipcode" class="form-control" placeholder="우편번호" required="required">
								<label for="floatingInputInvalid">우편번호</label>
								<input class="btn btn-outline-dark" type="button" value="주소찾기" onClick="findAddr()">
							</div>
							<div class="form-floating mb-3">
								<input type="text" name="address" id="address" class="form-control" placeholder="주소" required="required">
								<label for="floatingInputInvalid">주소</label>
							</div>
						</div>
						<div class="form-group pt-2">
							<label for="inputPassword">몸무게</label>
							<div class="form-floating mb-3">
								<input type="number" name="weight" id="weight" class="form-control" placeholder="kg" required="required">
								<label for="floatingInputInvalid">kg</label>
							</div>
						</div>
						<div class="d-grid gap-2 d-md-flex justify-content-md-end pt-3">
							<button class="btn btn-primary" type="submit">확인</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>





<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
  <div class="container-fluid">
    <a class="navbar-brand fs-3 mx-5" href="${ctxpath}/main/viewMain.do">BIKEWAY</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDarkDropdown" aria-controls="navbarNavDarkDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDarkDropdown">
      <ul class="navbar-nav">
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle mx-3" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            자전거코스
          </a>
          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
            <li><a class="dropdown-item" href="${ctxpath}/corse/corse.do">추천코스</a></li>
            <li><a class="dropdown-item" href="${ctxpath}/weather/weatherInfo.do">주간 날씨예보</a></li>
          </ul>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle mx-3" href="#" id="navbarDarkDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            자전거 구매
          </a>
          <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="navbarDarkDropdownMenuLink">
            <li><a class="dropdown-item" href="${ctxpath}/goods/newgoods.do">상품</a></li>
            <li><a class="dropdown-item" href="${ctxpath}/goods/usedgoods.do">중고상품</a></li>
          </ul>
        </li>
      </ul>
    </div>
    
    
    <c:if test="${empty sessionScope.member}">
	    <div>
		    <button type="button" class="btn btn-Dark mx-2" data-bs-toggle="modal" data-bs-target="#login">로그인</button>
	    </div>
	    <div>
		    <button type="button" class="btn btn-Dark mx-2" data-bs-toggle="modal" data-bs-target="#membership">회원가입</button>
		</div>
    </c:if>
    <c:if test="${!empty sessionScope.member}">
	    <div>
		    <a class="btn btn-Dark mx-2" href="${ctxpath}/dataScience/dataScienceForm.do">나의 라이딩일지</a>
		</div>
	    <div>
		    <a class="btn btn-Dark mx-2" href="${ctxpath}/member/logoutPro.do">로그아웃</a>
	    </div>
    </c:if>
    
    
    
    
	
  </div>
</nav>