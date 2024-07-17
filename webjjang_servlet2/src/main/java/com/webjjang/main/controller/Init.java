package com.webjjang.main.controller;

import java.util.HashMap;
import java.util.Map;

import com.webjjang.board.dao.BoardDAO;
import com.webjjang.board.service.BoardDeleteService;
import com.webjjang.board.service.BoardListService;
import com.webjjang.board.service.BoardUpdateService;
import com.webjjang.board.service.BoardViewService;
import com.webjjang.board.service.BoardWriteService;
import com.webjjang.boardreply.dao.BoardReplyDAO;
import com.webjjang.boardreply.service.BoardReplyDeleteService;
import com.webjjang.boardreply.service.BoardReplyListService;
import com.webjjang.boardreply.service.BoardReplyUpdateService;
import com.webjjang.boardreply.service.BoardReplyWriteService;
import com.webjjang.image.dao.ImageDAO;
import com.webjjang.image.service.ImageChangeService;
import com.webjjang.image.service.ImageDeleteService;
import com.webjjang.image.service.ImageListService;
import com.webjjang.image.service.ImageUpdateService;
import com.webjjang.image.service.ImageViewService;
import com.webjjang.image.service.ImageWriteService;
import com.webjjang.main.dao.DAO;
import com.webjjang.main.service.Service;
import com.webjjang.member.dao.MemberDAO;
import com.webjjang.member.service.MemberChangeGradeService;
import com.webjjang.member.service.MemberChangeStatusService;
import com.webjjang.member.service.MemberCheckIdService;
import com.webjjang.member.service.MemberConUpdateService;
import com.webjjang.member.service.MemberListService;
import com.webjjang.member.service.MemberLoginService;
import com.webjjang.member.service.MemberWriteService;
import com.webjjang.notice.dao.NoticeDAO;
import com.webjjang.notice.service.NoticeDeleteService;
import com.webjjang.notice.service.NoticeListService;
import com.webjjang.notice.service.NoticeUpdateService;
import com.webjjang.notice.service.NoticeViewService;
import com.webjjang.notice.service.NoticeWriteService;
import com.webjjang.qna.dao.QnaDAO;
import com.webjjang.qna.service.QnaDeleteService;
import com.webjjang.qna.service.QnaListService;
import com.webjjang.qna.service.QnaUpdateService;
import com.webjjang.qna.service.QnaViewService;
import com.webjjang.qna.service.QnaWriteService;

public class Init {
	
	// service 생성해서 저장하는 객체 - <URI, service>
	private static Map<String, Service> serviceMap = new HashMap<>();
	// DAO 생성해서 저장하는 객체 - <className, DAO>
	private static Map<String, DAO> daoMap = new HashMap<>();
	
	//static 변수에 데이터를 초기화 시키는 1번만 실행되는 블럭 -> 클래스가 불려지면 자동 실행
	static {
		// DAO 생성
		daoMap.put("boardDAO", new BoardDAO()); // 일반 게시판 DAO
		daoMap.put("qnaDAO", new QnaDAO()); // 일반 게시판 DAO
		daoMap.put("boardReplyDAO", new BoardReplyDAO()); // 일반 게시판 댓글 DAO
		daoMap.put("memberDAO", new MemberDAO()); // 회원 관리 DAO
		daoMap.put("imageDAO", new ImageDAO()); // 이미지 게시판 DAO
		daoMap.put("noticeDAO", new NoticeDAO()); // 공지사항 게시판 DAO
		
		// Service 생성
		// 일반 게시판 서비스
		serviceMap.put("/board/list.do", new BoardListService());
		serviceMap.put("/board/view.do", new BoardViewService());		
		serviceMap.put("/board/write.do", new BoardWriteService());
		serviceMap.put("/board/update.do", new BoardUpdateService());
		serviceMap.put("/board/delete.do", new BoardDeleteService());
		// 질문 답변 게시판 서비스
		serviceMap.put("/qna/list.do", new QnaListService());
		serviceMap.put("/qna/view.do", new QnaViewService());		
		serviceMap.put("/qna/write.do", new QnaWriteService());
		serviceMap.put("/qna/update.do", new QnaUpdateService());
		serviceMap.put("/qna/delete.do", new QnaDeleteService());
		// 일반 게시판 댓글 서비스
		serviceMap.put("/boardreply/list.do", new BoardReplyListService());
		serviceMap.put("/boardreply/write.do", new BoardReplyWriteService());
		serviceMap.put("/boardreply/update.do", new BoardReplyUpdateService());
		serviceMap.put("/boardreply/delete.do", new BoardReplyDeleteService());
		// 회원관리 서비스
		serviceMap.put("/member/login.do", new MemberLoginService());
		serviceMap.put("/member/list.do", new MemberListService());
		serviceMap.put("/member/write.do", new MemberWriteService());
		serviceMap.put("/member/changeGrade.do", new MemberChangeGradeService());
		serviceMap.put("/member/changeStatus.do", new MemberChangeStatusService());
		serviceMap.put("/member/updateConDate.do", new MemberConUpdateService());
		serviceMap.put("/ajax/checkId.do", new MemberCheckIdService());
		// 이미지 게시판 서비스
		serviceMap.put("/image/list.do", new ImageListService());
		serviceMap.put("/image/view.do", new ImageViewService());
		serviceMap.put("/image/write.do", new ImageWriteService());
		serviceMap.put("/image/update.do", new ImageUpdateService());
		serviceMap.put("/image/delete.do", new ImageDeleteService());
		serviceMap.put("/image/changeImage.do", new ImageChangeService());
		// 공지사항 게시판 서비스
		serviceMap.put("/notice/list.do", new NoticeListService());
		serviceMap.put("/notice/view.do", new NoticeViewService());
		serviceMap.put("/notice/write.do", new NoticeWriteService());
		serviceMap.put("/notice/update.do", new NoticeUpdateService());
		serviceMap.put("/notice/delete.do", new NoticeDeleteService());
		
		// 조립 dao->service
		// 일반 게시판 서비스 DAO 조립
		serviceMap.get("/board/list.do").setDAO(daoMap.get("boardDAO"));		
		serviceMap.get("/board/view.do").setDAO(daoMap.get("boardDAO"));		
		serviceMap.get("/board/write.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/board/update.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/board/delete.do").setDAO(daoMap.get("boardDAO"));
		// 질문 답변 서비스 DAO 조립
		serviceMap.get("/qna/list.do").setDAO(daoMap.get("qnaDAO"));	
		serviceMap.get("/qna/view.do").setDAO(daoMap.get("qnaDAO"));		
		serviceMap.get("/qna/write.do").setDAO(daoMap.get("qnaDAO"));
		serviceMap.get("/qna/update.do").setDAO(daoMap.get("boardDAO"));
		serviceMap.get("/qna/delete.do").setDAO(daoMap.get("boardDAO"));
		// 일반 게시판 댓글 서비스 DAO 조립
		serviceMap.get("/boardreply/list.do").setDAO(daoMap.get("boardReplyDAO"));
		serviceMap.get("/boardreply/write.do").setDAO(daoMap.get("boardReplyDAO"));
		serviceMap.get("/boardreply/update.do").setDAO(daoMap.get("boardReplyDAO"));
		serviceMap.get("/boardreply/delete.do").setDAO(daoMap.get("boardReplyDAO"));
		// 회원관리 서비스 DAO 조립
		serviceMap.get("/member/login.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/list.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/write.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/changeGrade.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/changeStatus.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/member/updateConDate.do").setDAO(daoMap.get("memberDAO"));
		serviceMap.get("/ajax/checkId.do").setDAO(daoMap.get("memberDAO"));
		// 이미지 게시판 서비스 DAO 조립
		serviceMap.get("/image/list.do").setDAO(daoMap.get("imageDAO"));
		serviceMap.get("/image/view.do").setDAO(daoMap.get("imageDAO"));
		serviceMap.get("/image/write.do").setDAO(daoMap.get("imageDAO"));
		serviceMap.get("/image/update.do").setDAO(daoMap.get("imageDAO"));
		serviceMap.get("/image/delete.do").setDAO(daoMap.get("imageDAO"));
		serviceMap.get("/image/changeImage.do").setDAO(daoMap.get("imageDAO"));
		// 이미지 게시판 서비스 DAO 조립
		serviceMap.get("/notice/list.do").setDAO(daoMap.get("noticeDAO"));
		serviceMap.get("/notice/view.do").setDAO(daoMap.get("noticeDAO"));
		serviceMap.get("/notice/write.do").setDAO(daoMap.get("noticeDAO"));
		serviceMap.get("/notice/update.do").setDAO(daoMap.get("noticeDAO"));
		serviceMap.get("/notice/delete.do").setDAO(daoMap.get("noticeDAO"));
		
		
		System.out.println("Init.static 초기화 블럭 --- 객체 생성과 로딩 ---");
	}
	
	public static Service get(String uri) {
		return serviceMap.get(uri);
	}
}
