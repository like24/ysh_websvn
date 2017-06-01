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
		<title>
			<c:if test="${tid == 1 }">待回答的问题</c:if>
			<c:if test="${tid==2 }">已回答的问题</c:if>
		</title>
		<script type="text/javascript">
			var nodata = $ { contentlist.totalCount > 10 ? 1 : 0 };
		</script>
		<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
		<link rel="stylesheet" href="${ctx}/css/my_answer.css?v=${version}">
	</head>

	<body>
		<div class="wrapper">
			<section class="mainBox" id="mainBox">
				<div>
					<nav>
						<ul>
							<li <c:if test="${tid ==1 || tid ==0  }">class="high"</c:if>>
								<a href="${ctx}/w/my/1/ask.html">待回答</a>
							</li>
							<li <c:if test="${tid ==2 }">class="high"</c:if>>
								<a href="${ctx}/w/my/2/ask.html">已回答</a>
							</li>
						</ul>
					</nav>
					<ul id="list" class="list">
						<c:forEach items="${contentlist.results}" var="faq" varStatus="status">
							<li <c:if test="${tid ==1 }">data-url="${ctx}/w/faq/d/ask.html?p=${faq.id}&r=0"</c:if>
								<c:if test="${tid==2 }">data-url="${ctx}/w/faq/d.html?p=${faq.id}"</c:if>>
								<dl>
									<dt>
                              <c:choose>
							  <c:when test="${ fn:indexOf(faq.header,'http') > -1 }"> <img src="${faq.header}"  > </c:when>
							  <c:otherwise><img src="${ctx}/${faq.header}" ></c:otherwise></c:choose>
                              </dt>
									<dd>
										<h3>${faq.username }</h3>
										<c:choose>
											<c:when test="${faq.hasanswer == 0 }">
												<p class="already_answer1"><span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 未回答</p>
											</c:when>
											<c:when test="${faq.hasanswer == 1 && empty faq.subcontent}">
												<p class="already_answer"><span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 已回答</p>
											</c:when>
											<c:when test="${faq.hasanswer == 1 && not empty faq.subcontent}">
												<p class="already_answer"><span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 有追问</p>
											</c:when>
											<c:when test="${faq.hasanswer == 2 }">
												<p class="already_answer"> <span><c:choose><c:when test="${faq.askmoney>0}">￥${faq.askmoney }元</c:when><c:otherwise>免费</c:otherwise></c:choose></span> 已过期</p>
											</c:when>
										</c:choose>
									</dd>
								</dl>
								<h4>${faq.title }</h4>
								<time>${faq.showtime }</time>
							</li>
						</c:forEach>
					</ul>
					<c:if test="${ contentlist.totalCount == 0  }">
						<div class="zanwu">
							<img src="http://wimg.keepyoga.com/success.png" alt="">
							<p>还没有收到提问哦<br>快分享你的页面让大家提问吧～</p>
						</div>
					</c:if>
				</div>
			</section>
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="${ctx}/js/zepto.js?v=${version}"></script>
		<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
		<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
		<script>
			var pageIndex = 0;
			$("#list").on("tap", "li", function() {
				window.location.href = $(this).attr("data-url");
			})
			var pageIndex = 0;
			var nologin = "${nologin}";
			if(nologin == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
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