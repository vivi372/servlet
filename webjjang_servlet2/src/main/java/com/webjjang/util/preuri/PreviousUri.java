package com.webjjang.util.preuri;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;

import javax.servlet.http.HttpServletRequest;

public class PreviousUri {
	HttpServletRequest req;
	
	public PreviousUri(HttpServletRequest request) {
		req = request;
	}
	
	public String getNextUri() throws Exception {
		Enumeration<String> params = req.getParameterNames();
		String uri = req.getRequestURI();
		String param = "?";
		while (params.hasMoreElements()) {
			String key = (String) params.nextElement();
			String value = req.getParameter(key);
			if(value != null) {
            	value = URLDecoder.decode(value,"utf-8");                	
            }
            System.out.println("getNextUri="+value);
            if(checkKor(value)) {
            	System.out.println("한글");
            	value = URLEncoder.encode(value,"utf-8");
            }			
			param += key+"="+value+"&";			
		}
		System.out.println("getNextUri-"+param);
		if(param.equals("?")) {
			uri += " ";
		}else {
			uri += param.substring(0,param.lastIndexOf('&'));			
		}
		//System.out.println(param);
		return uri;
	}
	
	public String getPreUri() throws Exception {
		String refererUrl = req.getHeader("referer");
		
		URL url = new URL(refererUrl);
		
		
		String refererUri =  refererUrl.substring("http://localhost".length(),((refererUrl.indexOf("?")>=0)?refererUrl.indexOf("?")+1:refererUrl.length()));
		System.out.println("getPreUri - refererUri="+refererUri);
		String query = url.getQuery();
		query = MapToQueryString(extractParameters(query));
		System.out.println("getPreUri - query="+query);
		return refererUri+query;
	}
	
	private static Map<String, String> extractParameters(String query) throws UnsupportedEncodingException {      
        Map<String, String> params = new HashMap<>();           
            
        if (query != null) {
            String[] pairs = query.split("&");
            for (String pair : pairs) {
                int idx = pair.indexOf("=");
                String key = idx > 0 ? pair.substring(0, idx) : pair;
                String value = idx > 0 && pair.length() > idx + 1 ? pair.substring(idx + 1) : null;
                if(value != null) {
                	value = URLDecoder.decode(value,"utf-8");                	
                }
                System.out.println("extractParameters="+value);
                if(checkKor(value)) {
                	System.out.println("한글");
                	value = URLEncoder.encode(value,"utf-8");
                }
                params.put(key, value);
            }
        } 
        
        return params;
    }
	
	 private static boolean checkKor(String input) {
	        if (input == null || input.isEmpty()) {
	            return false;
	        }

	        for (char c : input.toCharArray()) {
	            if (Character.UnicodeBlock.of(c) == Character.UnicodeBlock.HANGUL_SYLLABLES ||
	                Character.UnicodeBlock.of(c) == Character.UnicodeBlock.HANGUL_JAMO ||
	                Character.UnicodeBlock.of(c) == Character.UnicodeBlock.HANGUL_COMPATIBILITY_JAMO) {	            	
	                return true;
	            }
	        }

	        return false;
	    }
	 
	 private static String MapToQueryString(Map<String, String> params) {
	        if (params == null || params.isEmpty()) {
	            return "";
	        }

	        StringJoiner queryString = new StringJoiner("&");
	        for (Map.Entry<String, String> entry : params.entrySet()) {
	            String key = entry.getKey();
	            String value = entry.getValue();
	            if (value != null) {
	                queryString.add(key + "=" + value);
	            } else {
	                queryString.add(key+"=");
	            }
	        }

	        return queryString.toString();
	    }
	
}
