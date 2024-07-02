<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 게시판 글 등록</title>
<!-- 라이브러리 등록 -->
	
<script type="text/javascript" src="/js/BoardInputUtil.js"></script>



<script type="text/javascript">
	$(function() { // == $(document).ready(function(){~});		
		//1. click 이벤트 - writeBtn
		//$("#writeBtn").click(function() {	
		//1. submit 이벤트 - writeForm
		$("#writeForm").submit(function() {			
			//alert("writeForm submit");			
			
			//필수 항목
			// 제목 체크 - 제목란의 값을 가져와서 좌우 공백을 제거한다.
			let title = $("#title").val().trim();
			// 공백을 제거한 데이터를 제목 입력란에 다시 넣는다.
			$("#title").val(title);			
			if(title=="") {
				alert("제목은 필수 입력 항목입니다."); // 경고
				$("#title").focus(); // 커서 위치
				return false; // 페이지 이동을 막는다.
			} // 제목 체크의 끝
			
			//내용 필수 항목 체크
			if(isEmpty("#content","내용",true)) return false;
			

			//내용 필수 항목 체크
			if(isEmpty("#writer","작성자",true)) return false;
			

			//내용 필수 항목 체크
			if(isEmpty("#pw","비밀번호",false)) return false;
			

			//내용 필수 항목 체크
			if(isEmpty("#pw2","비밀번호 확인",false)) return false;
			
			//길이 제한 체크
			//길이 체크
			if(lengthCheck("#title","제목",3,100,true)) return false;
			if(lengthCheck("#content","내용",3,1000,true)) return false;
			if(lengthCheck("#writer","작성자",2,10,true)) return false;
			if(lengthCheck("#pw","비밀번호",4,20,false)) return false;
			if(lengthCheck("#pw2","비밀번호 확인",4,20,false)) return false;
			
			
			//비밀번호와 비밀번호 확인	
			let pw=$("#pw").val();
			let pw2=$("#pw2").val();
			if(pw!=pw2) {
				alert("비밀번호와 비밀번호 확인 같지 않습니다. 다시 입력해주세요."); // 경고
				// 비밀번호 비밀번호 확인의 데이터를 지운다.
				$("#pw,#pw2").val("");
				$("#pw").focus(); // 커서 위치
				return false; // 페이지 이동을 막는다.
			}
			
			
			//페이지 이동 막기 - 최초 이벤트 처리되는 함수에 작성된다.			
			//return false;			
		});
		
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h3><i class="fa fa-pencil-square-o"></i>이미지 게시판 글 등록</h3>
	<form action="/image/write.do" method="post" id="writeForm" enctype="multipart/form-data">
		<div class="form-group">
			<label for="title">제목</label> 
				<input type="text" class="form-control" placeholder="제목 입력" id="title" name="title">
		</div>
		<div class="form-group">
			<label for="content">내용</label> 
				<textarea class="form-control" rows="7" placeholder="내용 입력" id="content" name="content"></textarea>
		</div>
		<div class="form-group">
			<label for="pw">사진 첨부</label> 
				<input type="file" id="fileName" name="fileName">
		</div>		
		<div class="form-group">
			<label for="writer">아이디</label> 
				<input type="text" class="form-control" readonly id="id" name="id" value="${login.id }">
		</div>
		
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		
		<div class="btn-group">
			<!-- 등록 버튼을 클릭하면 1. click-btn 2.submit-form 이벤트로 처리 가능하다. -->
  			<button type="submit" class="btn btn-dark" id="writeBtn">등록</button>
 			<button type="reset" class="btn btn-light">초기화</button>
  			<button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
		</div>		
	</form>
	</div>
</div>
</body>
</html>