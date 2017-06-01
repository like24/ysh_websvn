package com.yoga.controller.v2.activity;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.yoga.controller.v2.R;
import com.yoga.dao.Weixin_blog_distributor;
import com.yoga.dao.Weixin_blog_distributor_info;
import com.yoga.dao.Weixin_blog_distributor_signup;
import com.yoga.dao.Weixin_blog_sysdic;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.dao.Weixin_blog_user_logger;
import com.yoga.dao.Weixin_phy_activity;
import com.yoga.utils.AESUtil;
import com.yoga.utils.Config;
import com.yoga.utils.DateTools;
import com.yoga.weixin.WeixinUtil;
import com.yoga.weixin.pay.ConfigUtil;
import com.yoga.weixin.pay.PayCommonUtil;
import com.yoga.weixin.template.TemplateData;
import com.yoga.weixin.template.WxTemplate;

import net.sf.json.JSONObject;

/**
 * 孕产原
 * @author king
 *
 */
@Controller
public class WeixinActivityForYunchanController extends R{




	/**
	 * 瑜伽瘦身集训营售卖页面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("pay/yc{uuid}.html")
	public ModelAndView nvshenActivity(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("uuid")  String uuid
			){
		String money = "19900";
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url            = DOMAIN+"/pay/yc"+uuid+".html"; 
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( uuid != null && uuid.length() > 0 ){
			Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(uuid, ACTIVEIT_2017_YUNCHAN);
			if( distirbutor == null || distirbutor.getId() == 0  ){
				uuid = "YSH";
			} 
		}
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2 || token[2] == null ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 || token[2] == null  ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 || token[2] == null ){
			token = weixin.getToken();
		}  
		if( token != null && token.length > 2 ) {
			jsapiSignatureURL ( map,url,token[2] );
		}
		map.put("uuid",        uuid); 
		map.put("urlsecret",   AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_user user = getWeixinSession( request,session ); 
		boolean hasJoin = false;
		boolean nologin = false;
		map.put("uid",0);
		map.put("ordernumber",  0);
		if( user != null && user.getId() > 0 ){
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVEIT_2017_YUNCHAN ); 
			if( signup != null && signup.getRefund() == 0 ){
				hasJoin = true; 
			}else{
				String appId     = map.get("appid")+"";
				String nonceStr  = map.get("nonceStr")+"";
				String timestamp = map.get("timestamp")+"";
				Object[] payInfo = PayCommonUtil.getPrepay_id(ACTIVITY_YUNCHAN_2017, nonceStr,money, ACTIVEIT_2017_SLIMMING+"", user.getWxid() );
				if( payInfo != null && payInfo[1] != null && payInfo[0] != null ){
					String prepayid         = payInfo[1]+"";
					String ordernumber      = payInfo[0]+"";
					Map<String ,String >    signMap=new HashMap<String ,String>();
					signMap.put("appId",    appId);
					signMap.put("timeStamp",timestamp);
					signMap.put("package", "prepay_id="+prepayid);
					signMap.put("signType", "MD5");
					signMap.put("nonceStr", nonceStr);
					map.put("appId",        appId);
					map.put("timeStamp",    timestamp);
					map.put("nonceStr",     nonceStr);
					map.put("paytimestamp", timestamp);
					map.put("paypackage",   "prepay_id="+prepayid);
					map.put("paynonceStr",  nonceStr);
					map.put("paysignType",  "MD5");
					map.put("ordernumber",  ordernumber );
					map.put("paySign" ,     getPayCustomSign(signMap,ConfigUtil.API_KEY) );
					map.put("uid",          user.getId());
				}
			}
		}else{
			nologin = true;
			removeSession( session );
			String urll = "https://open.weixin.qq.com/connect/oauth2/authorize?appid="+Config.getString("weixin.appid")+"&redirect_uri="+ DOMAIN +"/"+AESUtil.Encrypt(url, R.cKey)+"/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			return new ModelAndView(new RedirectView(urll)); 
		}
		map.put("nologin",nologin);
		map.put("hasJoin",hasJoin);
		map.put("money",  "199" );
		return new ModelAndView("/ksite/active/yc/index",map);
	}





	/**
	 * 预生成订单
	 * @param session
	 * @param request
	 * @param response
	 * @param name
	 * @param phone
	 * @param pwd
	 * @param sign
	 * @param ordernumber
	 * @return
	 */
	@RequestMapping(value = "w/faq/yc/info.html")
	public @ResponseBody JSONObject nvshenActivitySaveSignup(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		String name = this.trim( request.getParameter("name") );
		String money= this.trim( request.getParameter("money") );
		String phone= this.trim( request.getParameter("phone") );
		String uuid = this.trim( request.getParameter("uuid") ); 
		String ordernumber = this.trim( request.getParameter("ordernumber") );
		String pwd  = this.trim( request.getParameter("pwd") );
		String loggerid = this.trim( request.getParameter("loggerid"));
		JSONObject result = new JSONObject();
		if( name == null || name.trim().length() < 1){
			result.put("status", false);
			result.put("msg", "请输入真实姓名");
			return result;	
		}
		if(phone == null || phone.trim().length() != 11){
			result.put("status", false);
			result.put("msg", "请输入正确的手机号码！");
			return result;
		}  
		if( !pwd.equals("99999") ){
			int flag = weixin.verificationNumber(phone, pwd);
			if( flag < 1 ){
				result.put("status", false);
				result.put("msg", "输入的验证码错误！");
				return result ;
			}
		}
		Weixin_blog_user user = getWeixinSession( request,session );
		if( user == null ){
			result.put("status", false);
			result.put("msg", "请先登录！");
			return result;
		}
		user.setMobile(phone);
		user.setRealname(name);
		int res = weixin.addOrUpdateWeixinUser(user);
		java.text.DecimalFormat myformat=new java.text.DecimalFormat("0.00");
		int MMM = Integer.valueOf( money );
		String str = myformat.format( MMM );    
		if( res > 0 ){
			setUserSession(user, response);
			SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Weixin_blog_distributor_signup signup = new Weixin_blog_distributor_signup();
			signup.setCname(user.getRealname());
			signup.setMobile(user.getMobile());
			signup.setMoney( str );
			signup.setRemark(user.getFile_path());
			signup.setWid(user.getId());
			signup.setWxid(user.getWxid());
			signup.setCreatetime(f.format(new Date()));
			signup.setRefund(-1); 
			signup.setCcname( ACTIVITY_YUNCHAN_2017 );
			signup.setOrdernumber(ordernumber);
			signup.setActtype( ACTIVEIT_2017_YUNCHAN );
			signup.setUnionid(user.getUnionid());
			signup.setChecked(0); 
			signup.setLoggerid( loggerid.length() == 0 ? 0 :Integer.valueOf( loggerid ) );
			Weixin_blog_distributor distirbutor = null;
			if( uuid != null ){
				distirbutor = manager.getDistributorByUUid(uuid, ACTIVEIT_2017_YUNCHAN );
			}
			if( loggerid.length() > 0 ){
				Weixin_blog_user_logger  logger = weixin.getLogger( Integer.valueOf( loggerid ));
				if( logger != null ){
					if( logger.getWxordernum() != null && logger.getWxordernum().length() > 5 ){
						signup.setWxordernum( logger.getWxordernum() );
					}
				}
			}
			Weixin_blog_sysdic yunc = manager.getSysdic( 33 );
			if( yunc != null && yunc.getId() > 0 && !StringUtils.isEmpty( yunc.getValue() )){
				if( DateTools.beforeDate( sdf.format( new Date() ), yunc.getValue() )){
					signup.setDid( distirbutor.getId() );
					signup.setDname(distirbutor.getCname() );
					signup.setFcbl( distirbutor.getFcbl() );
					signup.setDmoney("100");
					signup.setPmoney((MMM-100)+"");  
				}else{
					signup.setDid(0);
					signup.setDname("随心瑜平台");
					signup.setFcbl("0/10");
					signup.setDmoney("0"); 
					signup.setPmoney("0");
				}
			} 
			int signupid = manager.addOrUpdateSignup(signup);
			result.put("status",  signupid > 0);
			result.put("signupid", signupid);			
		}
		return result;
	}

	/**
	 * 发送短信
	 * @param session
	 * @param request
	 * @param response
	 * @param sid
	 * @param ordernumber
	 * @param logid
	 * @return
	 */
	@RequestMapping(value = "w/faq/yc/pay/{sid}.html", method = RequestMethod.POST)
	public @ResponseBody JSONObject slimmingActivitySendMsgSuccess(
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
		signup.setRefund(0);
		int offcet = manager.addOrUpdateSignup(signup);
		if( offcet> 0){
			Weixin_blog_user_logger log = weixin.getLogger( logid );
			if( log != null ) {
				log.setOrdernumber(ordernumber);
				log.setIsgiveup(1);
				weixin.addOrUpdateUserLogger( log );
			}
			sendBuyCoureseTemplatse(signup.getWxid(), log.getTmoney()); 
		}
		result.put("status", true);
		return result;
	}



	/**
	 * 付款成功到课程列表页
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("yc/courselist.html")
	public ModelAndView slimmingCourseList(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) throws Exception{

		HashMap<String, Object> map = new HashMap<String, Object>();
		String url            = DOMAIN+"/yc/courselist.html"; 
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
		Object[] token = weixin.getToken();
		if( token == null || token.length == 2 || token[2] == null ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 || token[2] == null  ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 2 || token[2] == null ){
			token = weixin.getToken();
		}  
		if( token != null && token.length != 2 ) {
			jsapiSignatureURL ( map,url,token[2] );
		}
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_user user = getWeixinSession( request,session ); 
		boolean hasJoin = false;
		boolean nologin = false;
		if( user != null && user.getId() > 0 ){
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVEIT_2017_YUNCHAN); 
			map.put("signup", signup);
			if( signup != null   ){
				Weixin_blog_distributor  distributor = manager.getDistributor( signup.getDid() );
				map.put("distributor", distributor == null ? new Weixin_blog_distributor() : distributor);
				if( signup.getRefund() == 0 ){
					hasJoin = true; 
					map.put("courselist", manager.getPActivityList("AND aid = 22 ORDER BY sort ASC", 1, 50));
				}
			}else{
				return new ModelAndView("redirect:/pay/ycM4643.html");  // 如果用户没有购买直接到购买页面
			}
		}else{
			nologin=true;
			removeSession( session );
		}
		map.put("nologin",nologin);
		map.put("hasJoin",hasJoin);
		map.put("money",  ACTIVITY_SLIMMING_MONEY);
		return new ModelAndView("/ksite/active/yc/courselist",map);
	}



	/**
	 * 发送购买课程的通知
	 * @param openId
	 * @return
	 */
	public int sendBuyCoureseTemplatse( String openId,String money ){
		String url = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token="+weixin.getToken()[0];
		//		{{first.DATA}}
		//		课程名称：{{keyword1.DATA}}
		//		支付金额：{{keyword2.DATA}}
		//		时间：{{keyword3.DATA}}
		//		{{remark.DATA}}


		//		购买成功后微信消息：
		//		课程购买通知
		//		您已报名成功
		//		课程名称：【孕产瑜伽私教集训营】视频课程+导师在线答疑
		//		支付金额：299元
		//		时间：2017年4月15日 上午11点开课
		WxTemplate temp = new WxTemplate();
		temp.setUrl( DOMAIN+"/yc/courselist.html");
		temp.setTouser( openId );
		temp.setTopcolor("#000000");
		temp.setTemplate_id( "Frqmvbn6GdujclBN1NfTTV-KdjE8QFuxm0RT-2TQeiA" );

		Map<String,TemplateData> m = new HashMap<String,TemplateData>();
		TemplateData first = new TemplateData();
		first.setColor("#000000");  
		first.setValue( "您已报名成功" );  
		m.put("first", first);  

		TemplateData keyword1 = new TemplateData();
		keyword1.setColor("#000000");  
		keyword1.setValue( "【孕产瑜伽私教集训营】视频课程+导师在线答疑" );  
		m.put("keyword1", keyword1);  

		TemplateData keyword2 = new TemplateData();
		keyword2.setColor("#000000");  
		keyword2.setValue( money+"元");  
		m.put("keyword2", keyword2);  

		TemplateData keyword3 = new TemplateData();
		keyword3.setColor("#000000");  
		keyword3.setValue( "2017年4月15日 上午11点开课");  
		m.put("keyword3", keyword3); 

		TemplateData remark = new TemplateData();  
		remark.setColor("#000000");  
		remark.setValue( "" );  
		m.put("Remark", remark);

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
	 * 经销商查看自己的收益
	 * @param session
	 * @param request
	 * @param did
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/faq/yc/money/{uuid}.html")
	public ModelAndView indiaActivityMoney(
			HttpSession            session, 
			HttpServletRequest     request,
			@PathVariable("uuid") String uuid
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url  = DOMAIN+"/w/faq/yc/money/"+uuid+".html"; 
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from!=null && !from.equals("") ){
			url+="?from="+from;
		}
		if( isappinstalled!=null && !isappinstalled.equals("") ){
			url+="&isappinstalled="+isappinstalled;
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
			jsapiSignatureURL (map,url,weixin.getToken()[2] );
		} 
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(uuid,ACTIVEIT_2017_YUNCHAN);
		if(distirbutor != null){
			List<HashMap<String, Object>> list = manager.getSignupByDid(distirbutor.getId(),ACTIVEIT_2017_YUNCHAN);
			float money = 0;
			for (HashMap<String, Object> signmap : list) {
				String dmoney=signmap.get("dmoney").toString();
				money+=Float.parseFloat(dmoney);
				if( signmap.get("createtime") != null ){
					signmap.put("createtime",signmap.get("createtime").toString().substring(0, 10));
				}
			}
			BigDecimal b=new BigDecimal(money); 
			distirbutor.setMoney(b.setScale(2,BigDecimal.ROUND_HALF_UP).toString());		    
			map.put("count", list.size());
			map.put("distributor", distirbutor);
			map.put("list", list);
		}
		return new ModelAndView("/ksite/active/yc/money",map);
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


	/**
	 * 瘦身集训营首页
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/yc{aid}.html")
	public ModelAndView phyIndex(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("aid") String aid
			) {  
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/w/yc"+aid+".html"; 
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		Weixin_blog_user user = getWeixinSession( request,session );
		map.put("nologin", user == null);
		if( from!=null && !from.equals("") ){
			url+="?from="+from;
		}
		if( isappinstalled!=null && !isappinstalled.equals("") ){
			url+="&isappinstalled="+isappinstalled;
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
			jsapiSignatureURL (map,url,token[2] );
		}
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		map.put("courselist", manager.getPActivityList("AND aid = "+aid+"  ORDER BY sort ASC", 1, 40));
		return new ModelAndView("/ksite/active/yc/courselist",map );
	}


	/**
	 * 明细课程
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @
	 */
	@RequestMapping(value = "w/yc/item/{id}.html")
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
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from!=null && !from.equals("") ){
			url+="?from="+from;
		}
		if( isappinstalled!=null && !isappinstalled.equals("") ){
			url+="&isappinstalled="+isappinstalled;
		}
		map.put("isfollow",    0); 
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
			jsapiSignatureURL (map,url,token[2] );
		}
		map.put("isbuy", false); 
		Weixin_phy_activity activeity = manager.getPActivity( id );
		if( token == null || activeity == null){
			return goIndexHome();
		}
		map.put("isbuy", false);
		if( user != null && user.getId() > 0 ){
			map.put("isfollow", checkUserHasFollow(user)?1:2 ); // 用户是否关注瑜是乎
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVEIT_2017_YUNCHAN);
			if( signup != null && signup.getRefund() == 0 && signup.getDel() != 1 ){
				map.put("isbuy", true);
			}
		}else{
			user = new Weixin_blog_user();
			removeSession( session );
		}
		if( activeity != null && activeity.getId() > 0 ){
			map.put("course",  activeity);
			map.put("teacher", weixin.getWeixinUser( activeity.getTid()) );
			map.put("socketaddress", Config.getString("websocket.address") );

			if( activeity.getTid() == user.getId()){
				map.put("isbuy", true);
			}
			if( activeity.getHolderids() != null ){
				String [] holder = activeity.getHolderids().split(",");
				for( String h : holder ){
					if( h.equals( user.getId()+"") ){
						map.put("isbuy", true);
						break;
					}
				}
			}
			if( activeity.getTeacherids() != null ){
				String [] teacher = activeity.getTeacherids().split(",");
				for( String t : teacher ){
					if( t.equals( user.getId()+"") ){
						map.put("isbuy", true);
						break;
					}
				}
			}
		}
		map.put("user",       user);  
		map.put("nologin",    user == null);
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey) );
		if( activeity.getStatus() == 2){
			return new ModelAndView("/ksite/active/yc/course_his",map );				
		}else{
			return new ModelAndView("/ksite/active/yc/course",map );
		}
	}
	
	/**
	 * 课代表填写信息
	 * @param session
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/faq/yc/distributor/info.html")
	public ModelAndView addInfo(
			HttpSession            session, 
			HttpServletRequest     request
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url  = DOMAIN+"/w/faq/yc/distributor/info.html"; 
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from!=null && !from.equals("") ){
			url+="?from="+from;
		}
		if( isappinstalled!=null && !isappinstalled.equals("") ){
			url+="&isappinstalled="+isappinstalled;
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
			jsapiSignatureURL (map,url,weixin.getToken()[2] );
		} 
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_user user = getWeixinSession( request,session ); 
		if(user != null){
			map.put("nologin", false);
			Weixin_blog_distributor_info disInfo = weixin.getDisInfo(user.getId());
			if(disInfo != null){
				map.put("isadd", true);
				map.put("user", user);
				map.put("disInfo", disInfo);
			}else{
				map.put("isadd", false);
			}
		}else{
			map.put("nologin", true);
		}
		return new ModelAndView("/ksite/active/yc/info_add",map);
	}
	
	/**
	 * 保存课代表信息
	 * @param session
	 * @param request
	 * @param response
	 * @param name
	 * @param phone
	 * @return
	 */
	@RequestMapping(value = "w/faq/distributor/info.html")
	public @ResponseBody JSONObject addDistributorInfo(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			){
		String name = this.trim( request.getParameter("name") );
		String phone= this.trim( request.getParameter("phone") );
		JSONObject result = new JSONObject();
		Weixin_blog_distributor_info disInfo = new Weixin_blog_distributor_info();
		Weixin_blog_user user = getWeixinSession( request,session );
		if(user != null){
			if(name.length()>10){
				result.put("satatus", false);
				result.put("msg", "请输入正确姓名！");
				return result;
			}
			if(phone.length()>11){
				result.put("satatus", false);
				result.put("msg", "请输入正确手机号！");
				return result;
			}
			disInfo.setCname(name);
			disInfo.setMobile(phone);
			disInfo.setWid(user.getId());
			disInfo.setWxid(user.getWxid());
			disInfo.setCreatetime(getTime());
		}else{
			result.put("satatus", false);
			result.put("msg", "请先登录！");
			return result;
		}
		int infoid = weixin.addOrUpdateDisInfo(disInfo);
		result.put("status",  infoid > 0);
		return result;
	}
}
