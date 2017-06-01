package com.yoga.controller.v2.activity;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.controller.v2.R;
import com.yoga.dao.Weixin_blog_user;

/**
 * 暖冬活动第二季
 * @author dongf
 *
 */
@Controller
public class WeixinActivityForMildwinterController extends R{
	
	@RequestMapping(value = "w/mildwinter/course.html")
	public ModelAndView course(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) throws Exception{
		Weixin_blog_user user = getWeixinSession( request,session );
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/w/mildwinter/course.html"; 
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("nologin",    user == null);
		return new ModelAndView("/ksite/mildwinter/course",map ); 
	}
 

	@RequestMapping(value = "w/mildwinter/coursehis.html")
	public ModelAndView coursehis(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) throws Exception{
		Weixin_blog_user user = getWeixinSession( request,session );
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/w/mildwinter/coursehis.html"; 
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("nologin",    user == null);
		return new ModelAndView("/ksite/mildwinter/course_his",map ); 
	}
 
}
