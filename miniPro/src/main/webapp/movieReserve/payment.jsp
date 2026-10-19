<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>결제해야지</h1>
<%
	String selectedSeats = request.getParameter("selectedSeats");
%>
<p><%= selectedSeats %>
</body>
</html>