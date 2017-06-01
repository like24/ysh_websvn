package com.yoga.filter; 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
 
import com.yoga.dao.Weixin_blog_user;


public class WeixinUserFilter extends HandlerInterceptorAdapter{
	/**
	 * 拦截器
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse res, Object handler) throws Exception {
		Weixin_blog_user user =(Weixin_blog_user)request.getSession().getAttribute(com.yoga.controller.v2.R.WEIXIN_SESSSION_KEY);
		request.setAttribute("wxuser", user);
		return true;	
	}

}
