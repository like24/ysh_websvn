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
		<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
		<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
		<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
		<title>关于</title>
		<link rel="stylesheet" href="${ctx}/css/about.css?v=${version}">
	</head>
	<div class="wrapper">
		<section class="mainBox" id="mainBox">
			<div>
				<img src="http://wimg.keepyoga.com/about.jpg" alt="" class="major">
				<ul>
					<li><i></i>业务不清困扰发展？一线导师等你来问</li>
					<li><i></i>线上、线下干货活动持续不断</li>
					<li><i></i>经管、精品课程持续更新</li>
				</ul>
				<img src="http://wimg.keepyoga.com/about4.jpg" alt="">
				<p class="title">【随心瑜Live】隶属于随心瑜品牌，专注于服务瑜伽专业人士，提供教学技能及运营管理能力的分享学习平台，聚集一批行业一线导师与众多优秀瑜伽人才，本着打造最优质、全面、前延的在线教育和问答互动平台。</p>
				<p class="tel">
					<a href="tel:4000186161">4000186161</a>工作日10：00-19：00</p>
			</div>
		</section>
		<%@ include file="../footer.jsp" %>
	</div>
	<!--<script src="../commonjs/zepto.js"></script>-->
	<script>
		var nologin = "${nologin}";
		if(nologin == "true") {
			window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=http://weixin.keepyoga.com/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}

		wx.config({
			debug: false,
			appId: '${appid}',
			timestamp: '${timestamp}',
			nonceStr: '${nonceStr}',
			signature: '${signature}',
			jsApiList: [
				'checkJsApi', 'openLocation',
				'getLocation', 'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
				'onMenuShareQQ', 'onMenuShareWeibo', 'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
				'showAllNonBaseMenuItem', 'chooseImage', 'previewImage', 'uploadImage',
				'chooseWXPay', 'downloadImage', 'getNetworkType', 'openLocation',
				'getLocation', 'hideOptionMenu', 'showOptionMenu'
			]
		});
		wx.ready(function(Api) {
			wx.hideAllNonBaseMenuItem();
			wx.showMenuItems({
				menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
		});
	</script>
	</body>

</html>