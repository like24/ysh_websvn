package com.yoga.controller.v2.activity;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping; 
import org.springframework.web.servlet.ModelAndView;

import com.yoga.controller.v2.R;
import com.yoga.dao.Weixin_blog_user;
 
/**
 * 为推广掌管APP所做的活动，即：
 * 在瑜是乎添加经销商，每个经销商拿着自己的推广链接去推广，被推广者注册后，完成推广操作；
 * 推广者会从云平台查到自己的推广效果，并赠送相关礼品或课程等
 * @author king
 */
@Controller
public class WeixinActivityForSaasAppController extends R {

	/**
	 * 
	 * @param id
	 * @param session
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "w/extension/{uuid}.html")
	public ModelAndView appDistributor(
			@PathVariable("uuid")  String uuid,
			HttpSession            session, 
			HttpServletRequest     request,
			HttpServletResponse    response
			) throws Exception{
		Weixin_blog_user user = getWeixinSession( request,session );
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("uuid",       uuid);
		String url = DOMAIN+"/w/extension/"+uuid+".html"; 
		jsapiSignatureURL (map,url,weixin.getToken()[2] );
		map.put("extension",  manager.getDistributorByApp(uuid));
		map.put("nologin",    user == null);
		return new ModelAndView("/ksite/active/extension_app/index",map ); 
	}
}
