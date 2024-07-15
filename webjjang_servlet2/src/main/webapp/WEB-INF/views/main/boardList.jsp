<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


	<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
		<h3><i class="fa fa-align-justify mb-2"></i>일반 게시판 리스트</h3>			
		<table class="table">		
			<tr>			
				<th>번호</th>
				<th>제목</th>				
				<th>작성일</th>			
			</tr>
			<c:forEach items="${boardList }" var="vo">
				<tr class = "dataRow board boardLink">
					<td class = "no">${vo.no}</td>
					<td><span class = "title">${vo.title}</span></td>					
					<td>${vo.writeDate}</td>			
				</tr>
			</c:forEach>		
		</table>	
	</div>

