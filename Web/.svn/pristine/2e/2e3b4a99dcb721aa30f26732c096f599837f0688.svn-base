package com.lingtong.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

public class CookieHelper {
	/**
     * 设置cookie有效期，根据需要自定义[本系统设置为7天]
     */
    private int cookie_max_age = 60 * 60 * 24 * 7;
    
    private static CookieHelper cookieHelper;
    
    private CookieHelper (){}
    
    public static CookieHelper getInstance(){
    	if( cookieHelper == null ){
    		cookieHelper = new CookieHelper();
    	}
    	return cookieHelper;
    }
    
    public void removeCookie(HttpServletResponse resp, Cookie cookie){
    	if( cookie != null ){
    		cookie.setValue("");
    		cookie.setMaxAge(0);
    		cookie.setPath("/");
    		
    		resp.addCookie(cookie);
    	}
    }
    
    public void removeCookie(HttpServletResponse resp, Cookie cookie, String domain){
    	if( cookie != null ){
    		cookie.setDomain(domain);
    		cookie.setValue("");
    		cookie.setMaxAge(0);
    		cookie.setPath("/");
    		
    		resp.addCookie(cookie);
    	}
    }
    
    public Cookie getCookie(HttpServletRequest req, String key){
    	Cookie[] cookies = req.getCookies();
    	for( int i = 0; cookies != null && i < cookies.length; i++ ){
    		Cookie cookie = cookies[i];
    		if( cookie.getName().equals(key) ){
    			return cookie;
    		}
    	}
    	return null;
    }
    
    public String getCookieValue(HttpServletRequest req, String key){
    	Cookie cookie = getCookie(req, key);
    	
    	if(cookie != null){
    		return cookie.getValue();
    	}
    	return null;
    } 
    
    public void setCookie(HttpServletResponse resp, String name, String value, int max_age){
    	if( StringUtils.isBlank(value) ){
    		value = "";
    	}
    	Cookie cookie = new Cookie(name, value);
    	
    	if( max_age > 0 ){
    		cookie.setMaxAge(max_age);
    	} else {
    		cookie.setMaxAge(cookie_max_age);
    	}
    	cookie.setPath("/");
    	resp.addCookie(cookie);
    }
    
    public void setCookie(HttpServletResponse resp, String name, String value){
    	setCookie(resp, name, value, cookie_max_age);
    }
}
