/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.43
 * Generated at: 2017-05-08 11:43:23 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views.ksite.more;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.yoga.dao.Weixin_blog_user;
import com.yoga.utils.Config;

public final class liveDetail_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(6);
    _jspx_dependants.put("jar:file:/Users/yinluyinlu/ysh_web/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ysh_web/WEB-INF/lib/standard-1.1.2.jar!/META-INF/c.tld", Long.valueOf(1098682290000L));
    _jspx_dependants.put("/WEB-INF/tld/tag.tld", Long.valueOf(1493898295000L));
    _jspx_dependants.put("jar:file:/Users/yinluyinlu/ysh_web/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ysh_web/WEB-INF/lib/standard-1.1.2.jar!/META-INF/fn.tld", Long.valueOf(1098682290000L));
    _jspx_dependants.put("jar:file:/Users/yinluyinlu/ysh_web/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/ysh_web/WEB-INF/lib/standard-1.1.2.jar!/META-INF/fmt.tld", Long.valueOf(1098682290000L));
    _jspx_dependants.put("/WEB-INF/views/ksite/more/../../taglibs.jsp", Long.valueOf(1493898310000L));
    _jspx_dependants.put("/WEB-INF/lib/standard-1.1.2.jar", Long.valueOf(1493898309000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("com.yoga.utils.Config");
    _jspx_imports_classes.add("com.yoga.dao.Weixin_blog_user");
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody;

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.release();
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      if (_jspx_meth_c_005fset_005f0(_jspx_page_context))
        return;
      if (_jspx_meth_c_005fset_005f1(_jspx_page_context))
        return;
      if (_jspx_meth_c_005fset_005f2(_jspx_page_context))
        return;
      if (_jspx_meth_c_005fset_005f3(_jspx_page_context))
        return;
      if (_jspx_meth_c_005fset_005f4(_jspx_page_context))
        return;
      if (_jspx_meth_c_005fset_005f5(_jspx_page_context))
        return;
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write(" <head>\n");
      out.write("\t<meta charset=\"UTF-8\">\n");
      out.write("\t<meta name=\"viewport\" content=\"initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no\">\n");
      out.write("\t<meta content=\"yes\" name=\"apple-mobile-web-app-capable\">\n");
      out.write("\t<meta content=\"yes\" name=\"apple-touch-fullscreen\">\n");
      out.write("\t<meta content=\"telephone=no,email=no\" name=\"format-detection\">\n");
      out.write("\t<title>瑜是乎 | 您想要学的课程都在这里</title>\n");
      out.write("\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/lib/setfontsize.min.js\"></script>\n");
      out.write("\t<link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/css/reset.css\" />\n");
      out.write("\t<link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/css/courseArrangement.css\" />\n");
      out.write("\t</head>\n");
      out.write("\n");
      out.write("\t<body >\n");
      out.write("\t\t<div class=\"wrapper bg-e4\" id=\"app\" v-clock>\n");
      out.write("\t\t\t<!--    iscroll滚动    -->\n");
      out.write("\t\t\t<section class=\"iscroll-box absolute ohidden iscroll-box1 iscroll-box2\" id=\"mainBox\">\n");
      out.write("\t\t\t\t<div class=\"iscrollBox \" id=\"pullUpWrapper\">\n");
      out.write("\t\t\t\t\t<header class=\"header\">\n");
      out.write("\t\t\t\t\t\t<div class=\"banner-box relative\">\n");
      out.write("\t\t\t\t\t\t\t<img :src=\"detaills.logo\" alt=\"\" class=\"img\" />\n");
      out.write("\t\t\t\t\t\t\t<p class=\"manLen absolute\"><i class=\"icon\"></i>{{detaills.buycount}}人报名</p>\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t<div class=\"courseInfo\">\n");
      out.write("\t\t\t\t\t\t\t<h1 class=\"ellipsis2 tit\">\n");
      out.write("\t\t\t\t\t\t\t\t{{detaills.name}}\n");
      out.write("\t\t\t\t\t\t\t</h1>\n");
      out.write("\t\t\t\t\t\t\t<span class=\"money\">\n");
      out.write("\t\t\t\t\t\t\t\t￥<big>{{detaills.money}}.00</big>\n");
      out.write("\t\t\t\t\t\t\t</span>\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t<div class=\"distributionEdition-box \">\n");
      out.write("\t\t\t\t\t\t\t<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/v2/live/saler/");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${zid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write(".shtml\" class=\"flex\">\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"distributionEdition\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<h4>分销榜</h4>\n");
      out.write("\t\t\t\t\t\t\t\t\t<p>{{totlesaler}}人</p>\n");
      out.write("\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t<div class=\"icon-box \">\n");
      out.write("\t\t\t\t\t\t\t\t\t<div class=\"flex\" id=\"iconBox\" >\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<img  v-for=\"item in shareLen\" :src=\"item.header\" alt=\"\" />\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t<i class=\"icon\"></i>\n");
      out.write("\t\t\t\t\t\t\t</a>\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t</header>\n");
      out.write("\t\t\t\t\t<!--介绍课程安排tab-->\n");
      out.write("\t\t\t\t\t<nav class=\"tab relative\" id=\"tab\">\n");
      out.write("\t\t\t\t\t\t<ul class=\"flex\">\n");
      out.write("\t\t\t\t\t\t\t<li class=\"curr\" @click=\"changeNav($event)\">介绍</li>\n");
      out.write("\t\t\t\t\t\t\t<span>|</span>\n");
      out.write("\t\t\t\t\t\t\t<li @click=\"changeNav($event)\" class=\"right\">课程安排</li>\n");
      out.write("\t\t\t\t\t\t</ul>\n");
      out.write("\t\t\t\t\t\t<div class=\"bottom absolute curr\"></div>\n");
      out.write("\t\t\t\t\t\t<div class=\"none\"></div>\n");
      out.write("\t\t\t\t\t\t<div class=\"bottom1 absolute\"></div>\n");
      out.write("\t\t\t\t\t</nav>\n");
      out.write("\t\t\t\t\t<div class=\"content\">\n");
      out.write("\t\t\t\t\t\t<!--介绍-->\n");
      out.write("\t\t\t\t\t\t<div class=\"jieshao-box \" id=\"jieshao\">\n");
      out.write("\t\t\t\t\t\t\t<div class=\"jieshao\">\n");
      out.write("\t\t\t\t\t\t\t\t<h2>内容介绍</h2>\n");
      out.write("\t\t\t\t\t\t\t\t<p>{{detaills.remark}}</p>\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t<!--导师-->\n");
      out.write("\t\t\t\t\t\t\t<div class=\"venue-box\">\n");
      out.write("\t\t\t\t\t\t\t\t<h2>老师介绍</h2>\n");
      out.write("\t\t\t\t\t\t\t\t<ul>\n");
      out.write("\t\t\t\t\t\t\t\t\t<li class=\"flex relative\"  v-for=\"(item,index) in teachs\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<img :src=\"item.file_path\" alt=\"\" />\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<div class=\"info\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<h3>{{item.nickname}}</h3>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<p class=\"ellipsis2\">{{item.remark}}</p>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<div class=\"btn-box\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<button class=\"yes\" v-show=\"item.followuser\" @click=\"gz(item.id,item.followuser,index)\" :data-a=\"item.followuser\"></button>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<button class=\"no\"  v-show=\"!item.followuser\" @click=\"gz(item.id,item.followuser,index)\" :data-a=\"item.followuser\">+关注</button>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<div class=\"absolute bottom\"></div>\n");
      out.write("\t\t\t\t\t\t\t\t\t</li>\n");
      out.write("\t\t\t\t\t\t\t\t</ul>\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t<!--课程安排 start-->\n");
      out.write("\t\t\t\t\t\t<div class=\"hot-recommend bg-fff m30 m-b none\" id=\"anpai\">\n");
      out.write("\t\t\t\t\t\t\t<div>\n");
      out.write("\t\t\t\t\t\t\t\t<dl class=\"item\" v-for=\"item in classList\">\n");
      out.write("\t\t\t\t\t\t\t\t\t<a :href=\"'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/w/faq/course.html?p='+item.cid+'&i=0'\" class=\"flex\"> <dt class=\"relative\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<img :src=\"item.logo\"  class=\"loadingimg\" :alt=\"item.cname\" />\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<!--正在直播-->\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<span class=\"icon abslute icon1\" v-if=\"item.status==0\"></span>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<!--即将开始-->\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<span class=\"icon abslute icon2\" v-if=\"item.status==1\"></span>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<!--直播结束-->\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t\t<span class=\"icon abslute icon3\" v-if=\"item.status==2\"></span>\n");
      out.write("\t\t\t\t\t\t\t\t\t</dt>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t<dd class=\"ohidden relative\">\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<h5 class=\"name ellipsis\" style=\"margin-bottom: .1rem;\"><p class=\"topic  \" :class=\"item.status?'zb-tit':'zb-tit'\">\n");
      out.write("\t            \t\t\t\t\t\t<small></small>\n");
      out.write("\t            \t\t\t\t\t</p>\t{{ item.title }}</h5>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<span class=\"ellipsis\">{{item.name}}</span>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<span class=\"type block ellipsis2\">{{ item.starttime.substr(5) }}开课</span>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<span class=\"time block\"><time>{{ item.buycount }}</time>人报名</span>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<p class='money absolute' v-if=\"item.money  > 0 \"><small>￥</small><big>{{ item.money }}</big></p>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t\t<p class='money absolute free' v-if=\"item.money <=0 \">免费</p>\n");
      out.write("\t\t\t\t\t\t\t\t\t\t</dd>\n");
      out.write("\t\t\t\t\t\t\t\t\t</a>\n");
      out.write("\t\t\t\t\t\t\t\t</dl>\n");
      out.write("\t\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t\t<!--课程安排 end-->\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t</section>\n");
      out.write("\t\t\t<!--    底部导航开始    -->\n");
      out.write("\t\t\t<footer class=\"footer bg-fff fixed\">\n");
      out.write("\t\t\t\t<ul class=\"flex\">\n");
      out.write("\t\t\t\t\t<li class=\"zixun\" id=\"consult\" @click=\"zixun\"><i class=\"icon\"></i><span>资讯</span></li>\n");
      out.write("\t\t\t\t\t<li class=\"money\" id=\"share\" @click=\"getMoney\">赚{{money.substr(4)/10*detaills.money}}元</li>\n");
      out.write("\t\t\t\t\t<li class=\"enter\"><span id=\"goShoping\" @click=\"goShoping\"  v-if=\"pay\">立即报名</span>\n");
      out.write("\t\t\t\t\t\t<a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/v2/live/zhibo/item730.shtml\" v-if=\"!pay\">进入教室</a>\n");
      out.write("\t\t\t\t\t</li>\n");
      out.write("\t\t\t\t</ul>\n");
      out.write("\t\t\t</footer>\n");
      out.write("\t\t\t<div class=\"masking absolute none\" id=\"masking\" @click=\"maskingHide\">\n");
      out.write("\t\t\t\t<img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/images/courseArrangement_share.png\" alt=\"\" />\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div class=\"pop none\" id=\"consultPop\">\n");
      out.write("\t\t\t\t<img src=\"http://wimg.keepyoga.com/images/ycyoga-share11.png\">\n");
      out.write("\t\t\t\t<div class=\"consult-hide\" id=\"consultHide\" @click=\"consultPopHide\"></div>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t\t<div class=\"masking absolute none\" id=\"masking2\" @click=\"masking2Hide\"></div>\n");
      out.write("\t\t\t<div class=\"submitBox\" id=\"submitBox\">\n");
      out.write("\t\t\t\t<div class=\"titleBox\">\n");
      out.write("\t\t\t\t\t<div>\n");
      out.write("\t\t\t\t\t\t<img :src=\"detaills.logo\" alt=\"\">\n");
      out.write("\t\t\t\t\t</div>\n");
      out.write("\t\t\t\t\t<h4>{{detaills.name}}</h4>\n");
      out.write("\t\t\t\t\t<span>￥{{detaills.money}}</span>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t\t<div class=\"inputBox\">\n");
      out.write("\t\t\t\t\t<label for=\"name\">\n");
      out.write("\t\t\t\t<i>*</i>\n");
      out.write("\t\t\t\t<span>姓名：</span>\n");
      out.write("\t\t\t\t<input type=\"text\" id=\"name\" v-model=\"name\">\n");
      out.write("\t\t\t</label>\n");
      out.write("\t\t\t\t\t<label for=\"phone\" class=\"phone\">\n");
      out.write("\t\t\t\t<i>*</i>\n");
      out.write("\t\t\t\t<span>手机：</span>\n");
      out.write("\t\t\t\t<input type=\"text\" id=\"phone\" v-model=\"phone\">\n");
      out.write("\t\t\t</label>\n");
      out.write("\t\t\t\t\t<label for=\"pwd\">\n");
      out.write("\t\t\t<i>*</i> \n");
      out.write("\t\t\t\t<span>验证码：</span>\n");
      out.write("\t\t\t\t<input type=\"text\" id=\"pwd\" placeholder=\"请输入验证码\" v-model=\"pwd\">\n");
      out.write("\t\t\t\t<span class=\"sendMes\" id=\"getpwd\" @click=\"getpwd\">发送验证码</span> \n");
      out.write("\t\t\t</label>\n");
      out.write("\t\t\t\t</div>\n");
      out.write("\t\t\t\t<p class=\"subP\">\n");
      out.write("\t\t\t\t\t<a href=\"javascript:;\" class=\"submitBtn\" id=\"submitBtn\" @click=\"submitBtn\">提交订单</a>\n");
      out.write("\t\t\t\t</p>\n");
      out.write("\t\t\t</div>\n");
      out.write("\t\t</div>\n");
      out.write("\n");
      out.write("\t\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/lib/vue.min.js\"></script>\n");
      out.write("\t\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/lib/zepto.min.js\"></script>\n");
      out.write("\t\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/lib/iscroll4.min.js\"></script>\n");
      out.write("\t\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/common.js\"></script>\n");
      out.write("\t\t<script src=\"http://res.wx.qq.com/open/js/jweixin-1.0.0.js\"></script>\n");
      out.write("\t\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/js/layer/layer.js\"></script>\n");
      out.write("\t\t<script>\t\n");
      out.write("\t\t\tvar JspElement = {\n");
      out.write("\t\t\t\twxid:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${wxid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tuid:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${uid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tuuid:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${uuid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tordernumber:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ordernumber}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tctx:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\turlsecret:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${urlsecret}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tnologin :'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${nologin}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tappid:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${appid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\ttimestamp:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${timestamp}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tnonceStr:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${nonceStr}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tsignature:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${signature}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tpaytimestamp:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${paytimestamp}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tpaynonceStr:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${paynonceStr}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tpaypackage:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${paypackage}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tpaySign:'");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${paySign}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("',\n");
      out.write("\t\t\t\tdetaillsId:\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${zid}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("\"\n");
      out.write("\t\t\t\t\n");
      out.write("\t\t\t}\n");
      out.write("\t\t\t\n");
      out.write("\t\t</script>\n");
      out.write("\t\t<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/resources/js/modules/courseArrangement.js\"></script>\n");
      out.write("\t</body>\n");
      out.write("\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }

  private boolean _jspx_meth_c_005fset_005f0(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f0 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f0_reused = false;
    try {
      _jspx_th_c_005fset_005f0.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f0.setParent(null);
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(6,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setVar("ctx");
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(6,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ pageContext.request.contextPath}", java.lang.Object.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null));
      int _jspx_eval_c_005fset_005f0 = _jspx_th_c_005fset_005f0.doStartTag();
      if (_jspx_th_c_005fset_005f0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f0);
      _jspx_th_c_005fset_005f0_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f0, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f0_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fset_005f1(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f1 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f1_reused = false;
    try {
      _jspx_th_c_005fset_005f1.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f1.setParent(null);
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(7,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f1.setVar("version");
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(7,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f1.setValue("20130306");
      int _jspx_eval_c_005fset_005f1 = _jspx_th_c_005fset_005f1.doStartTag();
      if (_jspx_th_c_005fset_005f1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f1);
      _jspx_th_c_005fset_005f1_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f1, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f1_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fset_005f2(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f2 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f2_reused = false;
    try {
      _jspx_th_c_005fset_005f2.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f2.setParent(null);
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(8,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f2.setVar("wxid");
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(8,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f2.setValue("wx10352e193b39e646");
      int _jspx_eval_c_005fset_005f2 = _jspx_th_c_005fset_005f2.doStartTag();
      if (_jspx_th_c_005fset_005f2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f2);
      _jspx_th_c_005fset_005f2_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f2, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f2_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fset_005f3(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f3 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f3_reused = false;
    try {
      _jspx_th_c_005fset_005f3.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f3.setParent(null);
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(9,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f3.setVar("cdn");
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(9,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f3.setValue("http://wimg.keepyoga.com");
      int _jspx_eval_c_005fset_005f3 = _jspx_th_c_005fset_005f3.doStartTag();
      if (_jspx_th_c_005fset_005f3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f3);
      _jspx_th_c_005fset_005f3_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f3, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f3_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fset_005f4(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f4 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f4_reused = false;
    try {
      _jspx_th_c_005fset_005f4.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f4.setParent(null);
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(10,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f4.setVar("sulist");
      // /WEB-INF/views/ksite/more/../../taglibs.jsp(10,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f4.setValue("13065,13060");
      int _jspx_eval_c_005fset_005f4 = _jspx_th_c_005fset_005f4.doStartTag();
      if (_jspx_th_c_005fset_005f4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f4);
      _jspx_th_c_005fset_005f4_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f4, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f4_reused);
    }
    return false;
  }

  private boolean _jspx_meth_c_005fset_005f5(javax.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    javax.servlet.jsp.PageContext pageContext = _jspx_page_context;
    javax.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:set
    org.apache.taglibs.standard.tag.rt.core.SetTag _jspx_th_c_005fset_005f5 = (org.apache.taglibs.standard.tag.rt.core.SetTag) _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.get(org.apache.taglibs.standard.tag.rt.core.SetTag.class);
    boolean _jspx_th_c_005fset_005f5_reused = false;
    try {
      _jspx_th_c_005fset_005f5.setPageContext(_jspx_page_context);
      _jspx_th_c_005fset_005f5.setParent(null);
      // /WEB-INF/views/ksite/more/liveDetail.jsp(4,0) name = var type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f5.setVar("footclass");
      // /WEB-INF/views/ksite/more/liveDetail.jsp(4,0) name = value type = null reqTime = true required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
      _jspx_th_c_005fset_005f5.setValue("v2index");
      int _jspx_eval_c_005fset_005f5 = _jspx_th_c_005fset_005f5.doStartTag();
      if (_jspx_th_c_005fset_005f5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE) {
        return true;
      }
      _005fjspx_005ftagPool_005fc_005fset_0026_005fvar_005fvalue_005fnobody.reuse(_jspx_th_c_005fset_005f5);
      _jspx_th_c_005fset_005f5_reused = true;
    } finally {
      org.apache.jasper.runtime.JspRuntimeLibrary.releaseTag(_jspx_th_c_005fset_005f5, _jsp_getInstanceManager(), _jspx_th_c_005fset_005f5_reused);
    }
    return false;
  }
}