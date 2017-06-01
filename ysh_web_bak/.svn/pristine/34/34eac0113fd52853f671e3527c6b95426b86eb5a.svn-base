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
		<title>关注的导师</title>
		<link rel="stylesheet" href="${ctx}/css/focus.css?v=${version}">
		<script type="text/javascript">
			var nodata = $ { contentlist.totalCount > 10 ? 1 : 0 };
		</script>
		<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
	</head>

	<body>
		<div class="wrapper">
			<section class="mainBox" id="mainBox">
				<div>
					<c:if test="${ contentlist.totalCount > 0 }">
						<h2>共关注${ contentlist.totalCount }个导师<a href="${ctx}/v2/index/tutor/more.shtml">找导师</a></h2>
					</c:if>
					<ul id="list" class="list">
						<c:forEach items="${contentlist.results}" var="teacher" varStatus="status">
							<li data-url="${ctx}/w/faq/person.html?p=${teacher.id}&t=4">
								<div>
									<dl>
										<dt>
				                    <a href="javascript:;">
	                                    <c:choose>
											<c:when test="${ fn:indexOf(teacher.header,'http') > -1 }"><img src="${teacher.header}"  ></c:when>
											<c:otherwise><img src="${ctx}/${teacher.header}"  ></c:otherwise>    
										 </c:choose>  
	                                 </a>
				                </dt>
										<dd>
											<h4><a href="javascript:;">${teacher.nickname }</a></h4>
											<h5><a href="javascript:;">${teacher.userpost }</a></h5>
											<p><span>${teacher.ask_count}个回答</span><span>${teacher.course_count}个课程</span><span>${teacher.fensi_count }人粉丝</span></p>
										</dd>
									</dl>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<c:if test="${ contentlist.totalCount == 0  }">
					<div class="zanwu">
						<img src="http://wimg.keepyoga.com/error.png">
						<p>您还没有关注任何导师~~</p>
						<a href="${ctx}/v2/index/tutor/more.shtml">找导师</a>
					</div>
				</c:if>
			</section>
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="${ctx}/js/zepto.js?v=${version}"></script>
		<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
		<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
		<script>
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