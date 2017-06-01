package com.yoga.controller.v2;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.dao.Weixin_blog_content;
import com.yoga.dao.Weixin_blog_distributor;
import com.yoga.dao.Weixin_blog_feedback;
import com.yoga.dao.Weixin_blog_saler;
import com.yoga.dao.Weixin_blog_teacher_balance;
import com.yoga.dao.Weixin_blog_teacher_course;
import com.yoga.dao.Weixin_blog_teacher_course_line;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.utils.AESUtil;
import com.yoga.utils.Config;
import com.yoga.utils.Pagination;
import com.yoga.weixin.WeixinUtil;
import com.yoga.weixin.template.TemplateData;
import com.yoga.weixin.template.WxTemplate;

import net.sf.json.JSONObject;
/**
 * 我的相关
 * @author jaker
 *
 */
@Controller
public class WeixinV2MyController extends R {


	/**
	 * 我的个人主页
	 * @param session
	 * @param request
	 * @param response
	 * @param p
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/index.html")
	public ModelAndView blogMyIndex(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession(  request,session );
		if( user != null && user.getId() > 0 ){
			map.put("user", weixin.getWeixinUser( user.getId() )); // 不直接从session中获取
			map.put("havaquestion", weixin.haveQuestion( user.getId() ));
			Weixin_blog_distributor distirbutor = manager.getDistributorByWid(user.getId()+1000,ACTIVITY_SJ);
			map.put("distirbutoruuid", distirbutor != null ? distirbutor.getUuid() : "null");
			Weixin_blog_saler sale=saler.getSalerBySalerid(user.getId());
			if(sale!=null){
				map.put("isSaler", true);
			}else{
				map.put("isSaler", false);
			}
		}else{
			map.put("user", new Weixin_blog_user());
			map.put("havaquestion", "0");
		}
		String url = DOMAIN+"/w/my/index.html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		map.put("nologin",   user == null);
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
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/index",map );
	}



	/**
	 * 我的提问
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/mineask.html")
	public ModelAndView blogMineAsk( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0  ){
			map.put("contentlist", weixin.getWeixinContentList(0, " AND wid="+ user.getId()+" AND dflag = 0  ORDER BY id DESC", 1, 10000, false)) ;
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/mineask.html";
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/mineAsk",map );
	}




	/**
	 * 我购买的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/minebuy.html")
	public ModelAndView blogMineBuyCourse( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", order.getOrderList(" AND wid="+user.getId()+" AND type=1 ORDER BY createtime DESC ", 1, 1000)) ;
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/minebuy.html";
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/mineCourse",map );
	}

	/**
	 * 我购买的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/minebuy/line.html")
	public ModelAndView blogMineBuyCourseLine( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", order.getBuyerList(" AND uid="+user.getId()+" ORDER BY id DESC ", 1, 1000)) ;
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/minebuy/line.html";
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/mineCourseLine",map );
	}




	/**
	 * 我收藏的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/minecol.html")
	public ModelAndView blogMineCollectionCourse( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			Pagination page=weixin.getWeixinCollectionList( " AND type = 2 AND wid="+ user.getId()+" ORDER BY id DESC ", 1, 10000);
			map.put("contentlist", page) ;
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/minecol.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/mineCollectionCourse",map );
	}


	/**
	 * 我收藏的线下培训课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/minecorline.html")
	public ModelAndView blogMineCollectionCourseLine( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", weixin.getWeixinCollectionList( " AND type = 3 AND wid="+ user.getId()+" ORDER BY id DESC ", 1, 10000)) ;
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/minecorline.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/mineCollectionCourseLine",map );
	}




	/**
	 * 我关注的老师
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/minefol.html")
	public ModelAndView blogMineFollowTeacher(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", weixin.getCollectionTeacherList(" AND wid="+ user.getId()+" ORDER BY id DESC ", 1, 10000));
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/minefol.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/mineTeacher",map );
	}



	/**
	 * 我上传的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/course.html")
	public ModelAndView blogMyCourse(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist",weixin.getCourseList(" AND uid="+user.getId()+" ORDER BY createtime DESC", 1, 10000));
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/course.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/myCourse",map );
	}


	/**
	 * 我的线下培训
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/line/course.html")
	public ModelAndView myLineCourse(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0  ){
			map.put("contentlist",manager.getLineCourseList(" AND uid="+user.getId()+" ORDER BY createtime DESC", 1, 10000));
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/line/course.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/myCourseLine",map );
	}





	/**
	 * 我的回答
	 * @param tid 1:待回答  2：已回答
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/my/{tid}/ask.html")
	public ModelAndView blogMyAsk(
			@PathVariable("tid")   int tid, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		map.put("tid",  tid);
		if( user != null ){
			String sql = " AND askid="+ user.getId()+" AND dflag = 0 AND (hasanswer = 0 OR hasanswer = 1 AND subcontent <> '' AND submp3path = '')  ORDER BY id DESC";
			if( tid == 2){
				sql = " AND askid="+ user.getId()+" AND hasanswer != 0  AND dflag = 0  ORDER BY id DESC";
			}
			map.put("contentlist", weixin.getWeixinContentList(0, sql, 1, 10000, false ));
		}else{
			map.put("contentlist", new Pagination() );
		}
		String url = DOMAIN+"/w/my/"+tid+"/ask.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/myAsk",map );
	}



	/**
	 * 我的收入
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/my/money.html")
	public ModelAndView blogMyMoney(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		String url = DOMAIN+"/w/my/money.html";
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		if( user != null && user.getId() > 0 ){
			Weixin_blog_teacher_balance balance = order.getTeacherBalanceByUid( user.getId() );
			map.put("balance",balance);
			if( user.getId() > 0){
				map.put("orderlist",  order.getOrderList(" AND isbalance=1 AND tid="+user.getId()+" ORDER BY balancetime DESC ", 1, 30).getResults());
			}else
				map.put("orderlist",  null);
		}else{
			map.put("balance", new Weixin_blog_teacher_balance());
			map.put("orderlist", null);
		}
		return new ModelAndView("/ksite/my/myMoney",map );
	}




	/**
	 * 老师回答
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/faq/d/ask.html")
	public ModelAndView blogMyAnswer(
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			@RequestParam(value = "r", required = false, defaultValue = "0") int r,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		map.put("j",   (r == 1?manager.executeJob("token"):0));
		HashMap<String,Object> content = weixin.getWeixinContentByMap(0, p );
		map.put("nologin", user == null);
		String url = DOMAIN+"/w/faq/d/ask.html?p="+p+"&r="+r;
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
		boolean hasSubAsk = false;
		if( content != null && !(content.get("hasanswer")+"").equals("0") ){
			String subConten = content.get("subcontent")+"", 
					submp3path = content.get("submp3path")+"";
			if(!"".equals(subConten) && "".equals(submp3path)){
				hasSubAsk = true;
			}else{
				map.put("p", p);
				map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
				map.put("d", content);
				if( content != null && content.size() > 0 ){
					map.put("showtime", showTime( content.get("createtime")+""));
				}
				return new ModelAndView("/ksite/faq/index",map );				
			}
		}
		if( user != null && !(content.get("askid")+"").equals(user.getId()+"") ){
			return new ModelAndView("redirect:/w/faq/index.html");
		}
		map.put("hasSubAsk", hasSubAsk);
		String filter = " AND cid = " + content.get("id");
		if( (content.get("hasanswer")+"").equals("0")){
			filter += " AND type = 0 ORDER BY id asc";
		}else{
			filter += " AND type = 1 ORDER BY id asc";			
		}
		List<HashMap<String, Object>> answers = weixin.getAnswersOfCentent(filter);
		map.put("answers", answers);
		map.put("d",   content);
		map.put("nologin", user == null);
		map.put("p",   p);
		map.put("dic", manager.getSysdic(20).getValue());
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/myAnswer",map );
	}



	/**
	 * 老是回答问题
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/faq/adk/ask.html")
	public @ResponseBody JSONObject blogAskQuestion(
			HttpServletRequest     request,
			HttpSession            session,  
			HttpServletResponse    response 
			)  {  
		JSONObject result = new JSONObject();
		String qid      = this.trim( request.getParameter("qid") );  // 问题id
		Weixin_blog_content content = weixin.getWeixinContent( Integer.parseInt( qid ));
		if( content == null ){
			result.put("result", "获取提问错误");
			return result;
		}
		String filter = " AND cid = " + content.getId();
		if( content.getHasanswer() == 0 ){
			filter += " AND type = 0 ORDER BY id asc";
		}else{
			filter += " AND type = 1 ORDER BY id asc";			
		}
		List<HashMap<String, Object>> answers = weixin.getAnswersOfCentent(filter);
		if(answers == null || answers.size() == 0){
			result.put("result", "未找到回答录音");
			return result;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if( user == null || content.getAskid() != user.getId() ){
			result.put("result", "获取信息错误");
			return result;
		}
		int asklong = 0;
		String cdndomain = Config.getString("cdndomain") + "/";
		if(!cdndomain.startsWith("http")){
			cdndomain = "http://" + cdndomain;
		}
		String localname=cdndomain + answers.get(0).get("mp3path");
		for (HashMap<String, Object> hashMap : answers) {
			asklong+=Integer.parseInt(hashMap.get("timelong").toString());
		}
		if(content.getHasanswer() == 0){
			content.setHasanswer(1);
			content.setAsktlong(formatTime(asklong));
			content.setMp3path( localname );
			content.setServerid( "" );
			content.setAsktime( getTime() );			
			int offset = order.answerQustion(content);
			result.put("status", offset > 0 );
		}else{ 
			Object[] res = weixin.addOrUpdateWeixinContent(content);
			result.put("status", res[0] );
		}
		Weixin_blog_user uuid = weixin.getWeixinUser(content.getWid());
		String wxid = uuid.getWxid() ;
		if( wxid != null && wxid.length() > 0 ){ // 此事务为最低事务，微信消息提醒
			sendAnswerQuestionTemplate(wxid, content, user.getNickname() );
		} 
		return result;
	}

	/**
	 * 发送回复用户的通知
	 * @param openId
	 * @return
	 */
	public int sendAnswerQuestionTemplate( String openId, Weixin_blog_content content, String tname){

		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl( Config.getString("domain")+"/w/faq/d.html?p="+content.getId());
		temp.setTouser( openId );
		temp.setTopcolor("#000000");
		temp.setTemplate_id( Config.getString("weixin.answerquestion.templateid"));

		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");
		if("".equals(content.getSubcontent())){
			first.setValue( "您的提问被"+ tname +"老师回复了" );  			
		}else{
			first.setValue( "您的追问被"+ tname +"老师回复了" );  						
		}
		m.put("first", first);  

		TemplateData name = new TemplateData();  
		name.setColor("#000000");  
		name.setValue( tname );  
		m.put("keyword1", name);

		TemplateData wuliu = new TemplateData();  
		wuliu.setColor("#000000");  
		wuliu.setValue( sdf.format( new Date() ));  
		m.put("keyword2", wuliu);


		TemplateData keyword3 = new TemplateData();  
		keyword3.setColor("#000000");  
		keyword3.setValue("录音文件");  
		m.put("keyword3", keyword3);

		TemplateData remark = new TemplateData();  
		remark.setColor("#000000");  
		remark.setValue( "如有问题请致电4000186161或直接在微信留言，小瑜将第一时间为您服务！" );  
		m.put("remark", remark);

		temp.setData( m );
		String jsonString = JSONObject.fromObject(temp).toString();
		JSONObject jsonObject = null;
		try {
			jsonObject = WeixinUtil.httpRequest(url, "POST", jsonString);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if ( null != jsonObject ) {  
			if (0 != jsonObject.getInt("errcode")) {  
				return jsonObject.getInt("errcode");
			}  
		}
		return -1;
	}


	/**
	 * 
	 * @param asklong
	 * @return
	 */
	private String formatTime(int asklong) {
		int min = asklong / 60;
		int sec = asklong % 60;
		String res = "";
		if(min < 10)
			res ="0";
		res = res + min + ":";
		if(sec < 10)
			res += "0";
		res += sec;
		return res;
	}



	/**
	 * 关于瑜是乎
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/help/about.html")
	public ModelAndView myAbout(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){   
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user); 
		String url = DOMAIN+"/w/help/about.html"; 
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/about",map );
	}


	/**
	 * 如何使用瑜是乎
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/help/index.html")
	public ModelAndView myHelpUseIndex(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){   
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+"/w/help/index.html"; 
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
		map.put("user", user); 
		return new ModelAndView("/ksite/help/index",map );
	}





	/**
	 * 如何使用瑜是乎
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/help/use.html")
	public ModelAndView myHelpUse(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session ); 
		map.put("user", user); 
		String url = DOMAIN+"/w/help/use.html"; 
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
		map.put("helplist", manager.getHelpListByAll() );
		return new ModelAndView("/ksite/help/howuse",map );
	}



	/**
	 * 如果使用瑜是乎明细帮助文档
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/help/item.html")
	public ModelAndView myHelpUseItem( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){   
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user); 
		String url = DOMAIN+"/w/help/item.html"; 
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
		return new ModelAndView("/ksite/help/index",map );
	}



	/**
	 * 用户协议
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/help/agreement.html")
	public ModelAndView myAgreement( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){   
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user); 
		String url = DOMAIN+"/w/help/agreement.html"; 
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
		return new ModelAndView("/ksite/help/agreement",map );
	}

	/**
	 * 意见反馈
	 * @param session
	 * @param request
	 * @param response 
	 */
	@RequestMapping(value = "w/help/feedback.html")
	public ModelAndView myFeedBack( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user",  user); 
		String url = DOMAIN+"/w/help/feedback.html";  
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
		map.put("nologin",   user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/feedback/feedback",map );
	}



	/**
	 * 提交意见反馈
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/add/feedback.html")
	public @ResponseBody JSONObject blogFeedBack(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  { 
		JSONObject result = new JSONObject();
		result.put("status", false);
		Weixin_blog_user user = getWeixinSession(request,session );
		if( user == null ){
			result.put("result", "");
			return result;
		}
		String content = this.trim( request.getParameter("question"));
		String questiontype = this.trim( request.getParameter("questiontype"));
		Object [] isSQLInj = isSQLInj( content );
		if( (Boolean) isSQLInj[0] ){
			result.put("status", false);
			result.put("result", ERROR_TMSG+isSQLInj[1]);
			return result;
		} 
		Weixin_blog_feedback feedback = new Weixin_blog_feedback();
		feedback.setCreatetime( getTime());
		feedback.setQuestiontype( Integer.parseInt( questiontype) );
		feedback.setUname( user.getNickname() );
		feedback.setUid( user.getId()) ;
		feedback.setContent( content );
		feedback.setMobile( this.trim( request.getParameter("mobile")));
		result.put("status", weixin.addOrUpdateFeedback(feedback) >0 );
		return result;
	}



	/**
	 * 课程页面
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex 
	 */
	@RequestMapping(value = "w/my/prizecourse.html")
	public ModelAndView blogCourse(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url  = DOMAIN+"/w/my/prizecourse.html?p="+p;
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
		String wxid = null;
		map.put("p", p);
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null );
		map.put("user",      user );
		Weixin_blog_teacher_course course = weixin.getCourse(p);
		if( course != null ){
			map.put("money", Integer.valueOf( course.getMoney() ));
			if( wxid == null && user != null && user.getWxid() != null )
				wxid = user.getWxid();
			map.put("u", weixin.getWeixinUser( course.getUid() ));
			map.put("wxid", wxid );
			map.put("commentlist",  weixin.getWeixinCommentList(" AND cid="+p+" AND ctype=1 AND status= 0  ORDER BY createtime desc ", 1, R.pageSize )); // 评论
			String playUrl = course.getRealfilepath();
			map.put("playUrl", playUrl);
		}
		map.put("c",         course); 
		boolean isBuy   = true;
		boolean isShow  = true; 
		map.put("isbuy",  isBuy);
		map.put("isshow", isShow);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey)); 
		if( user != null ){
			map.put("isfollow", weixin.isFollowCourseLine( user.getId(), p));
		}
		return new ModelAndView("/ksite/course/course",map );
	}


	/**
	 * 提交教师节日期和角色 
	 * 
	 * @param session
	 * @param request
	 * @param sign 组织机构标识
	 * @param day 选择日期
	 * @param role 选择角色
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/spowder.html",method=RequestMethod.POST)
	public  @ResponseBody JSONObject ajaxSpowder(
			HttpSession session,
			HttpServletRequest request
			) {
		JSONObject result = new JSONObject(); 
		Weixin_blog_user user = getWeixinSession(request, session);
		if( user != null && user.getId() > 0 ){
			result.put("code", 1);
			result.put("msg", "保存成功");
		}else{
			result.put("code", -1);
			result.put("msg", "无法获取用户信息");
		}
		return result;
	}


	/**
	 * 线下培训报名用户列表
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/course/line/buyer.html")
	public ModelAndView salerProducts(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			HttpSession session, 
			HttpServletRequest request, 
			HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession(request, session);
		String url   = DOMAIN + "/w/course/line/buyer.html";
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
		map.put("urlsecret", AESUtil.Encrypt(url, cKey));
		boolean login = false;
		if ( user != null ){
			Pagination havaMoneyList = manager.getLCourseMoneyList(" AND cid="+p +" ORDER BY money ASC",1,100);
			map.put("clist", havaMoneyList.getResults());
			login = true;
			Weixin_blog_teacher_course_line lcourse=manager.getLineCourse(user.getId());
			map.put("id", lcourse==null?"":lcourse.getId());
			String filter=" AND tid = "+user.getId()+" AND cid="+p+" ORDER BY id";
			Pagination page  = manager.getBuyesList(filter, 1, R.pageSize);
			map.put("buyers",     page.getResults());
			map.put("totalPage",     page.getTotalPage());
			map.put("totalCount", page.getTotalCount() );
			map.put("pageIndex",  1 );
		}
		map.put("login", login);
		return new ModelAndView("/ksite/my/line_buyer", map);
	}

	/**
	 * 线下培训报名用户分页ajax
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/course/line/buyerAjax.shtml")
	public @ResponseBody JSONObject salerProductsAjax(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			HttpSession session, 
			HttpServletRequest request, 
			HttpServletResponse response,
			@RequestParam(value = "srowid", required = true, defaultValue = "") String srowid,
			@RequestParam(value = "pageIndex", required = true, defaultValue = "1") int pageIndex )
	{
		JSONObject result = new JSONObject();
		Weixin_blog_user user = getWeixinSession(request, session);
		String filter=" AND tid = "+user.getId()+" AND cid="+p+" ORDER BY id";
		if(user != null){
			try {
				Pagination page=manager.getBuyesList(filter, pageIndex, R.pageSize);
				result.put("result",     page.getResults());
				result.put("totalCount", page.getTotalCount() );
				result.put("totalPage",  page.getTotalPage());
				result.put("pageIndex",  pageIndex );
				result.put("code", 1);
			} catch (Exception e) {
				result.put("code", 0);
			}
		}
		return result;
	}

	/**
	 * 我的奖品
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/my/mineprize.html")
	public ModelAndView myPrize( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null ){ 
			List<HashMap<String, Object>> awards = weixin.getWeixinUserExclusiveAward(user.getId());
			if(awards!=null&&awards.size()>0){
				map.put("havePrize", true);
			}
			map.put("awards", awards);
		}else{
			map.put("nologin",   user == null);
		} 
		String url = DOMAIN+"/w/my/mineprize.html";
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
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/my/myPrize",map );
	}


	/**
	 * 我购买的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "v2/my/minebuy/course.shtml")
	public ModelAndView MineCourse( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/my/minebuy/course.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/mine/minecourse",map );
	}

	/**
	 * 我购买的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "v2/my/minebuy/zhibo.shtml")
	public ModelAndView MineZhibo( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/my/minebuy/zhibo.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/mine/mine_zhibo",map );
	}

	/**
	 * 我购买的课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "v2/my/minebuy/course.json")
	public @ResponseBody HashMap<String,?> mineBuyCourse( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", order.getOrderList(" AND wid="+user.getId()+" AND type=1 ORDER BY createtime DESC ", 1, 1000).getResults()) ;
		}else{
			map.put("contentlist", new Pagination().getResults() );
		}
		return map;
	}

	
	/**
	 * 我购买的直播
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	
	@RequestMapping(value = "v2/my/minebuy/zhibo.json")
	public @ResponseBody HashMap<String,?> mineBuyZhibo( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){  
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("user", user);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", order.getOrderList(" AND wid="+user.getId()+" AND type=2 ORDER BY createtime DESC ", 1, 1000).getResults()) ;
		}else{
			map.put("contentlist", new Pagination().getResults() );
		}
		return map;
	}

}