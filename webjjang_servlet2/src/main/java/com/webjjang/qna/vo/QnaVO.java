package com.webjjang.qna.vo;

import lombok.Data;

@Data
public class QnaVO {

	// private 변수
	private Long no;
	private String title;
	private String content;
	private String id;
	private String name;
	private String writeDate;
	private Long refNo; //관련글 번호
	private Long ordNo; //순서 번호
	private Long levNo; //들여쓰기 번호
	private Long parentNo; //자동 삭제를 위한 부모글 번호
	private boolean isQuestion; //등록시 질문과 답변 구분
	
	
	
	
}
