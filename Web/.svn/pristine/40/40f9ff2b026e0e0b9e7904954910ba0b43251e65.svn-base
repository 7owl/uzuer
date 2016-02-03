package com.lingtong.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.ObjectUtils.Null;
import org.springframework.stereotype.Component;

@Component
public class RightInterceptor implements MethodInterceptor {

	/**
	 * 被拦截的方法中若有request和response对象，则判断session是否存在。
	 */
	public Object invoke(MethodInvocation invocation) throws Throwable {
		HttpServletRequest request = null;
		HttpServletResponse response = null;
	
		Object[] args = invocation.getArguments();
		for (int i = 0; i < args.length; i++) {
			if (args[i] instanceof HttpServletRequest) {
				request = (HttpServletRequest) args[i];
			}
			if (args[i] instanceof HttpServletResponse) {
				response = (HttpServletResponse) args[i];
			}
		}
		
		// 判断被拦截的方法中是否有request和response对象
		if (request != null && response != null) {
			if ( request.getSession().getAttribute("user") == null ) {
				if( request.getRequestURI().contains("/rental/login") ){
					return invocation.proceed();
				} else if( request.getRequestURI().contains("/rental/main") ){
					//登录验证
					if( StringUtils.isNotBlank( request.getParameter("username") ) && StringUtils.isNotBlank( request.getParameter("password") ) ){
						return invocation.proceed();
					}
				} else if ( request.getRequestURI().contains("/rental/logout") ){
					return invocation.proceed();
				}
				response.sendRedirect("/rental/logout");
				return null;
			}
		}

		return invocation.proceed();
	}

}
