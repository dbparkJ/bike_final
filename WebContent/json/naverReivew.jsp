<%@page import="map.storeDTO.NaverStoreReview"%>
<%@page import="map.storeDTO.KakaoStoreReview"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="map.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
Integer store_id = Integer.parseInt(request.getParameter("store_id"));
List<NaverStoreReview> naverReviewList= null;
MapDAO dao = MapDAO.getDao();
naverReviewList = dao.getNaverStoreReview(store_id);
%>
<%=naverReviewList%>