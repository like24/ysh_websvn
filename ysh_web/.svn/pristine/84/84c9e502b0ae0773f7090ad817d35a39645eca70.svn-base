package com.yoga.filter;

import com.yoga.controller.v2.R;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.utils.AESUtil;
import com.yoga.utils.Config;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class WeixinUserFilter extends HandlerInterceptorAdapter {
    /**
     * 拦截器
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse res, Object handler) throws Exception {
        Weixin_blog_user user = (Weixin_blog_user) request.getSession().getAttribute(com.yoga.controller.v2.R.WEIXIN_SESSSION_KEY);


        if (null == user) {
            StringBuffer reqUrl = request.getRequestURL();
            String param = request.getQueryString();
            if (param != null && param.length() > 0) {
                reqUrl.append("?").append(param);
            }
            if (reqUrl.toString().indexOf("/authorize.html")>-1||reqUrl.toString().indexOf("/smjia.html")>-1||reqUrl.toString().indexOf("order/notify.html")>-1){
                return true;
            }
            String url = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + Config.getString("weixin.appid") + "&redirect_uri=" + Config.getString("domain") + "/" + AESUtil.Encrypt(reqUrl.toString(), R.cKey) + "/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
            res.sendRedirect(url);
            return false;
        }


        request.setAttribute("wxuser", user);
        request.setAttribute("nologin", user == null);
        return true;
    }

}
