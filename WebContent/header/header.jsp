<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="ctxpath" value="<%=request.getContextPath()%>" scope="session"/>
<head>
	<title>Bikeway 당신의 라이딩과 함께</title>
	<meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<%-- 부트스트랩을 사용하기 위한 소스링크 --%>
	<link rel="stylesheet" href="${ctxpath}/static/lib/css/bootstrap.min.css">
	
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	
	    <!-- Popper JS -->
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	
	<style>
		body {
			font-family: 'SCoreDream';
		}
	</style>
	
</head>
