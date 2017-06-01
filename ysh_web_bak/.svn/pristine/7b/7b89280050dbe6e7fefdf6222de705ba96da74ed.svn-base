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
		<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
		<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
		<title>${user.nickname }个人中心</title>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="${ctx}/css/teach_personal.css?v=${version}">
		<style type="text/css">
			p.two_dimension_img {
				width: 10rem;
				height: 10rem;
				position: absolute;
				bottom: 3.625rem;
			}
			
			#masking9 {
				width: 100%;
				height: 100%;
				background: black;
				opacity: .5;
				position: absolute;
				left: 0;
				top: 0;
				z-index: 4;
			}
			
			.close {
				position: absolute;
				right: .5rem;
				top: .5rem;
				width: 1.2rem;
				height: 1.2rem;
			}
			
			div.masking {
				z-index: 99;
			}
		</style>
	</head>

	<body>
		<div class="wrapper">
			<div class="masking" style="display:none"></div>
			<div id="two_dimension_code" style="display:none">
				<img src="http://wimg.keepyoga.com/close.jpg" class="close">
				<c:choose>
					<c:when test="${ fn:indexOf(user.file_path,'http') > -1 }">
						<img id="tx" class="two_dimension" src="${user.file_path}">
					</c:when>
					<c:otherwise>
						<img id="tx" class="two_dimension" src="${ctx}/${user.file_path}">
					</c:otherwise>
				</c:choose>
				<p class="two_dimension_img" id="jrcode"></p>
				<h1>${user.nickname }(ysh${user.id}16)</h1>
				<p class="title1">${user.userpost }</p>
				<p class="title2" style="margin-left:.9rem">扫一扫上面的二维码图案，加我微信</p>
			</div>

			<section class="mainBox" id="mainBox">
				<div>
					<header <c:if test="${user.isteacher == 0 }">class="header"</c:if> >
						<c:if test="${user.isteacher == 1 }">
							<p class="share">
								<a href="javascript:;" id="aa"><img src="http://wimg.keepyoga.com/my_icon.png" alt=""><span>分享二维码</span></a>
							</p>
						</c:if>
						<dl <c:if test="${user.isteacher == 0 }"> class="student"</c:if> >
							<dt>
                        <a <c:if test="${user.isteacher == 0 }">href="javascript:;"</c:if> <c:if test="${user.isteacher == 1 }">href="${ctx}/w/faq/person.html?p=${user.id}"</c:if> >
                           <c:choose>
								 <c:when test="${ fn:indexOf(user.file_path,'http') > -1 }">
										  <img id="tx" src="${user.file_path}" >
								  </c:when>
								  <c:otherwise>
										  <img id="tx" src="${ctx}/${user.file_path}" >
										  </c:otherwise>
								 </c:choose>
                        </a>
                    </dt>
							<dd>
								<c:if test="${user.isteacher == 1 }">
									<h1><a href="${ctx}/w/faq/person.html?p=${user.id}">${user.nickname}(ysh${user.id}16)</a></h1>
								</c:if>
								<c:if test="${user.isteacher == 0 }">
									<h1><a href="javascript:;">${user.nickname}<span><br/>用户ID：ysh${user.id}16<span></span></a></h1>
								</c:if>
								<c:if test="${user.isteacher == 1 }">
									<h2>${user.userpost}</h2>
								</c:if>
							</dd>
							<c:if test="${ user.isteacher == 1 }">
								<p class="introduction">${user.shortremark }</p>
								<p>向我提问需要支付<span>￥${user.askmoney} 元；关注人数  ${user.fensi_count}</span></p>
							</c:if>
						</dl>
					</header>
					<c:if test="${user.isteacher ==1  }">
						<ul class="my1">
							<li data-url="${ctx}/w/my/1/ask.html"><i></i>我的回答
								<c:if test="${ havaquestion > 0 }"><b style="display:block"></b></c:if><span></span></li>
							<li data-url="${ctx}/w/my/course.html"><i></i>我的课程<b></b><span></span></li>
							<li data-url="${ctx}/w/my/money.html"><i></i>我的收入<b></b><span></span></li>
						</ul>
					</c:if>
					<ul class="my2">
						<li data-url="${ctx}/w/my/mineask.html"><i></i>我的提问<b></b><span></span></li>
						<li data-url="${ctx}/w/my/mineprize.html"><i></i>我的奖品<b></b><span></span></li>
						<li data-url="${ctx}/w/my/minebuy.html"><i></i>购买的课程<b></b><span></span></li>
						<li data-url="${ctx}/w/my/minecol.html"><i></i>收藏的课程<b></b><span></span></li>
						<li data-url="${ctx}/w/my/minefol.html"><i></i>关注的导师<b></b><span></span></li>
						<c:if test='${distirbutoruuid != "" &&distirbutoruuid != "null" }'>
							<li data-url="${ctx}/weixin/distribution2/${distirbutoruuid}.html"><i></i>我的分销收益<b></b><span></span></li>
						</c:if>
					</ul>
					<ul class="my5">
						<li data-url="${ctx}/w/faq/yc/distributor/info.html"><i></i>孕产瑜伽课代表信息完善<b></b><span></span></li>
					</ul>
					<!--  
             <ul class="my4">
	             <c:if test='${!isSaler}'>
	                 <li data-url="${ctx}/w/saler/tobe.html" class="fxy"><i></i>成为分销员<b></b><span></span></li>     
	             </c:if>
             	 <c:if test='${isSaler}'>
	                 <li data-url="${ctx}/w/saler/products.html"  class="sp"><i></i>我的分销商品<b></b><span></span></li>
	                 <li data-url="${ctx}/w/saler/revenue.html"  class="sy"><i></i>我的分销收益<b></b><span></span></li>      
                 </c:if>    
             </ul>
              -->
					<ul class="my3">
						<li data-url="${ctx}/w/help/index.html"><i></i>如何使用随心瑜Live<b></b><span></span></li>
						<li data-url="${ctx}/w/help/about.html"><i></i>关于<b></b><span></span></li>
						<li data-url="${ctx}/w/help/feedback.html"><i></i>提建议<b></b><span></span></li>
					</ul>
					<div class="phone">
						<p>随心瑜Live在线热线：
							<a href="tel:4000186161">4000186161</a>
						</p>
					</div>
				</div>
			</section>
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="${ctx}/js/zepto.js?v=${version}"></script>
		<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
		<script src="${ctx}/js/qrcode.min.js?v=${version}"></script>
		<script>
			$("#mainBox").on("tap", "li", function() {
				window.location.href = $(this).attr("data-url");
			})

			var qrcode = new QRCode("jrcode", {
				text: "${ctx}/w/faq/person.html?p=${user.id}",
				width: 200,
				height: 200
			});

			$("#aa").on("tap", function() {
				$(".masking").css("display", "block");
				$("#two_dimension_code").css("display", "block");
			})
			$(".masking").on("tap", function() {
				$(".masking").css("display", "none");
				$("#two_dimension_code").css("display", "none");
			})

			$(".close").on("tap", function() {
				$(".masking").css("display", "none");
				$("#two_dimension_code").css("display", "none");
			})

			function loaded() {
				var iscroll = new iScroll("mainBox", {
					vScrollar: false
				});
			}
			document.addEventListener('DOMContentLoaded', loaded, false);

			var title1 = "我是${user.nickname }，有问题，欢迎来「随心瑜Live」问我";
			var desc1 = "${user.nickname }|${user.userpost}";
			var link1 = "${ctx}/w/faq/person.html?p=${user.id}";
			var img1 = $("#tx").attr("src");

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
			var nologin = "${nologin}";
			if(nologin == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}
		</script>
		<script src="${ctx}/js/wblog.js?v=${version}"></script>
		<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
	</body>

</html>