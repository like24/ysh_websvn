<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %> 
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="http://weixin.keepyoga.com/css/reset.css?v=201121S2">
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<title>实战经管集训营课程</title>
	<link rel="stylesheet" href="http://wimg.keepyoga.com/distribution3.css">
	<script src="http://weixin.keepyoga.com/js/setfontsize.js?v=201121S2"></script>
	<style type="text/css">
		body{-webkit-overflow-scrolling : touch; }
	</style>
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
			wx.hideOptionMenu();
		});
	</script>
	<div class="bj" style="line-height=0;font-size=0;">
		<img src="http://wimg.keepyoga.com/images/1.pic_hd_01.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/1.pic_hd_02.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/1.pic_hd_03.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/app_distriution.jpg" alt="">
	</div>
</body>
</html>
