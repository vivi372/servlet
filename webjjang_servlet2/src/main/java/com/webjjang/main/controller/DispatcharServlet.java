package com.webjjang.main.controller;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.webjjang.board.controller.BoardController;
import com.webjjang.boardreply.controller.BoardReplyController;
import com.webjjang.image.controller.ImageController;
import com.webjjang.member.controller.MemberController;


/**
 * Servlet implementation class DispatcharServlet
 */
//웹서버와 연결하기 위해서 servlet 으로 등록이 되어 있어야 한다.
//1. @WebServlet - 프로그램 수정 가능, 2. web.xml에 등록 - 프로그램 수정 불가능
//@WebServlet(urlPatterns = "*.do", loadOnStartup = 1)
//Servlet을 상속 - 기능 : URL 연결 - 서버에서 동작 프로그램 - 한번만 생성(싱글톤 프로그램)
public class DispatcharServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// Controller 생성과 선언 - 한번만 실행
	private BoardController boardController = new BoardController();
	private BoardReplyController boardReplyController = new BoardReplyController();
	private MemberController memberController = new MemberController();
	private ImageController imageController = new ImageController();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DispatcharServlet() {    	
        super();                
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		//드라이버 확인 / 객체 생성 처리 - Class.forName(class명)
		//서버가 실행될 때 먼저 실행되어야만 한다.
		System.out.println("DispatcharServlet 실행 -- 초기화 진행");
		
		try {
			// 객체 생성과 초기화 + 조립
			Class.forName("com.webjjang.main.controller.Init");
			// 오라클 드라이버 확인 + 로딩
			Class.forName("com.webjjang.util.db.DB");
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//메뉴를 출력하고 선택(uri) 처리
		//uri - /board가 앞에 붙어 있으면 BoardController로 가게 만든다.
		System.out.println("DispatcharServlet.service() 실행");
		
		String uri = request.getRequestURI();
		System.out.println("DispatcharServlet - uri = "+uri);
		
		//uri = /module/기능 -> /board/list.do
		int pos = uri.indexOf("/",1);
		
		String jsp = null;
		
		if(pos==-1) {
			request.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(request, response);
			return;
		}
		
		String module = uri.substring(0,pos);
		System.out.println("module = "+module);
		
		//request에 module 담아서 어떤 메뉴가 선택되었는지 처리 
		request.setAttribute("module", module);
		request.setAttribute("uri", uri);
		switch (module) {
		case "/board":
			System.out.println("일반 게시판");
			try {
				jsp = boardController.execute(request);			
			} catch (Exception e) {		
				System.out.println("서블릿 - DB 에러");
				request.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(request, response);
				return;
			}			
			break;
		case "/boardreply":
			System.out.println("일반 게시판 댓글");
			try {
				jsp = boardReplyController.execute(request);
			} catch (Exception e) {		
				System.out.println("서블릿 - DB 에러");
				request.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(request, response);
				return;
			}			
			break;
		case "/member":
			System.out.println("회원 관리");		
			
			jsp = memberController.execute(request);
			break;
		case "/image":
			System.out.println("회원 관리");		
			
			jsp = imageController.execute(request);
			break;
		default:
			request.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(request, response);
			return;			
		}
		//jsp 정보 앞에 "redirect:"이 붙어 있으면 redirect 시킨다.(페이지 자동 이동)
		//jsp 정보 앞에 "redirect:"이 붙어 있지 않으면 forward 시킨다.(페이지 자동 이동)
		
		if(jsp.indexOf("redirect:")==0) {		
			// uri로 사용하기 위해 redirect:은 잘라 버린다.
			response.sendRedirect(jsp.substring("redirect:".length()));
		} else {
			//jsp로 포워드 한다.
			request.getRequestDispatcher("/WEB-INF/views/"+jsp+".jsp").forward(request, response);
			//request.getSession().removeAttribute("msg");
		}
		
	}

}