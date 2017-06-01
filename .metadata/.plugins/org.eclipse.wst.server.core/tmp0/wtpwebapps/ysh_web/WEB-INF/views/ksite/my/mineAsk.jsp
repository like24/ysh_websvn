<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="my" /> 
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
    <title>我的提问</title>
    <script type="text/javascript">
    var nodata = ${ contentlist.totalCount > 10 ? 1: 0 };
    </script> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <link rel="stylesheet" href="${ctx}/css/my_question.css?v=${version}">
</head>
<body>
    <div class="wrapper">
		<section class="mainBox" id="mainBox" >
              <div>
                  <c:if test="${ contentlist.totalCount > 0 }">
	                  <header>
	                      <h3>共问了${ contentlist.totalCount }个问题</h3>
	                      <a href="${ctx}/v2/index/tutor/more.shtml">去问一个</a>
	                  </header>
                  </c:if>
                  <ul id="list" class="list">
                     <c:forEach items="${contentlist.results}" var="faq" varStatus="status">
	                      <li data-url="${ctx}/w/faq/d.html?p=${faq.id}" >
	                          <dl>
	                              <dt>
	                              <c:choose>
											  <c:when test="${ fn:indexOf(faq.askheader,'http') > -1 }">
													  <img src="${faq.askheader}"  >
											  </c:when>
											   <c:otherwise>
													  <img src="${ctx}/${faq.askheader}" >
											    </c:otherwise>    
										  </c:choose>
	                              </dt>
	                              <dd>
	                                  <h3>${faq.askusername }</h3>
	                                  <c:choose>
		                                  <c:when test="${faq.hasanswer == 0 }"><p class="already_answer1"><span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 未回答</p></c:when>
		                                  <c:when test="${faq.hasanswer == 1 }"><p class="already_answer"><span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 已回答</p></c:when>
		                                  <c:when test="${faq.hasanswer == 2 }"><p class="already_answer"> <span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 已过期</p></c:when>
		                              </c:choose>
	                              </dd>
	                          </dl>
	                          <h4>${faq.title }</h4>
	                          <time>${faq.showtime }</time>
	                      </li>
                      </c:forEach>
                  </ul>
              </div>
            <c:if test="${ contentlist.totalCount == 0  }">
	            <div class="zanwu" >
	                <img src="http://wimg.keepyoga.com/error.png" >
	                <p>您还没有提问题哦~~</p>
	                <a href="${ctx}/w/faq/index.html?p=1">去问一个</a>
	            </div>
            </c:if>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script> 
	<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>t>
	<script>
        $("#list").on("tap","li",function(){
            window.location.href=$(this).attr("data-url");
        })
        var pageIndex = 0;
        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
		wx.config({
		    debug: false,
		    appId: '${appid}',
		    timestamp:'${timestamp}' ,
		    nonceStr: '${nonceStr}',
		    signature: '${signature}',
		    jsApiList: [ 
		        'checkJsApi','openLocation',
		        'getLocation','checkJsApi','onMenuShareTimeline','onMenuShareAppMessage',
		        'onMenuShareQQ','onMenuShareWeibo','hideMenuItems','showMenuItems','hideAllNonBaseMenuItem',
		        'showAllNonBaseMenuItem', 'chooseImage','previewImage','uploadImage',
		        'chooseWXPay','downloadImage','getNetworkType','openLocation',
		        'getLocation','hideOptionMenu','showOptionMenu'
		      ]
		}); 
		wx.ready(function(Api){ 
		    wx.hideAllNonBaseMenuItem();
		    wx.showMenuItems({
			    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
		});
    </script>
    </body>
</html>
 