<%@page import="map.corseDTO.CorseMaxMinLatLon"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="map.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String mapName = request.getParameter("keyword");
List<CorseMaxMinLatLon> corseMaxMinList = null;
MapDAO dao = MapDAO.getDao();
corseMaxMinList = dao.getCorseMaxMinLatLon(mapName);
%>

<%=corseMaxMinList%>