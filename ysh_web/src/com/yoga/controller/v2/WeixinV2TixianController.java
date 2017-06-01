package com.yoga.controller.v2;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yoga.dao.Weixin_blog_saler_balance;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.utils.Pagination;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
//		Weixin_blog_user user = getWeixinSession( request,session );
//		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/my/tixian",map );
	}

	/**
	 * 收益明细页面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/my/earning.shtml")
	public ModelAndView earningInfo(
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response
	) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/my/earning.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
//		Weixin_blog_user user = getWeixinSession( request,session );
//		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/my/earninginfo",map );
	}

	/**
	 * 提现明细页面
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "v2/my/enchashment.shtml")
	public ModelAndView enchashmentInfo(
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response
	) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		String url = DOMAIN+"/v2/my/enchashment.shtml";
		String from           = request.getParameter("from");
		String isappinstalled = request.getParameter("isappinstalled");
		if( from != null && !from.equals("") ){
			url += "?from="+from;
		}
		if( isappinstalled != null && !isappinstalled.equals("") ){
			url += "&isappinstalled="+isappinstalled;
		}
//		Weixin_blog_user user = getWeixinSession( request,session );
//		map.put("nologin",   user == null );
		map.put("urlsecret", AESUtil.Encrypt( url, R.cKey ) );
		return new ModelAndView("/ksite/my/enchashmentinfo",map );
	}

	/**
	 * 我的收益明细
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="v2/my/earning.json")
	public HashMap<String,?> getOrderBysid(
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response
	){
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession( request,session );
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", saler.getSalerOrderList(""," AND salerid="+user.getId()+" AND producttype=2 ORDER BY createtime DESC ", 1, 1000).getResults()) ;
		}else{
			map.put("contentlist", new Pagination().getResults() );
		}

		return map;
	}

	/**
	 * 提现
	 */
	@RequestMapping(value="v2/my/tixian.json")
	@ResponseBody
	public HashMap<String,Object> tixian(
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response
	){
		HashMap<String,Object> map = new HashMap<String,Object>();
		response.setHeader("Access-Control-Allow-Origin",  "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		Weixin_blog_user user = getWeixinSession( request,session );
		BigDecimal money = new BigDecimal(request.getAttribute("money").toString());
		Weixin_blog_saler_balance salerBalance = new Weixin_blog_saler_balance();
		if( user != null && user.getId() > 0 ){
			salerBalance.setMoney(money);
			salerBalance.setSalerid(user.getId());
			salerBalance.setSalername(user.getNickname());
			salerBalance.setSalerwxid(user.getWxid());
			salerBalance.setCreatetime(getTime());
//			int sbid = saler.addOrUpdateSalerBlance(salerBalance);
//			map.put("status", sbid > 0);
//			map.put("sbid", sbid);
		}else{
			user = new Weixin_blog_user();
			removeSession( session );
			map.put("status",false);
			map.put("Msg","提现失败");
		}
		return map;
	}

	/**
	 * 我的提现明细
	 */
	@RequestMapping(value="v2/my/enchashment.json")
	@ResponseBody
	public HashMap<String,?> getEnchashmentListByUid(
			HttpSession            session,
			HttpServletRequest     request,
			HttpServletResponse    response
	) {
		response.setHeader("Access-Control-Allow-Origin", "*");
		response.setHeader("Access-Control-Allow-Methods", "POST");
		response.setHeader("Access-Control-Allow-Headers", "x-requested-with,content-type");
		HashMap<String, Object> map = new HashMap<String, Object>();
		Weixin_blog_user user = getWeixinSession(request, session);
		if( user != null && user.getId() > 0 ){
			map.put("contentlist", saler.getTixianListByUid(user.getId())) ;
		}else{
			map.put("contentlist", new Pagination().getResults() );
		}
		return map;
	}

}
