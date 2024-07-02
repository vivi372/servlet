<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>

<script type="text/javascript">
	$(function() {	
		// 댓글 페이지 이벤트 처리
		$("#replyPerPageNum").change(function() {
			location = "/board/view.do?no=${replyPageObject.no}&inc=0&${replyPageObject.pageObject.pageQuery}&replyPage=1&replyPerPageNum="+$("#replyPerPageNum").val();
		});
		$("#replyPerPageNum").val("${replyPageObject.replyPageObject.perPageNum}");
		
		// 모달 화면 이벤트 처리
		$('#boardReplyModal').on('hidden.bs.modal', function () {
			// 모달창 닫힐때 데이터 지우기
			$("#boardReplyForm").attr("action","");				
			$("#replyRno").val("");			
			$("#replyWriter").val("");
			$("#replyContent").val("");
			$("#replyPw").val("");
			$("#replyPw2").val("");			
		});
		
		$("#replyWriteBtn").click(function() {
			// 데이터 전송해서 실행되는 uri를 지정한다.
			$("#boardReplyForm").attr("action","/boardreply/write.do");
			// 제목을 댓글 등록
			$("#boardReplyModal").find(".modal-title").text("댓글 등록 폼");
			// input / text를 선택 - 작성자 , 내용, 비밀번호 , 비밀번호 확인	
			$("#boardReplyForm").find(".form-group").show();
			// 버튼을 선택한다.
			$("#modalSubmitBtn").text("등록 처리");
			$("#modalSubmitBtn").attr("class","btn btn-dark");
			// 모달창 보이게
			$("#boardReplyModal").modal("show");
		});
		
		$(".replyUpdateBtn").click(function() {
			// 데이터 전송해서 실행되는 uri를 지정한다.
			$("#boardReplyForm").attr("action","/boardreply/update.do");
			// 제목을 댓글 수정
			$("#boardReplyModal").find(".modal-title").text("댓글 수정 폼");	
			// input / text를 선택 - 작성자 , 내용, 비밀번호
			$("#boardReplyForm").find(".form-group").show();
			$("#replyPw2Input").hide();
			// 댓글 번호와 내용, 작성자를 데이터를 수집해서 value값으로 세팅해야 한다.
			let replyDataRow = $(this).closest(".replyDataRow");			
			// date("rno") -> tag 안에 data-rno = "값"
			let rno = replyDataRow.data("rno");
			$("#replyRno").val(rno);
			let writer = replyDataRow.find(".replyWriter").text();			
			$("#replyWriter").val(writer);
			let content = replyDataRow.find(".replyContent").text();			
			$("#replyContent").val(content);
			// 버튼을 선택한다.
			$("#modalSubmitBtn").text("수정 처리");
			$("#modalSubmitBtn").attr("class","btn btn-outline-secondary");
			// 모달창 보이게
			$("#boardReplyModal").modal("show");
			
		});
		
		$(".replyDeleteBtn").click(function() {
			// 데이터 전송해서 실행되는 uri를 지정한다.
			$("#boardReplyForm").attr("action","/boardreply/delete.do");
			// 제목을 댓글 삭제
			$("#boardReplyModal").find(".modal-title").text("댓글 삭제 폼");	
			// input / text를 선택
			$("#boardReplyForm").find(".form-group").hide();
			$("#replyPwInput").show();
			// 댓글 번호와 내용, 작성자를 데이터를 수집해서 value값으로 세팅해야 한다.
			let rno = $(this).closest(".replyDataRow").data("rno");
			$("#replyRno").val(rno);
			// 버튼을 선택한다.
			$("#modalSubmitBtn").text("삭제 처리");
			$("#modalSubmitBtn").attr("class","btn btn-secondary");
			// 모달창 보이게
			$("#boardReplyModal").modal("show");
		});
		
		
		
	});
	
</script>


<style type="text/css">

.page-link {
  color: #444;  
  border-color: #444;
}

.page-item.active .page-link {
 z-index: 1;
 color: #ccc;
 font-weight:bold;
 background-color: #333;
  border-color: #444;
 
}

.page-link:focus, .page-link:hover {
  color: #ccc;
  background-color: #222; 
  border-color: #444;
}

</style>

<div class="card">
 	<div class="card-header">
 		<span class="btn btn-dark float-right" id="replyWriteBtn">등록</span>
 		<div style="width: 250px;" class="float-right mr-3">
			<div class="input-group mb-3">
   				<div class="input-group-prepend">
     				<span class="input-group-text bg-dark text-white">페이지당 댓글 수:</span>
   				</div>
   				<select name="replyPerPageNum" id=replyPerPageNum class="form-control">
					<option value="10">10</option>
					<option value="15">15</option>
					<option value="20">20</option>
					<option value="25">25</option>   							
  				</select>
 			</div>
		</div>
 		<h4>댓글 리스트</h4>
 	</div>
 	<div class="card-body"> 
 		<c:if test="${empty replyList }">
 			데이터가 존재하지 않습니다.
 		</c:if>
 		<c:if test="${!empty replyList }">
 			<c:forEach items="${replyList }" var="vo"> 				
		  		<div class="card replyDataRow" data-rno="${vo.rno }" style="margin: 5px 0">
				    <div class="card-header">
				    	<span class="float-right">${vo.writeDate }</span>
		 				<b class="replyWriter">${vo.writer }</b>
					</div>
				    <div class="card-body">
				    	<pre class="replyContent">${vo.content }</pre>
				    </div> 
				    <div class="card-footer">
				    	<button class="btn btn-outline-secondary btn-sm replyUpdateBtn">수정</button>
				    	<button class="btn btn-secondary btn-sm replyDeleteBtn">삭제</button>
				    </div>
		  		</div> 
		  	</c:forEach>
  		</c:if>  			
 	</div> 
 	<div class="card-footer pagination justify-content-center">
 		<pageNav:replayPageNav listURI="view.do" pageObject="${replyPageObject }"></pageNav:replayPageNav>
 	</div>
 	
 	<!-- 댓글 등록 / 수정 / 삭제를 위한 모달창 -->
 	<!-- The Modal -->
  	<div class="modal fade" id="boardReplyModal">
    	<div class="modal-dialog modal-dialog-centered">
      		<div class="modal-content">
      		
      			<form method="post" id="boardReplyForm">
	        		<!-- Modal Header -->
	        		<div class="modal-header">
	        			<!-- 버튼에 따라서 제목을 수정해서 사용 - .text(제목) -->
	          			<h4 class="modal-title"></h4>
	          			<button type="button" class="close" data-dismiss="modal">&times;</button>
	       			</div>
	        
	        		<!-- Modal body -->
	        		<div class="modal-body">
	          			
	          				<input id="replyNo" name="no" type="hidden" value="${param.no }">
	          				<input id="replyRno" name="rno" type="hidden">
	          				<div class="form-group" id="replyWriterInput">
	    						<label for="replyWriter">작성자:</label>
	    						<input class="form-control" placeholder="작성자 입력" id="replyWriter" name="writer">
	  						</div>
	  						<div class="form-group" id="replyContentInput">
	    						<label for="replyContent">내용:</label>
	    						<textarea rows="3" cols="100" class="form-control" placeholder="내용 입력" id="replyContent" name="content"></textarea>    						
	  						</div>  						
	  						<div class="form-group" id="replyPwInput">
	    						<label for="replyPw">비밀번호:</label>
	    						<input type="password" class="form-control" placeholder="비밀번호 입력" id="replyPw" name="pw">
	  						</div>
	  						<div class="form-group" id="replyPw2Input">
	    						<label for="replyPw2">비밀번호 확인:</label>
	    						<input type="password" class="form-control" placeholder="비밀번호 확인" id="replyPw2">
	  						</div>
	  						<!-- 페이지 정보 보내기 -->
	  						<input name="page" value="${param.page }" type="hidden">
							<input name="perPageNum" value="${param.perPageNum }" type="hidden">
							<input name="key" value="${param.key }" type="hidden">
							<input name="word" value="${param.word }" type="hidden">	
							<!-- 댓글 페이지 정보 보내기 -->				
	          				<input id="replyPage" name="replyPage" type="hidden" value="${param.replyPage }">
	          				<input id="replyPerPageNum" name="replyPerPageNum" type="hidden" value="${param.replyPerPageNum }">
	          			
	        		</div>
	        
	        		<!-- Modal footer -->
	        		<div class="modal-footer">
	          			<button type="submit" class="btn btn-dark" id="modalSubmitBtn">등록 처리</button>
<!-- 	          			<button type="submit" class="btn btn-dark" id="replyModalUpdateBtn">수정 처리</button> -->
<!-- 	          			<button type="submit" class="btn btn-dark" id="replyModalDeleteBtn">삭제 처리</button> -->
	          			<button type="button" class="btn btn-outline-dark" data-dismiss="modal">닫기</button>
	        		</div>
        		</form>
        		
      		</div>
    	</div>
  	</div>
  	
</div>


