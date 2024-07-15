<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 글 보기</title>
<meta charset="utf-8">





<script type="text/javascript" src="/js/BoardInputUtil.js"></script>

<script type="text/javascript">
	$(function() {		
		$(".replyUpdateBtn").click(function() {
			let rno = $(this).closest(".replyDataRow").data("rno");
			console.log(rno);
		});
		
		$("#deleteBtn").click(function() {
			if(!confirm("정말 삭제하시겠습니까?")){
				return false;
			}
		});
		
	});
</script>
</head>
<body class="bg-light">

<div class="container">
	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-book"></i>공지사항 글보기</h2>
	<table class="table">
		
		<tr>
			<th>글번호</th>
			<td>${vo.no }</td>
			<th>제목</th>
			<td colspan="5">${vo.title }</td>
		</tr>
		<tr>
			<th>시작일</th>
			<td>${vo.startDate }</td>
			<th>종료일</th>
			<td>${vo.endDate }</td>
			<th>작성일</th>
			<td>${vo.writeDate }</td>
			<th>수정일</th>
			<td>${vo.updateDate }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td colspan="8">
				<pre>${vo.content }</pre>            
			</td>
		</tr>
		<tr>
			<td colspan="8">
				<a href="/notice/list.do?period=${param.period }&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-dark">목록</a>
				<c:if test="${!empty login && login.gradeNo==9 }">
					<a href="/notice/updateForm.do?no=${vo.no}&page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }" class="btn btn-light">수정</a>
					<a href="/notice/delete.do?no=${vo.no }&perPageNum=${param.perPageNum }" class="btn btn-dark" id="deleteBtn">삭제</a>	
				</c:if>
				
			</td>			
		</tr>		
	</table>
	
	<!-- 댓글 처리 시작 --> 
<%-- 	<jsp:include page="boardreply.jsp"></jsp:include> --%>
	<!-- 댓글 처리 끝 --> 
	
	<!-- container의 끝 -->
	</div>
	
 
</div>
</body>
</html>