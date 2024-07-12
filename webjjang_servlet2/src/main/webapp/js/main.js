/**
 * main.jsp 자바스크립트 파일
 */
$(function(){
	$(".dataRow").click(function(){
		//alert("클릭");
		//어떤 모듈을 클릭했는지 알아보자
		if($(this).hasClass("board")){
			let no = $(this).find(".no").text();
			//alert(no);
			location = "/board/view.do?no="+no+"&inc=1";
		} else if($(this).hasClass("image")){
			let no = $(this).data("no");
			//alert(no);
			location = "/image/view.do?no="+no;
		} else if($(this).hasClass("notice")){
			let no = $(this).find(".no").text();
			//alert(no);
			location = "/notice/view.do?no="+no;
		}
	});
});
