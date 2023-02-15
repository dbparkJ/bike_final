<%@page import="map.storeDTO.NaverStore"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="map.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
List<NaverStore> matzipList = null;
MapDAO dao = MapDAO.getDao();
Double minlon = Double.parseDouble(request.getParameter("minlon"));
Double minlat = Double.parseDouble(request.getParameter("minlat"));
Double maxlon = Double.parseDouble(request.getParameter("maxlon"));
Double maxlat = Double.parseDouble(request.getParameter("maxlat"));
matzipList = dao.getNaverStoreList(minlon,maxlon,minlat,maxlat);

%>
<%=matzipList%>