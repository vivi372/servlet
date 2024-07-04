<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 게시판 리스트</title>
<!-- 라이브러리 등록 -->
<!-- sitemesh에서 등록 처리 -->	

<style type="text/css">
.dataRow:hover {
	opacity : 70%;
	background: rgb(192, 192, 192);
	cursor: pointer;
}
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
<script type="text/javascript">
	$(function() {
		console.log("제이쿼리 로딩");
		$(".dataRow").click(function() {
			//alert("click");
			//글번호 필요 - 수집
			let no = $(this).data("no");
			console.log(no);
			let link = "view.do?no="+no+"&${pageObject.getPageQuery()}";
			location =link;
		});
		
		// perPageNum 처리
		$("#perPageNum").change(function() {
			//alert("change perPageNum");
			// page는 1페이지 + 검색 데이터 전부 보낸다.
			$("#search").submit();
		});
		
		//검색 데이터 세팅		
		$("#key").val("${(empty pageObject.key)?'t':pageObject.key}");
		$("#perPageNum").val("${(empty pageObject.perPageNum)?'6':pageObject.perPageNum}");
		$("#word").val("${pageObject.word}");
		//$("#perPageNum").val("${pageObject.perPageNum}");	
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-align-justify"></i>이미지 게시판 리스트</h2>
	<form action="list.do" id="search">
		<input name="page" value="1" type="hidden">
		<div class="row">		
			<div class="col-md-8">				
				<div class="input-group mb-3">
  					<div class="input-group-prepend">    					
   						<select name="key" id="key" class="form-control">
   							<option value="t">제목</option>
   							<option value="c">내용</option>
   							<option value="w">작성자</option>
   							<option value="tc">제목+내용</option>
   							<option value="cw">내용+작성자</option>
   							<option value="tcw">모두</option>
   						</select>    					
  					</div>
 				 	<input type="text" class="form-control" placeholder="검색" id="word" name="word">
 				 	<div class="input-group-append">
    					<button class="btn btn-dark" type="submit"><i class="fa fa-search"></i></button>
  					</div>
				</div>				
			</div>	<!-- col-8 end : 검색 -->			
			<div class="col-md-4">
				<!-- 너비를 조정하기 위한 div 추가 - float-right : 오른쪽 정렬 -->
				<div style="width: 200px;" class="float-right">
					<div class="input-group mb-3">
	    				<div class="input-group-prepend">
	      					<span class="input-group-text bg-dark text-white">페이지당 글수:</span>
	    				</div>
	    				<select name="perPageNum" id="perPageNum" class="form-control">
	   						<option value="6">6</option>
	   						<option value="9">9</option>
	   						<option value="12">12</option>
	   						<option value="15">15</option>   							
	   					</select>
	  				</div>
  				</div>
			</div>	<!-- col-4 end : 한 페이지당 페이지 수 -->	
		</div>
	</form>	
	<c:if test="${empty list }">
		<div class="jumbtron">
			<h4>데이터가 존재하지 않습니다.</h4>
		</div>
	</c:if>
	<c:if test="${!empty list }">
		<!-- 이미지의 데이터가 있는 만큼 반복해서 표시 -->
		<div class="row my-3">
			<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
			<c:forEach items="${list }" var="vo" varStatus="vs">	
				<!-- 줄 바꿈 처리 - 찍는 인덱스 번호가 3의 배수이면 줄바꿈을 한다. -->
				<c:if test="${vs.index != 0 && vs.index % 3 ==0 }">
					${"</div>" }
					${"<div class='row my-3'>" }
				</c:if>
				<div class="col-md-4">
		    		<div class="card dataRow" data-no="${vo.no }" style="width:100%">
		    			<img class="card-img-top" src="${vo.fileName }" alt="Card image" height="400px" style="width:100%">
		    			<div class="card-body">
		      				<h4 class="card-title">${vo.no}. ${vo.title }</h4>
		      				<p class="card-text">
		      					작성자 : ${vo.name }
		      					<br>
		      					작성일 : ${vo.writeDate }
		      				</p>      				
		    			</div>
		  			</div>
<!--   				imgCard end -->
  				</div> 	
  			<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 끝 -->
  			</c:forEach>
		</div>
	</c:if>

	<c:if test="${!empty login }">
		<a class="btn btn-dark mt-2" href="/image/writeForm.do?${pageObject.getPageQuery()}">글 등록</a>
	</c:if>
	<div class="pagination justify-content-center mt-2">
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>			
	</div>
	</div>
	</div>

</body>
</html>