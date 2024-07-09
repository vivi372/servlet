package com.webjjang.util.preuri;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

public class PreviousUri {
	HttpServletRequest req;
	
	public PreviousUri(HttpServletRequest request) {
		req = request;
	}
	
	public String getNextUri() {
		Enumeration<String> params = req.getParameterNames();
		String uri = req.getRequestURI();
		String param = "?";
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = req.getParameter(name);
			try {
				param += name+"="+((name.equals("word")&&value!=null)?URLEncoder.encode(value, "utf-8"):value)+"&";				
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println(uri);
		if(param.equals("?")) {
			uri += " ";
		}else {
			uri += param.substring(0,param.lastIndexOf('&'));			
		}
		//System.out.println(param);
		return uri;
	}
	
	public String getPreUri() {
		String preUri = req.getHeader("referer");
		
		if(preUri.indexOf("word")>=0) {
			String wordValue = preUri.substring(preUri.indexOf("word")+5,((preUri.indexOf("&",preUri.indexOf("word"))==-1)?preUri.length():preUri.indexOf("&",preUri.indexOf("word"))));
			
			try {
				String encodingValue = URLEncoder.encode(URLDecoder.decode(wordValue,"utf-8"),"utf-8");
				preUri = preUri.replace(wordValue,encodingValue);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return preUri;
	}
}
