package com.webjjang.util.filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.webjjang.member.vo.LoginVO;
import com.webjjang.util.preuri.PreviousUri;

/**
 * Servlet Filter implementation class AuthorityFilter
 */
//@WebFilter("/AuthorityFilter")
public class AuthorityFilter extends HttpFilter implements Filter { 
	private static final long serialVersionUID = 1L;
	
	//uri에 따른 권한 저장 Map
	private static Map<String, Integer> authMap = new HashMap<>(); 	
	
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		System.out.println("권한 처리 필터 동작");
		
		//request HttpServletRequest타입으로 변환
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		
		String uri = req.getRequestURI();
		System.out.println("AuthorityFilter.doFilter() - uri = "+uri);
		HttpSession session = req.getSession();
		session.setAttribute("uri", uri);
		//페이지의 권한을 int를 가져온다. - 데이터가 없으면 null이 나온다.
		Integer pageGrade = authMap.get(uri);
		LoginVO login = null;
		//로그인이 필요한 권한 처리
		if(pageGrade != null) {
			login = (LoginVO) session.getAttribute("login");
			//로그인을 하지 않은 경우 처리 - 로그인 페이지로 이동
			if(login == null) {
				try {
					session.setAttribute("upcomingUri", new PreviousUri(req).getNextUri());					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				//권한 메시지 모달 창 표시
				session.setAttribute("msg", "로그인이 필요한 서비스 입니다. 로그인해 주세요.");
				//로그인 페이지로 이동
				res.sendRedirect("/member/loginForm.do");
				
				return;
				//req.getRequestDispatcher("/member/loginForm.do").forward(req, response);
			} // 로그인 처리 확인의 끝
			Integer userGrade = login.getGradeNo();
			System.out.println(userGrade);
			System.out.println("페이지 권한"+pageGrade);
			//로그인 처리가 된 경우 관리자 권한 처리 체크 처리
			if(pageGrade > 1) {
				if(pageGrade > userGrade) {
					
					req.getRequestDispatcher("/WEB-INF/views/error/authority.jsp").forward(req, res);
					
					return;
				}
			}
		}	
		
		
		// pass the request along the filter chain - 실제적으로 실행되는 곳으로 이동
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		//서버가 시작될 때 딱 한번 실행되는 메서드
		System.out.println("AuthorityFilter.init()");
		
		//권한 세팅 - URI 따라서
		authMap.put("/image/writeForm.do", 1);
		authMap.put("/image/write.do", 1);
		authMap.put("/image/updateForm.do", 1);
		authMap.put("/image/update.do", 1);
		authMap.put("/image/delete.do", 1);
		authMap.put("/image/changeImage.do", 1);
		
		authMap.put("/member/logout.do", 1);
		authMap.put("/member/list.do", 9);
		authMap.put("/member/changeGrade.do", 9);
		authMap.put("/member/changeStatus.do", 9);
		
		authMap.put("/notice/writeForm.do", 9);
		authMap.put("/notice/write.do", 9);
		authMap.put("/notice/updateForm.do", 9);
		authMap.put("/notice/update.do", 9);
		authMap.put("/notice/delete.do", 9);
	}

}
