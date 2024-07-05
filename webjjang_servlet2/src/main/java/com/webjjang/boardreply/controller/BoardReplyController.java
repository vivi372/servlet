package com.webjjang.boardreply.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.webjjang.boardreply.vo.BoardReplyVO;
import com.webjjang.main.controller.Init;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.ReplyPageObject;


// Board Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class BoardReplyController {

	
	public String execute(HttpServletRequest request) {
		System.out.println("BoardReplyController.execute()");
		// session을 request에서 부터 꺼낸다.
		HttpSession session = request.getSession();
		// 메뉴 입력
		String uri = request.getRequestURI();
		
		//Object result = null;
		
		String jsp = null;
		
		// 입력 받는 데이터 선언
		Long rno = 0L;
		
		try { // 정상 처리
			ReplyPageObject replyPageObject = ReplyPageObject.getInstance(request);
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {							
			case "/boardreply/write.do":
				System.out.println("1.일반게시판 댓글 등록");				
				
				String content = request.getParameter("content");
				String writer = request.getParameter("writer");
				String pw = request.getParameter("pw");
				BoardReplyVO vo =new BoardReplyVO();
				vo.setNo(replyPageObject.getNo());
				vo.setContent(content);
				vo.setWriter(writer);
				vo.setPw(pw);
				Execute.execute(Init.get(uri),vo);
				
				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.		
				//일반 게시판 글보기로 돌아간다. 페이지 정보도 가져간다.
				jsp = "redirect:/board/view.do?no="+replyPageObject.getNo()+"&inc=0&"+replyPageObject.getPageObject().getPageQuery()
						+"&"+replyPageObject.getNotPageQuery();
				session.setAttribute("msg", "댓글이 성공적으로 등록되었습니다.");
				break;
				
			case "/boardreply/update.do":
				System.out.println("2.일반게시판 댓글 수정");
				
				rno = Long.parseLong(request.getParameter("rno"));				
				content = request.getParameter("content");
				writer = request.getParameter("writer");
				pw = request.getParameter("pw");					
				
				
				vo =new BoardReplyVO();				
				vo.setRno(rno);				
				vo.setContent(content);
				vo.setWriter(writer);
				vo.setPw(pw);
				
				Execute.execute(Init.get(uri),vo);						
							
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.
				jsp = "redirect:/board/view.do?no="+replyPageObject.getNo()+"&inc=0&"+replyPageObject.getPageObject().getPageQuery()
						+"&"+replyPageObject.getPageQuery();
				session.setAttribute("msg", "댓글이 성공적으로 수정되었습니다.");
				break;
			case "/boardreply/delete.do":
				System.out.println("3.일반게시판 댓글 삭제");
				// 데이터 수집 - DB에서 실행에 필요한 데이터 - 글번호, 비밀번호 - BoardVO
				vo = new BoardReplyVO();
				rno = Long.parseLong(request.getParameter("rno"));	
				pw = request.getParameter("pw");
				vo.setRno(rno);
				vo.setPw(pw);
				
				// DB 처리
				Execute.execute(Init.get(uri), vo);
				System.out.println();
				System.out.println("***************************");
				System.out.println("**  " + vo.getRno()+ "글이 삭제되었습니다.  **");
				System.out.println("***************************");
				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.				
				jsp = "redirect:/board/view.do?no="+replyPageObject.getNo()+"&inc=0&"+replyPageObject.getPageObject().getPageQuery()
						+"&"+replyPageObject.getNotPageQuery();
				session.setAttribute("msg", "댓글이 성공적으로 삭제되었습니다.");
				break;
			case "0":
				
				return jsp;

			default:
				System.out.println("####################################");;
				System.out.println("## 잘못된 메뉴를 선택하셨습니다.          ##");;
				System.out.println("## [0~5, 0] 중에서 입력하셔야 합니다.    ##");;
				System.out.println("####################################");;
				break;
			} // end of switch
		} catch (Exception e) {
			
			// e.printStackTrace();
			System.out.println();
			System.out.println("$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@");
			System.out.println("$%@ << 오류 출력 >>                         $%@");
			System.out.println("$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@");
			System.out.println("$%@ 타입 : " + e.getClass().getSimpleName());
			System.out.println("$%@ 내용 : " + e.getMessage());
			System.out.println("$%@ 조치 : 데이터를 확인 후 다시 실행해 보세요.");
			System.out.println("$%@     : 계속 오류가 나면 전산담당자에게 연락하세요.");
			System.out.println("$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@$%@");
			
			//throw e;
		} // end of try~catch		
		return jsp;
	} // end of execute()
	
} // end of class
