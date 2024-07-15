<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 리스트</title>
<!-- 라이브러리 등록 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
	
<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>


<!-- sitemesh에서 등록 처리 -->	

<style type="text/css">
.dataRow:hover {
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
.custom-control-label:hover{
	cursor: pointer;
}
.custom-radio .custom-control-input:checked~.custom-control-label::before{
 	background-color: black;
    border-color: black;
}
</style>
<script type="text/javascript">
	$(function() {
		console.log("제이쿼리 로딩");
		$(".dataRow").click(function() {
			//alert("click");
			//글번호 필요 - 수집
			let no = $(this).find(".no").text();
			console.log(no);
			let link = "view.do?no="+no+"&inc=1&period=${pageObject.period }&${pageObject.getPageQuery()}";
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
		$("#perPageNum").val("${(empty pageObject.perPageNum)?'10':pageObject.perPageNum}");
		$("#word").val("${pageObject.word}");
		$("#perPageNum").val("${pageObject.perPageNum}");	
		
		
		$(".noticeOpt").change(function() {
			//alert("라디오버튼 클릭");
			if(this.optList[0].checked) {
				//alert("현재공지");	
				location = "/notice/list.do?period=pre";
			}
			else if(this.optList[1].checked) {
				//alert("이전공지");	
				location = "/notice/list.do?period=old";
			}
			else if(this.optList[2].checked) {
				//alert("예정공지");	
				location = "/notice/list.do?period=res";
			}
			else if(this.optList[3].checked) {
				//alert("모든공지");	
				location = "/notice/list.do?period=all";
			}			

		});		
		
// 		$("#${pageObject.period}").attr("checked","true");		
		$("[value='${pageObject.period}']").attr("checked","true");		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-align-justify"></i>공지사항 리스트</h2>
	<form action="list.do?" id="search">
		<input name="page" value="1" type="hidden">
		<div class="row">		
			<div class="col-md-8">				
				<div class="input-group mb-3">
  					<div class="input-group-prepend">    					
   						<select name="key" id="key" class="form-control">
   							<option value="t">제목</option>
   							<option value="c">내용</option>   							
   							<option value="tc">제목+내용</option>   							 							
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
	   						<option value="10">10</option>
	   						<option value="15">15</option>
	   						<option value="20">20</option>
	   						<option value="25">25</option>   							
	   					</select>
	   					<input name="period" type="hidden" value="${pageObject.period}">
	  				</div>
  				</div>
			</div>	<!-- col-4 end : 한 페이지당 페이지 수 -->	
		</div>
	</form>	
	<c:if test="${!empty login && login.gradeNo==9 }">	
		<form class="noticeOpt mb-3">									
			<div class="custom-control custom-radio custom-control-inline">		  
				<input type="radio" class="custom-control-input" id="pre" name="optList" value="pre">  	
		    	<label class="custom-control-label" for="pre">
		    		현재 공지
		    	</label>
		  	</div>
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="old" name="optList" value="old">
		    	<label class="custom-control-label" for="old">이전 공지</label>
		  	</div>
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="res" name="optList" value="res">
		    	<label class="custom-control-label" for="res">예정 공지</label>
		  	</div>
		  	<div class="custom-control custom-radio custom-control-inline">
		    	<input type="radio" class="custom-control-input" id="all" name="optList" value="all">
		    	<label class="custom-control-label" for="all">모든 공지</label>
		  	</div>					  		
		</form>				
	</c:if>
	<div class="table-responsive-lg">
	<table class="table">		
		<tr>			
			<th>번호</th>
			<th>제목</th>
			<th>시작일</th>
			<th>종료일</th>			
			<th>수정일</th>
		</tr>
		<c:forEach items="${list }" var="vo">
			<tr class = "dataRow">
			<td class = "no">${vo.no}</td>
			<td>${vo.title}</td>
			<td>${vo.startDate}</td>
			<td>${vo.endDate}</td>			
			<td>${vo.updateDate}</td>
		</tr>
		</c:forEach>		
		<c:if test="${!empty login && login.gradeNo==9 }">
			<tr>
				<td colspan="5">
					<a href="/notice/writeForm.do?period=${pageObject.period }&${pageObject.getPageQuery()}"><button class="btn btn-dark">글 등록</button></a>
				</td>				
			</tr>
			
		</c:if>
		
	</table>
	<div class="pagination justify-content-center">
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>			
	</div>
	</div>
	</div>
</div>
</body>
</html>