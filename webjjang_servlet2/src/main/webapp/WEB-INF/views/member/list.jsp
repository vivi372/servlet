<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>

<script type="text/javascript">
	//회원 한줄을 클릭하면 회원 정보보기로 이동 시키는 처리
	$(function() {
		function dataRowClick() {
			alert("test");
		}
		
		$(".dataRow").click(function() {
			dataRowClick();			
		});
		$(".grade, .status").parent().on("mouseover", function() {
			$(".dataRow").off("click");
		})
		.on("mouseout", function() {
			$(".dataRow").on("click", function() {
				dataRowClick();
			});
		});
		
		//등급 변경 - 관리자 변경은 상태가 정상일때만 가능
		$(".changeGradeForm").submit(function() {
			let status = $(this).closest(".dataRow").find(".status").data("value");
			let changeGrade = $(this).find(".grade").val();
			if(status != "정상" && changeGrade == 9) {
				alert("정상 상태가 아닌 회원은 관리자 등급이 될 수 없습니다.");
				return false;
			}
		});
		
		//select 이벤트 처리
		$(".dataRow").on("change", ".grade, .status", function() {
			//this - select 태그 선택 .next() 다음 형제 태그 - div 안 태그
			let value = $(this).data("value");
			console.log(value);
			if(value == $(this).val()){
				$(this).next().find(".btn").attr("disabled","true");	
			} else
				$(this).next().find(".btn").removeAttr("disabled");			
		});
		
		
	});
</script>
<style type="text/css">
.dataRow:hover{
	background: #e0e0e0;
	cursor: pointer;
}
</style>
</head>
<body>
<div class="container">
	<h3>회원 리스트</h3>
	<form action="list.do" id="search">
		<input name="page" value="1" type="hidden">
		<div class="row">		
			<div class="col-md-8">				
				<div class="input-group mb-3">
  					<div class="input-group-prepend">    					
   						<select name="key" id="key" class="form-control">
   							<option value="i">아이디</option>
   							<option value="t">연락처</option>
   							<option value="n">이름</option>
   							<option value="it">아이디+연락처</option>
   							<option value="in">아이디+이름</option>
   							<option value="tn">연락처+이름</option>
   							<option value="itn">모두</option>
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
	  				</div>
  				</div>
			</div>	<!-- col-4 end : 한 페이지당 페이지 수 -->	
		</div>
	</form>	
	
	<table class="table">	
		<thead>	
			<tr>			
				<th>사진</th>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>성별</th>
				<th>연락처</th>
				<th>이메일</th>
				<th>등급</th>
				<th>상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list }" var="vo">
				<tr class="dataRow" data-no="${vo.id}">
					<td class = "no"><img alt="회원 이미지" src="${vo.photo}" class="rounded-circle" width="30px" height="30px"></td>
					<td class="id">${vo.id}</td>
					<td>${vo.name}</td>
					<td>${vo.birth}</td>
					<td>${vo.gender}</td>
					<td>${vo.tel}</td>
					<td>${vo.email}</td>
					<td>
						<form action="changeGrade.do" method="post" class="changeGradeForm">
							<input name="id" type="hidden" value="${vo.id }">
							<input name="page" value="${param.page }" type="hidden">
							<input name="perPageNum" value="${param.perPageNum }" type="hidden">
							<input name="key" value="${param.key }" type="hidden">
							<input name="word" value="${param.word }" type="hidden">
							<div class="input-group mb-3">
  								<select class="form-control grade" name="gradeNo" data-value="${vo.gradeNo }">
  									<option value="1" ${(vo.gradeNo == 1)?"selected":"" }>일반회원</option>
  									<option value="9" ${(vo.gradeNo == 9)?"selected":"" }>관리자</option>
  								</select>
  								<div class="input-group-append">
    								<button class="btn btn-dark" type="submit" disabled="disabled">변경</button>
  								</div>
							</div>
						</form>						
					</td>
					<td>
						<form action="changeStatus.do">
							<input name="id" type="hidden" value="${vo.id }">
							<input name="page" value="${param.page }" type="hidden">
							<input name="perPageNum" value="${param.perPageNum }" type="hidden">
							<input name="key" value="${param.key }" type="hidden">
							<input name="word" value="${param.word }" type="hidden">
							<div class="input-group mb-3">
  								<select class="form-control status" name="status" data-value="${vo.status }">
  									<option ${(vo.status == "정상")?"selected":"" }>정상</option>
  									<option ${(vo.status == "탈퇴")?"selected":"" }>탈퇴</option>
  									<option ${(vo.status == "휴면")?"selected":"" }>휴면</option>
  									<option ${(vo.status == "강퇴")?"selected":"" }>강퇴</option>
  								</select>
  								<div class="input-group-append">
    								<button class="btn btn-dark" type="submit" disabled="disabled">변경</button>
  								</div>
							</div>
						</form>				
					</td>					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination justify-content-center">
	<pageNav:pageNav listURI="/member/list.do" pageObject="${pageObject }"></pageNav:pageNav>
	</div>		
</div>

</body>
</html>