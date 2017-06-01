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

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.yoga.controller.v2.R;
import com.yoga.dao.Weixin_blog_distributor;
import com.yoga.dao.Weixin_blog_distributor_signup;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.dao.Weixin_blog_user_logger;
import com.yoga.utils.AESUtil;
import com.yoga.weixin.pay.ConfigUtil;
import com.yoga.weixin.pay.PayCommonUtil;

import net.sf.json.JSONObject;
/**
 * 印度大会，线上课程售卖活动，在瑜是好做分销，然后去掌管app听课
 * @author king
 *
 */
@Controller
public class WeixinActivityForIndeaController extends R {


	/**
	 * 经销商推广链接
	 * @param session
	 * @param request
	 * @param response
	 * @param sign
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("w/faq/india{uuid}.html")
	public ModelAndView indiaActivityIndex(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response,
			@PathVariable("uuid")  String uuid
			) throws Exception{
		String money = String.valueOf((int)(ACTIVITY_INDIA_MONEY*100));
		if( uuid != null ){
			Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(uuid, ACTIVITY_INDIA);
			if( distirbutor == null ){
				uuid = "YSH";
			}
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url            = DOMAIN+"/w/faq/india"+uuid+".html"; 
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from!=null && !from.equals("") ){
			url += "?from="+from+"&isappinstalled="+isappinstalled;
		}
		Object [] token = weixin.getToken();
		if( token == null ){
			token = weixin.getToken();
		}
		if( token == null || token.length == 0 ){
			goIndexHome();
		}
		jsapiSignatureURL ( map,url,token[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_user user = getWeixinSession( request,session ); 
		boolean hasJoin = false;
		boolean nologin = false;
		if( user != null ){
			Weixin_blog_distributor_signup signup = manager.getSignup(user.getId(), ACTIVITY_INDIA); 
			if( signup != null && signup.getRefund() == 0 ){
				hasJoin=true; 
			}
			String appId=map.get("appid").toString();
			String nonceStr =map.get("nonceStr").toString();
			String timestamp =map.get("timestamp").toString();
			Object[] payInfo = PayCommonUtil.getPrepay_id(ACTIVITY_INDIA_NAME, nonceStr,money, "", user.getWxid());
			String prepayid = payInfo[1].toString();
			String ordernumber = payInfo[0].toString();
			Map<String ,String >    signMap=new HashMap<String ,String >();
			signMap.put("appId",   appId);
			signMap.put("timeStamp",timestamp);
			signMap.put("package", "prepay_id="+prepayid);
			signMap.put("signType", "MD5");
			signMap.put("nonceStr", nonceStr);
			map.put("appId",appId);
			map.put("timeStamp",    timestamp);
			map.put("nonceStr",     nonceStr);
			map.put("paytimestamp", timestamp);
			map.put("paypackage",   "prepay_id="+prepayid);
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
		map.put("money",ACTIVITY_INDIA_MONEY);
		map.put("sign", uuid);
		return new ModelAndView("/ksite/active/india/index",map);
	}


	/**
	 * 经销商查看自己的收益
	 * @param session
	 * @param request
	 * @param did
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/faq/india/money/{uuid}.html")
	public ModelAndView indiaActivityMoney(
			HttpSession            session, 
			HttpServletRequest     request,
			@PathVariable("uuid") String uuid
			) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url  = DOMAIN+"/w/faq/india/money/"+uuid+".html"; 
		String from = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from!=null && !from.equals("") ){
			url+="?from="+from+"&isappinstalled="+isappinstalled;
		}
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		Weixin_blog_distributor distirbutor = manager.getDistributorByUUid(uuid,ACTIVITY_INDIA);
		if(distirbutor != null){
			List<HashMap<String, Object>> list = manager.getSignupByDid(distirbutor.getId(),ACTIVITY_INDIA);
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
		return new ModelAndView("/ksite/active/india/money",map);
	}



	/**
	 * 购买成功后的成功页面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("w/faq/india/success.html")
	public ModelAndView indiaActivitySuccess(
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url   = DOMAIN+"/w/faq/india/success.html"; 
		String from  = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url+="?from="+from+"&isappinstalled="+isappinstalled;
		}
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("urlsecret",  AESUtil.Encrypt(url, R.cKey));
		return new ModelAndView("/ksite/active/india/success",map);
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
	@RequestMapping(value = "w/faq/india/info.html")
	public @ResponseBody JSONObject indiaActivitySaveSignup(
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
		String str = myformat.format(ACTIVITY_INDIA_MONEY);    
		String money= String.valueOf(str);
		if( res > 0 ){
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
			signup.setCcname(ACTIVITY_INDIA_NAME);
			signup.setOrdernumber(ordernumber);
			signup.setActtype(ACTIVITY_INDIA);
			signup.setUnionid(user.getUnionid());
			signup.setChecked(0);
			Weixin_blog_distributor distirbutor = null;
			if(sign != null){
				distirbutor = manager.getDistributorByUUid(sign, ACTIVITY_INDIA);
			}
			if(distirbutor != null && distirbutor.getStatus() == 0){
				signup.setDid(distirbutor.getId());
				signup.setDname(distirbutor.getCname());
				signup.setFcbl(distirbutor.getFcbl());
				try {
					String[] nums = distirbutor.getFcbl().split("/");
					int rate = Integer.parseInt(nums[0]);
					int rate2 = Integer.parseInt(nums[1]);
					float dmoney = ACTIVITY_INDIA_MONEY * rate/10;
					float pmoney = ACTIVITY_INDIA_MONEY * rate2/10;
					signup.setDmoney(dmoney + "");
					signup.setPmoney(pmoney + "");
				} catch (Exception e) {
				}
				weixin.updateVerificationNumber(phone, pwd);
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
	@RequestMapping(value = "w/faq/india/pay/{sid}.html", method = RequestMethod.POST)
	public @ResponseBody JSONObject indiaActivitySendMsgSuccess(
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
		int offcet = manager.addOrUpdateSignup(signup);
		if( offcet> 0){
			Weixin_blog_user_logger log = weixin.getLogger(logid);
			log.setOrdernumber(ordernumber);
			log.setIsgiveup(1);
			weixin.addOrUpdateUserLogger( log );
			String msg = "亲，您已成功购买中印瑜伽大会课程。请登录APP【随心瑜掌馆】学习页面进行听课，APP下载：http://t.cn/RcT79aZ。如有疑问请与400-018-6161联系。";
			weixin.sendMSM(phone, msg);
		}
		result.put("status", true);
		return result;
	}
}
