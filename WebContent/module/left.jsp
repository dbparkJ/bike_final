<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctxpath" value="<%=request.getContextPath() %>"/>
<%-- left.jsp --%>
<!-- left -->
<nav id="sidebarMenu" class="col-md-3 col-lg-2 d-md-block sidebar collapse border-right pt-3">
  <div class="sidebar-sticky">
    <div class="mb-5 text-center"><h2>My 당근</h2></div>
    <ul class="nav flex-column text-center">
      <li class="nav-item my-3">
        <a class="nav-link text-dark" href="${ctxpath}/member/infoForm.do">
          내 정보 수정
        </a>
      </li>
      <li class="nav-item my-3">
        <a class="nav-link text-dark" href="${ctxpath}/wishlist/wishListForm.do">
          위시리스트
        </a>
      </li>
      <li class="nav-item my-3">
        <a class="nav-link text-dark" href="${ctxpath}/item/saleForm.do">
          판매내역
        </a>
      </li>
      <li class="nav-item my-3">
        <a class="nav-link text-dark" href="${ctxpath}/item/buyForm.do">
          구매내역
        </a>
      </li>
      <li class="nav-item my-3">
        <a class="nav-link text-dark" href="${ctxpath}/msg/receiveListForm.do">
          받은 쪽지함
        </a>
      </li>
      <li class="nav-item my-3">
        <a class="nav-link text-dark" href="${ctxpath}/msg/sendListForm.do">
          보낸 쪽지함
        </a>
      </li>
    </ul>
  </div>
</nav>

<!-- left end -->
