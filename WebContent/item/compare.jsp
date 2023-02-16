<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>



<body>

<script>
var compareData= new Array()
compareData.push(${ CompareItem.getChartData()})
console.log(compareData)
</script>


<img src="${CompareItem.getItem_img()}">

${ CompareItem.getChartData()}





</body>
</html>