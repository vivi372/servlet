<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("일반 게시판 글 삭제 처리 - delete.jsp");
	//데이터 수집
	String noStr = request.getParameter("no");
	String pw = request.getParameter("pw");
	System.out.println("no = "+noStr+" pw = "+pw);
	//글삭제 처리
	//자동으로 리스트로 돌아가기
	response.sendRedirect("list.jsp");
%>