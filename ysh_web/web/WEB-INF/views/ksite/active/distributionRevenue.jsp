<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="footclass" value="my" />
<!doctype html>
<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<title>我的分销收益</title>
		<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
		<link rel="stylesheet" href="http://wimg.keepyoga.com/css/reset.css?v=${version}">
		<link rel="stylesheet" href="http://wimg.keepyoga.com/css/distributionRevenue5.css?v=${version}">
		<c:if test="${empty distributor.mobile}">
			<style>
				#mainBox {
					margin-top: 2.6rem;
				}
			</style>
		</c:if>
	</head>
	<body>
		<div class="wrapper">
			<c:if test="${empty distributor.mobile}">
				<h1 id="backMes"><a href="javascript:;" onclick="goForCollect()">银行卡信息完善></a></h1>
			</c:if>
			<section class="mainBox" id="mainBox" style="top:0;">

				<div class="money">
					<div>
						<h4>待结收益（元）</h4>
						<b><fmt:formatNumber value="${distributor.money}" type="currency" pattern="0.0#"/></b>
						<a href="javascript:;">分销总收入：
							<fmt:formatNumber value="${distributor.money}" type="currency" pattern="￥0.0#" />元</a>
					</div>
					<h3 class="rule">结款规则</h3>
					<p>您的收入将会在活动结束（2016年11月13日）后的15个工作日结算到您填写的银行账户，请在活动结束前完善您的银行卡信息，并确保输入无误。<br>注意：课代表本人购买课程，将不计入分销收益内。</p>
					<h3>分销明细</h3>
					<ul>
						<c:forEach items="${list}" var="li" varStatus="st">
							<li>
								<img src="${li.remark}" alt="">
								<h5>${li.cname}</h5>
								<p>
									<b>￥${li.dmoney}</b>
									<time>${li.createtime}</time>
								</p>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!--no  content-->
				<c:if test="${count==0}">
					<div class="zanwu">
						<img src="http://wimg.keepyoga.com/image/success.png" alt="">
						<p>还没有收入哦，继续努力哦~~</p>
					</div>
				</c:if>
			</section>
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="http://wimg.keepyoga.com/js/setfontsize.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript">
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
			wx.ready(function() {
				//wx.hideOptionMenu();
			});

			function goForCollect() {
				var nologin = "${nologin}";
				if(nologin == "true") {
					window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
				} else {
					window.location.href = "${ctx}/weixin/collect/userinfo.html";
				}
			}
		</script>
	</body>

</html>