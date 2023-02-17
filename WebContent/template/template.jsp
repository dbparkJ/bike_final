<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/header/header.jsp"%>

<%-- template.jsp --%>

<html>
	<body>
		<div>
			<div>
				<!-- 상단바 -->	
				<jsp:include page="/module/top.jsp" flush="false"/>
				<!-- 메인이미지 -->	
				<jsp:include page="${CONTENT}" flush="false"/>
				
			</div>	
		</div>
	</body>
</html>
