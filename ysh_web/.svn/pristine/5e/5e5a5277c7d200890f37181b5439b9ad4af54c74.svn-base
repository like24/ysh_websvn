package com.yoga.controller.v2;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import com.yoga.weixin.pay.ConfigUtil;
import com.yoga.weixin.pay.PayCommonUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.controller.v2.api.QCode;
import com.yoga.dao.Weixin_blog_distributor_signup;
import com.yoga.dao.Weixin_blog_saler;
import com.yoga.dao.Weixin_blog_saler_order;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.dao.Weixin_blog_user_logger;
import com.yoga.dao.Weixin_blog_zhibo;
import com.yoga.dao.Weixin_blog_zhibo_item;
import com.yoga.utils.AESUtil;
import com.yoga.utils.Config;
import com.yoga.utils.Pagination;

import net.sf.json.JSONObject;

/**
 * 直播相关Controller
 * 
 * @author king
 *
 */
@SuppressWarnings("all")
@Controller
public class WeixinV2LiveController extends R {

	/**
	 * 直播更多页面
	 * 
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/live/more.shtml")
	public ModelAndView v2LiveMore(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/v2/live/more.shtml";
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if (from != null && !from.equals("")) {
			url += "?from=" + from;
		}
		if (isappinstalled != null && !isappinstalled.equals("")) {
			url += "&isappinstalled=" + isappinstalled;
		}
		Weixin_blog_user user = getWeixinSession(request, session);
		map.put("nologin", user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/index", map);
	}

	/**
	 * 直播页面
	 * 
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/live/{sid}.shtml")
	public ModelAndView v2Live(
			@PathVariable("sid") int sid, 
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/v2/live/more.shtml";
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if (from != null && !from.equals("")) {
			url += "?from=" + from;
		}
		if (isappinstalled != null && !isappinstalled.equals("")) {
			url += "&isappinstalled=" + isappinstalled;
		}
		Weixin_blog_user user = getWeixinSession(request, session);
		map.put("nologin", user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/index", map);
	}

	/**
	 * 
	 * @Title: v2ListMore 
	 * @Description: TODO(获取直播大厅数据) 
	 * @return ModelAndView
	 * 返回类型 @throws
	 */
	@RequestMapping(value = "v2/live/list.shtml")
	public ModelAndView list(HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN + "/v2/live/list.shtml";
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");

		if (from != null && !from.equals("")) {
			url += "?from=" + from;
		}
		if (isappinstalled != null && !isappinstalled.equals("")) {
			url += "&isappinstalled=" + isappinstalled;
		}

		Weixin_blog_user user = getWeixinSession(request, session);
		map.put("nologin", user == null);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/more/livelist", map);
	}

	/**
	 * @Title: detail 
	 * @Description: 获取直播详情 
	 * @return ModelAndView 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "pay/live/detail/{money}_{zhiboId}.shtml")
	public ModelAndView detail(
			@PathVariable("zhiboId") int zhiboId,
			@PathVariable("money") String money,
			@RequestParam(value = "p", required = false, defaultValue = "0") int p,
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response
			) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession(request, session);
		boolean hasJoin = false;
		String url = Config.getString("domain") + request.getRequestURI();
		String backUrl = url;
		if (request.getQueryString() != null){
			url+="?"+request.getQueryString();
		}

		System.out.println("分享加签地址："+url);

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
		if( user != null && user.getId() > 0 ){
			Weixin_blog_saler_order signup = saler.getSignup(user.getId(), zhiboId );
			if( signup != null && signup.getRefund() == 0 ){
				hasJoin = true;
			}else{
				String appId     = map.get("appid")+"";
				String nonceStr  = map.get("nonceStr")+"";
				String timestamp = map.get("timestamp")+"";
				BigDecimal v1 = new BigDecimal(money);
				v1.setScale(2);
				v1 = v1.multiply(new BigDecimal(100));
				Object[] payInfo = PayCommonUtil.getPrepay_id("直播课程ID"+zhiboId, nonceStr,String.valueOf(v1.intValue()), "1000", user.getWxid() );
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
					map.put("nologin",user == null);
				}
			}
		}else{
			map.put("nologin", true);
		}

		List<HashMap<String,Object>> tList = live.getZhiboTeacherList(zhiboId);
		for(HashMap teacher:tList){
			if (user.getId() == Integer.parseInt(teacher.get("id").toString())){
				hasJoin = true;
				break;
			}
		}
		List<HashMap<String,Object>> tAhList = live.getTHByZid(zhiboId);
		for(HashMap tah:tAhList){
			String[] teacherids = tah.get("teacherids").toString().split(",");
			String[] holderids = tah.get("holderids").toString().split(",");
			for(String a:teacherids){
				if(a != null && !a.equals("")) {
					if (user.getId() == Integer.parseInt(a)) {
						hasJoin = true;
						break;
					}
				}
			}
			for(String b:holderids){
				if(b != null && !b.equals("")){
					if(user.getId() == Integer.parseInt(b)){
						hasJoin = true;
						break;
					}
				}
			}
		}




		map.put("hasJoin",hasJoin);
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		map.put("zid", zhiboId);
		map.put("uid", user.getId());
		map.put("appid", Config.getString("weixin.appid"));
		map.put("buycount",saler.getCountNum(zhiboId));
		map.put("BACKURL",backUrl+"?p="+user.getId());
		map.put("zhibo",live.getZhiboDetail(zhiboId));

		return new ModelAndView("/ksite/more/liveDetail", map);
	}
	
	/**
	 * @Title: detail 
	 * @Description: 获取分销商list
	 * @return ModelAndView 返回类型 
	 * @throws
	 */
	@RequestMapping(value = "v2/live/saler/{zhiboId}.shtml")
	public ModelAndView salerList(
			@PathVariable("zhiboId") int zhiboId,
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response
			) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession(request, session);
		if(user == null ){
			map.put("nologin", true);
		}
		String url = DOMAIN + "/v2/live/saler/" + zhiboId + ".shtml";
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if (from != null && !from.equals("")) {
			url += "?from=" + from;
		}
		if (isappinstalled != null && !isappinstalled.equals("")) {
			url += "&isappinstalled=" + isappinstalled;
		}
		map.put("urlsecret", AESUtil.Encrypt(url, R.cKey));
		map.put("zid", zhiboId);
		map.put("uid", user.getId());
		return new ModelAndView("/ksite/more/liveSaler", map);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "v2/live/saler/getList/{uid}/{zid}.json")
	public HashMap<String, ?> getSalerList(
			@PathVariable("uid") int uid,
			@PathVariable("zid") int zid,
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		String pageNo = request.getParameter("pageNo");
//		String zhiboIdStr = request.getParameter("zhiboId");
//		String salerid = request.getParameter("uid");
		if (StringUtils.isBlank(pageNo)) {
			pageNo = "1";
		}
		int page = Integer.parseInt(pageNo);
		int pageSize = 10;
		boolean isSaler = false ; 
		String filter = " AND sd.productid="+zid+" GROUP BY sd.salerid ORDER BY SUM(sd.money_) DESC";
		Pagination salerPage = live.getSalerList(filter, page, pageSize);
		if(uid != 0){
			Weixin_blog_saler saler = live.getSaler(uid);
			if(saler != null){
				isSaler = true ;
				HashMap<String, Object> salerOrder = live.getSalerOrder(uid, zid);
				map.put("saler", salerOrder);
			}
		}
		map.put("status", true);
		map.put("code", QCode.SUCCESS.getCode());
		map.put("msg", QCode.SUCCESS.getMsg());
		map.put("issaler", isSaler);
		map.put("data", salerPage.getResults());
		map.put("totalcount", salerPage.getTotalCount());
		return map;
	}
	

	@ResponseBody
	@RequestMapping(value = "v2/live/getList.json")
	public HashMap<String, ?> getZhiboList(
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		String pageNo = request.getParameter("pageNo");
		if (StringUtils.isBlank(pageNo)) {
			pageNo = "1";
		}
		int page = Integer.parseInt(pageNo);
		int pageSize = 20;
		String filter = " ORDER BY STATUS DESC,starttime";
		Pagination resPage = live.getZhiboList(filter, page, pageSize);
		map.put("status", true);
		map.put("code", QCode.SUCCESS.getCode());
		map.put("msg", QCode.SUCCESS.getMsg());
		map.put("data", resPage.getResults());
		map.put("totalcount", resPage.getTotalCount());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "v2/live/getDetail.json")
	public HashMap<String, ?> getZhiboDetail(
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		String pageNo = request.getParameter("pageNo");
		String zhiboIdStr = request.getParameter("zhiboId");
		String filter = "";
		if (StringUtils.isBlank(pageNo)) {
			pageNo = "1";
		}
		if (zhiboIdStr != null) {
			Weixin_blog_zhibo zhibo = live.getZhiboDetail(Integer.parseInt(zhiboIdStr));
			map.put("zhibo", zhibo);
			filter = " AND sd.productid="+zhiboIdStr+" GROUP BY sd.salerid ORDER BY SUM(sd.money_) DESC";
			Pagination page = live.getSalerList(filter, Integer.valueOf(pageNo), 10);
			map.put("salerlist", page.getResults());
			map.put("totlesaler", page.getTotalCount());
		}
		return map;
	}
	

	@RequestMapping(value = "v2/live/item/list.json")
	@ResponseBody
	public HashMap<String, ?> getItemList(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		String pageNo = request.getParameter("pageNo");
		String zhiboIdStr = request.getParameter("zhiboId");
		if (StringUtils.isBlank(pageNo)) {
			pageNo = "1";
		}
		int page = Integer.parseInt(pageNo);
		int pageSize = 20;
		if (zhiboIdStr != null) {
			List<HashMap<String, Object>> list = live.getZhiboItemList(Integer.parseInt(zhiboIdStr), page, pageSize);
			map.put("list", list);
		}
		return map;
	}

	
	@RequestMapping(value = "v2/live/teacher/list.json")
	@ResponseBody
	public HashMap<String, ?> getTeacherList(HttpSession session, HttpServletRequest request,
			HttpServletResponse response) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession(request, session);
		String pageNo = request.getParameter("pageNo");
		String zhiboIdStr = request.getParameter("zhiboId");
		if (StringUtils.isBlank(pageNo)) {
			pageNo = "1";
		}
		if (zhiboIdStr != null) {
			List<HashMap<String, Object>> list = live.getZhiboTeacherList(Integer.parseInt(zhiboIdStr));
			for (HashMap<String, Object> teacher : list) {
				if (user != null && user.getId() > 0) {
					if (teacher.get("id") != null && !teacher.get("id").equals("0")) {
						boolean follow = weixin.isFollowUser(user.getId(), Integer.parseInt(teacher.get("id") + ""));
						teacher.put("followuser", follow);
					}
				}
			}
			map.put("list", list);
		}
		return map;
	}

	/**
	 * 
	 * @param user
	 * @return
	 */
	public boolean checkUserHasFollow(Weixin_blog_user user) {
		boolean result = false;
		if (user == null || user.getWxid() == null) {
			return result;
		}
		Object[] token = weixin.getToken();
		if (token == null || token.length == 2 || token[0] == null) {
			token = weixin.getToken();
		}
		if (token == null || token.length == 2 || token[0] == null) {
			token = weixin.getToken();
		}
		if (token == null || token.length == 2 || token[0] == null) {
			token = weixin.getToken();
		}
		if (token != null && token.length > 2) {
			String url = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + token[0] + "&openid="
					+ user.getWxid() + "&lang=zh_CN";
			JSONObject json = JSONObject.fromObject(httpClient.doGet(url));
			if (json == null) {
				return result;
			}
			if (json.containsKey("subscribe")) {
				return json.getInt("subscribe") == 1;
			}
		}
		return result;
	}

	 /**
	 * 预生成订单
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	 @RequestMapping(value = "v2/live/zhibo/info.json")
	 public @ResponseBody JSONObject zhiboOrder(
		 HttpSession session,
		 HttpServletRequest request,
		 HttpServletResponse response
		 ){
		 String name = this.trim( request.getParameter("name") );
		 String phone= this.trim( request.getParameter("phone") );
		 String sid = this.trim( request.getParameter("sid") );
		 String ordernumber = this.trim( request.getParameter("ordernumber") );
		 String pwd = this.trim( request.getParameter("pwd") );
		 String loggerid = this.trim( request.getParameter("loggerid"));
		 String m = this.trim(request.getParameter("money"));
		 String zid = this.trim(request.getParameter("zid"));
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
		 BigDecimal money = new BigDecimal( m );
		 String str = myformat.format( money );
		 if( res > 0 ){
			 setUserSession(user, response);
			 SimpleDateFormat f = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			 Weixin_blog_saler_order order = new Weixin_blog_saler_order();
			 Weixin_blog_zhibo zhibo = new Weixin_blog_zhibo();
			 if(zid != null && !zid.equals("0")){
			 zhibo = manager.getZhibo(Integer.parseInt(zid));
			 }
			 order.setBuyername(user.getRealname());
			 order.setBuyerid(user.getId());
			 order.setMobile(user.getMobile());
			 order.setMoney( new BigDecimal(zhibo.getMoney() ));
			 order.setBuyerid(user.getId());
			 order.setCreatetime(f.format(new Date()));
			 order.setRefund(-1);
			 order.setProductname( zhibo.getName() );
			 order.setOrdernumber(ordernumber);
			 order.setProducttype(2);
			 order.setProductid(zhibo.getId());
			 order.setFcbl(zhibo.getFcbl());
			 order.setMoney_(new BigDecimal(str));
			 order.setBuyerid(user.getId());
			 order.setBuywxid(user.getWxid());
			 order.setLoggerid( loggerid.length() == 0 ? 0 :Integer.valueOf( loggerid ) );
			 if(sid != null && !sid.equals("0")){
				 Weixin_blog_saler saler = live.getSaler(Integer.valueOf(sid));
				 if(saler != null){
					 order.setSalerid(Integer.parseInt(sid));
					 order.setSalername(saler.getSalename());
					 order.setSalerwxid(saler.getSalerwxid());
				 }
			 }
			 if( loggerid.length() > 0 ){
				 Weixin_blog_user_logger logger = weixin.getLogger( Integer.valueOf( loggerid ));
				 if( logger != null ){
					 if( logger.getWxordernum() != null && logger.getWxordernum().length() > 5 ){
						 	order.setWxordernum( logger.getWxordernum() );
					 }
				 }
			 }
			 int orderid = live.addOrUpdateZhiboOrder(order);
			 result.put("status", orderid > 0);
			 result.put("signupid", orderid);
		}
		 return result;
	 }
	 
	 /**
	  * 支付成功修改订单
	  * @param session
	  * @param request
	  * @param response 
	  * @param sid
	  * @return
	  */
	 @RequestMapping(value = "w/payforsignup/{oid}.html", method = RequestMethod.POST)
		public @ResponseBody JSONObject addSignup(
				HttpSession            session, 
				HttpServletRequest     request,
				HttpServletResponse    response,
				@PathVariable("oid") Integer oid
				){
		 	String sid = this.trim( request.getParameter("sid") );
			JSONObject result = new JSONObject();
			if(oid == null){
				result.put("status", false);
				return result;			
			}
			Weixin_blog_user user = getWeixinSession( request,session );
			if(user == null){
				result.put("status", false);
				return result;
			}
			
			Weixin_blog_saler_order order = live.getSalerOrder(oid);
			order.setRefund(0);
			if(live.addOrUpdateZhiboOrder(order) > 0){
				if(sid != null){
					Weixin_blog_saler saler = live.getSaler(Integer.valueOf(sid));
					saler.setTotlemoney(saler.getTotlemoney()+order.getMoney_());
					saler.setMoney(saler.getMoney()+order.getMoney_());
					saler.setSalecount(saler.getSalecount()+1);
					live.addOrUpdateSaler(saler);
				}
				result.put("status", true);
			}
			return result;
		}
	 

	/**
	 * 直播间页面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/live/zhibo/item{id}.shtml")
	public ModelAndView zhibo(
			@PathVariable("id") int id,
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response
			) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		if( id <= 0 ){
			return goIndexHome();
		} 
		Weixin_blog_user user = getWeixinSession( request,session );
		String url = DOMAIN+ request.getRequestURI();
		if (request.getQueryString() != null){
			url+="?"+request.getQueryString();
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


		Weixin_blog_zhibo_item zhiboItem = live.getZhiboItem(id);
		Weixin_blog_zhibo zhibo = live.getZhiboDetail(zhiboItem.getZid());
		Weixin_blog_saler_order salerOrder = saler.getSignup(user.getId(),zhibo.getId());
		if (null == salerOrder){

			map.put("isbuy", false);
		}else{
			map.put("isbuy", true);
		}
		if( token == null || zhiboItem == null){
			return goIndexHome();
		}
//		map.put("isbuy", false);
		if( user != null && user.getId() > 0 ){
			map.put("isfollow", checkUserHasFollow(user)?1:2 ); // 用户是否关注瑜是乎
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVEIT_2017_YUNCHAN);
			if( signup != null && signup.getRefund() == 0 && signup.getDel() != 1 ){
//				map.put("isbuy", true);
			}
		}else{
			user = new Weixin_blog_user();
			removeSession( session );
		}
		if( zhiboItem != null && zhiboItem.getId() > 0 ){
			map.put("course",  zhiboItem);
			map.put("teacher", weixin.getWeixinUser( zhiboItem.getTid()) );
			map.put("socketaddress", Config.getString("websocket.address") );
			if( zhiboItem.getTid() == user.getId()){
//				map.put("isbuy", true);
			}
			if( zhiboItem.getHolderids() != null ){
				String [] holder = zhiboItem.getHolderids().split(",");
				for( String h : holder ){
					if( h.equals( user.getId()+"") ){
//						map.put("isbuy", true);
						break;
					}
				}
			}
			if( zhiboItem.getTeacherids() != null ){
				String [] teacher = zhiboItem.getTeacherids().split(",");
				for( String t : teacher ){
					if( t.equals( user.getId()+"") ){
//						map.put("isbuy", true);
						break;
					}
				}
			}
		}
		List<HashMap<String,Object>> tList = live.getZhiboTeacherList(zhibo.getId());
		for(HashMap teacher:tList){
			if (user.getId() == Integer.parseInt(teacher.get("id").toString())){
				map.put("isbuy", true);
				break;
			}
		}
		List<HashMap<String,Object>> tAhList = live.getTHByZid(zhibo.getId());
		for(HashMap tah:tAhList){
			String[] teacherids = tah.get("teacherids").toString().split(",");
			String[] holderids = tah.get("holderids").toString().split(",");
			for(String a:teacherids){
				if(a != null && !a.equals("")) {
					if (user.getId() == Integer.parseInt(a)) {
						map.put("isbuy", true);
						break;
					}
				}
			}
			for(String b:holderids){
				if(b != null && !b.equals("")){
					if(user.getId() == Integer.parseInt(b)){
						map.put("isbuy", true);
						break;
					}
				}
			}
		}


		map.put("user",       user);  
		map.put("nologin",    user == null);
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey) );
		String money = zhibo.getMoney();
		if (money.indexOf(".")>-1){
			money = money.substring(0,money.indexOf("."));
		}
		map.put("backurl", Config.getString("domain")+"/pay/live/detail/"+money+"_"+zhibo.getId()+".shtml");
		map.put("courseName", zhibo.getName());
		map.put("courseDsc",zhibo.getRemark());
		map.put("courseImg",zhibo.getLogo());
		map.put("roomStatus",zhiboItem.getStatus());
		return new ModelAndView("/ksite/active/live/index",map );
	}

	/**
	 * 关闭直播间
	 */
	@RequestMapping(value = "v2/live/zhibo/closeroom{id}.json")
	@ResponseBody
	public HashMap closeRoom(
			@PathVariable("id") int id,
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response
	){
			live.closeRoom(id);
		return null;
	}

	/**
	 * 保存成分销商
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/live/besaler.json")
	public @ResponseBody JSONObject salerInfo(
			HttpSession session, 
			HttpServletRequest request,
			HttpServletResponse response
			) {
		JSONObject object = new JSONObject();
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		Weixin_blog_user user = getWeixinSession(request, session);
		Weixin_blog_saler saler = null;
		if (user != null && user.getId() > 0) {
			saler = live.getSaler(user.getId());
			System.out.println(saler);
			if(saler != null && saler.getId() > 0){
				object.put("status", true);
			}else{
				saler = new Weixin_blog_saler();
				saler.setSalerid(user.getId());
				saler.setSalename(user.getNickname()); 
				saler.setSalerwxid(user.getWxid());
				saler.setMobile(user.getMobile());
				saler.setCreatetime(getTime());
				int sid = live.addOrUpdateSaler(saler);
				object.put("status", sid > 0);
			}
		}
		object.put("code", QCode.SUCCESS.getCode());
		object.put("msg", QCode.SUCCESS.getMsg());
		return object;
	}

}
