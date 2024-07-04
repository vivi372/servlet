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
import javax.servlet.http.HttpSession;

import com.webjjang.member.vo.LoginVO;

/**
 * Servlet Filter implementation class AuthorityFilter
 */
//@WebFilter("/AuthorityFilter")
public class AuthorityFilter extends HttpFilter implements Filter {     

	private static Map<String, Integer> authMap = new HashMap<>(); 
	
	static {
		authMap.put("/image/updateForm.do", 1);
		authMap.put("/image/update.do", 1);
		authMap.put("/image/delete.do", 1);
		authMap.put("/image/writeForm.do", 1);
		authMap.put("/image/write.do", 1);
		authMap.put("/member/logout.do", 1);
	}
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// place your code here
		System.out.println("권한 처리 필터 동작");
		
		//request HttpServletRequest타입으로 변환
		HttpServletRequest req = (HttpServletRequest) request;
		
		//권한 처리
		String uri = req.getRequestURI();
		HttpSession session = req.getSession();
		LoginVO login = (LoginVO) session.getAttribute("login");
		long gradeNo = 0L;
		if(login != null) gradeNo = login.getGradeNo();
		System.out.println("AuthorityFilter - uri = "+uri);
		
		if(authMap.get(uri) != null) {
			if(login == null) {
				session.setAttribute("msg", "로그인이 필요한 서비스 입니다. 로그인해 주세요.");
				req.getRequestDispatcher("/member/loginForm.do").forward(req, response);
			}
		}
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
