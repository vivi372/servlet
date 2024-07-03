<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글 수정</title>

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
<form action="update.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" method="post" id="writeForm">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h1><i class="fa fa-eraser"></i>일반 게시판 글 수정</h1>
	<div class="alert alert-secondary">
    	이미지를 제외한 나머지 텍스트 데이터를 수정합니다.<br>
    	이미지는 이미지 게시판 상세보기 화면의 이미지 안에 바꾸기 버튼을 사용하세요.
  	</div>
		<div class="form-group">
			<label for="no">글번호</label>
				<input type="text" class="form-control" readonly id="no" name="no" value="${imageVO.no }">
		</div>
		<div class="form-group">
			<label for="title">제목</label>
				<input type="text" class="form-control" placeholder="제목 입력" value="${imageVO.title }" id="title" name="title">
		</div>
		<div class="form-group">
			<label for="content">내용</label>
				<textarea class="form-control" rows="8" cols="125" id="content" placeholder="내용 입력" name="content">${imageVO.content }</textarea>
		</div>		
		
		<button type="submit" class="btn btn-dark">수정</button>
		<button type="reset" class="btn btn-light">리셋</button>
		<button type="button" class="btn btn-secondary cancelBtn" onclick="history.back();">취소</button>	
		</div>	
</form>
</div>
</body>
</html>