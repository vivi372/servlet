package com.webjjang.qna.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.webjjang.board.vo.BoardVO;
import com.webjjang.main.controller.Init;
import com.webjjang.member.vo.LoginVO;
import com.webjjang.qna.vo.QnaVO;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.PageObject;


// Board Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class QnaController {

	
	public String execute(HttpServletRequest request) {
		System.out.println("QnaController.execute()");
		
		HttpSession session = request.getSession();
		// 메뉴 입력
		String uri = request.getRequestURI();
		
		//Object result = null;
		
		LoginVO login = (LoginVO) session.getAttribute("login");
		String id = null;
		if(login!=null) {
			id = login.getId();
		}
		
		String jsp = null;
		
		// 입력 받는 데이터 선언
		Long no = 0L;
		
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			case "/qna/list.do":
				// [QnaController] - (Execute) - QnaListService - QnaDAO.list()
				System.out.println("1.질문답변 리스트");
				
				//페이지 처리를 위한 객체
				//getInstance - 기본 값이 있고 넘어오는 페이지와 검색 정보를 세팅 처리
				PageObject pageObject = PageObject.getInstance(request);		
								
				// DB에서 데이터 가져오기 - 가져온 데이터는 List<QnaVO>				
				// 가져온 데이터 저장 - request에 저장 -> jsp까지 전달
				request.setAttribute("list", Execute.execute(Init.get(uri), pageObject));	
				
				System.out.println("QnaController - " + pageObject);
				// pageObject 담기
				request.setAttribute("pageObject", pageObject);	
				
				// /WEB-INF/views/  + qna/list + .jsp
				jsp = "qna/list";
				
				break;			
			case "/qna/view.do":
				System.out.println("2.질문 답변 글보기");
				// 1. 조회수 1증가(글보기), 2. 일반게시판 글보기 데이터 가져오기 : 글보기, 글수정
				// 넘어오는 글 번호와 조회수 1증가를 수집한다.(request에 들어 있다.)
				no = Long.parseLong(request.getParameter("no"));											
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("vo", Execute.execute(Init.get(uri),no));
				pageObject = PageObject.getInstance(request);
				request.setAttribute("pageObject", pageObject);
				
				jsp = "qna/view";
				
				break;
			case "/qna/questionForm.do":
				System.out.println("3-1.질문하기 등록 폼");
				request.setAttribute("headTitle", "질문하기 폼");
				jsp = "qna/writeForm";			
				
				break;
			case "/qna/answerForm.do":
				System.out.println("3-2.답변하기 등록 폼");
				request.setAttribute("headTitle", "답변하기 폼");
				//넘어온 글번호에 따른 데이터를 가져와서 request에 저장한다.
				no = Long.parseLong(request.getParameter("no"));
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("vo", Execute.execute(Init.get("/qna/view.do"),no));
				jsp = "qna/writeForm";			
				
				break;	
		
			case "/qna/write.do":
				System.out.println("3-3.질문 답변 등록 처리");
				
				String title = request.getParameter("title");
				String content = request.getParameter("content");	
				String strRefNo = request.getParameter("refNo");
				long ordNo = Long.parseLong(request.getParameter("ordNo"));
				long levNo = Long.parseLong(request.getParameter("levNo"));
				String strParentNo = request.getParameter("parentNo");
				
				
				QnaVO vo =new QnaVO();
				vo.setTitle(title);
				vo.setContent(content);
				vo.setId(id);				
				vo.setOrdNo(ordNo);
				vo.setLevNo(levNo);
				//답변인 경우 처리
				if(strRefNo != null && !strRefNo.equals("")) {					
					vo.setRefNo(Long.parseLong(strRefNo));
					vo.setParentNo(Long.parseLong(strParentNo));					
					vo.setQuestion(false); //답변
				} else {
					vo.setQuestion(true); //질문					
				}				
				
				Execute.execute(Init.get(uri),vo);
				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.				
				session.setAttribute("msg", ((vo.isQuestion())?"질문":"답변")+"이 성공적으로 등록되었습니다.");				
				jsp = "redirect:list.do?perPageNum="+request.getParameter("perPageNum");
				break;
			case "/board/updateForm.do":
				System.out.println("4-1 일반게시판 글 수정 폼");
				
				no = Long.parseLong(request.getParameter("no"));
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("boardVO", Execute.execute(Init.get("/board/view.do"),new Long[]{no, 0L}));
				jsp = "board/updateForm";
				break;
			case "/board/update.do":
				System.out.println("4-2.일반게시판 글수정");
				
				no = Long.parseLong(request.getParameter("no"));
				title = request.getParameter("title");
				content = request.getParameter("content");
				String writer = request.getParameter("writer");
				String pw = request.getParameter("pw");				
				
				
				
				vo =new QnaVO();				
				vo.setNo(no);
				vo.setTitle(title);
				vo.setContent(content);
				
				
				Execute.execute(Init.get(uri),vo);				
				//페이지 정보 받기 & uri에 붙이기
				PageObject pageObjectUp = PageObject.getInstance(request);				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.
				jsp = "redirect:view.do?no="+no+"&inc=0&"+pageObjectUp.getPageQuery();
				session.setAttribute("msg", "글이 성공적으로 수정되었습니다.");
				break;
			case "/board/delete.do":
				System.out.println("5.일반게시판 글삭제");
				// 데이터 수집 - DB에서 실행에 필요한 데이터 - 글번호, 비밀번호 - BoardVO
				BoardVO deleteVO = new BoardVO();
				no = Long.parseLong(request.getParameter("no"));
				pw = request.getParameter("pw");
				deleteVO.setNo(no);
				deleteVO.setPw(pw);
				
				// DB 처리
				Execute.execute(Init.get(uri), deleteVO);
				System.out.println();
				System.out.println("***************************");
				System.out.println("**  " + deleteVO.getNo()+ "글이 삭제되었습니다.  **");
				System.out.println("***************************");
				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.				
				jsp = "redirect:list.do?perPageNum="+request.getParameter("perPageNum");
				session.setAttribute("msg", "글이 성공적으로 삭제되었습니다.");
				break;			
			default:				
				jsp = "error/404";
				break;
			} // end of switch
		} catch (Exception e) {
			
			e.printStackTrace();
			
			//예외객체를 jsp에서 사용하기 위해 request에 담는다.
			request.setAttribute("e", e);
			
			jsp = "error/500";
			
			//throw e;
		} // end of try~catch		
		return jsp;
	} // end of execute()
	
} // end of class
