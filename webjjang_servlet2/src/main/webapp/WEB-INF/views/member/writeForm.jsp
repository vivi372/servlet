<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<!-- 라이브러리 등록 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
	
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<script type="text/javascript" src="/js/BoardInputUtil.js"></script>


<script type="text/javascript">
	$(function() {
		//if(isEmpty("#id","아이디",true))
		//이벤트 처리
		//아이디 체크 처리
		$("#id").keyup(function() {
			let id = $(this).val();
			console.log(id);
			//3자 미만인 경우
			if(id.length < 3){
				//class 지정 디자인
				$("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-warning");
				$("#checkIdDiv").text("아이디는 필수 입력 입니다. 3글자 이상입니다.");
			} else {
				//서버에 가서 데이터를 확인하고 온다. - 결과를 JSP로 받는다.
				//$("#checkIdDiv") 안에 넣을 문구를 가져 와서 넣는다.
				//ajx의 load 함수 사용 load(url , data , function(){})
				//status -상태 - success/error, 통신객체
				
// 				$("#checkIdDiv").load("/ajax/checkId.do?id="+id , function(result) {
// 					if(result.indexOf("중복")>=0) {
// 						$("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-danger");
// 					} else {
// 						$("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-success");					
// 					}				
// 				}); // load()의 끝
				
				$.ajax({
					url: "/ajax/checkId.do?id="+id,
					success: function(data) {
						console.log("ajax - "+data);						
						if(data != id) {
	 						$("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-success");					
	 						$("#checkIdDiv").text("사용가능한 아이디입니다.");
	 					} else {
	 						$("#checkIdDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-danger");
	 						$("#checkIdDiv").text("중복된 아이디입니다. 다른 아이디를 입력해주세요.");
	 					}				
					}
				});
			} // if ~ else의 끝
			
		}); // $("#id").keyup()의 끝
		
		
		//비밀번호와 비밀빈호 확인의 이벤트 시작		
		$("#pw, #pw2").keyup(function() {
			let pw = $("#pw").val();
			let pw2 = $("#pw2").val();
			if(pw.length < 4) {
				$("#pwDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-warning");				
				$("#pwDiv").text("비밀번호는 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");				
			} else {
				$("#pwDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-warning");				
				$("#pwDiv").text("4글자 이상입니다.");
			}
			if(pw2.length < 4){
				$("#pw2Div").removeClass("alert-success alert-danger alert-warning").addClass("alert-warning");
				$("#pw2Div").text("비밀번호 확인은 필수 입력 입니다. 4글자 이상 입력하셔야 합니다.");
			} else {
				$("#pw2Div").removeClass("alert-success alert-danger alert-warning").addClass("alert-warning");
				$("#pw2Div").text("4글자 이상입니다.");
			}
			if(pw.length >= 4 && pw2.length >= 4){
				if(pw == pw2){
					$("#pwDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-success");
					$("#pwDiv").text("적당한 비밀번호입니다.");	
					$("#pw2Div").removeClass("alert-success alert-danger alert-warning").addClass("alert-success");
					$("#pw2Div").text("적당한 비밀번호 확인입니다.");
				} else {
					$("#pwDiv").removeClass("alert-success alert-danger alert-warning").addClass("alert-danger");
					$("#pwDiv").text("비밀번호가 일치하지 않습니다.");
					$("#pw2Div").removeClass("alert-success alert-danger alert-warning").addClass("alert-danger");
					$("#pw2Div").text("비밀번호와 일치하지 않습니다.");
				}			
			}
			
		});// $("#pw, #pw2").keyup()의 끝
		
		//날짜 입력 설정 - datepicker
		let now = new Date();
		let endYear = now.getFullYear();
		let yearRange = (endYear - 100) +":" + endYear ;		
		$(".datepicker").datepicker({
			//년,월 선택 입력 추가
			changeMonth: true,
			changeYear: true,
			//입력한의 데이터 포맷
			dateFormat: "yy-mm-dd",		
			//요일,월 선택 때 이름 - 원래는 영어
			dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
			monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
			//선택할수 있는 최대 날짜
			"maxDate" : now,
			//선택할수 있는 년도 범위 - 0~100살까지
			yearRange: yearRange		
		}
		);
		    
		
	});// $(function()) 의 끝
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<h3><i class="fa fa-address-card"></i> <b> 회원 가입</b></h3>
		
		<form action="/member/write.do" method="post" id="writeForm" enctype="multipart/form-data">
			<div class="form-group">
				<label for="id">아이디</label> 
				<input type="text" class="form-control" placeholder="아이디 입력" id="id" name="id"
				maxlength="20" pattern="^[a-zA-Z][a-zA-Z0-9]{2,19}$" title="맨앞에 영문자만 가능. 3~20자 이내" required autocomplete="off">
			</div>
			<div id="checkIdDiv" class="alert alert-warning">
				아이디는 필수 입력 입니다. 3글자 이상입니다.
			</div>			
			
			<div class="form-group">
				<label for="pw">비밀번호</label> 
				<input type="password" class="form-control" placeholder="비밀번호 입력" id="pw" name="pw"
				maxlength="20" pattern="^.{4,20}$" title="비밀번호는 4~20자로 작성하셔야 합니다." required>
			</div>
			<div id="pwDiv" class="alert alert-warning">
				비밀번호는 필수 입력 입니다. 4글자 이상입니다.
			</div>
			<div class="form-group">
				<label for="pw2">비밀번호 확인</label> 
				<input type="password" class="form-control" placeholder="비밀번호 확인" id="pw2"
				maxlength="20" pattern="^.{4,20}$" title="비밀번호는 4~20자로 작성하셔야 합니다." required>
			</div>
			<div id="pw2Div" class="alert alert-warning">
				비밀번호 확인은 필수 입력 입니다. 4글자 이상입니다.
			</div>
			<div class="form-group">
				<label for="name">이름</label> 
				<input type="text" class="form-control" placeholder="이름 입력" id="name" name="name"
				maxlength="10" pattern="^[가-힣]{2,10}$" title="이름은 한글로 두자부터 열자만 가능합니다." required>
			</div>
			<div class="form-group">
				<label>성별</label> <br>
				<div class="form-check-inline">
  					<label class="form-check-label">
    					<input type="radio" class="form-check-input" name="gender" value="남자" checked>남자
  					</label>
				</div>
				<div class="form-check-inline">
  					<label class="form-check-label">
    					<input type="radio" class="form-check-input" name="gender" value="여자">여자
  					</label>
				</div>				
			</div>
			<div class="form-group">
				<label for="birth">생년월일</label> 
				<input type="text" class="form-control datepicker" placeholder="생년월일" id="birth" name="birth" required autocomplete="off">			
			</div>
			
			<div class="form-group">
				<label for="tel">연락처</label> 
				<input type="text" class="form-control" placeholder="XXX-XXXX-XXXX" id="tel" name="tel"
				pattern="^(\+82|0)[1-9][0-9]{1,2}-[0-9]{3,4}-[0-9]{4}$" title="틀린 형식의 전화 번호입니다.">
			</div>
			
			<div class="form-group">
				<label for="email">이메일</label> 
				<input type="text" class="form-control" placeholder="이메일 입력" id="email" name="email"
				 pattern="^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,}$" title="올바르지 않는 이메일 형식입니다." required>
			</div>
			
			<div class="form-group">
				<label for="photoFile">사진 첨부 : </label><br>
					<input class="btn" type="file" id="photoFile" name="photoFile">
			</div>				
		
			
			<input name="perPageNum" value="${param.perPageNum }" type="hidden">
			
			<div class="btn-group mt-3">
				<!-- 등록 버튼을 클릭하면 1. click-btn 2.submit-form 이벤트로 처리 가능하다. -->
	  			<button type="submit" class="btn btn-dark" id="writeBtn">회원가입</button>
	 			<button type="reset" class="btn btn-light">초기화</button>
	  			<button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
			</div>		
		</form>
		
	</div>
	
</div>
</body>
</html>