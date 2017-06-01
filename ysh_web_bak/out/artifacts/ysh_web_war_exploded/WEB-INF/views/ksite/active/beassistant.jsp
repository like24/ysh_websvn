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
	<title>热门课程</title>
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/reset.css?v=${version}">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/common.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/assistant3.css?v=${version}">
</head>

<body>
	<div style="display: none;"><img alt="" src="http://wimg.keepyoga.com/image/fx1_02.jpg"></div>
	<div class="wrapper">
		<div class="top">
			<img src="http://wimg.keepyoga.com/assistant_icon.jpg" alt="">
			<h1>恭喜您已成为私教集训营活动的课代表！</h1>
		</div>
		<div class="center">
			<h1>您可以通过以下两种方式分销课程：</h1>
			<ul>
				<li>
					<span>
						<i>1</i>
							<b>方式</b>
					</span>
					<div>
						<h2>常规转发分销</h2>
						<p>此页面已做特殊处理，请点击页面右上角...选择<img src="http://wimg.keepyoga.com/assistant_icon1.jpg">发送给朋友或<img src="http://wimg.keepyoga.com/assistant_icon2.jpg">分享到朋友圈</p>
					</div>
				</li>
				<li>
					<span>
						<i>2</i>
							<b>方式</b>
					</span>
					<div >
						<h2>长按复制下面链接，发送给好友或者朋友圈</h2>
						<p id="line"  >http://weixin.keepyoga.com/w/faq/distribution${sign}.html</p>
					</div>
				</li>
			</ul>
		</div>
		<div class="bottom">
			<h1>分销收益查看方式：</h1>
			<p>您可以进入随心瑜Live服务号 "我的><a style="color:blue;text-decoration: underline;" href="${ctx}/weixin/distribution2/${sign}.html">我的分销收益</a>" 查看收益和通过您的分享完成购买的用户</p>
			<h1>分销收益计算标准：</h1>
			<p>个人分销收益=99元/人*课程成交量*40%。</p>
		</div>
	</div>
	<script src="http://wimg.keepyoga.com/js/setfontsize.js?v=${version}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script>
		var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
        var icon = ""; 
		var title1 = "随心瑜Live|中秋投票活动";
		var desc1  = "赶紧邀请你的小伙伴来一起参与吧";
		var link1  = "";
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
		
		wx.ready(function(){
			wx.hideMenuItems({
				menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
			var linka = "${ctx}/w/faq/distribution${sign}.html";
			wx.onMenuShareAppMessage({
			    title: '瑜伽私教线上集训营', // 分享标题
			    desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
			    link: linka, // 分享链接
			    imgUrl: 'http://wimg.keepyoga.com/image/fx1_02.jpg', // 分享图标
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
				 title: '瑜伽私教线上集训营', // 分享标题
				 desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
				 link: linka, // 分享链接
				 imgUrl: 'http://wimg.keepyoga.com/image/fx1_02.jpg', // 分享图标
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