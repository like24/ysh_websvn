<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../../taglibs.jsp" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<title>瑜伽瘦身集训营分销收益</title>
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/common.css?v=${version}">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/reset.css?v=${version}">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/distributionRevenue5.css?v=${version}">
	<script src="http://wimg.keepyoga.com/js/setfontsize.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<c:if test="${empty distributor.mobile}">
		<style>
			#mainBox{
				margin-top:2.6rem;
			}
		</style>
	</c:if>
</head>

<body>
	<script type="text/javascript">
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
			    wx.hideAllNonBaseMenuItem();
			    wx.showMenuItems({
				    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				});
		   });
	</script>
		<header>
			<h3 class="women" style="width:100%;text-align:center;line-height:2rem;font-size:16px;">销售人员：${distributor.cname}</h3>
		</header>
	<div class="wrapper">
		<section class="mainBox" id="mainBox" style="top:0;">

			<div class="money">
				<div>
					<h4>预计收益（元）</h4>
					<b><fmt:formatNumber value="${distributor.money}" type="currency" pattern="0.0#"/></b>
				</div>
				<h3 class="rule">结款规则</h3>
				<p>您的收益将于活动结束后10个工作日内，结算到您的银行卡账户。</p>
				<h3>分销明细</h3>
				<ul>
					<c:forEach items="${list}" var="li" varStatus="st">
						<li >
							<h5 style="margin-left:.8rem;">${li.cname}</h5>
							<p style="position: absolute;left: 5rem;margin-top:-3.3rem">
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
	</div>
</body>
</html>