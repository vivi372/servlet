package com.webjjang.notice.controller;



import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.webjjang.main.controller.Init;
import com.webjjang.notice.vo.NoticeVO;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.PageObject;


// Notice Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class NoticeController {

	public String execute(HttpServletRequest request) {
		String jsp = null;
		HttpSession session = request.getSession();

		// 메뉴 입력
		String uri = request.getRequestURI();		
		
		
		// 입력 받는 데이터 선언
		Long no = 0L;
		
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			case "/notice/list.do":
				// [NoticeController] - (Execute) - NoticeListService - NoticeDAO.list()
				System.out.println("1.공지사항 리스트");
				PageObject pageObject = PageObject.getInstance(request);
				// DB에서 데이터 가져오기 - 가져온 데이터는 List<NoticeVO>
				request.setAttribute("list", Execute.execute(Init.get(uri), pageObject));	
				request.setAttribute("pageObject", pageObject);
				jsp = "notice/list";
				break;
			case "/notice/view.do":
				System.out.println("2.공지사항 글보기");
				// 1. 조회수 1증가(글보기), 2. 공지사항 글보기 데이터 가져오기 : 글보기, 글수정
				// 사용자가 보고 싶은 글번호를 입력한다.
				no = Long.parseLong(request.getParameter("no"));				
				// 전달 데이터 - 글번호, 조회수 증가 여부(1:증가, 0:증가 안함) : 배열 또는 Map
				request.setAttribute("vo", Execute.execute(Init.get(uri), no));			
				jsp = "notice/view";
				break;
			case "/notice/writeForm.do":
				
				jsp="notice/writeForm";
				break;
			case "/notice/write.do":
				System.out.println("3.공지사항 글등록");
				
				// 데이터 수집 - 사용자 : 제목, 내용, 작성자, 비밀번호
				String title = request.getParameter("title");
				String content = request.getParameter("content");
				String startDate = request.getParameter("startDate");
				String endDate = request.getParameter("endDate");
				
				// 변수 - vo 저장하고 Service
				NoticeVO vo = new NoticeVO();
				vo.setTitle(title);
				vo.setContent(content);
				vo.setStartDate(startDate);
				vo.setEndDate(endDate);
				
				// [NoticeController] - NoticeWriteService - NoticeDAO.write(vo)
				Execute.execute(Init.get(uri), vo);
				
				jsp = "redirect:list.do?perPageNum="+request.getParameter("perPageNum");
				session.setAttribute("msg", "공지사항이 성공적으로 등록되었습니다.");
				break;
			case "/notice/updateForm.do":
				
				
				no = Long.parseLong(request.getParameter("no"));		
				request.setAttribute("vo", Execute.execute(Init.get("/notice/view.do"), no));
				
				jsp="notice/updateForm";
				break;
			case "/notice/update.do":
				System.out.println("3.공지사항 글등록");				
				
				no = Long.parseLong(request.getParameter("no"));	
				title = request.getParameter("title");
				content = request.getParameter("content");
				startDate = request.getParameter("startDate");
				endDate = request.getParameter("endDate");
				 // 현재 날짜 구하기
		        LocalDate today = LocalDate.now();
		        
		        // 날짜 형식 지정
		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		        
		        // 형식에 맞춰 날짜 포맷팅
		        String formattedDate = today.format(formatter);
				String updateDate = formattedDate;
				
				// 변수 - vo 저장하고 Service
				vo = new NoticeVO();
				vo.setNo(no);
				vo.setTitle(title);
				vo.setContent(content);
				vo.setStartDate(startDate);
				vo.setEndDate(endDate);
				vo.setUpdateDate(updateDate);
				
				// [NoticeController] - NoticeWriteService - NoticeDAO.write(vo)
				Execute.execute(Init.get(uri), vo);
				
				jsp = "redirect:/notice/view.do?no="+no+"&"+PageObject.getInstance(request).getPageQuery();
				session.setAttribute("msg", "공지사항이 성공적으로 수정되었습니다.");
				break;
			case "/notice/delete.do":
				System.out.println("5.공지사항 글삭제");
				// 데이터 수집 - DB에서 실행에 필요한 데이터 - 글번호
				no = Long.parseLong(request.getParameter("no"));	
				
				// DB 처리
				Execute.execute(Init.get(uri), no);
				
				jsp = "redirect:list.do?perPageNum="+request.getParameter("perPageNum");
				session.setAttribute("msg", no+"번 공지사항이 성공적으로 삭제되었습니다.");
				break;
			

			default:
				jsp = "/error/404";
				break;
			} // end of switch
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("e", e);
			jsp="/error/500";
		} // end of try~catch
		return jsp;
	} // end of execute()
	
} // end of class
