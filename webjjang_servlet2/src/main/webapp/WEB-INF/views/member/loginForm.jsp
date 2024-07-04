<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
</head>
<body class="bg-light">
<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<h3><b>
		<i class="fa fa-sign-in"></i>
		로그인	
		</b></h3>
		<form action="/member/login.do" method="post">
	  		<div class="form-group">
	    		<label for="id">ID:</label>
	    		<input type="text" class="form-control" placeholder="ID를 입력하세요" id="id" name="id" autocomplete="none">
	  		</div>
	  		<div class="form-group">
	    		<label for="pw">Password:</label>
	    		<input type="password" class="form-control" placeholder="비밀번호를 입력하세요" id="pw" name="pw">
	  		</div>	  		
	  		<button type="submit" class="btn btn-dark">로그인</button>
		</form>
	</div>
</div>
</body>
</html>