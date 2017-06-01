package com.yoga.controller.v2;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.dao.Weixin_blog_user;
import com.yoga.exception.NotFindAccessTokenException;
import com.yoga.utils.AESUtil;

import net.sf.json.JSONObject;

/**
 * 第三版版本
 * @author king
 *
 */
@Controller
public class WeixinControllerV3 extends R {

	/**
	 * V2首页
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/index.shtml")
	public ModelAndView v2IndexHome(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
	){ 

		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/index.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		Object []        res  = weixin.getToken(); 
		if( res[0] == null || res[0].equals("") ){
			res = weixin.getToken();
		}
		if( res[0] != null ){
			jsapiSignatureURL ( map, url, res[2] );
		}else{
			try {
				throw new NotFindAccessTokenException("v2/index.shtml--->|v2IndexHome|NotFindAccessTokenException");
			} catch (NotFindAccessTokenException e) {
				e.printStackTrace();
			}
		}
		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/index",map );
	}

	
	/**
	 * faq/index.html
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex
	 * @return
	 * @ 
	 */
	@RequestMapping(value = "v2/smjia.html")
	public ModelAndView v2IndexBymajia(
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = null;
		if( user == null ){
			user = weixin.getWeixinUser(p);
			session.setAttribute(WEIXIN_SESSSION_KEY, user);
			setUserSession(user, response);
		}
		String url = DOMAIN+"/w"+p+"/faq/index.html?p=0";
		Object[] token = weixin.getToken();
		if( token[0] == null || token[2] == null || token[0].equals("") ){
			token = weixin.getToken();
		}
		if( token[0] == null || token[2] == null || token[0].equals("") ){
			token = weixin.getToken();
		}
		if( token[0] == null || token[2] == null || token[0].equals("") ){
			token = weixin.getToken();
		}
		if( token !=null && token.length > 0 ){
			jsapiSignatureURL (map,url, token[2] );
		} 
		map.put("nologin", user == null);
		map.put("p", 0);   
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/index",map );
	}
	
	
	
	/**
	 * V2详情页
	 * @param type    查看更多的内容
	 *        free    更多免费课程
	 *        pay     更多付费课程
	 *        teacher 更多老师
	 *        special 更多专题
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/index/{type}/more.shtml")
	public ModelAndView v2More(
			@PathVariable("type")      String type,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response)  { 

		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/index/"+type+"/more.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		Object []        res  = weixin.getToken();
		if( res[0] == null || res[0].equals("") ){
			res = weixin.getToken();
		}
		if( res[0] != null ){
			jsapiSignatureURL ( map, url, res[2] );
		}else{
			try {
				throw new NotFindAccessTokenException("v2/index/"+type+"/more.shtml--->|v2More|NotFindAccessTokenException");
			} catch (NotFindAccessTokenException e) {
				e.printStackTrace();
			}
		}
		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/more/more"+type,map );
	}
 


	/**
	 * V2首页
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/search/index.shtml")
	public ModelAndView v2SearchHome(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
	){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/search/index.shtml";
		Weixin_blog_user user = getWeixinSession( request,session );
		Object []        res  = weixin.getToken(); 
		if( res[0] == null || res[0].equals("") ){
			res = weixin.getToken();
		}
		if( res[0] != null ){
			jsapiSignatureURL ( map, url, res[2] );
		}else{
			try {
				throw new NotFindAccessTokenException("v2/search/index.shtml--->|v2SearchHome|NotFindAccessTokenException");
			} catch (NotFindAccessTokenException e) {
				e.printStackTrace();
			}
		}
		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/search/searchv2",map );
	}




	/**
	 * 课程分类列表页筛选
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/cls/{cid}/index.shtml")
	public ModelAndView v2ClassFilter(
			@PathVariable("cid")   String cid,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response) { 
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/cls/"+cid+"/index.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		Object []        res  = weixin.getToken(); 
		if( res[0] == null || res[0].equals("") ){
			res = weixin.getToken();
		}
		if( res[0] != null ){
			jsapiSignatureURL ( map, url, res[2] );
		}else{
			try {
				throw new NotFindAccessTokenException("v2/cls/"+cid+"/index.shtml--->|v2SearchHome|NotFindAccessTokenException");
			} catch (NotFindAccessTokenException e) {
				e.printStackTrace();
			}
		}
		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/courseclass/index",map );
	}
	
	
	

	/**
	 * 清理掉首页缓存
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="B5/clear/index.html")
	public @ResponseBody JSONObject verificationNumber(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		JSONObject result = new JSONObject();
		result.put("status", false);
		String passwd = this.trim( request.getParameter("passwd"));
		if( passwd.equals("password911") ){
			v2Index.clearIndexHome();
			result.put("status", true);
		}
		return result;
	}
}
