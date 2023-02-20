<%@page import="map.storeDTO.NaverStore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="map.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
Integer store_id = Integer.parseInt(request.getParameter("store_id"));
List<NaverStore> naverStoreAIRecommand= null;
MapDAO dao = MapDAO.getDao();
naverStoreAIRecommand = dao.getNaverStoreAIRecommand(store_id);
%>
<%=naverStoreAIRecommand%>