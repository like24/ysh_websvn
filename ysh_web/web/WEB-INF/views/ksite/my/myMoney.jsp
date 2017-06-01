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
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <title>我的收入</title>
    <script type="text/javascript">
	     var nodata = 0;
    </script> 
    <style type="text/css">
    .money ul > li p span {
	    font-size: 12px;
	    line-height: 12px;
	    color: white;
	    background: #c0c0c0;
	    padding: 2px 4px;
	    border-radius: 3px;
	}
    </style>
	<link rel="stylesheet" href="${ctx}/css/my_income.css?v=${version}">
</head>
<body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox" >
             <div class="money" <c:if test="${balance.money == 0 && balance.money_ == 0}">style="display:none"</c:if> >
	            <div>
	                <h4>待结款费用（元）</h4>
	                <b>${balance.money}</b>
	                <p>已结费用：<span>￥${balance.money_}</span></p>
	                <a href="javascript:moneytips();">结款规则</a>
	            </div>
	            <c:if test="${balance.money_ > 0 }">
	              <h3>已结款明细</h3>
	            </c:if>
	            <ul>
	                <c:forEach items="${orderlist}" var="order" varStatus="status">
		                <li>
		                    <h5>${order.cname }</h5>
		                    <p><time>${order.createtime }</time><b>￥${order.money }</b>&nbsp;&nbsp;<span><c:if test="${order.type == 0}">问答</c:if><c:if test="${order.type == 1}">课程</c:if></span></p>
		                </li> 
	                </c:forEach>
	            </ul>
            </div>
            <c:if test="${balance.money_ == 0 && balance.money == 0 }">
	            <div class="zanwu">
	                <img src="http://wimg.keepyoga.com/success.png"  >
	                <p>还没有收入哦，继续努力哦~~</p>
	            </div>
            </c:if>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
</body>
<script type="text/javascript">
	function moneytips() {
	    dialog({
	        wrapper: ".wrapper",
	        id: "money",
	        close: true,
	        title1: "结算规则：",
	        title2: "每月15号平台会将您的待结收入（问答、购课的收入提成）存到您的微信钱包，结款金额小于1元不结算。 如你有疑问可拨打服务电话157-1288-7177",
	        mask: true,
	        bodytap: true
	    });
	}
	var nologin = "${nologin}"; 
	if( nologin == "true" ) {   
	    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=http://weixin.keepyoga.com/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
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
</html>
 