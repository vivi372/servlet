package com.webjjang.main.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.webjjang.member.vo.LoginVO;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.PageObject;


// Board Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class MainController {

	
	public String execute(HttpServletRequest request) {
		System.out.println("MainController.execute()");
		
		
		// 메뉴 입력
		String uri = request.getRequestURI();
		
		//Object result = null;
		
		String jsp = null;	
		
		HttpSession session = request.getSession();
		int gradeNo = 0;
		LoginVO login = (LoginVO) session.getAttribute("login");
		if(login!=null) {
			gradeNo = login.getGradeNo();
		}

		
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			case "/main/main.do":
				// [MainController] - (Execute) - BoardListService/ImageListService - BoardDAO.list()/ImageDAO.list()
				System.out.println("1.메인화면 리스트");
				//페이지 처리를 위한 객체				
				PageObject pageObject = new PageObject();	
				
				if(gradeNo == 9) {					
					pageObject.setPeriod("all");				
				}else {
					pageObject.setPeriod("pre");
				}
				
				//메인에 표시할 데이터 - 공지 사항/일반 게시판/ 이미지 게시판
				// DB에서 데이터 가져오기 - 가져온 데이터는 List<BoardVO> / List<ImageVO>				
				// 가져온 데이터 저장 - request에 저장 -> jsp까지 전달
				//일반 게시판 데이터 가져오기
				pageObject.setPerPageNum(7);
				request.setAttribute("noticeList", Execute.execute(Init.get("/notice/list.do"), pageObject));	
				//일반 게시판 데이터 가져오기
				pageObject.setPerPageNum(7);
				request.setAttribute("boardList", Execute.execute(Init.get("/board/list.do"), pageObject));	
				//이미지 게시판 데이터 가져오기
				pageObject.setPerPageNum(6);
				request.setAttribute("imageList", Execute.execute(Init.get("/image/list.do"), pageObject));	
				
				// /WEB-INF/views/  + main/main + .jsp
				jsp = "main/main";
				
				break;			
			default:				
				jsp = "error/404";
				break;
			} // end of switch
		} catch (Exception e) {
			
			//e.printStackTrace();
			
			//예외객체를 jsp에서 사용하기 위해 request에 담는다.
			request.setAttribute("e", e);
			
			jsp = "error/500";
			
			//throw e;
		} // end of try~catch		
		return jsp;
	} // end of execute()
	
} // end of class
