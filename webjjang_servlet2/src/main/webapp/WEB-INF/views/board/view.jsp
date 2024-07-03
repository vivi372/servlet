<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일반 게시판 글 보기</title>
<meta charset="utf-8">





<script type="text/javascript" src="/js/BoardInputUtil.js"></script>

<script type="text/javascript">
	$(function() {
		
		//이벤트 처리
		//메인 삭제 버튼 클릭
		$("#deleteBtn").click(function() {			
			//$("#deleteDiv").show();
			//$("#pw").val("");
			$("#deleteModal").modal("show");
			$("#deleteBtn").attr("disabled",true);
		});
		
		//form 삭제 버튼 클릭
		$("#deleteForm").submit(function() {
			console.log("btn-form");
			
			//필수 입력 체크
			if(isEmpty("#pw","비밀번호",false)) return false;
			//길이 체크
			if(lengthCheck("#pw","비밀번호",4,20,false)) return false;
			//return false;
		});
		
		/*
		//form 삭제 취소 버튼 클릭
		$(".delCelBtn").click(function() {
			console.log("btn-form-cancel");
			$("#pw").val("");
			//$("#deleteDiv").hide();
			//모달창 끄기
			//$("#deleteModal").modal("hide");
			$("#deleteBtn").attr("disabled",false);
		});
		*/
		
		$('#deleteModal').on('hidden.bs.modal', function () {
			console.log("btn-form-cancel");
			$("#pw").val("");
			$("#deleteBtn").attr("disabled",false);
		});
		
		
		
		$(".replyUpdateBtn").click(function() {
			let rno = $(this).closest(".replyDataRow").data("rno");
			console.log(rno);
		});
		
		
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-book"></i>일반 게시판 글보기</h2>
	<table class="table">
		
		<tr>
			<th>글번호</th>
			<td>${boardVO.no }</td>
			<th>제목</th>
			<td colspan="3">${boardVO.title }</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${boardVO.writer }</td>
			<th>작성일</th>
			<td>${boardVO.writeDate }</td>
			<th>조회수</th>
			<td>${boardVO.hit }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="6">
				<pre>${boardVO.content }</pre>
			</td>
		</tr>
		<tr>
			<td colspan="6">
				<a href="/board/list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-dark">목록</a>
				<a href="updateForm.do?no=${boardVO.no}&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-light">수정</a>
				<!--<button class="btn btn-secondary" id="deleteBtn" data-target="#myModal">삭제</button>-->
				<button type="button" id="deleteBtn" class="btn btn-secondary" data-toggle="modal" data-target="#deleteModal">
    			삭제
  				</button>
				
			</td>			
		</tr>		
	</table>
	
	<!-- 댓글 처리 시작 -->
	<jsp:include page="boardreply.jsp"></jsp:include>
	<!-- 댓글 처리 끝 -->
	
	<!-- container의 끝 -->
	</div>
	<!-- The Modal -->
  	<div class="modal fade" id="deleteModal">
    	<div class="modal-dialog modal-dialog-centered">
      		<div class="modal-content">
      			
	        	<!-- Modal Header -->
	       		<div class="modal-header">
	         		<h4 class="modal-title"><i class="material-icons">delete</i>삭제를 위한 비밀번호 입력</h4>
	          		<button type="button" class="close delCelBtn" data-dismiss="modal">&times;</button>
	        	</div>
	        
	        	<!-- Modal body -->
	        	<div class="modal-body">
	        		<form action="delete.do?perPageNum=${param.perPageNum }" method="post" id="deleteForm" class="form-inline">
	        			<input id="no" name="no" type="hidden" value="${param.no }">
						<input id="pw" name="pw" type="password" placeholder="비밀번호 입력" style="padding: 5px">
						<button class="btn btn-secondary">삭제 처리</button>
					</form>
	        	</div>
	        
	        	<!-- Modal footer -->
	        	<div class="modal-footer">	        		
	          		<button type="button" class="btn btn-dark delCelBtn" data-dismiss="modal">취소</button>
	        	</div>
        		
      		</div>
    	</div>
  	</div>
 
</div>
</body>
</html>