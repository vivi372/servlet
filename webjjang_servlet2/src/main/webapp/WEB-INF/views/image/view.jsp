<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 게시판 글 보기</title>
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
		
		$('#deleteModal').on('hidden.bs.modal', function () {
			console.log("btn-form-cancel");
			$("#pw").val("");
			$("#deleteBtn").attr("disabled",false);
		});	
		
		$('#changeImageModal').on('hidden.bs.modal', function () {			
			$("#imageFile").val("");
			
		});	
		
		
		$('[data-toggle="tooltip"]').tooltip();   
		
		
// 		console.log($("#image").width());
// 		console.log($("#card-header").width());
		
		
		if($("#card-header").width()<$("#image").width()) $("#image").addClass('w-100');
		
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-book"></i>이미지 게시판 글보기</h2>  			
		<div class="card">
 			<div class="card-header">
 				<h5><b>${imageVO.no }. ${imageVO.title }</b></h5>
 			</div>
 			<div class="card-body">
				<div class="card">
  					<div class="card-header" id="card-header">  						
						<!-- card-img-overlay위 또는 card-img-top - 기본 w-100 -->
  						<img class="rounded" src="${imageVO.fileName }" alt="Card image" id="image">
	  					<div class="card-img-overlay ml-2">    					
	    					<c:if test="${login.id == imageVO.id  }">
								<button type="button" class="btn btn-light" data-toggle="modal" data-target="#changeImageModal">
	  								이미지 변경
								</button>
							</c:if>
							<c:if test="${login.id != imageVO.id  }">
								<a href="${imageVO.fileName }" download class="btn btn-light">다운로드</a>
							</c:if>
	  					</div>
  					</div>
  					<div class="card-body">	    				
	    				<p class="card-text"><pre>${imageVO.content }</pre></p>	    				
  					</div>
				</div>
			</div> 
 			<div class="card-footer">
 				<span class="float-right">${imageVO.writeDate }</span>
 				${imageVO.name }			
 			</div>
		</div>	
		<div class="mt-3">
			<a href="list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-dark">목록</a>
			<c:if test="${login.id == imageVO.id  }">
				<a class="btn btn-light" href="updateForm.do?no=${imageVO.no}&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
				data-toggle="tooltip" data-placement="top" title="이미지 수정은 이미지 변경에서 가능합니다." id="updateBtn">
						수정
				</a>
			</c:if>
			<!--<button class="btn btn-secondary" id="deleteBtn" data-target="#myModal">삭제</button>-->
			<c:if test="${login.id == imageVO.id  }">
				<button type="button" id="deleteBtn" class="btn btn-secondary" data-toggle="modal" data-target="#deleteModal">
	   				삭제
	 			</button>
			</c:if>	
		</div>		
	<!-- container의 끝 -->
	</div>
	<!-- 글 삭제 모달 -->
	<!-- The Modal -->
  	<div class="modal fade" id="deleteModal">
    	<div class="modal-dialog modal-dialog-centered">
      		<div class="modal-content">
      			
	        	<!-- Modal Header -->
	       		<div class="modal-header">
	         		<h4 class="modal-title"><i class="material-icons">delete</i>삭제 확인</h4>
	          		<button type="button" class="close delCelBtn" data-dismiss="modal">&times;</button>
	        	</div>
	        
	        	<!-- Modal body -->
	        	<form action="delete.do?perPageNum=${param.perPageNum }" method="post" id="deleteForm" class="form-inline" enctype="multipart/form-data">
		        	<div class="modal-body">
		        		<b>정말로 삭제하시겠습니까?</b><br>
		        			<input id="no" name="no" type="hidden" value="${param.no }">							
							<input name="deleteFileName" value="${imageVO.fileName }" type="hidden">
		        	</div>
		        
		        	<!-- Modal footer -->
		        	<div class="modal-footer">	        		
						<button class="btn btn-secondary">삭제</button>
		          		<button type="button" class="btn btn-dark delCelBtn" data-dismiss="modal">취소</button>
		        	</div>
				</form>
        		
      		</div>
    	</div>
  	</div>
 	
 	<!-- The Modal -->
	<div class="modal" id="changeImageModal">
  		<div class="modal-dialog">
    		<div class="modal-content">

	      		<!-- Modal Header -->
	      		<div class="modal-header">
	        		<h4 class="modal-title">이미지 수정</h4>
	        		<button type="button" class="close" data-dismiss="modal">&times;</button>
	      		</div>
				
				<form action="changeImage.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" method="post" enctype="multipart/form-data">
				    <!-- Modal body -->
				    <div class="modal-body">
				    	<!-- 숨겨야할 데이터 - 이미지 번호, 파일 네임(삭제) -->
				    	<input name="no" value="${imageVO.no }" type="hidden">
				    	<input name="deleteFileName" value="${imageVO.fileName }" type="hidden">
				     	<input type="file" class="btn" name="imageFile" id="imageFile">
				    </div>
		
				    <!-- Modal footer -->
				    <div class="modal-footer">
				    	<button type="submit" class="btn btn-secondary">바꾸기</button>
				    	<button type="button" class="btn btn-dark" data-dismiss="modal">Close</button>
				    </div>
				</form>
    		</div>
  		</div>
	</div>
</div>
</body>
</html>