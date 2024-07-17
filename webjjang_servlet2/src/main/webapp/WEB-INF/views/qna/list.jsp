<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>질문 답변</title>
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
</style>
<script type="text/javascript">
	$(function() {
		$(".dataRow").click(function() {
			location = "/qna/view.do?no="+$(this).find(".no").text()+"&${pageObject.getPageQuery() }";
		});
	});
</script>
</head>
<body>
<div class="container">
	<h3><i class="material-icons">question_answer</i> 질문 답변 리스트</h3>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>			
		</tr>
		<c:forEach items="${list }" var="vo">
			<tr class="dataRow">
				<td class="no">${vo.no }</td>
				<td>
					<c:if test="${vo.levNo != 0 }">
						<c:forEach begin="1" end="${vo.levNo*3}">						
						&nbsp;
						</c:forEach>
						<i class="material-icons">subdirectory_arrow_right</i>
					</c:if>
					${vo.title }
				</td>
				<td>${vo.name }</td>
				<td>${vo.writeDate }</td>
			</tr> 
		</c:forEach>
	</table>
	<c:if test="${!empty login }">
		<a href="questionForm.do?${pageObject.getPageQuery() }" class="btn btn-dark">질문하기</a>
	</c:if>
	<div class="pagination justify-content-center">
		<pageNav:pageNav listURI="list.do" pageObject="${pageObject }"></pageNav:pageNav>			
	</div>
</div>
</body>
</html>