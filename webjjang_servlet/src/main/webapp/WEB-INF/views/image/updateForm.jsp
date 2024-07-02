<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글 수정</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>



<script type="text/javascript">
	$(function() {
		console.log("jqurey loading");
		
		$("#writeForm").submit(function() {
			//alert("submit");
			// 데이터 유효성 검사
			// 필수 항목 체크
			if(isEmpty("#title","제목",true)) return false;
			if(isEmpty("#content","내용",true)) return false;
			if(isEmpty("#writer","작성자",true)) return false;
			if(isEmpty("#pw","비밀번호",false)) return false;
			// 길이 체크
			if(lengthCheck("#title","제목",3,100,true)) return false;
			if(lengthCheck("#content","내용",3,1000,true)) return false;
			if(lengthCheck("#writer","작성자",2,10,true)) return false;
			if(lengthCheck("#pw","비밀번호",4,20,false)) return false;
			
			
			
			//return false;
		});
	});
</script>
</head>
<body class="bg-light">

<div class="container">
<form action="update.do" method="post" id="writeForm">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h1><i class="fa fa-eraser"></i>일반 게시판 글 수정</h1>
		<div class="form-group">
			<label for="no">글번호</label>
				<input type="text" class="form-control" readonly id="no" name="no" value="${boardVO.no }">
		</div>
		<div class="form-group">
			<label for="title">제목</label>
				<input type="text" class="form-control" placeholder="제목 입력" value="${boardVO.title }" id="title" name="title">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
				<textarea class="form-control" rows="8" cols="125" id="content" placeholder="내용 입력" name="content">${boardVO.content }</textarea>
		</div>
		<div class="form-group">
			<label for="writer">작성자</label> 
				<input type="text" class="form-control" placeholder="작성자 입력" value="${boardVO.writer }" id="writer" name="writer">
		</div>
		<div class="form-group">
			<label for="pw">비밀번호</label>
				<input type="password" class="form-control" placeholder="비밀번호 입력" id="pw" name="pw">
		</div>
		<input name="page" value="${param.page }" type="hidden">
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		<input name="key" value="${param.key }" type="hidden">
		<input name="word" value="${param.word }" type="hidden">
		
		<button type="submit" class="btn btn-dark">수정</button>
		<button type="reset" class="btn btn-light">리셋</button>
		<button type="button" class="btn btn-secondary cancelBtn">취소</button>	
		</div>	
</form>
</div>
</body>
</html>