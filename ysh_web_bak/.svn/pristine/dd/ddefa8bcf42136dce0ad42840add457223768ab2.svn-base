package com.yoga.controller.v2;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.dao.Weixin_blog_user;
import com.yoga.utils.AESUtil;
import com.yoga.utils.Pagination; 
/**
 * 发现
 * @author jaker
 *
 */
@Controller
public class WeixinV2FindController extends R {


	/**
	 * 发现的首页
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/find/index.html")
	public ModelAndView blogFindIndex(
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("p", p);
		String url = DOMAIN+"/w/find/index.html?p="+p;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
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
			jsapiSignatureURL (map,url,token[2] );
		} 
		Weixin_blog_user user = getWeixinSession(  request,session );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		map.put("nologin",    user == null);
		if( p == 0 ){
			Pagination page = weixin.getWeixinUserList(" AND  isteacher = 1 AND status = 0 AND isauth = 1 AND hide = 0 ORDER BY seqindex", 1, 300);
			List<HashMap<String,Object>> tList = page.getResults();
			List<List<HashMap<String,Object>>> groupList = new ArrayList<List<HashMap<String,Object>>>();
			if(tList!=null){
				for( int i = 0 ; i < tList.size() ; i+=4 ){
					groupList.add(tList.subList(i, (i+4) > tList.size() ? tList.size(): (i+4) ));
				}
			}
			map.put("teacherlist", groupList);
			return new ModelAndView("/ksite/find/index",map );
		}else{
			map.put("activitylist", weixin.getActivityList(" ORDER BY createtime DESC"));
			return new ModelAndView("/ksite/find/activitylist",map );
		}
	}

	@RequestMapping(value = "w/teacher/ajaxfind.html")
	public @ResponseBody JSONObject findTeachers(
			@RequestParam(value = "p", required = true, defaultValue = "2") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		JSONObject result = new JSONObject();
		List<HashMap<String, Object>> teachers = weixin.searchWeixinUserList(" AND  isteacher = 1 AND status = 0 AND isauth = 1 AND hide = 0 ORDER BY seqindex limit " + (p-1)*20 + ",20 ");
		result.put("teachers", teachers);
		return result;
	}



	/**
	 * 活动详情
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/activity/{p}.html")
	public ModelAndView blogActivityIndex(
			@PathVariable("p")     int p, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/w/activity/"+p+".html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
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
		HashMap<String,Object> active = weixin.getActivity( p );
		map.put("activity", active );
		if( active != null && active.get("url") != null && active.get("url").toString().length() > 5 ){
			return  new ModelAndView("redirect:"+ active.get("url").toString().replace("AID", p + "") );
		}else
			return new ModelAndView("/ksite/find/activity",map );
	}
}
