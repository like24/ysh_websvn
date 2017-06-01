<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../taglibs.jsp" %>
<!doctype html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<link rel="stylesheet" href="http://weixin.keepyoga.com/css/reset.css?v=${version}">
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<title>临时付款</title>
		<link rel="stylesheet" href="http://wimg.keepyoga.com/distribution3.css">
		<script src="http://weixin.keepyoga.com/js/setfontsize.js?v=${version}"></script>
		<script src="http://weixin.keepyoga.com/js/jquery.min.js?v=${version}"></script>
		<style type="text/css">
			body {
				-webkit-overflow-scrolling: touch;
			}
			.bj {
				display: block;
			}
			
			img {
				display: block;
			}
			footer {
				position: absolute;
				bottom: 0;
				left: 0;
				right: 0;
				width: 100%;
				height: 2.64rem;
				border-top: 1px solid #d6d6d6;
			}
			
			footer .item {
				float: left;
				box-sizing: border-box;
				width: 20%;
				height: 100%;
				text-align: center;
				background-color: #615964;
				color: white;
				border-right: 2px solid #f6f6f6;
			}
			
			footer .item img {
				display: inline-block;
				width: 0.865rem;
				height: 0.865rem;
				margin-top: 0.58rem;
				vertical-align: top;
			}
			
			a:active {
				-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
			}
			
			footer .item p {
				font-size: 0.576rem;
				color: white;
				margin-top: 0.234rem;
				margin-bottom: 0.342rem;
				height: 0.576rem;
			}
			
			footer a {
				line-height: normal;
				margin-left: 0;
				border-radius: 0;
				-webkit-tap-highlight-color: rgba(0, 0, 0, 0);
			}
			
			footer .buy {
				background-color: #fd4b47;
				height: 100%;
				font-size: .768rem;
				color: #fff;
				line-height: 2.64rem;
				text-align: center;
			}
			
			.pop {
				position: absolute;
				top: 0;
				bottom: 0;
				left: 0;
				right: 0;
				z-index: 200;
				background: rgba(0,0,0,.5);
			}
			
			.pop img {
				width: 100%;
				height: 100%;
				width: 100%;
   				 height: auto;
			}
			
			.hide {
				display: none;
			}
			
			.consult-hide {
				position: absolute;
				top: 76%;
				left: 50%;
				transform: translateX(-50%);
				z-index: 300;
				width: 8rem;
				height: 5rem;
			}
		.sendMes {
   			 color: red;
		    float: right;
		    margin-right: 1rem;
}
	#share{
		width:40%;
	}
	#share img{
		     margin: 0 .5rem;
		    margin-top: 0.58rem;
		    vertical-align: top;
	}
	label input{
		width:40%;
	}
	.share-ok{
		position: fixed;
		left: 0;
		right: 0;
		top:0;
		bottom:0;
		background: white;
		z-index: 99999;
		display: none;
	}
	.share-ok>div{
		width:100%;
		background: white;
		padding-bottom: 2rem;
		
	}
	.share-ok>div img{
		width:80%;
		height: auto;
		margin: 0 auto;
		display: block;
		
	}
	#shareOk a{
		 margin: 3rem auto;
    display: block;
    color: #ff9b0d;
    border: 1px solid #ff9b0d;
    width: 9rem;
    height: 2rem;
    text-align: center;
    line-height: 2rem;
    border-radius: 5px;
    font-size: .8rem;

	}
	.class-box{
		width:100%;
		height: 100%;
		position: absolute;
		left: 0;
		top:0;
		right:0;
		bottom: 0;
		overflow-y: scroll;
		z-index: 99999999;
		display: none;
		background: rgba(0,0,0,.8);
	}
	#close_box{
	    position: fixed;
    right: 0;
    width: 3rem;}
		</style>
	</head>

	<body>
		<div id="masking" style="display: none;"></div>
		<input type="hidden" id="signupid" value="0" />
		<input type="hidden" id="ordernumber" value="${ordernumber}" />
		<div class="submitBox" id="submitBox">
			<div class="titleBox">
				<div>
					<img src="http://wimg.keepyoga.com/images/Pregnant_yogasharimg.jpg" alt="">
				</div>
				<h4>临时付款</h4>
				<span>￥${money}</span>
			</div>
			<p class="subP">
				<a href="javascript:;" class="submitBtn" id="submitBtn">提交订单</a>
			</p>
		</div>
		<div class="bj" id="bj">
			<img src="http://wimg.keepyoga.com/images/ycyoge1.jpg">
			<img src="http://wimg.keepyoga.com/images/ycyoge2.jpg">
			<img src="http://wimg.keepyoga.com/images/ycyoge3.jpg"> 
		</div>
		<footer>
				<div class="item" id="consult"><img src="http://wimg.keepyoga.com/images/Pregnant_yoga8.jpg">
					<p>咨询</p>
				</div>
				<div class="item" id="share">
				<img src="http://wimg.keepyoga.com/images/Pregnant_yoga21.png" alt="" />
					<p>分享</p>
				</div>
				<div class="buy" id="goShoping">立刻报名<span style='font-size:0.5rem;'>￥</span>${money}<span style='font-size:0.5rem;'>.00</span></div>
		</footer>
		
		<div class='pop hide' id='consultPop'>
			<img src="http://wimg.keepyoga.com/images/ycyujiakefu1.png">
			<div class='consult-hide' id='consultHide'></div>
		</div>
		<div class="share-ok" id="shareOk">
			<div>
				<img src="http://wimg.keepyoga.com/images/ycyoga-ok111.jpg" alt="" />
				<a href="${ctx}/w/yc22.html">进入教室</a>
			</div>
		</div>
		<div class="class-box" id="classBox" >
			<img src="http://wimg.keepyoga.com/images/ycyogashareCalss.png" alt=""  style="width:100%;height:auto;"/>
		</div>
		<script src="${ctx}/js/layer/layer.js?2.x"></script>
		<script type="text/javascript">
			 
			var loggerid = 0;
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
					'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
					'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
					'showAllNonBaseMenuItem', 'chooseWXPay', 'hideOptionMenu', 'showOptionMenu'
				]
			});
			wx.ready(function() {
				wx.hideAllNonBaseMenuItem();
				wx.showMenuItems({
					menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				}); 
			});

			var disabledButton = false;
			 
			$("#classBox").on("click",function(){
				$("#classBox").hide();
			})
			$("#share").on("click", function() {
				$('#classBox').css("display","block");
			});
			$('#sharePop').on("click", function() {
				$('#sharePop').addClass('hide');
			});
			$("#consult").on("click", function() {
				$('#consultPop').removeClass('hide');
			});
			$('#consultHide').on("click", function() {
				$('#consultPop').addClass('hide');
			});

			$("#goShoping").on("click", function(e) {
				e.stopPropagation();
				if("${nologin}" == "true") {
					window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
					return;
				}
				if($(this).text().indexOf("立刻报名") > -1) {
					$("#submitBox").animate({
						bottom: 0
					}, 500);
				}
			});
			$("#bj").on('click', function(e) {
				if($(e.target).closest('#submitBox').length == 0) {
					$("#submitBox").animate({
						bottom: '-17rem'
					}, 500);
				}
			});
			  
			var dobuleClick = false;
			$("#submitBtn").on("click", function() {
				if("${nologin}" == "true") {
					window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
					return;
				} 
				weixinPay();
			}); 
			function weixinPay() {
				wx.ready(function(res) {
					wx.chooseWXPay({
						timestamp: "${paytimestamp}", // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
						nonceStr: "${paynonceStr}", // 支付签名随机串，不长于 32 位
						package: "${paypackage}", // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
						signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
						paySign: "${paySign}", // 支付签名
						success: function(res) {
							//alert(JSON.stringify(res))
							// 支付成功后的回调函数
							if(res.errMsg == 'chooseWXPay:ok') {
								$("#submitBox").animate({
									bottom: -17 + "rem"
								}, 500);
								tips('付款成功！');
							} else {
								$("#submitBox").animate({
									bottom: -17 + "rem"
								}, 500);
								tips('取消付款！');
							}
						},
						cancel: function(res) {
							//alert(JSON.stringify(res))
							$("#submitBox").animate({
								bottom: -17 + "rem"
							}, 500);
							 
						}
					});
				});
			}
			function tips(msg) {
				msg = "<font color='0xFFFFFF'>" + msg + "</font>"
				layer.open({
					content: msg,
					skin: 'msg',
					time: 2 //2秒后自动关闭
				});
			}
		</script>
	</body>

</html>