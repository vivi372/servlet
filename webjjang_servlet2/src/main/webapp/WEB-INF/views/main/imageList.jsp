<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script type="text/javascript">	
	$(function() {		
		//이미지 사이즈 조정 5:4
		let imgWidth = $(".imageDiv:first").width();
		let imgHeight = $(".imageDiv:first").height();
		//imageDiv의 배경을 검은색으로
		$(".imageDiv").css("background","black");
		console.log("w="+imgWidth+" h= "+imgHeight);
		//높이 계산 - 너비는 동일하다 : 이미지와 이미지를 감싸고 있는 div의 높이로 사용
		let height = imgWidth/5*4;
		//전체 imageDiv의 높이를 조정한다.
		$(".imageDiv").height(height);
		//이미지 배열로 처리하면 안 된다.  foreach 사용
		$(".imageDiv > img").each(function(idx,image) {		
			//이미지가 계산된 높이 보다 크면 줄인다.
			if($(this).height()>height) {
				let iamge_width = $(this).width();
				let iamge_height = $(this).height();
				let width =  height / iamge_width * iamge_height;
				//이미지 높이 줄이기
				$(this).height(height);					
				$(this).width(width);					
			}
		});			
	});
</script>


<div class="border rounded p-3 mb-2 bg-white text-dark shadow-sm">
	<h2><i class="fa fa-align-justify"></i>이미지 게시판 리스트</h2>
	
	<c:if test="${empty imageList }">
		<div class="jumbtron">
			<h4>데이터가 존재하지 않습니다.</h4>
		</div>
	</c:if>
	<c:if test="${!empty imageList }">
		<!-- 이미지의 데이터가 있는 만큼 반복해서 표시 -->
		<div class="row my-3">
			<!-- 이미지의 데이터가 있는 만큼 반복해서 표시하는 처리 시작 -->
			<c:forEach items="${imageList }" var="vo" varStatus="vs">	
				<!-- 줄 바꿈 처리 - 찍는 인덱스 번호가 3의 배수이면 줄바꿈을 한다. -->
				<c:if test="${vs.index != 0 && vs.index % 3 ==0 }">
					${"</div>" }
					${"<div class='row my-3'>" }
				</c:if>
				<div class="col-md-4">
		    		<div class="card dataRow image imageLink" data-no="${vo.no }" style="width:100%">
		    			<div class="imageDiv text-center align-content-center">
		    				<img class="card-img-top" src="${vo.fileName }" alt="Card image">
		    			</div>
		    			<div class="card-body">
		      				<h4 class="card-title text-truncate">${vo.no}. ${vo.title }</h4>
		      				<p class="card-text text-truncate">
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
</div>	
	

