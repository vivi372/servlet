package com.webjjang.image.controller;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.webjjang.board.vo.BoardVO;
import com.webjjang.image.vo.ImageVO;
import com.webjjang.main.controller.Init;
import com.webjjang.member.vo.LoginVO;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.PageObject;

// Board Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class ImageController {

	
	public String execute(HttpServletRequest request) {
		System.out.println("ImageController.execute()");
		
		HttpSession session = request.getSession();
		// 메뉴 입력
		String uri = request.getRequestURI();
		
		//Object result = null;
		
		String jsp = null;
		
		// 입력 받는 데이터 선언
		Long no = 0L;
		
		String savePath = "upload/img";
		ServletContext context = request.getServletContext();
		String uploadFilePath = context.getRealPath(savePath);
		System.out.println(uploadFilePath);
		int uploadFileSizeLimit = 100*1024*1024;
		String encType = "UTF-8";
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			case "/image/list.do":
				// [ImageController] - (Execute) - ImageListService - ImageDAO.list()
				System.out.println("1.이미지 게시판 리스트");
				//페이지 처리를 위한 객체
				//getInstance - 기본 값이 있고 넘어오는 페이지와 검색 정보를 세팅 처리
				PageObject pageObject = PageObject.getInstance(request);				
				// DB에서 데이터 가져오기 - 가져온 데이터는 List<ImageVO>				
				// 가져온 데이터 저장 - request에 저장 -> jsp까지 전달
				request.setAttribute("list", Execute.execute(Init.get(uri), pageObject));	
				// pageObject 담기
				request.setAttribute("pageObject", pageObject);	
				
				
				//페이지 오브젝트 데이터 확인
				System.out.println("ImageController.execute().pageObject - "+pageObject);
				// /WEB-INF/views/  + image/list + .jsp
				jsp = "image/list";
				
				break;			
			case "/image/view.do":
				System.out.println("2.이미지 게시판 글보기");
				// 1. 조회수 1증가(글보기), 2. 일반게시판 글보기 데이터 가져오기 : 글보기, 글수정
				// 넘어오는 글 번호와 조회수 1증가를 수집한다.(request에 들어 있다.)
				no = Long.parseLong(request.getParameter("no"));
				//long inc = 0L;
				
				//inc = Long.parseLong(request.getParameter("inc"));								
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("imageVO", Execute.execute(Init.get(uri),no));
				//댓글 페이지 객체
				//데이터 전달 - page / perPageNum / no / replyPage / replyPerPageNum
				//ReplyPageObject replyPageObject = ReplyPageObject.getInstance(request);				
				//request.setAttribute("replyList", Execute.execute(Init.get("/boardreply/list.do"),replyPageObject));	
				//가져온 댓글 데이터 request에 담기
				//request.setAttribute("replyPageObject", replyPageObject);
				jsp = "image/view";
				
				break;
			case "/image/writeForm.do":
				System.out.println("3-1.이미지 게시판 글등록 폼");
				
				jsp = "image/writeForm";			
				
				break;
			
			case "/image/write.do":
				System.out.println("3-2.이미지 게시판 글등록");
				MultipartRequest multi = new MultipartRequest(request, uploadFilePath,uploadFileSizeLimit,encType,new DefaultFileRenamePolicy());
				
				String title = multi.getParameter("title");
				String content = multi.getParameter("content");
				LoginVO login =  (LoginVO) session.getAttribute("login");				
				String id = login.getId();
				String fileName = "/upload/img/"+multi.getFilesystemName("fileName");
				ImageVO vo =new ImageVO();
				vo.setTitle(title);
				vo.setContent(content);
				vo.setId(id);
				vo.setFileName(fileName);
				Execute.execute(Init.get(uri),vo);
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.				
				jsp = "redirect:list.do?perPageNum="+multi.getParameter("perPageNum");
				session.setAttribute("msg", "글이 성공적으로 등록되었습니다.");
				break;
			case "/image/updateForm.do":
				System.out.println("4-1 이미지 게시판 글 수정 폼");
				
				no = Long.parseLong(request.getParameter("no"));
				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map						
				//가져온 데이터를 JSP로 보내기 위해 request에 담는다.
				request.setAttribute("boardVO", Execute.execute(Init.get("/board/view.do"),new Long[]{no, 0L}));
				jsp = "board/updateForm";
				break;
			case "/image/update.do":
				System.out.println("4-2.이미지 게시판 글수정");
				
				no = Long.parseLong(request.getParameter("no"));
				title = request.getParameter("title");
				content = request.getParameter("content");
				String writer = request.getParameter("writer");
				String pw = request.getParameter("pw");				
				
				
				
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
			case "/image/delete.do":
				System.out.println("5.이미지 게시판 글삭제");
				// 데이터 수집 - DB에서 실행에 필요한 데이터 - 글번호, 비밀번호 - BoardVO
				ImageVO deleteVO = new ImageVO();
				no = Long.parseLong(request.getParameter("no"));
				login =  (LoginVO) session.getAttribute("login");				
				id = login.getId();
				deleteVO.setNo(no);
				deleteVO.setId(id);
				
				// DB 처리
				Execute.execute(Init.get(uri), deleteVO);
				System.out.println();
				System.out.println("***************************");
				System.out.println("**  " + deleteVO.getNo()+ "글이 삭제되었습니다.  **");
				System.out.println("***************************");
				
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.				
				jsp = "redirect:/image/list.do?perPageNum="+request.getParameter("perPageNum");
				session.setAttribute("msg", "글이 성공적으로 삭제되었습니다.");
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