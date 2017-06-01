package com.yoga.controller.v2.activity;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

import com.yoga.controller.v2.R;
import com.yoga.dao.Weixin_blog_activity_actor;
import com.yoga.dao.Weixin_blog_distributor;
import com.yoga.dao.Weixin_blog_distributor_signup;
import com.yoga.dao.Weixin_blog_teacher_course;
import com.yoga.dao.Weixin_blog_teacher_order;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.dao.Weixin_blog_user_exclusive_award;
import com.yoga.dao.Weixin_blog_user_logger;
import com.yoga.dao.Weixin_phy_activity;
import com.yoga.utils.AESUtil;
import com.yoga.utils.Config;
import com.yoga.utils.Pagination;
import com.yoga.utils.StringUtils;
import com.yoga.weixin.WeixinUtil;
import com.yoga.weixin.pay.ConfigUtil;
import com.yoga.weixin.pay.PayCommonUtil;
import com.yoga.weixin.template.TemplateData;
import com.yoga.weixin.template.WxTemplate;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 发现
 * @author jaker	
 *
 */
@Controller
public class WeixinActivityForPhyController extends R{
	private final int ACTIVITY_ID=2;//活动id:1中秋投票，2国庆投票

	/**
	 * 首页
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/phy{aid}.html")
	public ModelAndView phyIndex(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("aid") String aid
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		String url = DOMAIN+"/w/phy"+aid+".html"; 
		jsapiSignatureURL (map,url,weixin.getToken()[2] );

		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		map.put("courselist", manager.getPActivityList("AND aid = "+aid+" ORDER BY sort ASC", 1, 40));
		return new ModelAndView("/ksite/phy/index",map );
	}


	@RequestMapping("w/jxy{aid}.html")
	public ModelAndView jxyindex(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("aid") String aid
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		String url = DOMAIN+"/w/jxy"+aid+".html"; 
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if (from != null && !from.equals("")) {
			url += "?from=" + from;
			if (isappinstalled != null && !isappinstalled.equals("")) {
				url += "&isappinstalled=" + isappinstalled;
			}
		}
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		try {
			map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		} catch (Exception e) {
			e.printStackTrace();
		}
		map.put("courselist", manager.getPActivityList("AND aid = "+aid+" ORDER BY sort ASC", 1, 100));
		//分享处理
		String shareTitle = "",shareDesc="",shareImage="",shareLink="";
		HashMap<String, Object> sharemap=manager.getNearActivity(aid);
		if(sharemap.size()>0){
			shareTitle=sharemap.get("name")+"";
			shareDesc=sharemap.get("tname")+"老师在随心瑜开设课程啦，快快学习新知识~";
			shareImage=sharemap.get("theader")+"";
			shareLink=url;
		}
		map.put("aid", aid);
		map.put("shareTitle", shareTitle);
		map.put("shareDesc", shareDesc);
		map.put("shareLink", shareLink);
		map.put("shareImage", shareImage);
		return new ModelAndView("/ksite/jxy/index",map );
	}


	/**
	 * 明细课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/phy/item/{id}.html")
	public ModelAndView phyDetail(
			@PathVariable("id")    int id, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		String url = DOMAIN+ request.getRequestURI(); 
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_phy_activity activeity = manager.getPActivity( id );
		if( activeity.getCid() > 0){
			Weixin_blog_teacher_course course = weixin.getCourse( activeity.getCid() );
			map.put("ocourse", course);
		}
		map.put("teacher", weixin.getWeixinUser( activeity.getTid() ));
		if( user != null ){
			Weixin_blog_teacher_order order_ = order.getOrderBywxid( user.getWxid(), activeity.getCid() );
			map.put("isbuy",  order_ == null ? false: true ); // 是否购买了该课程对应的普通课程
		}else
			map.put("isbuy", false);
		map.put("course",  activeity);
		map.put("user",    user);
		if(activeity.getStatus() == 2){
			return new ModelAndView("/ksite/phy/course_his",map );
		}
		map.put("socketaddress", Config.getString("websocket.address") );
		return new ModelAndView("/ksite/phy/course",map );
	}

	@RequestMapping(value = "w/jxy/item/{id}.html")
	public ModelAndView jxyDetail(
			@PathVariable("id")    int id, 
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		if( id <= 0 ){
			return goIndexHome();
		} 
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+ request.getRequestURI();
		Object token = weixin.getToken()[2];
		if( token == null ){
			token = weixin.getToken()[2];
		}
		if( token == null ){
			token = weixin.getToken()[2];
		}
		if( token == null ){
			token = weixin.getToken()[2];
		}
		map.put("isbuy", false);
		jsapiSignatureURL (map,url, token);
		Weixin_phy_activity activeity = manager.getPActivity( id );
		if( token == null || activeity == null){
			return goIndexHome();
		}
		if( activeity != null && activeity.getId() > 0 ){
			map.put("course",  activeity);
			map.put("ocourse", weixin.getCourse( activeity.getCid() ));
			map.put("teacher", weixin.getWeixinUser( activeity.getTid() ));
			map.put("socketaddress", Config.getString("websocket.address") );
		}
		if( user != null && user.getId() > 0 ){
			if( user.getRealname() == null || "".equals(user.getRealname().trim()) ){
				user.setRealname(user.getNickname());
			}
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVITY_SJ);
			if(activeity.getTid() != user.getId() && (signup == null || signup.getRefund() != 0)){
				map.put("isbuy", false);
			}else{
				map.put("isbuy", true);
			}
		}else{
			user = new Weixin_blog_user();
		}


		map.put("user",    user);  
		map.put("nologin",    user == null);
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey) );
		if( activeity.getTeacherids() != null && activeity.getTeacherids().length() > 0){
			if(activeity.getStatus() == 2){
				return new ModelAndView("/ksite/jxy/warmwinter_his",map );				
			}
			return new ModelAndView("/ksite/jxy/warmwinter",map );
		}else{
			if( activeity.getStatus() == 2 ){
				return new ModelAndView("/ksite/jxy/course_his",map );				
			}else
				return new ModelAndView("/ksite/jxy/course",map );
		}
	}


	/**
	 * 检验验证码是否正确
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/phy/{code}/{id}/code.html")
	public @ResponseBody JSONObject phyVCode(
			@PathVariable("code")  String code,
			@PathVariable("id")    int id,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			)  { 
		JSONObject result = new JSONObject();
		Weixin_phy_activity activeity = manager.getPActivity( id );
		result.put("status", false);
		if( activeity != null ){
			if( activeity.getCode().equals( code ) ){
				result.put("status", true);
				Weixin_blog_teacher_course course = weixin.getCourse( activeity.getCid() );
				result.put("realpath", course.getRealfilepath());
				return result;
			}
		} 
		return result;
	}

//	/**
//	 * json格式翻页
//	 * @param session
//	 * @param request
//	 * @param response
//	 * @param pageIndex
//	 * @return
//	 */
//	@RequestMapping(value = "w/chat/msg/json.html")
//	public @ResponseBody JSONObject getRoomMsgList(
//			HttpSession            session, 
//			HttpServletRequest     request,
//			HttpServletResponse    response,
//			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
//			@RequestParam(value = "type", required=false, defaultValue="0") int type,
//			@RequestParam(value = "pageIndex", required = true, defaultValue = "0") int pageIndex 
//			)  { 
//		JSONObject obj = new JSONObject();
//		StringBuffer filter = new StringBuffer();
//		int pageSize = 60;
//		filter.append(" AND roomid = ").append(p);
//		if (type == 0){
//			filter.append(" AND t = 1 ORDER BY createtime ASC");
//		}else if (type == 1){
//			filter.append(" AND t <= 9 ORDER BY talktime ASC");
//		}else {
//			filter.append(" AND t = 9 ORDER BY createtime ASC");
//		}
//		Pagination page = manager.getRoomMsgList(filter.toString(), pageIndex, pageSize);
//		JSONArray jsonArray = new JSONArray(); 
//		List<HashMap<String,Object>> msglist = page.getResults();
//		if( type == 9 ){
////			Collections.reverse(msglist);
//		}
//		if( msglist != null && msglist.size() > 0 ){
//			for( HashMap<String,Object> msg : msglist ){
//				JSONObject itemJson = new JSONObject();
//				itemJson.put("isteacher",msg.get("t"));
//				itemJson.put("content",  msg.get("content"));
//				itemJson.put("type",     msg.get("type"));
//				itemJson.put("wid",      msg.get("wid")); 
//				itemJson.put("header",   msg.get("header"));
//				itemJson.put("mp3path",  msg.get("mp3path"));
//				itemJson.put("mp3time",  msg.get("mp3time"));
//				itemJson.put("serverid", msg.get("serverId"));
//				itemJson.put("realname", msg.get("realname"));
//				itemJson.put("nickname", msg.get("nickname"));
//				jsonArray.add( itemJson ); 
//			}
//		}
//		obj.put("data", jsonArray);
//		obj.put("totalcount", page.getTotalCount());
//		obj.put("totalpage", page.getTotalPage());
//		return obj;
//	}
	
	/**
	 * json格式翻页
	 * @param session
	 * @param request
	 * @param response
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping(value = "w/chat/msg/json.html")
	public @ResponseBody JSONArray getRoomMsgList(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			@RequestParam(value = "type", required=false, defaultValue="0") int type,
			@RequestParam(value = "pageIndex", required = true, defaultValue = "0") int pageIndex 
			)  { 
		StringBuffer filter = new StringBuffer();
		int pageSize = 60;
		filter.append(" AND roomid = ").append(p);
		if (type == 0){
			filter.append(" AND t = 1 ORDER BY createtime ASC");
		}else if (type == 1){
			filter.append(" AND t <= 9 ORDER BY talktime ASC");
		}else {
			filter.append(" AND t = 9 ORDER BY createtime ASC");
//			pageSize = 20;
		}
		Pagination page = manager.getRoomMsgList(filter.toString(), pageIndex, pageSize);
		JSONArray jsonArray = new JSONArray(); 
		List<HashMap<String,Object>> msglist = page.getResults();
		if( type == 9 ){
//			Collections.reverse(msglist);
		}
		if( msglist != null && msglist.size() > 0 ){
			for( HashMap<String,Object> msg : msglist ){
				JSONObject itemJson = new JSONObject();
				itemJson.put("isteacher",msg.get("t"));
				itemJson.put("content",  msg.get("content"));
				itemJson.put("type",     msg.get("type"));
				itemJson.put("wid",      msg.get("wid")); 
				itemJson.put("header",   msg.get("header"));
				itemJson.put("mp3path",  msg.get("mp3path"));
				itemJson.put("mp3time",  msg.get("mp3time"));
				itemJson.put("serverid", msg.get("serverId"));
				itemJson.put("realname", msg.get("realname"));
				itemJson.put("nickname", msg.get("nickname"));
				jsonArray.add( itemJson ); 
			}
		}
		return jsonArray;
	}


	/**
	 * 中秋活动页面
	 * @return
	 * @ 
	 */
	@RequestMapping("weixin/active/vote.html")
	public ModelAndView midautumnActive(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		String url = DOMAIN+"/weixin/active/vote.html"; 
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		if(user != null&&user.getId()>0){
			map.put("cur_uid", user.getId());
			map.put("hasnotice",checkUserHasNotice(user));
			map.put("hasvote", true);
			Weixin_blog_activity_actor actor = manager.getActivityActor(user.getId(),ACTIVITY_ID);
			if(actor == null){
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				actor = new Weixin_blog_activity_actor();
				actor.setUid(user.getId());
				actor.setWxid(user.getWxid());
				actor.setNickname(user.getNickname());
				actor.setCreate_time(f.format(new Date()));
				actor.setActivityid(ACTIVITY_ID);
				int res = manager.addActivityActor(actor);
				if(res > 0){
					 this.sendMidautumnCreateSucNotice(user.getWxid());
				}
				map.put("cur_actid", res);
			}else{
				Pagination page = manager.getActivityVotorList(" AND status =1 AND actorid="+actor.getId()+" and fromuid = " +actor.getUid() ,0,100);
				if(page != null){
					map.put("votelist", page.getResults());					
				}
				map.put("cur_actid", actor.getId());
			}
		}
		return new ModelAndView("/ksite/active/toupiao",map );
	}


	@RequestMapping("weixin/{from_uid}/sharevote.html")
	public ModelAndView sharAutumnpage(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("from_uid") Integer from_uid
			) {

		Weixin_blog_user user = getWeixinSession( request,session );
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("nologin",   user == null);
		String url = DOMAIN+"/weixin/"+from_uid+"/sharevote.html"; 
		String from=request.getParameter("from");
		String isappinstalled=request.getParameter("isappinstalled");
		if(from!=null&&!from.equals("")){
			url+="?from="+from+"&isappinstalled="+isappinstalled;
		}
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		if(user != null&&user.getId()>0){
			map.put("cur_uid", user.getId());
			map.put("hasnotice",checkUserHasNotice(user));
			Weixin_blog_user fromuser = weixin.getWeixinUser(from_uid);
			if(fromuser!=null){
				map.put("fromuser", fromuser);
				Weixin_blog_activity_actor autor = manager.getActivityActor(from_uid,ACTIVITY_ID);
				map.put("from_uid", from_uid);
				map.put("from_actid", autor.getId());
				if(from_uid.equals(user.getId())){
					map.put("hasvote", true);
				}else{
					int res = manager.checkOrAddVote(user,fromuser,autor.getId());
					map.put("hasvote", !(res>0));
				}
			}
			Weixin_blog_activity_actor actor = manager.getActivityActor(user.getId(),ACTIVITY_ID);
			if(actor == null){
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				actor = new Weixin_blog_activity_actor();
				actor.setUid(user.getId());
				actor.setWxid(user.getWxid());
				actor.setNickname(user.getNickname());
				actor.setCreate_time(f.format(new Date()));
				actor.setActivityid(ACTIVITY_ID);
				int res = manager.addActivityActor(actor);
				if(res > 0){
				}
				map.put("cur_actid", res);			
			}else{
				map.put("cur_actid", actor.getId());		
				Pagination page = manager.getActivityVotorList(" AND status =1 AND actorid="+actor.getId()+" AND fromuid = " +user.getId() ,0,100);
				if(page != null){
					map.put("votelist", page.getResults());					
				}
			}
			map.put("haseNotice", checkUserHasNotice(user));
		}
		return new ModelAndView("/ksite/active/toupiao",map );
	}
	@RequestMapping("weixin/{from_uid}/dovote{from_actid}.html")
	public @ResponseBody JSONObject voteAutumn(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("from_uid") Integer from_uid,
			@PathVariable("from_actid") Integer from_actid
			){
		JSONObject result = new JSONObject();
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("status", false);
			result.put("msg", "用户还未登录！");
			return result;
		}
		int res = manager.voteAutumnActive(from_uid,user.getId(),from_actid);
		result.put("status", res > 0);
		if(res > 0){
			Weixin_blog_user actorUser = weixin.getWeixinUser(from_uid);
			this.sendMidautumnVoteSucNotice(user.getWxid(),actorUser.getNickname());
		}
		return result;
	}

	@RequestMapping("w/faq/distribution{sign}.html")
	public ModelAndView distribution(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("sign") String sign
			) {
		if(sign != null){
			Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(sign, ACTIVITY_SJ);
			if(distirbutor == null){
				sign = "q";
			}
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user != null){
			map.put("nologin",   false);
			map.put("hasNotice", checkUserHasNotice(user));
			map.put("sign", sign);
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVITY_SJ);
			map.put("hasJoin", signup != null && signup.getRefund()==0);

			String nonceStr =PayCommonUtil.CreateNoncestr();
			long timestamp = System.currentTimeMillis() / 1000;
			Object[] payInfo = PayCommonUtil.getPrepay_id("随心瑜-瑜伽理疗线上私教集训营", nonceStr,"9900", "", user.getWxid()  );
			String prepayid = payInfo[1].toString();
			String ordernumber = payInfo[0].toString();
			Map<String ,String >    signMap=new HashMap<String ,String >();
			signMap.put("appId",    Config.getString("weixin.appid"));
			signMap.put("timeStamp",timestamp+"");
			signMap.put("package", "prepay_id="+prepayid);
			signMap.put("signType", "MD5");
			signMap.put("nonceStr", nonceStr);

			map.put("appId",    Config.getString("weixin.appid"));
			map.put("timeStamp",timestamp+"");
			map.put("nonceStr", nonceStr);
			map.put("paytimestamp", timestamp);
			map.put("paypackage",  "prepay_id="+prepayid);
			map.put("paynonceStr",  nonceStr);
			map.put("paysignType",  "MD5");
			map.put("ordernumber",  ordernumber );
			map.put("paySign" ,     getPayCustomSign(signMap,ConfigUtil.API_KEY) );

		}else{
			map.put("nologin",   user == null);
			String url = DOMAIN+"/w/faq/distribution{SIGN}.html"; 
			url = url.replace("{SIGN}", sign);
			jsapiSignatureURL (map,url,weixin.getToken()[2] );
			map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		}
		return new ModelAndView("/ksite/active/distribution",map);
	}

	@RequestMapping(value = "w/updateuser/info.html", method = RequestMethod.POST)
	public @ResponseBody JSONObject updateUserInfo(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			String name,
			String phone,
			String city,
			String sign,
			String ordernumber
			){
		JSONObject result = new JSONObject();
		if(name == null || name.trim().length() < 1){
			result.put("satatus", false);
			result.put("msg", "请输入真实姓名");
			return result;	
		}
		if(phone == null || phone.trim().length() != 11){
			result.put("satatus", false);
			result.put("msg", "请输入正确的手机号码！");
			return result;
		}
		if(city == null || city.trim().length() < 1){
			result.put("satatus", false);
			result.put("msg", "请输入所在城市！");
			return result;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("satatus", false);
			result.put("msg", "请先登录！");
			return result;
		}
		Weixin_blog_distributor my = manager.getDistributorByWid(user.getId() + 1000,ACTIVITY_SJ);
		boolean notDistributor = (my == null);
		user.setMobile(phone);
		user.setRealname(name);
		user.setArea(city);
		int res = weixin.addOrUpdateWeixinUser(user);
		if(res > 0){
			setUserSession(user, response);
			/*生成未付款订单，完成支付后将订单更新为已支付*/
			Weixin_blog_distributor distirbutor = null;
			if(sign != null){
				distirbutor = manager.getDistributorByUUid(sign,ACTIVITY_SJ);
			}
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Weixin_blog_distributor_signup signup = new Weixin_blog_distributor_signup();
			signup.setCname(user.getRealname());
			signup.setMobile(user.getMobile());
			signup.setMoney("99");
			signup.setRemark(user.getFile_path());
			signup.setWid(user.getId());
			signup.setWxid(user.getWxid());
			signup.setCreatetime(f.format(new Date()));
			signup.setRefund(-1);
			signup.setCcname("瑜伽私教线上集训营");
			signup.setOrdernumber(ordernumber);
			signup.setChecked(0);
			signup.setActtype(ACTIVITY_SJ);
			if(notDistributor && distirbutor != null && distirbutor.getStatus() == 0){
				signup.setDid(distirbutor.getId());
				signup.setDname(distirbutor.getCname());
				signup.setFcbl(distirbutor.getFcbl());
				float m = 99f;
				try {
					String[] nums = distirbutor.getFcbl().split("/");
					int rate = Integer.parseInt(nums[0]);
					int rate2 = Integer.parseInt(nums[1]);
					float dmoney = m*rate/10;
					float pmoney =  m*rate2/10;
					signup.setDmoney(dmoney + "");
					signup.setPmoney(pmoney + "");
				} catch (Exception e) {
				}			
			}else{
				signup.setDid(0);
				signup.setDname("随心瑜平台");
				signup.setFcbl("0/10");
				signup.setDmoney("0");
				signup.setPmoney("99");
			}
			int signupid = manager.addOrUpdateSignup(signup);
			if(signupid > 0){
				result.put("status", signupid > 0);
				result.put("signupid", signupid);				
			}
		}
		return result;
	}

	@RequestMapping(value = "w/payforsignup/{sid}.html", method = RequestMethod.POST)
	public @ResponseBody JSONObject addSignup(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("sid") Integer sid
			){
		JSONObject result = new JSONObject();
		if(sid == null){
			result.put("status", false);
			return result;			
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("status", false);
			return result;
		}
		Weixin_blog_distributor_signup signup = manager.getSignUp(sid);
		signup.setRefund(0);
		if(manager.addOrUpdateSignup(signup) > 0){
			sendDistributorTemplate(user.getWxid(), user.getRealname());			
		}
		result.put("status", true);
		return result;
	}

	@RequestMapping(value = "w/deleteforsignup/{sid}.html", method = RequestMethod.POST)
	public @ResponseBody void deleteSignup(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("sid") Integer sid
			){
		manager.delSignup(sid);

	}

	@RequestMapping("weixin/distribution/{did}.html")
	public ModelAndView showDistribution(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("did") String sign){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(sign,ACTIVITY_SJ);
		if(distirbutor != null){
			List<HashMap<String, Object>> list = manager.getSignupByDid(distirbutor.getId(),ACTIVITY_SJ);
			map.put("count", list.size());
			map.put("distributor", distirbutor);
			map.put("list", list);
		}

		return new ModelAndView("/ksite/active/salesman",map);
	}

	@RequestMapping("weixin/distribution2/{did}.html")
	public ModelAndView showDistribution2(
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("did") String sign){
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			String url = DOMAIN + "/weixin/distribution2/"+sign+".html";
			jsapiSignatureURL (map,url,weixin.getToken()[2] );
			map.put("nologin",   true);
			try {
				map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(!StringUtils.isNull(sign)){
			Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(sign, ACTIVITY_SJ);
			if(distirbutor != null){
				List<HashMap<String, Object>> list = manager.getSignupByDid(distirbutor.getId(),ACTIVITY_SJ);
				map.put("count", list.size());
				map.put("distributor", distirbutor);
				map.put("list", list);
			}
		}
		return new ModelAndView("/ksite/active/distributionRevenue",map);
	}

	/**
	 * 给老师发送提问消息
	 * @param openId
	 * @return
	 */
	public int sendDistributorTemplate( String openId, String distributor){
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl( DOMAIN +"/weixin/jieshao.html");
		temp.setTouser( openId );
		temp.setTopcolor("#000000");
		temp.setTemplate_id( Config.getString("weixin.distributor.templateid"));

		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");
		first.setValue("您已成功购买瑜伽私教线上集训营课程！");
		m.put("first", first);  

		TemplateData keyword1 = new TemplateData();
		keyword1.setColor("#000000");
		keyword1.setValue("瑜伽私教集训营课程购买");
		m.put("keyword1", keyword1);

		TemplateData keyword2 = new TemplateData();
		keyword2.setColor("#000000");
		keyword2.setValue(distributor);
		m.put("keyword2", keyword2);

		TemplateData remark = new TemplateData();
		remark.setColor("#000000");
		remark.setValue("点击下方“详情”，查看听课与提问参与方式；同时，请留意瑜是乎平台的上课通知！");
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

	@RequestMapping("weixin/midautumnzs/{uid}.html")
	public ModelAndView getMidautumnZS(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("uid")   int uid,
			@RequestParam(value = "imgurl", required = true, defaultValue = "0") String imgurl 
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/weixin/midautumnzs/"+uid+".html?imgurl=" + imgurl;
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		Weixin_blog_user user = weixin.getWeixinUser(uid);
		if(user != null){
			String no = "";
			if(uid < 10){
				no = "Y0000" + uid;
			}else if(uid < 100){
				no = "Y000" + uid;
			}else if(uid < 1000){
				no = "Y00" + uid;
			}else if(uid < 10000){
				no = "Y0" + uid;
			}else{
				no = "Y" + uid;
			}
			map.put("zsno", no);
			map.put("zsname", user.getRealname());
			map.put("imgurl", imgurl);
		}

		return new ModelAndView("/ksite/active/zhengshu",map);
	}

	@RequestMapping("weixin/assistant/distructor.html")
	public ModelAndView tobeAssistant(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/weixin/assistant/distructor.html";
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		if(user != null){
			Weixin_blog_distributor distirbutor = manager.getDistributorByWid(user.getId() + 1000,ACTIVITY_SJ);
			map.put("isdistirbutoe", distirbutor!= null);
		}else{
			try {
				map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return new ModelAndView("/ksite/active/distructor",map);
	}

	@RequestMapping("weixin/assistant/success.html")
	public ModelAndView becomeAssistant(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/weixin/assistant/success.html";
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		if(user != null){
			int wid = user.getId() + 1000; //课代表的wid是user.id + 1000
			Weixin_blog_distributor distributor = manager.getDistributorByWid(wid,ACTIVITY_SJ);
			String sign=getDistributorOnlyNumber();
			map.put("sign",sign );
			if(distributor == null){
				SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				distributor = new Weixin_blog_distributor();
				String cname = user.getNickname();
				if(user.getRealname() != null && user.getRealname().length() > 0){
					cname = user.getRealname();
				}
				distributor.setCname(cname);
				distributor.setIdcard("");
				distributor.setStatus(0);
				distributor.setCreatetime(f.format(new Date()));
				distributor.setMobile("");
				distributor.setRemark("");
				distributor.setWid(user.getId() + 1000);
				distributor.setUuid(sign);
				distributor.setSalecount(0);
				distributor.setMoney("0");
				distributor.setFilepath("");
				distributor.setFcbl("4/6");
				distributor.setSalename("课代表");
				distributor.setSaleid(1);
				distributor.setActtype(ACTIVITY_SJ);
				int res = manager.addOrUpdateDistributor(distributor);
				if(res > 0){
					sendAssistantTemplate(user.getWxid());					
				}
			}
		}else{
			try {
				map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
			} catch (Exception e) {
				e.printStackTrace();
			}			
		}
		return new ModelAndView("/ksite/active/beassistant",map);
	}


	/**
	 * 成为课代表的模板消息
	 * @param openId
	 * @return
	 */
	public int sendAssistantTemplate( String openId){
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl( DOMAIN +"/weixin/assistant/success.html");
		temp.setTouser( openId );
		temp.setTopcolor("#000000");
		temp.setTemplate_id( Config.getString("weixin.Assistant.templateid"));

		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");
		first.setValue("恭喜您已成为私教集训营活动的课代表！");
		m.put("first", first);  

		TemplateData keyword1 = new TemplateData();
		keyword1.setColor("#000000");
		keyword1.setValue("课代表成功提醒");
		m.put("keyword1", keyword1);

		SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		TemplateData keyword2 = new TemplateData();
		keyword2.setColor("#000000");
		keyword2.setValue(f.format(new Date()));
		m.put("keyword2", keyword2);

		TemplateData remark = new TemplateData();
		remark.setColor("#000000");
		remark.setValue("点击“详情”，即可获取分享方式，快分享给您的小伙伴吧");
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

	@RequestMapping("weixin/collect/userinfo.html")
	public ModelAndView collectUserinfo(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/weixin/collect/userinfo.html";
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin",   user == null);
		if(user != null){
			String sign = AESUtil.enSimpleSercty((user.getId() + 1000) + "");
			map.put("sign", sign);
		}else{
			try {
				map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return new ModelAndView("/ksite/active/collectUserInfo", map);
	}

	@RequestMapping(value="weixin/updateuserinfo.html", method=RequestMethod.POST)
	public @ResponseBody JSONObject updateUserInfo(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			String name,
			String bankno,
			String bankaddress,
			String mobile,
			String idcard1,
			String idcard2
			){
		JSONObject result = new JSONObject();
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("status", -1);
			result.put("msg", "请先登录！");
			return result;
		}
		Weixin_blog_distributor distributor = manager.getDistributorByWid(user.getId() + 1000,ACTIVITY_SJ);
		if(distributor == null){
			result.put("status", -2);
			result.put("msg", "还不是课代表！");
			return result;
		}
		distributor.setCname(name);
		distributor.setBankaccount(bankno);
		distributor.setMobile(mobile);
		distributor.setBankaddress(bankaddress);
		distributor.setIdfile1id(idcard1);
		distributor.setIdfile2id(idcard2);
		result.put("status", manager.updateDistributorInfo(distributor));
		return result;
	}

	public int sendMidautumnCreateSucNotice(String wxid) {
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl(Config.getString("domain")+"/weixin/active/vote.html");
		temp.setTouser(wxid);
		temp.setTopcolor("#000000");
		temp.setTemplate_id("I65ySJjowvEY15Uovllj0gbVCNNb--Ps3xJ0vjzsBGM");
		//temp.setTemplate_id("OjD-60xh1bASfCfjaOI4hy2ROX55bZKDfk3ZHPINfhY");
		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");  
		first.setValue("您已经成功参与随心瑜国庆送礼投票活动");  
		m.put("first", first);  

		TemplateData keyword1 = new TemplateData();  
		keyword1.setColor("#000000");  
		keyword1.setValue("随心瑜国庆送礼活动");  
		m.put("keyword1", keyword1);

		TemplateData keyword2 = new TemplateData();  
		keyword2.setColor("#000000");  
		keyword2.setValue(sdf.format(new Date()));  
		m.put("keyword2", keyword2);

		TemplateData remark = new TemplateData();  
		remark.setColor("#000000");  
		remark.setValue("快分享给您的小伙伴们为您投票吧");  
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
	public int sendMidautumnVoteSucNotice(String wxid,String unackname) {
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		WxTemplate temp = new WxTemplate();
		temp.setUrl(Config.getString("domain")+"/weixin/active/vote.html");
		temp.setTouser(wxid);
		temp.setTopcolor("#000000");
		temp.setTemplate_id("5uL-YW1Aqh-oMA8fksvHOzti2zS04PnkHz0ePYFO5y8");
		//		temp.setTemplate_id("q8OSWxUjeplN6raO4Ngtc4ENAwdWW9DqYyfq5EMVgWI");
		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");  
		first.setValue("您已经成功给"+unackname+"投票");  
		m.put("first", first);  

		TemplateData keyword1 = new TemplateData();  
		keyword1.setColor("#000000");  
		keyword1.setValue("随心瑜国庆送礼活动");  
		m.put("keyword1", keyword1);

		TemplateData keyword2 = new TemplateData();  
		keyword2.setColor("#000000");  
		keyword2.setValue(sdf.format(new Date()));  
		m.put("keyword2", keyword2);

		TemplateData remark = new TemplateData();  
		remark.setColor("#000000");  
		remark.setValue("您也可以自己参与投票活动，邀请20位好友为您投票即可免费领取优质瑜伽课程哦");  
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


	@RequestMapping("w/faq/appec{sign}.html")
	public ModelAndView aDistribution(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("sign") String sign
			) {
		String money = String.valueOf((int)(ACTIVITY_JG_MONEY*100));
		if( sign != null ){
			Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(sign, ACTIVITY_JG);
			if(distirbutor == null){
				sign = "q";
			}
		}
		HashMap<String, Object> map = new HashMap<String, Object>();

		String url = DOMAIN+"/w/faq/appec"+sign+".html"; 
		String from=request.getParameter("from");
		String isappinstalled=request.getParameter("isappinstalled");
		if(from!=null&&!from.equals("")){
			url+="?from="+from+"&isappinstalled="+isappinstalled;
		}
		Object [] token = weixin.getToken();
		if(token==null||token.length==0){
			goIndexHome();
		}
		jsapiSignatureURL (map,url,token[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_user user = getWeixinSession( request,session ); 
		boolean hasJoin=false;
		boolean nologin=false;
		if(user != null){
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVITY_JG); 
			if(signup != null && signup.getRefund()==0)
				hasJoin=true; 
			String appId=map.get("appid").toString();
			String nonceStr =map.get("nonceStr").toString();
			String timestamp =map.get("timestamp").toString();
			Object[] payInfo = PayCommonUtil.getPrepay_id(ACTIVITY_JG_NAME, nonceStr,money, "", user.getWxid());
			String prepayid = payInfo[1].toString();
			String ordernumber = payInfo[0].toString();
			Map<String ,String >    signMap=new HashMap<String ,String >();
			signMap.put("appId",   appId);
			signMap.put("timeStamp",timestamp);
			signMap.put("package", "prepay_id="+prepayid);
			signMap.put("signType", "MD5");
			signMap.put("nonceStr", nonceStr);

			map.put("appId",appId);
			map.put("timeStamp",timestamp);
			map.put("nonceStr",  nonceStr);
			map.put("paytimestamp", timestamp);
			map.put("paypackage",  "prepay_id="+prepayid);
			map.put("paynonceStr",   nonceStr);
			map.put("paysignType",  "MD5");
			map.put("ordernumber",  ordernumber );
			map.put("paySign" ,     getPayCustomSign(signMap,ConfigUtil.API_KEY) );
			map.put("uid", user.getId());
		}else{
			nologin=true;
		}
		map.put("nologin",nologin);
		map.put("hasJoin",hasJoin);
		map.put("money",ACTIVITY_JG_MONEY);
		map.put("sign", sign);
		return new ModelAndView("/ksite/active/appdistribution",map);
	}

	/**
	 * 发送验证码
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="w/app/distribution/sendcode.html")
	public @ResponseBody JSONObject sendCode(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			String phone
			){
		JSONObject result = new JSONObject();
		int flag = weixin.sendCaptcha(phone, 0);
		if(flag > 0){
			result.put("status",true);
			return result ;
		}
		return null;
	}

	@RequestMapping(value = "w/app/updateuser/info.html")
	public @ResponseBody JSONObject updateaUserInfo(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			String name,
			String phone, 
			String pwd,
			String sign,
			String ordernumber
			){
		JSONObject result = new JSONObject(); 
		if(name == null || name.trim().length() < 1){
			result.put("satatus", false);
			result.put("msg", "请输入真实姓名");
			return result;	
		}
		if(phone == null || phone.trim().length() != 11){
			result.put("satatus", false);
			result.put("msg", "请输入正确的手机号码！");
			return result;
		}
		if(pwd != null ){
			int flag = weixin.verificationNumber(phone, pwd);
			if(flag < 1){
				result.put("satatus", false);
				result.put("msg", "输入的验证码错误！");
				return result ;
			}
		}else{
			result.put("satatus", false);
			result.put("msg", "请输入验证码！");
			return result;
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("satatus", false);
			result.put("msg", "请先登录！");
			return result;
		}
		user.setMobile(phone);
		user.setRealname(name);
		int res = weixin.addOrUpdateWeixinUser(user);
		java.text.DecimalFormat myformat=new java.text.DecimalFormat("0.00");
		String str = myformat.format(ACTIVITY_JG_MONEY);    
		String money= String.valueOf(str);
		if(res > 0){
			setUserSession(user, response);
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Weixin_blog_distributor_signup signup = new Weixin_blog_distributor_signup();
			signup.setCname(user.getRealname());
			signup.setMobile(user.getMobile());
			signup.setMoney(money);
			signup.setRemark(user.getFile_path());
			signup.setWid(user.getId());
			signup.setWxid(user.getWxid());
			signup.setCreatetime(f.format(new Date()));
			signup.setRefund(-1);
			signup.setCcname(ACTIVITY_JG_NAME);
			signup.setOrdernumber(ordernumber);
			signup.setActtype(ACTIVITY_JG);
			signup.setUnionid(user.getUnionid());
			signup.setChecked(0);
			Weixin_blog_distributor distirbutor = null;
			if(sign != null){
				distirbutor = manager.getDistributorByUUid(sign, ACTIVITY_JG);
			}
			if(distirbutor != null && distirbutor.getStatus() == 0){
				signup.setDid(distirbutor.getId());
				signup.setDname(distirbutor.getCname());
				signup.setFcbl(distirbutor.getFcbl());
				try {
					String[] nums = distirbutor.getFcbl().split("/");
					int rate = Integer.parseInt(nums[0]);
					int rate2 = Integer.parseInt(nums[1]);
					float dmoney = ACTIVITY_JG_MONEY*rate/10;
					float pmoney =  ACTIVITY_JG_MONEY*rate2/10;
					signup.setDmoney(dmoney + "");
					signup.setPmoney(pmoney + "");
				} catch (Exception e) {
				}
			}else{
				signup.setDid(0);
				signup.setDname("随心瑜平台");
				signup.setFcbl("0/10");
				signup.setDmoney("0"); 
				signup.setPmoney(money);
			}
			int signupid = manager.addOrUpdateSignup(signup);
			weixin.updateVerificationNumber(phone,pwd);
			result.put("status", signupid > 0);
			result.put("signupid", signupid);			
		}
		return result;
	}

	@RequestMapping(value = "w/app/payforsignup/{sid}.html", method = RequestMethod.POST)
	public @ResponseBody JSONObject addASignup(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("sid") Integer sid,
			@RequestParam(value = "o", required = true, defaultValue = "")  String ordernumber,
			@RequestParam(value = "p", required = true, defaultValue = "0") int logid
			){
		JSONObject result = new JSONObject();
		if(sid == null){
			result.put("status", false);
			return result;			
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("status", false);
			return result;
		}
		Weixin_blog_distributor_signup signup = manager.getSignUp(sid);
		String phone = signup.getMobile();
		signup.setRefund(0);
		int offcet=manager.addOrUpdateSignup(signup);
		if( offcet> 0){
			Weixin_blog_user_logger log = weixin.getLogger(logid);
			log.setOrdernumber(ordernumber);
			log.setIsgiveup(1);
			weixin.addOrUpdateUserLogger( log );
			String msg = "亲，您已成功购买实战经管集训营课程。请登录APP【随心瑜掌馆】学习页面经管频道进行听课，APP下载：http://t.cn/RcT79aZ。如有疑问请与400-018-6161联系。";
			weixin.sendMSM(phone, msg);
		}
		result.put("status", true);
		return result;
	}

	@RequestMapping(value = "w/appec/benefit{did}.html")
	public ModelAndView appbenefit(
			HttpSession            session, 
			HttpServletRequest     request,
			@PathVariable("did") String did
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url  = DOMAIN+"/w/appec/benefit"+did+".html"; 
		String from = request.getParameter("from");
		String isappinstalled=request.getParameter("isappinstalled");
		if( from!=null&&!from.equals("") ){
			url+="?from="+from+"&isappinstalled="+isappinstalled;
		}
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(did,ACTIVITY_JG);
		if(distirbutor != null){
			List<HashMap<String, Object>> list = manager.getSignupByDid(distirbutor.getId(),ACTIVITY_JG);
			float money=0;
			for (HashMap<String, Object> signmap : list) {
				String dmoney=signmap.get("dmoney").toString();
				money+=Float.parseFloat(dmoney);
				if(signmap.get("createtime")!=null){
					signmap.put("createtime",signmap.get("createtime").toString().substring(0, 10));
				}
			}
			BigDecimal b=new BigDecimal(money); 
			distirbutor.setMoney(b.setScale(2,BigDecimal.ROUND_HALF_UP).toString());		    
			map.put("count", list.size());
			map.put("distributor", distirbutor);
			map.put("list", list);
		}
		return new ModelAndView("/ksite/active/appbenefit",map);
	}

	@RequestMapping("w/app/distribution/success.html")
	public ModelAndView successPage(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/w/app/distribution/success.html"; 
		String from=request.getParameter("from");
		String isappinstalled=request.getParameter("isappinstalled");
		if(from!=null&&!from.equals("")){
			url+="?from="+from+"&isappinstalled="+isappinstalled;
		}
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/active/success_page",map);
	}

	@RequestMapping(value = "w/actishare{aid}.html", method = RequestMethod.POST)
	public @ResponseBody JSONObject jxyshare(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("aid") Integer aid
			){
		JSONObject result = new JSONObject();
		if(aid == null){
			result.put("status", false);
			return result;			
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user == null){
			result.put("status", false);
			return result;
		}
		Weixin_blog_user_logger log=new Weixin_blog_user_logger();
		log.setCid(aid);
		log.setCname(user.getNickname()+"分享了暖冬活动ID:"+aid+"，时间:"+getDate());
		log.setWid(user.getId());
		log.setWxid(user.getWxid());
		log.setType(5);
		log.setCreatetime(getTime());
		log.setIsgiveup(1);
		int loggerid =weixin.addOrUpdateUserLogger(log);
		if(loggerid<1){
			result.put("status", false);
			result.put("msg", "日志处理失败");
			return result;
		}
		String courses = Config.getString("WARM_WINTER_COURSE");
		String[] courseArray=courses.split("/");
		List<HashMap<String, Object>> awards = weixin.getWeixinUserExclusiveAward(user.getId());
		int index=0;
		//说明已有奖励
		if(awards!=null&&awards.size()>0){
			//判断今日是否得过奖励
			String createtime=awards.get(0).get("createtime").toString();
			Date date=null;
			try {
				date = sdf_date.parse(createtime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			if(getDate().equals(sdf_date.format(date))){
				result.put("status", true);
				result.put("msg", "今天已奖励过课程，去查看吧");
				return result;
			}else{
				int size=awards.size();
				if(size>=courseArray.length){
					result.put("status", true);
					result.put("msg", "奖励课程已领完了，去查看吧");
					return result;
				}else{
					index=size;
				}
			}
		}
		String courseid=courseArray[index];
		Weixin_blog_user_exclusive_award award=new Weixin_blog_user_exclusive_award();
		award.setAwardres("2016暖冬活动Weixin_phy_activity_ID:"+aid);
		award.setCreatetime(getTime());
		award.setWid(user.getId());
		award.setCtype(1);
		award.setCid(Integer.parseInt(courseid));
		int res=weixin.addOrUpdateUserExclusiveAward(award);
		if(res>0){
			result.put("status", true);
			result.put("msg", "奖励课程已奖励，去查看吧");
		}else{
			result.put("status", false);
			result.put("msg", "奖励失败");
		}
		return result;
	}

	@RequestMapping(value = "w/acticount.html")
	public @ResponseBody JSONObject acticount(){
		JSONObject result = new JSONObject();
		result.put("allcount", weixin.getActiAllShareCount(5,18));
		result.put("list", weixin.getActiShareCountList(5,18));
		return result;
	}
}

