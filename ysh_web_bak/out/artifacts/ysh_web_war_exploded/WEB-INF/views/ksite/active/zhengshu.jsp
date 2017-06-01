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
	<title>随心瑜Live毕业证书</title>
	<script src="http://weixin.keepyoga.com/js/setfontsize.js?v=201121S2"></script>
	<style>
		.wrapper {
			width: 100%;
			height: 100%;
			overflow-y: auto;
		}
		
		.wrapper>div {
			position: relative;
		}
		
		.wrapper img {
			width: 100%;
			height: auto;
		}
		
		span {
			position: absolute;
   			left: 7.6rem;
    		top: 13.6rem;
    		font-size: 20px;
    		color: black;
		}
		
		p {
			position: absolute;
			left: 6.1rem;
			top: 16rem;
			font-size: 30px;
			color: black;
			display: block;
			width: 93px;
			text-align: center;
		}
	</style>
</head>

<body>
	<div class="wrapper">
		<div>
			<c:if test="${imgurl == '0'}">
				<img src="http://wimg.keepyoga.com/zsss.jpg" alt="">
				<span>${zsno}</span>
				<p>${zsname}</p>
			</c:if>
			<c:if test="${imgurl != ''}">
				<img src="${imgurl}" alt="">
			</c:if>
		</div>
	</div>
	<script type="text/javascript">
	var title1 = "随心瑜Live毕业证书";
	var desc1  = "随心瑜Live——专业的瑜伽教学平台";
	var link1  = window.location.href;
	var img1   = "http://wimg.keepyoga.com/734394356101245431.jpg" ;
	
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
		var linka = link1;
		wx.hideOptionMenu();
		wx.onMenuShareAppMessage({
		    title: '随心瑜Live毕业证书', // 分享标题
		    desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
		    link: linka, // 分享链接
		    imgUrl: 'http://wimg.keepyoga.com/734394356101245431.jpg', // 分享图标
		    type: '', // 分享类型,music、video或link，不填默认为link
		    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		wx.onMenuShareTimeline({
			 title: '随心瑜Live毕业证书', // 分享标题
			 desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
			 link: linka, // 分享链接
			 imgUrl: 'http://wimg.keepyoga.com/734394356101245431.jpg', // 分享图标
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
	});
	</script>
</body>

</html>
