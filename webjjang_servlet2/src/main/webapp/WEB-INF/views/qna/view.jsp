<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 답변 글 보기</title>
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
		
		
		$('#deleteModal').on('hidden.bs.modal', function () {
			console.log("btn-form-cancel");
			$("#pw").val("");
			$("#deleteBtn").attr("disabled",false);
		});	
		
		
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-book"></i>질문 답변 글보기</h2>
	<div class="card mb-3">
  		<div class="card-header">
  			<span class="float-right">번호: ${vo.no }</span>
  			${vo.title }
  		</div>
  		<div class="card-body"><pre>${vo.content }</pre></div>
  		<div class="card-footer">
  			<span class="float-right">${vo.writeDate }</span>
  			${vo.name }
  		</div>
	</div>	
		<a href="/qna/list.do?${pageObject.pageQuery }" class="btn btn-dark">목록</a>
		<a href="updateForm.do?no=${vo.no}&${pageObject.pageQuery }" class="btn btn-light">수정</a>
		<c:if test="${!empty login && vo.id != login.id && (vo.levNo<3)}">
			<a href="answerForm.do?no=${vo.no}&${pageObject.pageQuery }" class="btn btn-light">답변</a>
		</c:if>
		<!--<button class="btn btn-secondary" id="deleteBtn" data-target="#myModal">삭제</button>-->
		<button type="button" id="deleteBtn" class="btn btn-secondary" data-toggle="modal" data-target="#deleteModal">
	 		삭제
		</button>
	
				
	
	
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