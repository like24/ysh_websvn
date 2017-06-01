<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %> 
<!doctype html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/reset.css?v=${version}">
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<title>成为课代表</title>
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/distribution.css?v=${version}">
	<script src="http://wimg.keepyoga.com/js/setfontsize.js?v=${version}"></script>
	<script src="http://wimg.keepyoga.com/js/jquery.min.js"></script>
	<style type="text/css">
	.foot{position: fixed;bottom: 0;height: 2.36rem;width: 100%;}
	.foot .left{width: 62%;height: 2.36rem;line-height: 2.36rem;background-color: #fff;font-size: 11px;position: absolute;top: 0;}
	.foot .left .content{height: 2rem;margin:.18rem auto;width: 186px;}
	.foot .left span{background: url('http://wimg.keepyoga.com/image/checked.jpg');width: .775rem;height: .775rem;display: inline-block;position: relative;left: -.1rem;top: .16rem;background-size: contain;}
	.foot .left a{text-decoration: underline;color:#0443cc;}
	.foot .right{width: 38%;height: 2.36rem;line-height: 2.36rem;text-align: center;background-color: #e03c6e;font-size: 18px;position: absolute;right: 0;top: 0;color: #fff;font-size: 15px;}
	.foot .grey{width: 38%;height: 2.36rem;line-height: 2.36rem;text-align: center;background-color: #9c9c9c;font-size: 18px;position: absolute;right: 0;top: 0;color: #fff;font-size: 15px;}
	.contentOK{width:100%;text-align:center;background:white;border-top:1px solid #e8e8e8;height: 2.36rem;line-height: 2.36rem;font-size:14px;}
	.contentOK a{color:blue;text-decoration: underline;}
	body{-webkit-overflow-scrolling: touch;}
	</style>
</head>
<body>
	<div class="bj">
		<img src="http://wimg.keepyoga.com/image/distructor.jpg" alt="">
	</div>
	<div class="foot">
		<input type="hidden" id="checked" value="0"/>
	
		<c:if test="${not isdistirbutoe}">
			<div class="left">
			<div class="content"><span></span>我已阅读并同意<a href="http://wx.keepyoga.com/weixin/pages/agreement.html">随心瑜Live用户协议</a></div>
			</div>
			<div class="right">成为课代表</div>		
		</c:if>
		<c:if test="${isdistirbutoe}">
			<div class="content contentOK"><span></span>您已成为课代表，<a href="${ctx}/weixin/assistant/success.html">点击这里</a>查看分销方式</div>
		<!-- 	<div class="grey">成为课代表</div>		 -->
		</c:if>
	</div>
	<script>
	var _hmt = _hmt || [];
	(function() {
	  var hm = document.createElement("script");
	  hm.src = "//hm.baidu.com/hm.js?ba67d2ff32de2e30f289292c1cbf41d4";
	  var s = document.getElementsByTagName("script")[0]; 
	  s.parentNode.insertBefore(hm, s);
	})();
	</script>
	<script src="http://wimg.keepyoga.com/js/setfontsize.js"></script>
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
			wx.hideMenuItems({
				menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
			var linka = window.location.href;
			wx.onMenuShareAppMessage({
			    title: '随心瑜Live喊你来当课代表啦', // 分享标题
			    desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
			    link: linka, // 分享链接
			    imgUrl: 'http://wimg.keepyoga.com/355481714971996472.jpg', // 分享图标
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
				 title: '随心瑜Live喊你来当课代表啦', // 分享标题
				 desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
				 link: linka, // 分享链接
				 imgUrl: 'http://wimg.keepyoga.com/355481714971996472.jpg', // 分享图标
			    success: function () { 
			        // 用户确认分享后执行的回调函数
			    },
			    cancel: function () { 
			        // 用户取消分享后执行的回调函数
			    }
			});
		});
	
		var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
// 		if("${isdistirbutoe}" == "true"){
// 			window.location.href= "${ctx}/weixin/assistant/success.html";	
// 		}
		$(function(){
			$("span").on("click",function(){
				var flg = $("#checked").val();
				if(flg == 0){
					$(this).css({"background":"url('http://wimg.keepyoga.com/image/check.jpg')","background-size": "contain"});
					$("#checked").val(1);
				}else{
					$(this).css({"background":"url('http://wimg.keepyoga.com/image/checked.jpg')","background-size": "contain"});
					$("#checked").val(0);
				}
			});
		});
		$(".right").on("click",function(){
			var flg = $("#checked").val();
			if(flg == 1){
				alert("请先同意协议！");
				return;
			}else{
				window.location.href="${ctx}/weixin/assistant/success.html";
			}
		});
	</script>
</body>
</html>