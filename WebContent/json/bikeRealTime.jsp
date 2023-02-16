<%@page import="map.corseDTO.BikeRealTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="map.*"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
List<BikeRealTime> bikeRealTimeList = null;
MapDAO dao = MapDAO.getDao();
Double minlon = Double.parseDouble(request.getParameter("minlon"));
Double minlat = Double.parseDouble(request.getParameter("minlat"));
Double maxlon = Double.parseDouble(request.getParameter("maxlon"));
Double maxlat = Double.parseDouble(request.getParameter("maxlat"));
bikeRealTimeList = dao.getBikeRealTimeList(minlon, maxlon, minlat, maxlat);

%>
<%=bikeRealTimeList%>