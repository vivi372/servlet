package com.webjjang.util.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;

/**
 * Servlet Filter implementation class AuthorityFilter
 */
//@WebFilter("/AuthorityFilter")
public class AuthorityFilter extends HttpFilter implements Filter {     

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
		System.out.println("AuthorityFilter - uri = "+uri);
		
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
