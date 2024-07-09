package com.webjjang.ajax.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.webjjang.board.vo.BoardVO;
import com.webjjang.main.controller.Init;
import com.webjjang.member.vo.LoginVO;
import com.webjjang.util.exe.Execute;
import com.webjjang.util.page.PageObject;
import com.webjjang.util.page.ReplyPageObject;
import com.webjjang.util.preuri.PreviousUri;

//Member Module 에 맞는 메뉴 선택 , 데이터 수집(기능별), 예외 처리
public class AjaxController {

	
	public String execute(HttpServletRequest request) {
		System.out.println("AjaxController.execute()");		
		
		//login된 정보 중에서 id를 많이 사용한다.
		String id = null;	
		
		
		// 메뉴 입력
		String uri = request.getRequestURI();
		
		
		
		String jsp = null;
		
		
		try { // 정상 처리
		
			// 메뉴 처리 : CRUD DB 처리 - Controller - Service - DAO
			switch (uri) {
			
			case "/ajax/checkId.do":
				System.out.println("1. 아이디 체크");				
				
				id = request.getParameter("id");				
				
							
				id = (String) Execute.execute(Init.get(uri),id);
				//jsp 정보 앞에 "redirect:"가 붙어 있으면 redirect 아니면 forward를 시킨다.		
				
				request.setAttribute("id", id);
				jsp = "ajax/checkId";
				
				break;	
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
