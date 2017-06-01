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
		<title id="title">我的奖品</title>
		<link rel="stylesheet" href="${ctx}/css/common.css">
		<link rel="stylesheet" href="${ctx}/css/reset.css">
		<link rel="stylesheet" href="${ctx}/css/myPrize.css">
		<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
		<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	</head>

	<body>
		<div class="wrapper">
			<section class="mainBox" id="mainBox">
				<c:if test="${havePrize }">
					<div class="havePrize">
						<ul>
							<c:forEach items="${awards}" var="vo">
								<li>
									<i class="icon icon-3"></i>
									<div>
										${vo.cname}
									</div>
									<a href="${ctx}/w/faq/course.html?p=${vo.cid}" class="btn">去观看</a>
								</li>
							</c:forEach>
							<c:if test="${prizelv!=0 && prizelv<=5}">
								<li>
									<i class="icon icon-1"></i>
									<div>
										<p>${prize_name }</p>
									</div>
									<c:choose>
										<c:when test="${noaddress == 1 }">
											<a href="${ctx}/w/my/address.html" class="btn">去领奖</a>
										</c:when>
										<c:otherwise>
											<a href="javascript:;" class="btn" style="background:#ccc;">已领奖</a>
										</c:otherwise>
									</c:choose>
								</li>
							</c:if>
							<c:if test="${role ==1 }">
								<li>
									<i class="icon icon-2"></i>
									<div>
										<p>随心瑜会员管理系统</p>
										<span>最懂瑜伽馆的经营管理工具</span>
									</div>
									<a href="http://m.keepyoga.com/static/register.php?recommender=%E7%91%9C%E6%98%AF%E4%B9%8E" class="btn">去使用</a>
								</li>
							</c:if>
							<c:if test="${prizelv == 6 }">
								<li>
									<i class="icon icon-3"></i>
									<div>
										<c:choose>
											<c:when test="${role == 1  }">瑜伽在中国之盈利模式解析【导师：梁佩兰】</c:when>
											<c:when test="${role == 2  }">瑜伽教学——能量的扩展【导师：普若帕克】</c:when>
											<c:otherwise>阿斯汤加的姿势详细解析</c:otherwise>
										</c:choose>
									</div>
									<c:choose>
										<c:when test="${role == 1  }">
											<a href="${ctx}/w/my/prizecourse.html?p=416" class="btn">去观看</a>
										</c:when>
										<c:when test="${role == 2  }">
											<a href="${ctx}/w/my/prizecourse.html?p=480" class="btn">去观看</a>
										</c:when>
										<c:otherwise>
											<a href="${ctx}/w/my/prizecourse.html?p=211" class="btn">去观看</a>
										</c:otherwise>
									</c:choose>
								</li>
							</c:if>
						</ul>
					</div>
				</c:if>
				<c:if test="${!havePrize }">
					<div class="no-prize">
						<img src="data:image/png;base64,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">
						<h1>您还没有奖品，关注瑜是乎活动赢取奖品~</h1>
						<a href="${ctx}/w/jxy18.html">去看看</a>
					</div>
				</c:if>
			</section>
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="${ctx}/js/zepto.js?v=${version}"></script>
		<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
		<script src="${ctx}/js/qrcode.min.js?v=${version}"></script>
		<script>
			var pageIndex = 0;
			var nologin = "${nologin}";
			if(nologin == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}

			function spowder() {
				$.post("${ctx}/w/my/spowder.html", function(data) {
					if(data.code > 0) {
						window.location.href = "http://www.baidu.com";
					} else {
						modelTip("统计失败", 1500);
					}
				});
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
		<script src="${ctx}/js/wblog.js?v=${version}"></script>
		<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
	</body>

</html>