<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet" href="/css/main.css">
<script src="/js/main.js"></script>
</head>
<body class="bg-light">
<div class="container">	
	<div class="m-3">
		<h2><i class="fa fa-buysellads text-dark" style="font-size:40px;"></i> <b>웹짱 닷컴</b></h2>
	</div>
	
	<div class="row">
		<div class="col-md-6 my-3 px-1">			
			<jsp:include page="noticeList.jsp"></jsp:include>
		</div>	
		<div class="col-md-6 my-3 px-1">			
			<jsp:include page="boardList.jsp"></jsp:include>
		</div>			
	</div>
	<div class="row">
		<div class="col-md-12 my-3 mx-1">
			<jsp:include page="imageList.jsp"></jsp:include>			
		</div>
	</div>
</div>
</body>
</html>