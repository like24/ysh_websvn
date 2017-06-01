<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../../taglibs.jsp" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>随心瑜会员管理系统免费领取</title>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/reset.css?v=201246">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/swiper-3.3.1.min.css?v=201246">
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" href="${ctx}/css/animateAdd.css">
	<link rel="stylesheet" href="${ctx}/css/animation1.css">
</head>
<body>
	<div class="swiper-container swiper-container-v">
		<div class="swiper-wrapper">

			<div class="swiper-slide page1">
				<img src="http://wimg.keepyoga.com/images/page1_1.png" style="-webkit-animation-delay:.3s" class="page1_1 animated fadeIn">
				<img src="http://wimg.keepyoga.com/images/page1_2.png" style="-webkit-animation-delay:.8s" class="page1_2 animated zoomIn">
				<img src="http://wimg.keepyoga.com/images/page1_3.png" style="-webkit-animation-delay:.3s" class="page1_3 animated fadeIn">
				<img src="http://wimg.keepyoga.com/images/arrow1.png" class="page1_4">

				<img src="http://wimg.keepyoga.com/images/page1_6.png" style="-webkit-animation-delay:1.3s" class="page1_6 animated swing  ">
			</div>
			<div class="swiper-slide page2">
				<img src="http://wimg.keepyoga.com/images/page2_1_2.jpg" class="page2_1 animated bounceInDown">
				<img src="http://wimg.keepyoga.com/images/page2_2_2.png" style="-webkit-animation-delay:.8s" class="page2_base page2_2 animated rotateIn">
				<p class="tex1">来自<span>百度、阿里、腾讯</span>的专业研发团队</p >
				<p class="tex2">有<span>十年行业资深</span>瑜伽馆运营经验</p >
				<p class="tex3">想<span>解决</span>中小瑜伽馆创业经营难的行业<span>难题</span></p >
				<p class="tex4">为瑜伽人献上了<span>全球首款</span>互联网瑜伽馆会员管理系统</p >
			</div>

			<div class="swiper-slide page3">
				<img src="http://wimg.keepyoga.com/images/page3_1_2.jpg" style="-webkit-animation-delay:1.5s" class="page3_pic1 animated bounceInLeft">
				<img src="http://wimg.keepyoga.com/images/page3_2_2.jpg" style="-webkit-animation-delay:2s" class="page3_pic2 animated bounceInRight">
				<img src="http://wimg.keepyoga.com/images/page3_4_3.png" style="-webkit-animation-delay:2.5s" class="page3_pic3 animated bounceInLeft">
				<img src="http://wimg.keepyoga.com/images/page3_3_4.png" style="-webkit-animation-delay:3s" class="page3_pic4 animated bounceInRight">
				<img src="http://wimg.keepyoga.com/images/page3_4_4.png" style="-webkit-animation-delay:3.5s" class="page3_pic5 animated bounceInLeft">
				<img src="http://wimg.keepyoga.com/images/page3_6_2.png" style="-webkit-animation-duration:3s;" class="page3_pic6 animated bounceInUp">

			</div>


			<div class="swiper-slide page4">
				<img src="http://wimg.keepyoga.com/images/page4_bj.jpg" alt="" class="page4_1">
				<img src="http://wimg.keepyoga.com/images/page4_2.jpg" alt="" class="page4_2">
				<img src="http://wimg.keepyoga.com/images/page4_3.png" alt="" class="page4_3">
				<img src="http://wimg.keepyoga.com/images/page4_4.png" style="-webkit-animation-delay:6s" class="page4_4 animated rotateInDownRight">
			</div>

			<div class="swiper-slide page5">
				<img src="http://wimg.keepyoga.com/images/page5_2_5.jpg" class="page5_1 animated fadeInUp" style="-webkit-animation-delay:1s">
				<img src="http://wimg.keepyoga.com/images/H5_06.jpg" class="page5_2 animated zoomIn" style="-webkit-animation-delay:2s">
				<img src="http://wimg.keepyoga.com/images/page5_2_2.jpg" class="page5_3 animated zoomIn" style="-webkit-animation-delay:3s">
				<img src="http://wimg.keepyoga.com/images/page5_2_3.jpg" class="page5_4 animated zoomIn" style="-webkit-animation-delay:4s">
			</div>
			<div class="swiper-slide page6">
				<p class="page6_1 animated "  id="jrcode"></p >
				<p class="text1 animated " >长按扫描二维码</p >
				<a href="javascript:;" onclick="goAppUrl()"><img src="http://wimg.keepyoga.com/images/page6_3.jpg" alt="" class="page6_3"><img src='http://wimg.keepyoga.com/images/page6_2.png' class="page6_2"></ a>

			</div>

		</div>
	</div>



</body>

<script src="http://wimg.keepyoga.com/js/setfontsize.js?v=20161018"></script>
<script src="http://wimg.keepyoga.com/js/swiper-3.3.1.min.js"></script>
<script src="${ctx}/js/qrcode.min.js"></script>

<script>

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
	var linka = "${ctx}/w/extension/${uuid}.html";
	wx.onMenuShareAppMessage({
	    title: '全球首款专为瑜伽人研发的会员管理系统免费领取', // 分享标题
	    desc: '最懂瑜伽馆的经营管理工具', // 分享描述
	    link: linka, // 分享链接
	    imgUrl: 'http://wimg.keepyoga.com/139085731596156460.jpg', // 分享图标
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
		 title: '全球首款专为瑜伽人研发的会员管理系统免费领取', // 分享标题
		 desc: '最懂瑜伽馆的经营管理工具', // 分享描述
		 link: linka, // 分享链接
		 imgUrl: 'http://wimg.keepyoga.com/139085731596156460.jpg', // 分享图标
	    success: function () { 
	        // 用户确认分享后执行的回调函数
	    },
	    cancel: function () { 
	        // 用户取消分享后执行的回调函数
	    }
	});
});  

	new Swiper('.swiper-container-v', {
		direction: 'vertical'
	})
	var url = "http://m.keepyoga.com/static/register.php?recommender="+encodeURIComponent('${extension.cname}');
	var qrcode = new QRCode("jrcode", {
		text : url,
		width :135,
		height : 135
    });
	function goAppUrl(){
		window.location.href = url;
	}
</script>
</html>