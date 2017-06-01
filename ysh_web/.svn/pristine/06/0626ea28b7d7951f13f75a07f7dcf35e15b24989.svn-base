package com.yoga.controller.v2;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yoga.dao.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.utils.AESUtil;
import com.yoga.utils.Config;
import com.yoga.utils.DateTools;
import com.yoga.utils.Pagination;
import com.yoga.utils.StringUtils;
import com.yoga.weixin.pay.ConfigUtil;
import com.yoga.weixin.pay.PayCommonUtil;

import net.sf.json.JSONObject;

/**
 * 
 * @author jaker
 *
 */
@SuppressWarnings("all")
@Controller
public class WeixinControllerV2 extends R {
	/**
	 * faq/index.html
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex
	 * @return
	 * @ 
	 */
	@RequestMapping(value = "w/faq/index.html")
	public ModelAndView blogfaqIndex(
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request, 
			HttpServletResponse    response 
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		
		String url = DOMAIN+"/w/faq/index.html?p="+p;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
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
		if( token !=null && token.length > 2 ){
			jsapiSignatureURL (map,url,token[2] );
		} 
		map.put("nologin", user == null);
		map.put("p", p);
		if( p == 0 ){
			map.put("resultlist", weixin.getWeixinContentListByIndex(" AND hasanswer =1 AND isopen= 0 ORDER BY asktime DESC", 1, R.pageSize));
		}
		if( p == 1 ){
			map.put("resultlist", weixin.getWeixinUserList("  AND isteacher = 1 AND status = 0 AND isauth = 1 AND hide = 0 AND isacceptask != 2 ORDER BY seqindex", 1, R.pageSize));
		}
		List<HashMap<String, Object>> bannerlist = weixin.getBannerListAll(1);
		map.put("bannerlist", bannerlist);
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/study/index",map );
	}


	/**
	 * json格式翻页
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/faq/index/json.html")
	public @ResponseBody JSONObject blogfaqIndexJson(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			@RequestParam(value = "pageIndex", required = true, defaultValue = "1") int pageIndex 
			){ 
		Pagination page = null;
		if( p == 0 ){
			page = weixin.getWeixinContentListByIndex(" AND hasanswer =1 AND isopen= 0  ORDER BY asktime DESC", pageIndex, R.pageSize);
		}
		if( p == 1 ){
			page = weixin.getWeixinUserList(" AND  isteacher = 1 AND status = 0 AND isauth = 1 ORDER BY seqindex", pageIndex, R.pageSize);
		}
		JSONObject result = new JSONObject();
		if( page.getResults() != null && page.getResults().size() > 0 ) {
			StringBuffer strBuffer = new StringBuffer();
			List<HashMap<String,Object>> list = page.getResults();
			for( HashMap<String,Object>  c : list){
				if( p == 0 ){
					strBuffer.append("<li data-url="+DOMAIN+"/w/faq/d.html?p="+c.get("id")+">");
					strBuffer.append("<h2><a href="+DOMAIN+"/w/faq/d.html?p="+c.get("id")+">"+c.get("synopsis")+"</a></h2>");
					strBuffer.append("<div>");
					strBuffer.append("<p class='introduction'><span class='name'>"+(c.get("askusername")==null?"":c.get("askusername"))+"</span><b>|</b><span class='summary'>"+(c.get("askuserpost")==null?"":c.get("askuserpost"))+"</span></p>");
					strBuffer.append("<dl>");
					strBuffer.append("<dt>");
					strBuffer.append("<a href="+DOMAIN+"/w/faq/person.html?p="+c.get("askuserid")+">");
					if(c.containsKey("askheader")&&c.get("askheader")!=null){
						if( (c.get("askheader")+"").indexOf("http") > -1 ){
							strBuffer.append("<img src="+c.get("askheader")+" >");
						}else{
							strBuffer.append("<img src="+DOMAIN+"/"+c.get("askheader")+" >");
						}	
					}
					strBuffer.append("</a>");
					strBuffer.append("</dt>");
					strBuffer.append("<dd><a href="+DOMAIN+"/w/faq/d.html?p="+c.get("id")+"><img src='"+CDNDOMAIN+"/son.png'>免费听</a><span>"+c.get("asktlong")+"</span></dd>");
					strBuffer.append("</dl>");
					strBuffer.append("</div>");
					strBuffer.append("</li>");
				}else{
					strBuffer.append("<li data-url="+DOMAIN+"/w/faq/person.html?p="+c.get("id")+">");
					strBuffer.append("<div>");
					strBuffer.append("<dl>");
					strBuffer.append("<dt><a href="+DOMAIN+"/w/faq/person.html?p="+c.get("id")+">");
					if( (c.get("file_path")+"").indexOf("http") > -1 )
						strBuffer.append("<img src="+c.get("file_path")+" >");
					else
						strBuffer.append("<img src="+DOMAIN+"/"+c.get("file_path")+" >");
					strBuffer.append("</a></dt>");
					strBuffer.append("<dd>");
					strBuffer.append("<h4><a href='javascript:;'>"+c.get("nickname")+"</a></h4>");
					strBuffer.append("<h5><a href='javascript:;'>"+c.get("userpost")+"</a></h5>");
					strBuffer.append("<p><span>"+c.get("ask_count")+"个回答</span><span>"+c.get("fensi_count")+"人关注</span>");
					strBuffer.append("</dd>");
					strBuffer.append("</dl>");
					strBuffer.append("</div>");
					strBuffer.append("</li>");
				}
			}
			result.put("result",     strBuffer.toString());
			result.put("totalPage",  page.getTotalPage() );
			result.put("totalCount", page.getTotalCount() );
			result.put("pageIndex",  pageIndex );
		}else
			result.put("result", "");
		return result;
	}



	/**
	 * 老师个人主页
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex 
	 */
	@RequestMapping(value = "w/faq/person.html")
	public ModelAndView blogPersonIndex(
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			@RequestParam(value = "t", required = false, defaultValue = "0") int t,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		String toUrl = "";
		map.put("p", p);
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null );
		String url = DOMAIN+"/w/faq/person.html?p="+p+"&t="+t;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
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
		if( token !=null && token.length > 2 ){
			jsapiSignatureURL (map,url,token[2] );
		} 
		Weixin_blog_user teacher = weixin.getWeixinUser(p);
		if( teacher != null && t < 2 ){
			if(teacher.getIsacceptask() == 1){
				t = 0;
			}else if(teacher.getIsacceptask() == 2){
				t = 1;
			}
		}
		map.put("t", t);
		map.put("u",  teacher );
		map.put("loginuser", user);
		if( user != null && user.getId() > 0 ){  
			map.put("followuser", weixin.isFollowUser( user.getId(), p ));  
		}
		if( teacher != null){
			map.put("desc", replaceBlank( teacher.getShortremark() ));
		}
		if ( (t == 0 || t==3) && teacher != null  ) {
			if( teacher.getAskmoney() == null || teacher.getAskmoney().equals("") ){
				teacher.setAskmoney("0");
			}
			if( Integer.parseInt( teacher.getAskmoney()) > 0 ){  // 付费问答
				String wxid = null;
				if( wxid == null && user != null && user.getWxid() != null ){
					wxid = user.getWxid();
				}
				if( wxid != null ){  // 获得微信授权 
					String nonceStr =PayCommonUtil.CreateNoncestr();
					long timestamp = System.currentTimeMillis() / 1000;
					Object[] payInfo = PayCommonUtil.getPrepay_id(teacher.getNickname()+"提问", nonceStr, teacher.getAskmoney()+"00", teacher.getId()+"_teacher", wxid  );
					if( payInfo != null && payInfo.length == 2 && payInfo[0] != null && payInfo[1] != null){
						String prepayid = payInfo[1].toString();
						String ordernumber = payInfo[0].toString();
						Map<String ,String >   signMap=new HashMap<String ,String >();
						signMap.put("appId",    Config.getString("weixin.appid"));
						signMap.put("timeStamp", timestamp+"");
						signMap.put("package", "prepay_id="+prepayid);
						signMap.put("signType", "MD5");
						signMap.put("nonceStr", nonceStr);
						map.put("paytimestamp", timestamp);
						map.put("paypackage", "prepay_id="+prepayid);
						map.put("paynonceStr", nonceStr);
						map.put("ordernumber", ordernumber);
						map.put("paysignType", "MD5");
						map.put("paySign" ,    getPayCustomSign(signMap,ConfigUtil.API_KEY) );
					}
				}
			}
			toUrl = "/ksite/teacher/person";
			map.put("dic",        manager.getSysdic(20).getValue());
			map.put("resultlist", weixin.getWeixinContentList(0, " AND askid="+teacher.getId()+" AND isopen=0  AND hasanswer = 1 ORDER BY createtime DESC ", 1, R.pageSize, false));
		}
		if( (t == 1 || t == 4) && teacher != null ){
			map.put("resultlist", weixin.getCourseList(" AND uid="+teacher.getId()+"  AND status = 0 ORDER BY istop DESC", 1, R.pageSize));
			toUrl = "/ksite/teacher/course";
		}
		if( (t == 2 || t == 5) && teacher != null){
			map.put("resultlist", manager.getLineCourseList("AND uid="+teacher.getId()+" AND status = 0 ORDER BY id DESC", 1, R.pageSize));
			toUrl = "/ksite/teacher/lcourse";
		}
		return new ModelAndView(toUrl,map);
	}




	/**
	 * json格式翻页
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/faq/person/json.html")
	public @ResponseBody JSONObject blogPersonIndexJson(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			@RequestParam(value = "t", required = false, defaultValue = "0") int t,
			@RequestParam(value = "pageIndex", required = true, defaultValue = "1") int pageIndex
			) { 
		Pagination page = null;
		if( t == 0 ){
			page = weixin.getWeixinContentList(0, " AND askid="+p+" AND isopen=0  AND hasanswer = 1 ORDER BY createtime DESC ", pageIndex, R.pageSize, false);
		}
		if( t == 1 ){
			page = weixin.getCourseList(" AND uid="+p+" AND status = 0  ORDER BY istop DESC ", pageIndex, R.pageSize);
		}
		if( t == 2 ){
			page = manager.getLineCourseList(" AND uid="+p+" AND status = 0 ORDER BY id DESC ", pageIndex, R.pageSize);
		}
		JSONObject result = new JSONObject();
		if( page.getResults() != null ) {
			StringBuffer strBuffer = new StringBuffer();
			List<HashMap<String,Object>> list = page.getResults();
			for( HashMap<String,Object>  c : list){
				if( t == 0 ){
					strBuffer.append("<input type='hidden' id='isplay_"+c.get("id")+"' value='0'/>");
					strBuffer.append("<li>");
					strBuffer.append("<dl>");
					strBuffer.append("<dt>");
					strBuffer.append("<a href="+DOMAIN+"/w/faq/person.html?p="+c.get("wid")+">");
					if(c.containsKey("header")&&c.get("header")!=null){
						if( c.get("header").toString().indexOf("http") > -1 )
							strBuffer.append("<img src="+c.get("header")+" >");
						else
							strBuffer.append("<img src="+DOMAIN+"/"+c.get("header")+" >");
					}
					strBuffer.append("</a>");
					strBuffer.append("</dt>");
					strBuffer.append("<dd><h4>"+c.get("synopsis")+"</h4>");
					if( !c.get("askmoney").equals("0"))
						strBuffer.append("<p>￥"+c.get("askmoney")+"</p>");
					strBuffer.append("</dd>");
					strBuffer.append("</dl>");
					strBuffer.append("<dl>");
					strBuffer.append("<dt>");
					if(c.containsKey("askheader")&&c.get("askheader")!=null){
						if( c.get("askheader").toString().indexOf("http") > -1 )
							strBuffer.append("<img src="+c.get("askheader")+" >");
						else
							strBuffer.append("<img src="+DOMAIN+"/"+c.get("askheader")+" >");
					}
					strBuffer.append("</dt>");
					strBuffer.append("<dd>");
					if(c.get("answers")!=null){
						@SuppressWarnings("unchecked")
						List<HashMap<String,Object>> answers =(List<HashMap<String,Object>>) c.get("answers");
						for (HashMap<String, Object> ans : answers) {
							strBuffer.append("<button class='audio'  onclick='playmp3(this,"+ans.get("id")+")' data-id="+ans.get("cid")+"  data-src="+CDNDOMAIN+"/"+ans.get("mp3path")+">");
							strBuffer.append("<img src='"+CDNDOMAIN+"/son.png'>免费听</button>");
							strBuffer.append("<span id='aa_"+ans.get("id")+"'>"+ans.get("timelong")+"</span>");
						}
					}
					strBuffer.append("</dd>");
					strBuffer.append("</dl>");
					strBuffer.append("<p><span>"+c.get("showtime")+"</span><span>听过&nbsp;&nbsp;<span id='span_"+c.get("id")+"'>"+c.get("play_count")+"</span></span></p>");
					strBuffer.append("</li>");
					if(c.get("subcontent")!=null&&!StringUtils.isNull(c.get("subcontent").toString())){
						strBuffer.append("<li>");
						strBuffer.append("<dl>");
						strBuffer.append("<dt>");
						strBuffer.append("<a href="+DOMAIN+"/w/faq/person.html?p="+c.get("wid")+">");
						if(c.containsKey("header")&&c.get("header")!=null){
							if( c.get("header").toString().indexOf("http") > -1 )
								strBuffer.append("<img src="+c.get("header")+" >");
							else
								strBuffer.append("<img src="+DOMAIN+"/"+c.get("header")+" >");
						}
						strBuffer.append("</a>");
						strBuffer.append("</dt>");
						strBuffer.append("<dd>");
						strBuffer.append("<h2>"+c.get("subcontent")+"</h2>");
						strBuffer.append("</dd>");
						strBuffer.append("</dl>");
						strBuffer.append("<dl>");
						strBuffer.append("<dt>");
						if(c.containsKey("askheader")&&c.get("askheader")!=null){
							if( c.get("askheader").toString().indexOf("http") > -1 )
								strBuffer.append("<img src="+c.get("askheader")+" >");
							else
								strBuffer.append("<img src="+DOMAIN+"/"+c.get("askheader")+" >");
						}
						strBuffer.append("</dt>");
						strBuffer.append("<dd>");
						@SuppressWarnings("unchecked")
						List<HashMap<String,Object>> answers_expand =(List<HashMap<String,Object>>) c.get("answers_expand");
						for (HashMap<String, Object> ans : answers_expand) {
							strBuffer.append("<button class='audio'  onclick='playmp3(this,'"+ans.get("id")+"')' data-id="+ans.get("cid")+"  data-src="+CDNDOMAIN+"/"+ans.get("mp3path")+">");
							strBuffer.append("<img src='"+CDNDOMAIN+"/son.png'>免费听</button>");
							strBuffer.append("<span id='aa_"+ans.get("id")+"'>"+ans.get("timelong")+"</span>");
						}
						strBuffer.append("</dd>");
						strBuffer.append("</dl>");
						strBuffer.append("</li>");
					}
				}else if(t == 1){
					strBuffer.append("<li class=\"taplist\"  onclick=\"sel(this)\" data-url=\""+DOMAIN+"/w/faq/course.html?p="+c.get("id")+"\">");
					strBuffer.append("<h1>"+c.get("cname")+"</h1>");
					strBuffer.append("<p>"+c.get("remark")+"</p>"); 
					if( c.get("taglist") != null && c.get("taglist").toString().length() > 0 ){
						String []taglist = c.get("taglist").toString().split(",");
						strBuffer.append("<ul>");   
						for( String tag : taglist ){
							strBuffer.append("<li>"+tag+"</li> ");
						}
						strBuffer.append("</ul>");   
					}
					strBuffer.append("</li>");  
				}else{
					strBuffer.append("<li class=\"taplist\"  onclick=\"sel(this)\" data-url=\""+DOMAIN+"/w/faq/lcourse.html?p="+c.get("id")+"\">");
					strBuffer.append("<h1>"+c.get("cname")+"</h1>");
					strBuffer.append("<p>"+c.get("remark")+"</p>"); 
					if( c.get("taglist") != null && c.get("taglist").toString().length() > 0 ){
						String []taglist = c.get("taglist").toString().split(",");
						strBuffer.append("<ul>");   
						for( String tag : taglist ){
							strBuffer.append("<li>"+tag+"</li> ");
						}
						strBuffer.append("</ul>");
					}
					strBuffer.append("</li>");  
				}
			}
			result.put("result",     strBuffer.toString());
			result.put("totalPage",  page.getTotalPage() );
			result.put("totalCount", page.getTotalCount() );
			result.put("pageIndex",  pageIndex );
		}else
			result.put("result", "");
		return result;
	}



	/**
	 * 关注或取消关注
	 * @param tid
	 * @param link
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/follow/{tid}/{link}.html")
	public  @ResponseBody JSONObject followUser(
			@PathVariable("tid")   int tid,
			@PathVariable("link")  boolean link, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		JSONObject result = new JSONObject();
		result.put("status", false);
		Weixin_blog_user user = getWeixinSession( request,session ) ;
		if( user != null && tid > 0 ){
			result.put("status", weixin.followUser( user.getId(),tid, link?2:1 )> 0);
		}
		return result;
	}




	/**
	 * 判断用户是否购买力该课程
	 * @param cid
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/isbuy/{cid}.html")
	public  @ResponseBody JSONObject blogUserIsBuyCourse(
			@PathVariable("cid")   int cid, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		JSONObject result = new JSONObject();
		result.put("status", false);
		Weixin_blog_user user = getWeixinSession( request,session ) ;
		if( user != null && cid > 0 ){
			result.put("status", order.getOrderBywxid(user.getWxid(), cid) == null );
		}
		return result;
	}




	/**
	 * 课程页面
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex 
	 */
	@RequestMapping(value = "w/faq/course.html")
	public ModelAndView blogCourse(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			@RequestParam(value = "i", required = true, defaultValue = "0") int i,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) { 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("p", p);
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null );
		map.put("user",      user );
		Weixin_blog_teacher_course course = weixin.getCourse(p);
		map.put("c",         course); 
		boolean isBuy   = false;
		boolean isowner = false;
		String url  = DOMAIN+"/w/faq/course.html?p="+p+"&i="+i;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
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
		if( token !=null && token.length > 2 ){
			jsapiSignatureURL (map,url, token[2] );
		} 
		boolean isShow = false; 
		if( user != null ){
			Weixin_blog_teacher_order buyOrder = order.getOrderBywxid(user.getWxid(), p);
			if( buyOrder != null ){
				isBuy = true;
				if( buyOrder.getExpirationtime() != null ){
					if( !DateTools.beforeDate( sdf.format( new Date()), buyOrder.getExpirationtime()) ){
						isBuy = false;
						map.put("isexptime", true);
					}
				}
			}
			if( course != null && user.getId() == course.getUid() ){
				isowner = true;
				isBuy   = true;
			}
			if( user.getId() == 135 || user.getId() == 137 || user.getId() ==  12292 ||
				user.getId() == 181 || user.getId() == 646 || user.getId() ==  12250 ||	
				user.getId() == 129978 || user.getId() == 104048 || user.getId() ==  138 ||
				user.getId() == 129978 || user.getId() == 15752 || user.getId() ==  12022  ||
				user.getId() == 11942 || user.getId() == 260 || user.getId() ==  121893 || 
				user.getId() == 128504
			){
				isShow=true;
				isBuy=true;
			}
			HashMap<String, Object> award = weixin.getWeixinUserExclusiveAwardByCid(user.getId(), Integer.valueOf(p));
			if(award != null && award.size() > 0){
				isShow = true;
				isBuy = true ;
			}
		}
		if( course !=null && Integer.parseInt(course.getMoney()) == 0 || isowner || isBuy ){
			isShow = true;
		} 
		map.put("isbuy", isBuy);
		map.put("isshow",isShow);
		String wxid = null;
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		if( course != null ){
			map.put("money", Integer.valueOf( course.getMoney() ));
			if( wxid == null && user != null && user.getWxid() != null ){
				wxid = user.getWxid();
			}
			map.put("u",    weixin.getWeixinUser( course.getUid()) );
			map.put("wxid", wxid );
			map.put("commentlist",  weixin.getWeixinCommentList(" AND cid="+p+" AND ctype=1 AND status= 0  ORDER BY createtime desc ", 1, R.pageSize )); // 评论
			String playUrl = course.getRealfilepath();
			if( wxid != null && course.getMoney() != null && !course.getMoney().equals("0") ){  // 获得微信授权 
				String nonceStr =PayCommonUtil.CreateNoncestr();
				long timestamp = System.currentTimeMillis() / 1000;
				Object[] payInfo = PayCommonUtil.getPrepay_id(course.getCname(), nonceStr, course.getMoney()+"00", course.getId()+"", wxid  );
				if( payInfo != null && payInfo.length > 0 && payInfo[1] != null && payInfo[0] != null ) {
					String prepayid = payInfo[1].toString();
					String ordernumber = payInfo[0].toString();
					Map<String ,String >    signMap=new HashMap<String ,String >();
					signMap.put("appId",    Config.getString("weixin.appid"));
					signMap.put("timeStamp",timestamp+"");
					signMap.put("package", "prepay_id="+prepayid);
					signMap.put("signType", "MD5");
					signMap.put("nonceStr", nonceStr);
					map.put("paytimestamp", timestamp);
					map.put("paypackage",  "prepay_id="+prepayid);
					map.put("paynonceStr",  nonceStr);
					map.put("paysignType",  "MD5");
					map.put("ordernumber",  ordernumber );
					map.put("paySign" ,     getPayCustomSign(signMap,ConfigUtil.API_KEY) );
				}
			}
			if(course.getProperty() == 1){
				List<HashMap<String,Object>> items = weixin.getCourseItemByCid(p);
				if( items != null && items.size() > 0 ){
					if( i == 0 ){
						i = Integer.parseInt(items.get(0).get("id")+"");
						playUrl = items.get(0).get("filepath")+"";
					}else{
						for(HashMap<String, Object> it : items){
							if((i+"").equals(it.get("id")+"")){
								playUrl = it.get("filepath")+"";
								break;
							}
						}					
					}					
				}
				map.put("items", items);
				map.put("currentItem", i);
			}
			if( !isBuy && !"0".equals(course.getMoney()+"")){
				playUrl = course.getFilepath();
			}
			map.put("playUrl", playUrl);
		}
		if( user != null ){
			map.put("subscribe", checkUserHasFollow(user));
			map.put("isfollow", weixin.isFollowCourse( user.getId(), p));
		}
		return new ModelAndView("/ksite/course/course",map );
	}




	/**
	 * 课程的收藏或取消收藏
	 * @param t  1:收藏  2：取消收藏
	 * @param id 课程ID
	 * @param type 类型：类型： 1：问题 （无） 2：课程，3线下课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/course/follow/{t}/{cid}/{type}.html")
	public @ResponseBody JSONObject followCourse(
			@PathVariable("t")   int t,
			@PathVariable("cid")   int cid, 
			@PathVariable("type")   int type,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  { 
		JSONObject result = new JSONObject();
		result.put("status", false);
		Weixin_blog_user user = getWeixinSession( request,session ) ;
		if( user != null && cid > 0 ){
			result.put("status", weixin.followCourse(user.getId(),cid,t,type) > 0);
		}
		return result;
	}




	/**
	 * 评论课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/course/comment.html")
	public @ResponseBody JSONObject blogCourseComment(
			HttpServletRequest     request, 
			HttpSession            session,  
			HttpServletResponse    response
			) { 
		JSONObject result = new JSONObject();
		String content = this.trim( request.getParameter("comment"));
		Weixin_blog_user user = getWeixinSession( request,session ) ;
		if( user != null ){
			Weixin_blog_content_comment comment = new Weixin_blog_content_comment();
			comment.setCid( Integer.valueOf( request.getParameter("cid")));
			if( content == null || content.length() == 0 ){
				result.put("status", false);
				result.put("result", "内容为空!");
				return result;
			}
			Object [] isSQLInj = isSQLInj( content );
			if( (Boolean) isSQLInj[0] ){
				result.put("status", false);
				result.put("result", ERROR_TMSG+isSQLInj[1]);
				return result;
			} 
			comment.setContent(content);
			comment.setCreatetime( getTime() );
			comment.setWid( user.getId() );
			comment.setCtype(1);
			Object[] offset = weixin.addOrUpdateComment( comment );
			result.put("status", offset[0]);
			result.put("result", offset[1]);
			StringBuffer buffer = new StringBuffer();
			buffer.append("<li>");
			buffer.append("<dl>");
			buffer.append("<dt><a href="+DOMAIN+"/w/faq/person.html?p="+user.getId()+">");
			if( user.getFile_path().indexOf("http") > -1 )
				buffer.append("<img src="+user.getFile_path()+" >");
			else
				buffer.append("<img src="+DOMAIN+"/"+user.getFile_path());
			buffer.append("</a></dt>");
			buffer.append("<dd><h3><a href="+DOMAIN+"/w/faq/person.html?p="+user.getId()+">"+user.getNickname()+"</a></h3></dd>");
			buffer.append("</dl>");
			buffer.append("<div>");
			buffer.append("<h4>"+content+"</h4>");
			buffer.append("<p>刚刚</p>");
			buffer.append("</div>");
			buffer.append("</li>");
			result.put("html", buffer.toString());
		}else{
			result.put("status", false);
			result.put("result", "您未登录,请重新授权登录后在评论！");
		}
		return result; 
	}




	/**
	 * json格式翻页:评论翻页
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/faq/course/json.html")
	public @ResponseBody JSONObject blogCourseCommentJson(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value = "p", required = false, defaultValue = "0") int p, 
			@RequestParam(value = "pageIndex", required = true, defaultValue = "1") int pageIndex 
			) { 
		Pagination page = weixin.getWeixinCommentList(" AND cid="+p+" AND ctype=1 AND status= 0  ORDER BY createtime desc ", pageIndex, R.pageSize );
		JSONObject result = new JSONObject();
		if( page.getResults() != null ) {
			StringBuffer buffer = new StringBuffer();
			List<HashMap<String,Object>> list = page.getResults();
			for( HashMap<String,Object>  c : list){
				buffer.append("<li>");
				buffer.append("<dl>");
				buffer.append("<dt><a href="+DOMAIN+"/w/faq/person.html?p="+c.get("wid")+">");
				if( c.get("header").toString().indexOf("http") > -1 )
					buffer.append("<img src="+c.get("header")+" >");
				else
					buffer.append("<img src="+DOMAIN+"/"+c.get("header"));
				buffer.append("</a></dt>");
				buffer.append("<dd><h3><a href="+DOMAIN+"/w/faq/person.html?p="+c.get("wid")+">"+c.get("username")+"</a></h3></dd>");
				buffer.append("</dl>");
				buffer.append("<div>");
				buffer.append("<h4>"+c.get("content")+"</h4>");
				buffer.append("<p>"+c.get("showtime")+"</p>");
				buffer.append("</div>");
				buffer.append("</li>");
			}
			result.put("result",     buffer.toString());
			result.put("totalPage",  page.getTotalPage() );
			result.put("totalCount", page.getTotalCount() );
			result.put("pageIndex",  pageIndex );
		}else
			result.put("result", "");
		return result;
	}


	/**
	 * 问答详情
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex 
	 */
	@RequestMapping(value = "w/faq/d.html")
	public ModelAndView blogFaqDetail(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("p", p);
		String url = DOMAIN+"/w/faq/d.html?p="+p;
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
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		if( token !=null && token.length > 2 ){
			jsapiSignatureURL (map,url,token[2] );
		} 
		try {
			map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		} catch (Exception e) {
			e.printStackTrace();
		}
		HashMap<String,Object> askdetail = weixin.getWeixinContentByMap(0,p);
		Weixin_blog_user user = getWeixinSession(request, session);

		boolean canAsk = user != null && user.getId() == Integer.parseInt(askdetail.get("wid")+"") && "1".equals(askdetail.get("hasanswer")+"") && "".equals(askdetail.get("subcontent")+"");
		if(canAsk){
			Weixin_blog_user teacher = weixin.getWeixinUser(Integer.parseInt(askdetail.get("askid")+""));
			canAsk = teacher.getApplysubask() == 0;
			if(askdetail.get("asktime")!=null&&!askdetail.get("asktime").equals("null")){
				String asktime=askdetail.get("asktime")+"";//回答时间
				SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Date now=new Date();
				try {
					if(now.getTime()-df.parse(asktime).getTime()>24*60*60*1000){//4分钟
						canAsk = false;
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		//解决:追问未回答前不给非提问人显示问题
		map.put("ismine", user != null && user.getId() == Integer.parseInt(askdetail.get("wid")+""));
		map.put("canask", canAsk);
		map.put("d", askdetail);
		if( askdetail != null && askdetail.size() > 0 ){
			map.put("showtime", showTime( askdetail.get("createtime")+""));
		}
		return new ModelAndView("/ksite/faq/index",map );
	}




	/**
	 * 搜索
	 * @param session
	 * @param request
	 * @param response 
	 * @return
	 */
	@RequestMapping(value = "w/search.html")
	public ModelAndView blogSearch(
			HttpServletRequest     request, 
			HttpSession            session, 
			HttpServletResponse    response
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String content = this.trim( request.getParameter("textContent"));
		map.put("content",     replaceBlank(content));
		Object [] isSQLInj   = isSQLInj( content );
		String url = "w/search.html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
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
		if( token !=null && token.length > 2 ){
			jsapiSignatureURL (map,url,token[2] );
		} 
		int hasdata = 0 ;
		if( !(Boolean) isSQLInj[0] && content.length() > 0  ){
			Pagination teacherlist = weixin.getWeixinUserList(" AND status = 0  AND isteacher = 1 AND nickname like '%"+ content +"%' ", 1, 3);
			map.put("teacherlist", teacherlist);
			if( teacherlist.getResults() != null ) {
				hasdata += teacherlist.getResults().size();
			}
			Pagination courselist = weixin.getCourseList(" AND status = 0  AND cname like '%"+ content +"%'", 1, 3);
			map.put("courselist",  courselist);
			if( courselist.getResults() != null ){
				hasdata += courselist.getResults().size();
			}
			Pagination asklist = weixin.getWeixinContentList(0, " AND askid > 0 AND title like '%"+ content +"%'", 1, 3, false);
			map.put("asklist", asklist );
			if( asklist.getResults() != null ) {
				hasdata += asklist.getResults().size();
			}
			String[] search = weixin.getSearch();
			boolean has = false ;
			for(int i = 0 ; i < search.length ; i++){
				if(content.equals(search[i])){
					has = true ;
				}
			}
			if(!has){
				Weixin_blog_user_search sear = new Weixin_blog_user_search();
				sear.setSname(content);
				sear.setNumber(1);
				weixin.addOrUpdateSearch(sear);
			}else{
				weixin.updateSearch(content);
			}
		}else{
			map.put("teacherlist", null);
			map.put("courselist",  null);
			map.put("asklist",     null);
		}
		map.put("hasdata",     hasdata );
		return new ModelAndView("/ksite/search/search",map );
	}


	/**
	 * 搜索更多
	 * @param session
	 * @param request
	 * @param response 
	 * @return
	 */
	@RequestMapping(value = "w/search/{se}/more.html")
	public ModelAndView blogSearchMore(
			@PathVariable("se")  String se,
			@RequestParam(value = "text", required = true, defaultValue = "") String text,
			@RequestParam(value = "pageIndex", required = true, defaultValue = "1") int pageIndex,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			){  
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			text = URLDecoder.decode(text, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		map.put("content",  replaceBlank(text) );
		if( se.equals("teacher") ){
			map.put("teacherlist", weixin.getWeixinUserList(" AND status = 0  AND isteacher = 1 AND nickname like '%"+ text +"%' ", pageIndex, 100));
		}
		if( se.equals("course") ){
			map.put("courselist",  weixin.getCourseList(" AND status = 0  AND cname like '%"+ text +"%'", pageIndex, 100));
		}
		if( se.equals("ask")) {
			map.put("asklist",     weixin.getWeixinContentList(0, " AND askid > 0 AND title like '%"+ text +"%'", pageIndex, 100, false));
		}
		map.put("text", text);
		return new ModelAndView("/ksite/search/searchmore",map );
	}




	/**
	 * 获取用户授权
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "{url}/authorize.html")
	public ModelAndView authorize( 
			@PathVariable("url")      String url,
			final HttpSession         session ,
			final HttpServletRequest  request ,
			final HttpServletResponse response
			) { 
		String code = this.trim( request.getParameter("code") );
		Weixin_blog_user user = null;
		String realUrl = AESUtil.Decrypt( url, R.cKey );
		if( code.length() > 0 ) { 
			String wxid = regeditWeixinUser(code, user, response,session);
			if( wxid == null || wxid.equals("") ){
				return new ModelAndView( "redirect:/w/faq/index.html?p=0" );
			}
		}		
		return new ModelAndView("redirect:"+realUrl);
	}



	/**
	 * 播放次数
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/faq/count/play.html")
	public @ResponseBody JSONObject blogAskPlay(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value = "p", required = false, defaultValue = "0") int p
			){
		JSONObject result = new JSONObject();
		result.put("status", false);
		if( p > 0 ){
			Weixin_blog_content  content = weixin.getWeixinContent( p);
			if( content != null ){
				content.setPlay_count( content.getPlay_count() + 1);
				Object [] res = weixin.addOrUpdateWeixinContent(content);
				result.put("status", res[0]);
			}
		}
		return result;
	}

	/**
	 * 验证用户是否关注公众号
	 * @param session
	 * @param request
	 * @return
	 */
	@RequestMapping("weixin/checkuser.html")
	public @ResponseBody JSONObject checkUserNotice(
			HttpSession            session, 
			HttpServletRequest     request
			){
		JSONObject result = new JSONObject();
		Weixin_blog_user user = getWeixinSession( request,session ) ;
		result.put("status", checkUserHasNotice(user));
		return result;
	}


	/**
	 * 向老师提问
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/teacher/{m}_{o}_{t}/ask.html")
	public @ResponseBody JSONObject blogTeacherAsk(
			@RequestParam(value = "c", required = true, defaultValue = "")  String c,
			@RequestParam(value = "or", required = true, defaultValue = "")  String or,
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			@PathVariable("m")     Integer m,
			@PathVariable("o")     Integer o,
			@PathVariable("t")     Integer t, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response  
			)  {  
		JSONObject result = new JSONObject();
		try {
			c = URLDecoder.decode(c, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} 
		Weixin_blog_user user = getWeixinSession( request,session ) ;// 提问人
		if( user != null ){
			if(m>0){
				Weixin_blog_user_logger ulog=weixin.getWXUserLoggerByOrderMumber(or);
				if(ulog!=null&&(ulog.getIsgiveup()==1||!StringUtils.isNull(ulog.getWxordernum()))&&ulog.getContentid()>0){
					result.put("status", true);
					result.put("result", "提问成功");
					result.put("sid",   ulog.getContentid());
					return result;
				}
			}
			Weixin_blog_user teacher = weixin.getWeixinUser(t);
			if( teacher == null ){
				result.put("status", false);
				result.put("result", "获取老师信息失败！");
				return result;
			}
			Weixin_blog_content content = new Weixin_blog_content();
			content.setTitle( c );
			content.setSynopsis( c ); 
			content.setCreatetime( getTime() );
			content.setContent( c.replaceAll("\n", "<br>").replaceAll("\r", "<br>")); 
			content.setStatus(1);
			content.setWid( user.getId() );
			content.setAskid( teacher.getId() );
			content.setIsopen(o);
			content.setAskmoney(m+"");
			content.setLoggerid(p);
			content.setOrdernumber( or );
			if( p > 0 && m > 0 ){ 
				Weixin_blog_user_logger logger = weixin.getLogger( p );
				logger.setOrdernumber(or);
				logger.setIsgiveup(1);
				weixin.addOrUpdateUserLogger( logger );
			}
			Object[] res = weixin.addOrUpdateWeixinContent(content);
			if( res != null){				
				boolean success = (boolean) res[0];
				if( success ){
					String  fcbl = "8/2";
					String [] bl = fcbl.split("/");
					result.put("status", true);
					result.put("result", "提问成功");
					result.put("sid",   res[1]);
					if( m > 0 ){  // 记录分成订单
						Weixin_blog_teacher_order_buffer torder = new Weixin_blog_teacher_order_buffer();
						torder.setCid( Integer.parseInt(res[1]+"") );
						torder.setCname( c );
						torder.setCreatetime( getTime() );
						torder.setWid( user.getId() );
						torder.setWxid( user.getWxid() );
						torder.setTwxid( teacher.getWxid() );
						torder.setTmoney( String.valueOf(m) );//单笔总金额
						torder.setTid( teacher.getId() );
						torder.setProfit("0");//收益
						torder.setMoney( String.valueOf(m) ); //平台金额
						torder.setProfit( getDecimalNumber(m,bl[1]));
						torder.setMoney(  getDecimalNumber(m,bl[0]));
						torder.setFcbl( fcbl );
						torder.setLoggerid(p);
						torder.setOrdernumber(or);
						int bufferorder = order.addOrUpdateOrderBuffer( torder );
						if( bufferorder > 0 ) {
							Weixin_blog_content ccontent = weixin.getWeixinContent( Integer.parseInt(res[1]+"") );
							if( ccontent != null ){
								ccontent.setOrderid( bufferorder );
								weixin.addOrUpdateWeixinContent(ccontent);
							}
						}
					}
					if( res != null && teacher.getWxid() != null && teacher.getWxid().length() > 10 ){ // 
						sendTeacherTemplate(teacher.getWxid(), content , user.getNickname(), res[1]+"", getDecimalNumber(m,bl[0]));
					}
				}else{
					result.put("status", false);
					result.put("result", res[1]);
				}
			}
		}else{
			result.put("status", false);
			result.put("result", "您未登录,请重新授权登录后在评论！");
		}
		return result; 
	}

	/**
	 * 向老师追问
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/teacher/subask.html")
	public @ResponseBody JSONObject subBlogTeacherAsk(
			@RequestParam(value = "c", required = true, defaultValue = "")  String c,
			@RequestParam(value = "d", required = true, defaultValue = "0") int cid,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  {  
		JSONObject result = new JSONObject();
		try {
			c = URLDecoder.decode(c, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Weixin_blog_content content =  weixin.getWeixinContent(cid);
		if(content == null){
			result.put("status", false);
			result.put("result", "获取原始提问信息失败！");
			return result;
		}
		Weixin_blog_user teacher = weixin.getWeixinUser(content.getAskid());
		if( teacher == null ){
			result.put("status", false);
			result.put("result", "获取老师信息失败！");
			return result;
		}
		Weixin_blog_user user = getWeixinSession( request,session ) ;// 提问人
		if(user == null){
			result.put("status", false);
			result.put("result", "获取用户登录信息失败！");
			return result;
		}

		content.setSubcontent(c);
		Object[] res = weixin.addOrUpdateWeixinContent(content);
		if( res == null || res.length != 2){	
			result.put("status", false);
			result.put("result", "更新追问信息失败！");
			return result;
		}
		boolean success = (boolean) res[0];
		if( success ){
			result.put("status", true);
			result.put("result", "追问成功");
			result.put("sid",   res[1]);	
		}else{
			result.put("status", false);
			result.put("result", res[1]);
		}
		if( res != null && teacher.getWxid() != null && teacher.getWxid().length() > 10 ){
			sendTeacherTemplate(teacher.getWxid(), content , user.getNickname(), res[1]+"", "0");
		}
		return result; 
	}

	/**
	 * 购买课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/course/{m}/{c}/buy.html")
	public @ResponseBody JSONObject blogBuyCourse(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			@RequestParam(value = "o", required = true, defaultValue = "") String o,
			@PathVariable("m")     Integer m,
			@PathVariable("c")     Integer c, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  { 
		JSONObject result = new JSONObject();
		Weixin_blog_user user    = getWeixinSession( request,session ) ;// 提问人
		if( user == null ){
			result.put("status", false);
			result.put("result", "您未登录,请重新授权登录后在评论！");
			return result; 
		}
		Weixin_blog_teacher_course course = weixin.getCourse( c );
		if( course == null ){
			result.put("status", false);
			result.put("result", "获取课程信息失败！");
			return result; 
		}
		Weixin_blog_user_logger ulog=weixin.getWXUserLoggerByOrderMumber(o);
		if(ulog!=null&&(ulog.getIsgiveup()==1||!StringUtils.isNull(ulog.getWxordernum()))){
			result.put("status", true);
			result.put("result", "购买课程成功！");
			result.put("filepath", course.getRealfilepath());
			return result;
		}
		Weixin_blog_user teacher = weixin.getWeixinUser( course.getUid() );
		Weixin_blog_teacher_order torder = new Weixin_blog_teacher_order();
		torder.setCid( course.getId() );
		torder.setCname( course.getCname() );
		torder.setCreatetime( getTime() );
		torder.setMoney( String.valueOf(m ) );
		torder.setWid( user.getId() );
		torder.setWxid( user.getWxid() );
		torder.setType(1);
		torder.setTid( teacher.getId() );
		torder.setTwxid( teacher.getWxid());
		torder.setTmoney( String.valueOf(m) );
		String [] bl = teacher.getFcbl().split("/");
		torder.setProfit( getDecimalNumber(m,bl[1]));
		torder.setMoney( getDecimalNumber(m,bl[0]) );
		torder.setFcbl( teacher.getFcbl() );
		torder.setOrdernumber(o);
		torder.setExpirationtime( course.getExpiretime() );
		torder.setLoggerid(p);
		if( p > 0 ){   // 
			Weixin_blog_user_logger logger = weixin.getLogger( p );
			logger.setIsgiveup(1);
			logger.setOrdernumber(o);
			weixin.addOrUpdateUserLogger( logger );
		}
		if( teacher.getWxid() != null && teacher.getWxid().length() > 10 ){ // 
			sendBuyCoureseTemplate( teacher.getWxid(), course);
		} 
		int buySuccess =  order.addOrUpdateOrder( torder );
		result.put("status",   buySuccess > 0 );
		result.put("result",   buySuccess > 0 ?"购买课程成功！":"购买课程失败！");
		result.put("filepath", buySuccess > 0 ?course.getRealfilepath() :"");
		return result;
	}

	/**
	 * 用户操作购买日志
	 * @param t  类型  1：问答  2：课程,3 活动
	 * @param m  金额
	 * @param c  内容ID
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/logger/{t}/{m}/{c}.html")
	public @ResponseBody JSONObject blogUserLogger(
			@PathVariable("t")     Integer t,
			@PathVariable("m")     String m,
			@PathVariable("c")     Integer c,  
			@RequestParam(value = "o", required = true, defaultValue = "") String o,
			@RequestParam(value = "srowid", required = false,defaultValue = "") String srowid,
			@RequestParam(value = "usephone",required = false, defaultValue = "") String usephone,
			@RequestParam(value = "name",required = false, defaultValue = "") String name,
			@RequestParam(value = "courseName",required = false, defaultValue = "") String courseName,
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response){
		JSONObject result = new JSONObject();
		Weixin_blog_user user    = getWeixinSession( request,session ) ;// 提问人
		Weixin_blog_user teacher = null;
		Weixin_blog_teacher_course course = null;
		Weixin_blog_teacher_course_line lcourse = null;
		Weixin_blog_user_logger logger = new Weixin_blog_user_logger();
		String uname = "";
		logger.setCreatetime(getTime());
		logger.setType(t);
		logger.setCid(c);
		logger.setOrdernumber(o);
		logger.setIsgiveup(0);
		if( user == null ){
			result.put("status", false);
			result.put("result", "您未登录,请重新授权登录后在评论！");
			return result; 
		}
		if( t == 1 ) {
			String content=request.getParameter("content");
			String isopen=request.getParameter("isopen");
			logger.setContent(content);
			logger.setIsopen(Integer.parseInt(isopen));
			teacher = weixin.getWeixinUser( c );
			logger.setCname("用户："+user.getNickname()+"向："+ teacher.getNickname()+" 老师进行了提问");
			logger.setTmoney(""+m);
		}
		if( t == 2) {
			course = weixin.getCourse( c );
			logger.setContent(course.getCname());
			logger.setCname("用户："+user.getNickname()+"下单购买课程："+course.getCname() );
			logger.setTmoney(""+m);
			if(!StringUtils.isNull(srowid)){
				Weixin_blog_saler sale=saler.getSalerByRowid(srowid);
				Weixin_blog_saler_product product=saler.getSaleProductByPidPtype(c, 1);
				logger.setSwid(sale.getSalerid());
				logger.setSmoney(String.valueOf(product.getMoney()));
				String [] bl = product.getFcbl().split("/");
				logger.setSdmoney(getDecimalNumber(product.getMoney(),bl[0]));
				logger.setStmoney(getDecimalNumber(product.getMoney(),bl[1]));
			}
		}
		if( t == 3) {
			logger.setCname("用户："+user.getNickname()+"下单购买随心瑜经管课程" );
			logger.setTmoney(""+m);
		}
		if( t == 4) {
			lcourse = manager.getLineCourse( c );
			logger.setContent(usephone);
			logger.setCname("用户："+user.getRealname()+"("+usephone+")下单购买线下培训："+lcourse.getCname() );
			logger.setTmoney(""+m);
		}
		if(t == 5){
			logger.setCname("用户："+user.getNickname()+"下单购买随心瑜Live直播课程");
			logger.setTmoney(m+"");
		}

		if( t == 30 ) {
			logger.setContent( srowid );
			logger.setCname("用户："+user.getRealname()+"("+usephone+")下单购买2017世界瑜伽峰会");
			logger.setTmoney(""+m);
		}
		
		if( t == 31 ) {
			try {
				uname = URLDecoder.decode(name,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			logger.setContent( srowid );
			logger.setCname("用户："+uname+"("+usephone+")下单购买2017女神瘦身系列课程");
			logger.setTmoney(""+m);
		}
		if( t == 32 ) {
			try {
				uname = URLDecoder.decode(name,"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			logger.setContent( srowid );
			logger.setCname("用户："+uname+"("+usephone+")下单购买2017孕产瑜伽系列课程");
			logger.setTmoney(""+m);
		}
		if( t == 1000 ) {

			logger.setContent( srowid );
			logger.setCname("用户："+user.getNickname()+"("+usephone+")下单购买"+courseName);
			logger.setTmoney(""+m);
			if(!StringUtils.isNull(srowid)&&Integer.parseInt(srowid)>0){
				Weixin_blog_saler sale=saler.getSalerByRowid(srowid);
				int sid = 0;
				if (null == sale){
					Weixin_blog_user user1 = weixin.getWeixinUser(Integer.valueOf(srowid));
					sale = new Weixin_blog_saler();
					sale.setSalerid(user1.getId());
					sale.setSalename(user1.getNickname());
					sale.setSalerwxid(user1.getWxid());
					sale.setMobile(user1.getMobile());
					sale.setCreatetime(getTime());
					sid = saler.addOrUpdateSaler(sale);
					sid = user1.getId();
				}else {
					sid = sale.getSalerid();
				}
				logger.setSwid(sid);

			}
		}
		logger.setWid( user.getId() );
		logger.setWxid( user.getWxid() );
		logger.setType( t );
		result.put("id", weixin.addOrUpdateUserLogger(logger));
		return result;
	}


	/**
	 * 课程排行榜
	 * @param session
	 * @param request
	 * @param response
	 * @param p
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/hot/course/index.html")
	public ModelAndView blogHotCourse(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+"/w/hot/course/index.html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token != null  ){
			jsapiSignatureURL (map,url,token[2]);
		}
		map.put("nologin", user == null);
		map.put("tag", 0);
		map.put("speciallist", manager.getSpecialByParentid(0));
		map.put("recommends",  weixin.getRecommendCourse(10));
		List<HashMap<String,   Object>> bannerlist = weixin.getBannerListAll(2);
		map.put("bannerlist",  bannerlist);
		map.put("urlsecret",   AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/cour/hotcourse",map );
	}

	/***
	 * 查询课程列表
	 * @param session
	 * @param request
	 * @param response
	 * @param p 课程类型ID，0 全部
	 * @param t 课程分类，0全部，1音频，2视频
	 * @param by 排序方式，1 时间排序，0热度排序
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/hot/course/list.html")
	public ModelAndView showCourseList(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value="p", required=true, defaultValue="0") int p,
			@RequestParam(value="t", required=true, defaultValue="0") int t,
			@RequestParam(value="by", required=true, defaultValue="0") int by
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+"/w/hot/course/index.html";
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token != null ){
			jsapiSignatureURL (map,url,token[2]);
		}
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		map.put("nologin",   user == null);
		List<HashMap<String, Object>> specials = weixin.getAllCourseSpecialList();
		map.put("speciallist", specials);
		String special = "全部";
		if(specials != null && specials.size() > 0){
			for(HashMap<String, Object> s : specials){
				if((p + "").equals(s.get("id")+"")){
					special = s.get("name")+"";
					break;
				}
			}
		}
		map.put("currentSpecial", p);
		map.put("ctype", t);
		map.put("orderby", by);
		if(t == 0){
			special += "-全部";
		}else if(t == 1){
			special += "-音频";			
		}else if(t == 2){
			special += "-视频";						
		}
		if(by == 0){
			special += "-最热";
		}else{
			special += "-最新";			
		}
		map.put("title", special); 
		String filter = "AND status = 0 ";
		if(p > 0){
			filter += " AND specialid = " + p;
		}
		if(t == 1){
			filter += " AND ctype = 0 ";
		}else if(t == 2){
			filter += " AND ctype = 1 ";
		}
		if( by == 1){
			filter += " ORDER BY id desc ";
		}else if(by == 0){
			filter += " ORDER BY playcount desc ";			
		}
		map.put("courselist", weixin.getCourseList(filter, 1, R.pageSize));
		return new ModelAndView("/ksite/cour/list",map );
	}

	@RequestMapping("w/hot/course/morelist.html")
	public @ResponseBody JSONObject showCoursePage(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value="p", required=true, defaultValue="0") int p,
			@RequestParam(value="t", required=true, defaultValue="0") int t,
			@RequestParam(value="by", required=true, defaultValue="0") int by,
			@RequestParam(value="pageIndex", required=true, defaultValue="1") int pageIndex
			){
		JSONObject json = new JSONObject();

		String filter = " AND status = 0 ";
		if(p > 0){
			filter += " AND specialid = " + p;
		}
		if(t == 1){
			filter += " AND ctype = 0 ";
		}else if(t == 2){
			filter += " AND ctype = 1 ";
		}
		if(by == 1){
			filter += " ORDER BY id desc ";
		}else if(by == 0){
			filter += " ORDER BY playcount desc ";			
		}
		Pagination page = weixin.getCourseList(filter, pageIndex, R.pageSize);
		List<HashMap<String, Object>> list = page.getResults();
		if( list == null || list.size() < 1){
			json.put("result", "");
			return json;
		}
		StringBuilder sb = new StringBuilder();
		for(HashMap<String, Object> li : list){
			sb.append("<li data_id='").append(li.get("id")).append("'>")
			.append("<dl>")
			.append("<dt>");
			if(li.get("icon") == null || "".equals(li.get("icon")+"")){
				sb.append("<img src='/images/audio.jpg' alt=''/>");								
			}else{
				sb.append("<img src='").append(li.get("icon")).append("' alt=''/>");				
			}
			sb.append("<p>").append(li.get("playcount")).append("人在学</p>")
			.append("</dt>")
			.append("<dd>")
			.append("<h4>").append(li.get("cname")).append("</h4>")
			.append("<p><i></i>").append((li.get("taglist")+"").replaceAll(",", " ")).append("</p>");
			if("0".equals(li.get("money"))){
				sb.append("<span>免费</span>");
			}else{
				sb.append("<span class='money'>￥").append(li.get("money")).append("元</span>");				  
			}
			sb.append("</dd>").append("</dl>").append("</li>");
		}
		json.put("result", sb.toString());
		return json;
	}


	/***
	 * 查询课程列表
	 * @param session
	 * @param request
	 * @param response
	 * @param p 课程类型ID，0 全部
	 * @param t 课程分类，0全部，1音频，2视频
	 * @param by 排序方式，1 时间排序，0热度排序
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/hot/course/line/list.html")
	public ModelAndView showLineCourseList(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value="p", required=true, defaultValue="0") int p,
			@RequestParam(value="t", required=true, defaultValue="0") int t,
			@RequestParam(value="by", required=true, defaultValue="0") int by
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+"/w/hot/course/index.html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token != null  ){
			jsapiSignatureURL( map,url,token[2] );
		}

		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		map.put("nologin", user == null);
		List<HashMap<String, Object>> specials = weixin.getAllCourseSpecialList();
		map.put("speciallist", specials);
		String special = "全部";
		if(specials != null && specials.size() > 0){
			for(HashMap<String, Object> s : specials){
				if((p + "").equals(s.get("id")+"")){
					special = s.get("name")+"";
					break;
				}
			}
		}
		map.put("currentSpecial", p);
		map.put("ctype", t);
		map.put("orderby", by);
		if(t == 0){
			special += "-全部";
		}else if(t == 1){
			special += "-音频";			
		}else if(t == 2){
			special += "-视频";						
		}else if(t == 3){
			special += "-线下培训";
		}
		if(by == 0){
			special += "-最热";
		}else{
			special += "-最新";			
		}
		map.put("title", special); 
		String filter = "AND status = 0 ";
		if(p > 0){
			filter += " AND specialid = " + p;
		}
		if(by == 1){
			filter += " ORDER BY id desc ";
		}else if(by == 0){
			filter += " ORDER BY buycount desc, id desc ";			
		}
		map.put("courselist", manager.getLineCourseList(filter, 1, R.pageSize));
		return new ModelAndView("/ksite/cour/list",map );
	}


	@RequestMapping("w/hot/course/line/morelist.html")
	public @ResponseBody JSONObject showLineCoursePage(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value="p", required=true, defaultValue="0") int p,
			@RequestParam(value="t", required=true, defaultValue="0") int t,
			@RequestParam(value="by", required=true, defaultValue="0") int by,
			@RequestParam(value="pageIndex", required=true, defaultValue="1") int pageIndex
			){
		JSONObject json = new JSONObject();

		String filter = " AND status = 0 ";
		if(p > 0){
			filter += " AND specialid = " + p;
		}
		if(by == 1){
			filter += " ORDER BY id desc ";
		}else if(by == 0){
			filter += " ORDER BY buycount desc ";			
		}
		Pagination page = manager.getLineCourseList(filter, pageIndex, R.pageSize);
		List<HashMap<String, Object>> list = page.getResults();
		if(list == null || list.size() < 1){
			json.put("result", "");
			return json;
		}
		StringBuilder sb = new StringBuilder();
		for(HashMap<String, Object> li : list){
			sb.append("<li data_id='").append(li.get("id")).append("'>")
			.append("<dl>")
			.append("<dt>");
			if(li.get("icon") == null || "".equals(li.get("icon")+"")){
				sb.append("<img src='/images/audio.jpg' alt=''/>");								
			}else{
				sb.append("<img src='").append(li.get("icon")).append("' alt=''/>");				
			}
			sb.append("<p>").append(li.get("buycount")).append("人已报名</p>")
			.append("</dt>")
			.append("<dd>")
			.append("<h4>").append(li.get("cname")).append("</h4>")
			.append("<p><i></i>").append((li.get("taglist")+"").replaceAll(",", " ")).append("</p>");
			if("0".equals(li.get("money"))){
				sb.append("<span>免费</span>");
			}else{
				sb.append("<span class='money'>￥").append(li.get("money")).append("元</span>");				  
			}
			sb.append("</dd>").append("</dl>").append("</li>");
		}
		json.put("result", sb.toString());
		return json;
	}



	/**
	 * 专题排行榜
	 * @param session
	 * @param request
	 * @param response
	 * @param p
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/hot/special/index.html")
	public ModelAndView blogHotSpecial( 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+"/w/hot/special/index.html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object [] token = weixin.getToken();
		if( token == null || token.length == 2 ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 ){
			token = weixin.getToken();
		}
		if( token != null  ){
			jsapiSignatureURL (map,url,token[2]);
		}
		map.put("nologin", user == null);
		map.put("tag", 1);
		map.put("resultlist", weixin.getSpecialList(" ORDER BY seqindex ASC ", 1, R.pageSize));
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/cour/hotspecial",map );
	}



	/**
	 * 热门老师排行榜
	 * @param session
	 * @param request
	 * @param response
	 * @param p
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/hot/teacher/index.html")
	public ModelAndView blogHotTeacher(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+"/w/hot/teacher/index.html";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token != null  ){
			jsapiSignatureURL (map,url,token[2]);
		}
		map.put("nologin", user == null);
		map.put("tag", 2);
		map.put("resultlist", weixin.getWeixinUserList(" AND  isteacher = 1 AND status = 0 AND isauth = 1 AND hide = 0 AND isacceptask != 1  ORDER BY seqindex", 1, R.pageSize));
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/cour/hotteacher",map );
	}


	/**
	 * json格式翻页
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/hot/{hot}/json.html")
	public @ResponseBody JSONObject blogHotJson(
			@PathVariable("hot")   String hot,
			@RequestParam(value = "pageIndex", required = true, defaultValue = "1") int pageIndex
			)  { 
		Pagination page =  null ;
		if( hot.equals("teacher") ){
			page = weixin.getWeixinUserList(" AND  isteacher = 1 AND status = 0 AND isauth = 1 ORDER BY seqindex", pageIndex, pageSize);
		}else if( hot.equals("special") ){
			page = weixin.getSpecialList(" ORDER BY seqindex,createtime DESC", pageIndex, pageSize);
		} else if( hot.equals("course") ){
			page = weixin.getCourseList(" AND status = 0 ORDER BY Issystemtop,Playcount DESC", pageIndex, pageSize);
		}
		JSONObject result = new JSONObject();
		if( page.getResults() != null ) {
			StringBuffer buffer = new StringBuffer();
			List<HashMap<String,Object>> list = page.getResults();
			for( HashMap<String,Object>  c : list){  
				if( hot.equals("teacher") ){
					buffer.append("<li data-url="+DOMAIN+"/w/faq/person.html?p="+c.get("id")+"&t=1 >");
					buffer.append("<div>");
					buffer.append("<dl>");
					buffer.append("<dt>");
					buffer.append("<a href="+DOMAIN+"/w/faq/person.html?p="+c.get("id")+"&t=1>");
					if( (c.get("file_path")+"").indexOf("http") > -1 ){
						buffer.append("<img src="+c.get("file_path")+" >");
					}else
						buffer.append("<img src="+DOMAIN+"/"+c.get("file_path")+">");
					buffer.append("</a>");
					buffer.append("</dt>");
					buffer.append("<dd>");
					buffer.append("<h4><a href="+DOMAIN+"/w/faq/person.html?p="+c.get("id")+"&t=1>"+c.get("nickname")+"</a></h4>");
					buffer.append("<h5><a href="+DOMAIN+"/w/faq/person.html?p="+c.get("id")+"&t=1>"+c.get("userpost")+"</a></h5>");
					buffer.append("<p><span>"+c.get("course_count")+"个课程</span><span>"+c.get("fensi_count")+"人关注</span></p>");
					buffer.append("</dd>");
					buffer.append("</dl>");
					buffer.append("</div>");
					buffer.append("</li>");
				}else if( hot.equals("special") ){
					buffer.append("<li data-url="+DOMAIN+"/w/special/index.html?p="+c.get("id")+">");
					buffer.append("<div>");
					buffer.append("<h4>"+c.get("name")+"</h4>");
					buffer.append("<p>"+c.get("course_count")+"名课程</p>");
					buffer.append("<a href="+DOMAIN+"/w/special/index.html?p="+c.get("id")+"></a>");
					buffer.append("</div>");
					buffer.append(" </li>");
				} else if( hot.equals("course") ){
					buffer.append("<li data-url="+DOMAIN+"/w/faq/course.html?p="+c.get("id")+" >");
					buffer.append("<div>");
					buffer.append("<h4><a href="+DOMAIN+"/w/faq/course.html?p="+c.get("id")+">"+c.get("cname")+"</a></h4>");
					buffer.append("<p class='jieshao'><a href="+DOMAIN+"/w/faq/course.html?p="+c.get("id")+">"+c.get("remark")+"</a></p>");
					buffer.append("<p class='but'>");
					String [] tag = null;
					if( c.get("taglist") != null){
						tag = (c.get("taglist")+"").split(",");
						for( String t : tag ){
							buffer.append("<span>"+t+"</span>");
						}
					}
					buffer.append("</p>");
					buffer.append("<dl>");
					buffer.append("<dt>");
					buffer.append("<a href="+DOMAIN+"/w/faq/person.html?p="+c.get("uid")+">");
					if( (c.get("teacherheader")+"").indexOf("http") > -1 ){
						buffer.append("<img src="+c.get("teacherheader")+" >");
					}else
						buffer.append("<img src="+DOMAIN+"/"+c.get("teacherheader")+" >");
					buffer.append("</a>");
					buffer.append("</dt>");
					buffer.append("<dd>");
					buffer.append("<p><a href="+DOMAIN+"/w/faq/person.html?p="+c.get("uid")+"><span>"+c.get("teachername")+"</span><b>|</b><span  class='summary' >"+c.get("teacherport")+"</span></a></p>");
					buffer.append("</dd>");
					buffer.append("</dl>");
					buffer.append("</div>");
					buffer.append("</li>");

				}
			}
			result.put("result",     buffer.toString());
			result.put("totalPage",  page.getTotalPage() );
			result.put("totalCount", page.getTotalCount() );
			result.put("pageIndex",  pageIndex );
		}else
			result.put("result", "");
		return result;
	}



	/**
	 * 专题列表
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/special/index.html")
	public ModelAndView blogSpecialList(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response 
			) {   
		HashMap<String, Object> map = new HashMap<String, Object>(); 
		map.put("p",p );
		map.put("special", weixin.getSpecial( p ));
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("courselist", weixin.getSpecialCourse( p ));
		String url = DOMAIN+"/w/special/index.html?p="+p;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object []token = weixin.getToken();
		if( token[0] == null || token[2] == null || token[0].equals("") ){
			token = weixin.getToken();
		}
		if( token[0] == null || token[2] == null || token[0].equals("") ){
			token = weixin.getToken();
		}
		if( token[0] == null || token[2] == null || token[0].equals("") ){
			token = weixin.getToken();
		}
		if( token !=null && token.length > 2 ){
			jsapiSignatureURL (map,url,token[2] );
		} 
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		map.put("nologin",  user == null);
		return new ModelAndView("/ksite/cour/speciallist",map );
	}

	/**
	 * 用户给提问课程点赞
	 * @param session
	 * @param request
	 * @param response
	 * @param cid
	 * @return
	 */
	@RequestMapping("w/content/zan{cid}.html")
	public @ResponseBody JSONObject zanContent(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("cid") Integer cid
			){
		JSONObject result = new JSONObject();
		if(cid != null && cid > 0){
			result.put("status", weixin.userPraise(cid));
		}else{
			result.put("status",0);
		}
		return result;
	}



	/**
	 * 获取用户信息
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/user/info.html")
	public @ResponseBody JSONObject weixinUserInfo(
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		JSONObject result = new JSONObject(); 
		Weixin_blog_user user    = getWeixinSession( request,session ) ;// 提问人 
		if( user == null ){
			result.put("status", false);
			result.put("result", "您未登录");
			return result; 
		}
		Weixin_blog_user teacher = weixin.getWeixinUser( p );
		if( teacher == null ){
			result.put("status", false);
			result.put("result", "老师不存在");
			return result;
		}
		result.put("id",       teacher.getId());
		result.put("username", replaceBlank(teacher.getNickname()) );
		if( teacher.getFile_path().indexOf("http") > -1 ){
			result.put("header",   teacher.getFile_path() );
		}else{
			result.put("header",   DOMAIN+"/"+teacher.getFile_path() );
		} 
		result.put("userpost", teacher.getUserpost());
		result.put("remark",   replaceBlank(teacher.getShortremark()));
		if( user.getId() == teacher.getId() ){
			result.put("gz",  false);
		}else
			result.put("gz",  weixin.isFollowUser( user.getId(), p));  
		return result;
	}

	/**
	 * 线下课程页面
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex 
	 */
	@RequestMapping(value = "w/faq/courseline.html")
	public ModelAndView lineCourse(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) { 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null );
		map.put("user",      user );
		String url  = DOMAIN+"/w/faq/courseline.html?p="+p;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Weixin_blog_teacher_course_line lcourse = manager.getLineCourse(p);
		int end=0;//0正常，1已结束
		if(lcourse!=null){
			Long now=new Date().getTime();
			String endtime= lcourse.getCoursetime_start();
			Date enddate = null;
			try {
				enddate = sdf.parse(endtime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if( enddate.getTime() - now < 0 ){
				end=1;
			}
		}
		map.put("end", end);
		map.put("lcourse", lcourse);
		map.put("teacher", weixin.getWeixinUser( lcourse.getUid() ));
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		Object []token = weixin.getToken();
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2){
			token = weixin.getToken();
		}
		if( token != null  ){
			jsapiSignatureURL (map,url,token[2] );
		}
		boolean isjoin = false ;            // 是否报名
		boolean ismy   = false ;            // 是否是自己的活动
		int     tid    = lcourse.getUid();  // 线下课程老师ID
		map.put("mid",   0);
		if( user != null ){
			Weixin_blog_teacher_course_line_buyer buyer = manager.getBuyerByUid(String.valueOf(user.getId()),p);
			if( buyer != null ){
				isjoin = true ;
				map.put("mid",    buyer.getMid());
			}
			if(tid == user.getId()){
				ismy = true ;
			}
			map.put("ismy",   ismy);
			map.put("isjoin", isjoin);
		}
		// 是否有子价格
		boolean havaChildMoneyList = false;
		// 是否有子价格
		Pagination havaMoneyList = manager.getLCourseMoneyList(" AND cid="+lcourse.getId() +" ORDER BY money ASC",1,100);
		if(  havaMoneyList.getResults() != null && havaMoneyList.getResults().size() > 0 ){
			map.put("moneylist", havaMoneyList.getResults() );
			havaChildMoneyList = true;
		}
		map.put("havaChildMoneyList", havaChildMoneyList);

		if( !isjoin && lcourse != null ){
			map.put("money", Integer.valueOf( lcourse.getMoney() ));
			String wxid="";
			if( user != null && user.getWxid() != null ){
				wxid = user.getWxid();
			}
			if( wxid != null && lcourse.getMoney() != null && !lcourse.getMoney().equals("0") && !havaChildMoneyList  ){  // 获得微信授权 
				String nonceStr  = PayCommonUtil.CreateNoncestr();
				long timestamp   = System.currentTimeMillis() / 1000;
				Object[] payInfo = PayCommonUtil.getPrepay_id(lcourse.getCname(), nonceStr, lcourse.getMoney()+"00", lcourse.getId()+"", wxid  );
				if( payInfo != null && payInfo[0] != null && payInfo[1] != null ){
					String ordernumber = payInfo[0]+"";
					String prepayid = "";
					if( payInfo[1] != null ){
						prepayid = payInfo[1]+"";
					}
					Map<String ,String >    signMap=new HashMap<String ,String >();
					signMap.put("appId",    Config.getString("weixin.appid"));
					signMap.put("timeStamp",timestamp+"");
					signMap.put("package", "prepay_id="+prepayid);
					signMap.put("signType", "MD5");
					signMap.put("nonceStr", nonceStr);
					map.put("paytimestamp", timestamp);
					map.put("paypackage",  "prepay_id="+prepayid);
					map.put("paynonceStr",  nonceStr);
					map.put("paysignType",  "MD5");
					map.put("ordernumber",  ordernumber );
					map.put("paySign" ,     getPayCustomSign(signMap,ConfigUtil.API_KEY) );
				}
			}
		}
		if( user != null ){
			map.put("isfollow", weixin.isFollowCourseLine( user.getId(), p));
		}
		return new ModelAndView("/ksite/course/lcourse",map );
	}




	/**
	 * 线下课程页面子课程页面
	 * @param it 子课程ID
	 * @param session
	 * @param request
	 * @param response 
	 * @param pageIndex 
	 */
	@RequestMapping(value = "w/faq/courseitem.html")
	public ModelAndView lineCourseItemPay(
			@RequestParam(value = "p",  required = true,  defaultValue = "0") int p,
			@RequestParam(value = "it", required = true,  defaultValue = "0") int it,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){ 
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null );
		map.put("user",      user );
		String url  = DOMAIN+"/w/faq/courseitem.html?p="+p+"&it="+it;
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "&from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Weixin_blog_teacher_course_line lcourse = manager.getLineCourse(p);
		map.put("lcourse", lcourse);
		int uid = lcourse.getUid();
		map.put("teacher", weixin.getWeixinUser(uid));
		try {
			map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		} catch (Exception e) {
			e.printStackTrace();
		}
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2 ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 ){
			token = weixin.getToken();
		}
		if( token != null ){
		    jsapiSignatureURL(map,url,token[2]);
		}
		if( lcourse != null ){
			String wxid="";
			if( user != null && user.getWxid() != null ){
				wxid = user.getWxid();
			}
			Weixin_blog_teacher_course_line_money money = manager.getLineCourseMoney(it);
			map.put("itemcoursemoney", money);
			map.put("money", Integer.valueOf( money.getMoney() ));
            if( wxid != null && money.getMoney() != null && !money.getMoney().equals("0")  ){  // 获得微信授权 
				String nonceStr  = PayCommonUtil.CreateNoncestr();
				long timestamp   = System.currentTimeMillis() / 1000;
				Object[] payInfo = PayCommonUtil.getPrepay_id(money.getCname(), nonceStr, money.getMoney()+"00", lcourse.getId()+"", wxid  );
				if( payInfo != null && payInfo[0] != null && payInfo[1] != null ){
					String ordernumber = payInfo[0]+"";
					String prepayid = "";
					if( payInfo[1] != null ){
						prepayid = payInfo[1]+"";
					}
					Map<String ,String >    signMap=new HashMap<String ,String >();
					signMap.put("appId",    Config.getString("weixin.appid"));
					signMap.put("timeStamp",timestamp+"");
					signMap.put("package", "prepay_id="+prepayid);
					signMap.put("signType", "MD5");
					signMap.put("nonceStr", nonceStr);
					map.put("paytimestamp", timestamp);
					map.put("paypackage",  "prepay_id="+prepayid);
					map.put("paynonceStr",  nonceStr);
					map.put("paysignType",  "MD5");
					map.put("ordernumber",  ordernumber );
					map.put("paySign" ,     getPayCustomSign(signMap,ConfigUtil.API_KEY) );
				}
			}
		} 
		return new ModelAndView("/ksite/course/lcourseitem",map );
	}




	/**
	 * 购买课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "w/course/line/buy.html")
	public @ResponseBody JSONObject blogBuyCourseLine(
			@RequestParam(value = "p", required = true, defaultValue = "0") int p,
			@RequestParam(value = "o", required = true, defaultValue = "") String o,
			@RequestParam(value = "phone", required = true, defaultValue = "") String phone,
			@RequestParam(value = "name", required = true, defaultValue = "") String realname,
			@RequestParam(value = "m", required = true, defaultValue = "0")   Integer m,
			@RequestParam(value = "c", required = true, defaultValue = "0")   Integer c, 
			@RequestParam(value = "mid", required = true, defaultValue = "0") Integer mid,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  { 
		JSONObject result = new JSONObject();
		Weixin_blog_user user = getWeixinSession( request,session ) ;
		Weixin_blog_teacher_course_line lcourse = manager.getLineCourse( c );
		if( lcourse == null ){
			result.put("status", false);
			result.put("result", "获取课程信息失败！");
			return result; 
		}

		Weixin_blog_user teacher = weixin.getWeixinUser( lcourse.getUid() );
		if( m > 0 ){
			Weixin_blog_user_logger ulog=weixin.getWXUserLoggerByOrderMumber(o);
			if(ulog!=null&&(ulog.getIsgiveup()==1||!StringUtils.isNull(ulog.getWxordernum()))){
				result.put("status", true);
				result.put("result", "报名成功！");
				return result;
			}
			if( p > 0 ){ 
				Weixin_blog_user_logger logger = weixin.getLogger( p );
				logger.setIsgiveup(1);
				logger.setOrdernumber(o);
				weixin.addOrUpdateUserLogger( logger );
			}
			Weixin_blog_teacher_order lorder = new Weixin_blog_teacher_order();
			lorder.setCid( lcourse.getId() );
			lorder.setCname( lcourse.getCname() );
			lorder.setCreatetime( getTime() );
			lorder.setMoney( String.valueOf(m ) );
			lorder.setWid( user.getId() );
			lorder.setWxid( user.getWxid() );
			lorder.setType(2);
			lorder.setTid( teacher.getId() );
			lorder.setTwxid( teacher.getWxid());
			lorder.setTmoney( String.valueOf(m) );
			String [] bl = teacher.getLine_fcbl().split("/");
			lorder.setProfit( getDecimalNumber(m,bl[1]));
			lorder.setMoney( getDecimalNumber(m,bl[0]) );
			lorder.setFcbl( teacher.getFcbl() );
			lorder.setOrdernumber(o);
			lorder.setLoggerid(p);
			int buySuccess =  order.addOrUpdateOrder( lorder );
			if(buySuccess>0){
				Weixin_blog_teacher_course_line_buyer buyer = new Weixin_blog_teacher_course_line_buyer();
				buyer.setCid(c);
				buyer.setCname(lcourse.getCname());
				buyer.setRealname(realname);
				buyer.setUid(user.getId());
				buyer.setTid(lcourse.getUid());
				buyer.setMoney( m );
				buyer.setMid( mid );
				buyer.setPhone(phone);
				buyer.setWxid(user.getWxid());
				buyer.setTwxid(teacher.getWxid());
				buyer.setType(2);
				buyer.setCreatetime(getTime());
				int res=manager.addOrUpdateTeacherCourseLineBuyer(buyer);
				manager.updateTeacherCourseLineCount(c);
				result.put("status",   res > 0 );
				if(res > 0 ){
					result.put("result",   "报名成功" );
					manager.updateLineCourseLimit(mid);
				}else{
					result.put("result",   "报名失败" );
				}
			}
		}else{
			Weixin_blog_teacher_course_line_buyer buyer = new Weixin_blog_teacher_course_line_buyer();
			buyer.setCid(c);
			buyer.setCname(lcourse.getCname());
			buyer.setRealname(realname);
			buyer.setUid(user.getId());
			buyer.setTid(lcourse.getUid());
			buyer.setPhone(phone);
			buyer.setMoney( m );
			buyer.setMid( mid );
			buyer.setWxid(user.getWxid());
			buyer.setTwxid(teacher.getWxid());  
			buyer.setType(2);
			buyer.setCreatetime(getTime());
			int res=manager.addOrUpdateTeacherCourseLineBuyer(buyer);
			manager.updateTeacherCourseLineCount(lcourse.getId());
			result.put("status", res > 0 );
			if(res > 0 ){
				result.put("result",   "报名成功" );
			}else{
				result.put("result",   "报名失败" );
			}
		}
		return result;
	}
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	public boolean checkUserHasFollow( Weixin_blog_user user){
		boolean result = false;
		if( user == null || user.getWxid() == null){
			return result;
		}
		Object [] token = weixin.getToken();
		if( token == null || token.length == 2 || token[0] == null ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 || token[0] == null ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 || token[0] == null ){
			token = weixin.getToken();
		}
		if( token != null && token.length > 2 ){
			String url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token="+token[0]+ "&openid="+user.getWxid()+"&lang=zh_CN";
			JSONObject json = JSONObject.fromObject(httpClient.doGet(url));
			if( json == null ){
				return result;
			}
			if( json.containsKey("subscribe") ){
				return json.getInt("subscribe") == 1;
			}
		}
		return result;
	}
} 
