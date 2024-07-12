<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!-- sitemesh에서 등록 처리 -->	

	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<h2><i class="fa fa-align-justify"></i>공지사항 리스트</h2>		
		<div class="table-responsive-lg">
		<table class="table">		
			<tr>			
				<th>번호</th>
				<th>제목</th>
				<th>게시일</th>
				<th>종료일</th>			
				<th>수정일</th>
			</tr>
			<c:forEach items="${noticeList }" var="vo">
				<tr class = "dataRow notice noticeLink">
				<td class = "no">${vo.no}</td>
				<td>${vo.title}</td>
				<td>${vo.startDate}</td>
				<td>${vo.endDate}</td>			
				<td>${vo.updateDate}</td>
			</tr>
			</c:forEach>			
		</table>	
		</div>
	</div>
