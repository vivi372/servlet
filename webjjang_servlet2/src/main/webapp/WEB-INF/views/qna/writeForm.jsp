<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${headTitle }</title>
<script type="text/javascript">
$(function() {
	if(${!empty vo}){
		let title = $("#title");
		title.attr("value","[답변]${vo.title }");		
	}
});
</script>
</head>
<body>
<div class="container">
	<h3>${headTitle }</h3>
	<form action="/qna/write.do" method="post">
		<!-- 페이지 정보 넘기기 -->
		<input name="perPageNum" type="hidden" value="${param.perPageNum }">
		<!-- 질문답변 운영 정보 -->
		<input name="refNo" type="hidden" value="${vo.refNo }">
		<input name="ordNo" type="hidden" value="${(empty vo)?1:vo.ordNo+1 }">
		<input name="levNo" type="hidden" value="${(empty vo)?0:vo.levNo+1 }">
		<input name="parentNo" type="hidden" value="${vo.no }">
		<div class="form-group">
			<label for="title">제목</label> 
				<input type="text" class="form-control" placeholder="제목 입력" id="title" name="title" required>
		</div>
		<div class="form-group">
			<label for="content">내용</label> 
				<c:if test="${empty vo }">
					<textarea class="form-control" rows="7" placeholder="내용 입력" id="content" name="content" required></textarea>
				</c:if>
				<c:if test="${!empty vo }">
					<textarea class="form-control" rows="7" placeholder="내용 입력" id="content" name="content" required>

---------------------[질문 원본]---------------------
${vo.content }
</textarea>
				</c:if>
		</div>
		
		<div class="btn-group">
			<!-- 등록 버튼을 클릭하면 1. click-btn 2.submit-form 이벤트로 처리 가능하다. -->
  			<button type="submit" class="btn btn-dark" id="writeBtn">등록</button>
 			<button type="reset" class="btn btn-light">초기화</button>
  			<button type="button" class="btn btn-secondary" onclick="location='/qna/list.do?page=${param.page }&perPageNum=${param.perPageNum }&key=${param.key }&word=${param.word }';">취소</button>
		</div>	
	</form>
</div>
</body>
</html>