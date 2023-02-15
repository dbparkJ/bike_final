<%@page import="map.corseDTO.CorseList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="map.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
String name = request.getParameter("keyword");
List<CorseList> corseList = null;
MapDAO dao = MapDAO.getDao();
corseList = dao.getCorseLatLon(name);
%>
<%=corseList%>