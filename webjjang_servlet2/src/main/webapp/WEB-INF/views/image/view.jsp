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
		
		
		
		$('[data-toggle="tooltip"]').tooltip();   		
		
		let cardImg = $('[alt="Card image"]');			
		let imgWidth = cardImg.width();
		if(cardImg.parent().width()<cardImg.width()) cardImg.addClass('w-100');
		window.addEventListener("resize", function(){
			if(cardImg.parent().width()<imgWidth) cardImg.addClass('w-100');
			else cardImg.removeClass('w-100');
		});
				
		$("#deleteBtn").click(function() {
			// js 경고창 - alert : 일반 경고, confirm : 확인/취소, prompt : 키인
			//확인 창이 나타나는데 취소를 누르면 삭제 페이지 이동을 취소시킨다.
			if(!confirm("정말삭제하시겠습니까?")) return false;
		});
		
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
								<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#changeImageModal">
	  								이미지 변경
								</button>
							</c:if>
							
							<a href="${imageVO.fileName }" download class="btn btn-light">다운로드</a>
							
	  					</div>
  					</div>
  					<div class="card-body">	    				
	    				<pre class="card-text">${imageVO.content }</pre>    				
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
			
				<a class="btn btn-light" href="updateForm.do?no=${imageVO.no}&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }"
				data-toggle="tooltip" data-placement="top" title="이미지 수정은 이미지 변경에서 가능합니다." id="updateBtn">
						수정
				</a>
			
			<!--<button class="btn btn-secondary" id="deleteBtn" data-target="#myModal">삭제</button>-->
			
				<a href="delete.do?perPageNum=${param.perPageNum }&no=${param.no }&deleteFileName=${imageVO.fileName }">
				<button type="button" id="deleteBtn" class="btn btn-secondary">
	   				삭제
	 			</button>
	 			</a>
			
		</div>		
	<!-- container의 끝 -->
	</div>
	
 	<!-- 이미지 바꾸기 모달 -->
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