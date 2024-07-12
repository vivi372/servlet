<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글 수정</title>
<!-- 라이브러리 등록 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
	
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>

<script type="text/javascript" src="/js/BoardInputUtil.js"></script>



<script type="text/javascript">
	$(function() { // == $(document).ready(function(){~});		
		//날짜 입력 설정 - datepicker
		let now = new Date();
		let endYear = now.getFullYear()+10;
		let yearRange = (endYear - 20) +":" + endYear ;
		$(".datepicker").datepicker({
			//년,월 선택 입력 추가
			changeMonth: true,
			changeYear: true,
			//입력한의 데이터 포맷
			dateFormat: "yy-mm-dd",		
			//요일,월 선택 때 이름 - 원래는 영어
			dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ],
			monthNamesShort: [ "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" ],
			"minDate":now,
			//선택할수 있는 년도 범위 - 10년전부터 10년후 까지
			yearRange: yearRange 
		}
		);	
		
		$("#startDate").datepicker( "option", "maxDate", "${vo.endDate}" );
		$("#endDate").datepicker( "option", "minDate", "${vo.startDate}" );
		
		$("#startDate").change(function() {
			//alert($(this).val());
			$("#endDate").datepicker( "option", "minDate", $(this).val() );
		});
		
		$("#endDate").change(function() {
			//alert($(this).val());
			$("#startDate").datepicker( "option", "maxDate", $(this).val() );
		});
		
		$("#dateReset").click(function() {
			
			$("#startDate").datepicker( "setDate", "${vo.startDate }" );
			$("#endDate").datepicker( "setDate", "${vo.endDate}" );			
			$("#endDate").datepicker( "option", "minDate",now );
			$("#startDate").datepicker( "option", "maxDate",null );
		});
		
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h3><i class="fa fa-pencil-square-o"></i>공지사항 글 수정</h3>
	<form action="/notice/update.do" method="post" id="writeForm">
		<div class="form-group">
			<label for="no">글번호</label>
				<input type="text" class="form-control" readonly id="no" name="no" value="${vo.no }">
		</div>
		<div class="form-group">
			<label for="title">제목</label> 
				<input type="text" class="form-control" placeholder="제목 입력" id="title" name="title" value="${vo.title }">
		</div>
		<div class="form-group">
			<label for="content">내용</label> 
				<textarea class="form-control" rows="7" placeholder="내용 입력" id="content" name="content">${vo.content }</textarea>
		</div>
		<div class="form-group">
			<label>시작일 / 종료일</label> 
			<div class="form-inline">
				<input type="text" class="form-control datepicker" placeholder="시작일" id="startDate" name="startDate" value="${vo.startDate }" required autocomplete="off">	
				<span class="mx-3"> ~ </span>		
				<input type="text" class="form-control datepicker" placeholder="종료일" id="endDate" name="endDate" value="${vo.endDate }" required autocomplete="off">		
				<button class="btn btn-light" type="button" id="dateReset">날짜 리셋</button>
			</div>	
		</div>		
		
		<input name="page" value="${param.page }" type="hidden">
		<input name="perPageNum" value="${param.perPageNum }" type="hidden">
		<input name="key" value="${param.key }" type="hidden">
		<input name="word" value="${param.word }" type="hidden">
		
		<div class="btn-group">
			<!-- 등록 버튼을 클릭하면 1. click-btn 2.submit-form 이벤트로 처리 가능하다. -->
  			<button type="submit" class="btn btn-dark" id="writeBtn">수정</button>
 			<button type="reset" class="btn btn-light">초기화</button>
  			<button type="button" class="btn btn-secondary" onclick="location='/notice/view.do?no=${vo.no }&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }';">취소</button>
		</div>		
	</form>
	</div>
</div>
</body>
</html>