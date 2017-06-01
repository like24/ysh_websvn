<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<title>销售业绩</title>
	<link rel="stylesheet" href="${ctx}/css/salesman.css">
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
	<script src="${ctx}/js/jquery.lazyload.min.js"></script>
</head>

<body>
	<div class="wrapper">
		<header>
			<h3>销售人员：${distributor.cname}</h3>
		</header>
		<div class="moneyBox">
			<p>预计收益（元）</p>
			<span><fmt:formatNumber value="${distributor.money}" type="currency" pattern="￥0.0#"/></span>
		</div>
		<p class="manlen">共有${count}人通过您的分享完成购买</p>
		<ul class="man">
			<c:forEach items="${list}" var="li" varStatus="st">
				<c:if test="${st.index == 0}">
					<li>
				</c:if>
				<img src="${li.remark}" alt="">
				<c:if test="${(st.index+1) % 10 == 0}">
					</li>
					<li>
				</c:if>
				<c:if test="${st.last}">
					</li>
				</c:if>
			</c:forEach>
		</ul>
</body>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
$("img").lazyload();

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
wx.ready(function(){
	wx.hideOptionMenu();
});
</script>
</html>