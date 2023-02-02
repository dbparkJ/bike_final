<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="bike.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
List<RentBikeInfoDTO> rentBike = null;
BikeDAO dao = BikeDAO.getDao();
rentBike = dao.getRentBikeRecentInfo();
%>
<%=rentBike%>