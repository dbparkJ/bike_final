<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="bike.*"
    import="java.util.*"
    import="org.json.simple.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
List<MatzipDTO> matzipList = null;
BikeDAO dao = BikeDAO.getDao();
Double minlon = Double.parseDouble(request.getParameter("minlon"));
Double minlat = Double.parseDouble(request.getParameter("minlat"));
/* Double avglon = Double.parseDouble(request.getParameter("avglon"));
Double avglat = Double.parseDouble(request.getParameter("avglat"));
 */Double maxlon = Double.parseDouble(request.getParameter("maxlon"));
Double maxlat = Double.parseDouble(request.getParameter("maxlat"));
matzipList = dao.getMatzipList(minlon,maxlon,minlat,maxlat);

%>
<%=matzipList%>