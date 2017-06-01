package com.yoga.controller.v2;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.dao.Weixin_blog_user;
import com.yoga.utils.AESUtil;
/**
 * 提现Controller
 * @author king
 *
 */
@Controller
public class WeixinV2TixianController extends R{
   
	/**
	 * 提现页面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/my/tixian.shtml")
	public ModelAndView v2LiveMore(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) { 
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/my/tixian.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/tixian",map );
	}
}
