package com.webjjang.member.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.webjjang.board.vo.BoardVO;
import com.webjjang.main.controller.Init;
import com.webjjang.member.vo.LoginVO;
import com.webjjang.member.vo.MemberVO;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.PageObject;
import com.webjjang.util.page.ReplyPageObject;
import com.webjjang.util.preuri.PreviousUri;

//Member Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class MemberController {

	
	public String execute(HttpServletRequest request) {
		System.out.println("MemberController.execute()");
		
		//로그인 처리를 session으로 한다.
		HttpSession session = request.getSession();
		
		//login된 정보 중에서 id를 많이 사용한다.
		String id = null;
		LoginVO login = (LoginVO) session.getAttribute("login");
		// 로그인이 되어 있는 경우만 id를 꺼내온다.
		if(login!=null) id = login.getId();
		
		
		// 메뉴 입력
		String uri = request.getRequestURI();
		
		//Object result = null;
		
		String jsp = null;
		// 입력 받는 데이터 선언
		Long no = 0L;
		
		PreviousUri preUri = new PreviousUri(request);
		
		//이미지 파일 저장 위치
		//파일의 상대적 저장 위치
		String savePath = "upload/member";
		//파일 시스템에서는 절대 저장 위치가 필요하다 - 파일 업로드시 필요		
		String uploadFilePath = request.getServletContext().getRealPath(savePath);		
		//System.out.println(uploadFilePath);
		int uploadFileSizeLimit = 100*1024*1024;
		String encType = "UTF-8";
		
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			case "/member/loginForm.do":
				System.out.println("a.로그인 폼");
				
				
				jsp = "member/loginForm";	
				//이전 페이지 주소 저장
				String upcomingUri = (String) session.getAttribute("upcomingUri");
				
				if(session.getAttribute("upcomingUri") != null) {
					session.setAttribute("preUri", upcomingUri);
					session.removeAttribute("upcomingUri");					
				} else {					
					session.setAttribute("preUri", preUri.getPreUri());						
				}
				
				System.out.println("loginForm-perUri : "+session.getAttribute("preUri"));
				
				break;
			case "/member/login.do":
				System.out.println("a-1.로그인 처리");				
				
				id = request.getParameter("id");
				String pw = request.getParameter("pw");
				
				LoginVO loginVO =new LoginVO();
				loginVO.setId(id);
				loginVO.setPw(pw);
				try {
					session.setAttribute("login", Execute.execute(Init.get(uri),loginVO));					
				} catch (Exception e) {
					session.setAttribute("msg", "존재하지 않는 아이디거나 비밀번호가 다릅니다.");
					return "redirect:/member/loginForm.do";
				}
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.		
				//원래는 main이나 진행하려고 했던 uri로 이동시킨다.
				jsp = "redirect:"+session.getAttribute("preUri");
				session.removeAttribute("preUri");
				// 로그인 완료 메시지 처리
				session.setAttribute("msg", "성공적으로 로그인되었습니다.");
				break;
			case "/member/logout.do":
				System.out.println("b.로그아웃 처리");
				
				session.removeAttribute("login");
				
				jsp = "redirect:"+preUri.getPreUri();			
				session.setAttribute("msg", "성공적으로 로그아웃되었습니다.");
				break;
			case "/member/list.do":
				// [BoardController] - (Execute) - BoardListService - BoardDAO.list()
				System.out.println("1.일반게시판 리스트");
				//페이지 처리를 위한 객체
				//getInstance - 기본 값이 있고 넘어오는 페이지와 검색 정보를 세팅 처리
				PageObject pageObject = PageObject.getInstance(request);				
				// DB에서 데이터 가져오기 - 가져온 데이터는 List<BoardVO>				
				// 가져온 데이터 저장 - request에 저장 -> jsp까지 전달
				request.setAttribute("list", Execute.execute(Init.get(uri), pageObject));	
				// pageObject 담기
				request.setAttribute("pageObject", pageObject);	
				
				
				//페이지 오브젝트 데이터 확인
				System.out.println("BoardController.execute().pageObject - "+pageObject);
				// /WEB-INF/views/  + board/list + .jsp
				jsp = "board/list";
				
				break;			
			case "/member/view.do":
				System.out.println("2.일반게시판 글보기");
				// 1. 조회수 1증가(글보기), 2. 일반게시판 글보기 데이터 가져오기 : 글보기, 글수정
				// 넘어오는 글 번호와 조회수 1증가를 수집한다.(request에 들어 있다.)
				no = Long.parseLong(request.getParameter("no"));
				long inc = 0L;
				
				inc = Long.parseLong(request.getParameter("inc"));								
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("boardVO", Execute.execute(Init.get(uri),new Long[]{no, inc}));
				//댓글 페이지 객체
				//데이터 전달 - page / perPageNum / no / replyPage / replyPerPageNum
				ReplyPageObject replyPageObject = ReplyPageObject.getInstance(request);				
				request.setAttribute("replyList", Execute.execute(Init.get("/boardreply/list.do"),replyPageObject));	
				//가져온 댓글 데이터 request에 담기
				request.setAttribute("replyPageObject", replyPageObject);
				jsp = "board/view";
				
				break;		
			case "/member/writeForm.do":
				System.out.println("3-1.회원가입 폼");
				
				jsp = "member/writeForm";			
				
				break;
			
			case "/member/write.do":
				System.out.println("3-2.회원가입 처리");		
				
				//이미지 업로드 처리
				//new MultipartRequest(request, 실제저장위치,사이즈 제한,encoding,중복처리객체);
				//input name을 다르게 해서 올리세요 file1 , file2
				MultipartRequest multi = new MultipartRequest(request, uploadFilePath,uploadFileSizeLimit,encType,new DefaultFileRenamePolicy());
				
				id = multi.getParameter("id");
				pw = multi.getParameter("pw");
				String name = multi.getParameter("name");
				String gender = multi.getParameter("gender");
				String birth = multi.getParameter("birth");
				String tel = multi.getParameter("tel");
				String email = multi.getParameter("email");
				String photo = "/"+savePath+"/"+multi.getFilesystemName("photoFile");
				
				// 변수 - vo 저장하고 Service
				MemberVO vo = new MemberVO();
				vo.setId(id);
				vo.setPw(pw);
				vo.setName(name);
				vo.setGender(gender);
				vo.setBirth(birth);
				vo.setTel(tel);
				vo.setEmail(email);
				vo.setPhoto(photo);			
				Execute.execute(Init.get(uri),vo);
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.				
				jsp = "redirect:/board/list.do";
				session.setAttribute("msg", "성공적으로 가입되었습니다.");
				break;
			case "/member/checkId.do":
				System.out.println("3-3. 아이디 체크");				
				
				id = request.getParameter("id");				
				
							
				id = (String) Execute.execute(Init.get(uri),id);
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.		
				
				request.setAttribute("id", id);
				jsp = "member/checkId";
				
				break;
			case "/member/updateForm.do":
				System.out.println("4-1 일반게시판 글 수정 폼");
				
				no = Long.parseLong(request.getParameter("no"));
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("boardVO", Execute.execute(Init.get("/board/view.do"),new Long[]{no, 0L}));
				jsp = "board/updateForm";
				break;
			case "/member/update.do":
				System.out.println("4-2.일반게시판 글수정");
				
				no = Long.parseLong(request.getParameter("no"));
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String writer = request.getParameter("writer");
				pw = request.getParameter("pw");				
				
				
				
				BoardVO vo1 =new BoardVO();				
				vo1.setNo(no);
				vo1.setTitle(title);
				vo1.setContent(content);
				vo1.setWriter(writer);
				vo1.setPw(pw);
				
				Execute.execute(Init.get(uri),vo1);				
				//페이지 정보 받기 & uri에 붙이기
				PageObject pageObjectUp = PageObject.getInstance(request);				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.
				jsp = "redirect:view.do?no="+no+"&inc=0&"+pageObjectUp.getPageQuery();
				session.setAttribute("msg", "글이 성공적으로 수정되었습니다.");
				break;
			case "/member/delete.do":
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
			case "0":
				
				return jsp;

			default:
				jsp = "error/404";
				break;
			} // end of switch
		} catch (Exception e) {
			
			// e.printStackTrace();
			//예외객체를 jsp에서 사용하기 위해 request에 담는다.
			request.setAttribute("e", e);
			
			jsp = "error/500";
			
			//throw e;
		} // end of try~catch		
		return jsp;
	} // end of execute()
	
} // end of class
