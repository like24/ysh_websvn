<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="course" />
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
	<link rel="stylesheet" href="${ctx}/css/HotCourse.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/swiper-3.3.1.min.css?v=${version}">
	<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<script type="text/javascript" src="${ctx}/js/swiper-3.3.1.min.js?v=${version}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${version}"></script>
   
	<title>随心瑜Live|名师课程排行榜 </title>
</head>
<body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox">
		<div>
			<nav class="nav">
				<ul>					
					<li><a href="${ctx}/w/hot/course/index.html" class="high">热门课程</a></li>
					<li><a href="${ctx}/w/hot/teacher/index.html">导师榜</a></li>
				</ul>
				<a href="${ctx}/w/search.html" class="search" id="search"><img src="http://wimg.keepyoga.com/search.jpg" alt=""></a>
			</nav>
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<c:forEach items="${bannerlist }" var="banner" varStatus="status">
							<div class="swiper-slide">
								<a href="${banner.url }"><img src="${banner.icon }" alt=""></a>
							</div> 
					</c:forEach>
				</div>
				<!-- 如果需要分页器 --> 
				<div class="swiper-pagination"></div>
			</div>
			<div class="activeNav" id="activeNav">
				<c:forEach items="${speciallist}" var="special">
					<dl data_id="${special.id}">
						<dt>
							<img src="${special.logo}" alt="">
						</dt>
						<dd>${special.name}</dd>
					</dl>
				</c:forEach>
			</div>
			<div class="Content">
				<h4><a href="${ctx}/w/hot/course/list.html">更多</a>课程精选</h4>
				<c:forEach items="${recommends}" var="course">
					<dl data_id="${course.id}">
						<c:if test="${empty course.icon}">
							<dt><img src="${ctx}/images/audio.jpg" alt=""></dt>
						</c:if>
						<c:if test="${not empty course.icon}">
							<dt><img src="${course.icon}" alt=""></dt>
						</c:if>
						
						<dd>
							<b>${fn:split(course.taglist, ",")[0]}</b>
							<h4><i>${course.cname}</i><c:if test="${course.money>0}"><span>￥${course.money}元</span></c:if><c:if test="${course.money==0}"><span style="color:#1d92fb;">免费</span></c:if></h4>
	
						</dd>
					</dl>
				
				</c:forEach>
				<div class="btnMore"><a href="${ctx}/w/hot/course/list.html" id="btnMore">查看更多课程</a></div>
			</div>
			
			</div>
			
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
    <script src="${ctx}/js/zepto.js?v=${version}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
	<script>
        var pageIndex = 1;
        var icon = ""; 
		var title1 = "随心瑜Live|名师课程排行榜";
		var desc1  = "一个瑜伽人的掌上家园";
		var link1  = location.href;
		var img1   = icon ;
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

        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
		window.onload = function () {
			var mySwiper = new Swiper('.swiper-container', {
				autoplay: 5000,
				pagination: '.swiper-pagination',
				lazyLoading: true,
				lazyLoadingInPrevNext: true,
				preventClicks: false,
				preventLinksPropagation: false,
				autoplayDisableOnInteraction: false,
				touchMoveStopPropagation: false
			})
		};
		$(".Content dl").each(function (inx, inx1) {
			var inxLeft = $(".Content dl").eq(inx).find("b").width() / 20 + 1;
			$(".Content dl").eq(inx).find("h4").css("textIndent", inxLeft + "rem");
		})
		$(function(){
			$("#activeNav").on("tap","dl",function(){
				var dataId = $(this).attr("data_id");
				window.location.href="${ctx}/w/hot/course/list.html?p="+dataId;
			});
			
			$(".Content").on("tap","dl",function(){
				var dataId = $(this).attr("data_id");
				window.location.href="${ctx}/w/faq/course.html?p="+dataId;
			});
		});
		var dlLen=$("#activeNav").find("dl").length;
		if(dlLen>4){
			$("#activeNav").find("dl").css("width",28+"%");
		}
    </script>
    
</body>
</html> 
 