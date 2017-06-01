<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp"%>
<c:set var="footclass" value="v2index" />
<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<title>免费好课</title>
		<script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
		<link rel="stylesheet" href="${ctx}/resources/css/index.css" />
		<style>
			.recommend .icon {
    width: .45rem;
    height: .45rem;
    position: relative;
    top: .5rem;
			}
			
			.recommend .item {
				height: 1.2rem;
			}
			
			.recommend .item p {
				border-bottom: none !important;
			}
			
			.recommend .tiem span {
				font-size: .24rem;
				color: #B2B2B2;
			}
			
		.recommend .item p.tiem {
    position: relative;
    top: -.8rem;
    border-bottom: 1px solid #ebebeb !important;
    width: 88%;
    margin-left: 10%;
    line-height: 1rem;
}
			.recommend .item p.tiem .left {
				margin-right: .5rem;
			}
		</style>
	</head>

	<body>

		<div class="wrapper bg-e4" id="app" v-cloak>
			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden iscroll-box1" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper">
					<!--   免费推荐   -->
					<!--   免费推荐   -->
					<div class="recommend bg-fff m30 m-b">

						<ul>
							<li class="item " v-for="item in items">
								<a :href="'${ctx}/w/faq/course.html?p='+item.cid" class="flex">
									<i class="icon" :class="item.ctype?'icon-video':'icon-audio'"></i>
									<p class="text ellipsis">{{ item.cname }} : {{ item.remark }} </p>

								</a>
								<p class="tiem" @click="go('${ctx}/w/faq/course.html?p='+item.cid)"><span class="left">{{item.toptime}}</span><span class="long">时长：{{item.longtime}}</span></p>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<!--    底部导航开始    -->
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="${ctx}/resources/js/lib/vue.min.js"></script>
		<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
		<script src="${ctx}/resources/js/common.js"></script>
		<script src="${ctx}/resources/js/modules/more.js"></script>
		<script>
			vw.init("index/free/more.json");
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
				// 
				wx.showMenuItems({
					menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				});
			});
			var nologin = "${nologin}";
			if(nologin == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}
		</script>
		</script>
	</body>

</html>