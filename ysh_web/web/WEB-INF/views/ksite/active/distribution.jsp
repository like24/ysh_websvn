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
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<title>瑜伽私教线上集训营</title>
	<link rel="stylesheet" href="${ctx}/css/distribution.css?v=${version}">
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
	<script src="${ctx}/js/jquery.min.js"></script>
	<style type="text/css">
	html,
		body,
		.wrapper {
			width: 100%;
			height: 100%;
			font-size: 0;
			background: #033262;
			-webkit-overflow-scrolling: touch;
		}
		
		img {
			width: 100%;
			height: auto;
			display: inline-block;
		}
		</style>
</head>
<body>
	<div style="display: none;"><img src="${ctx}/images/fx1_02.jpg" alt=""></div>
	<div class="erweima" style="display: none;">
		<img src="${ctx}/images/close.jpg" alt="" class="close">
		<img src="${ctx}/images/zq.jpg" alt="" class="img">
	</div>
	<div id="masking" style="display: none;"></div>
	<input type="hidden" id="signupid" value="0" />
	<input type="hidden" id="ordernumber" value="${ordernumber}" />
	
	<div class="submitBox" id="submitBox">
		<div class="titleBox">
			<div>
				<img src="${ctx}/images/fx1_02.jpg" alt="">
			</div>
			<h4>瑜伽私教线上集训营</h4>
			<span>￥99</span>
		</div>
		<div class="inputBox">
			<label for="name">
				<i>*</i>
				<span>姓名：</span>
				<input type="text" id="name">
			</label>
			<label for="phone" class="phone">
				<i>*</i>
				<span>手机：</span>
				<input type="number" id="phone">
			</label>
			<label for="city">
				<i>*</i>
				<span>城市：</span>
				<input type="text" id="city">
			</label>
		</div>
		<p class="subP">
			<a href="javascript:;" class="submitBtn" id="submitBtn">提交订单</a>
		</p>
	</div>
	<div class="bj">
		<img src="http://wimg.keepyoga.com/images/a1.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/a2.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/a3.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/a4.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/a5.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/a6.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/a7.jpg" alt="">
	</div>
	<footer>
		<c:if test="${hasJoin}">
			<a href="javascript:;" style="background-color: #c0c0c0;">已购买</a>
		</c:if>
		<c:if test="${not hasJoin}">
		 <!-- 
			<a href="javascript:;" id="goShoping" style="display: none;">立刻购买</a>
		 -->
		</c:if>
	</footer>
	<script>
	var _hmt = _hmt || [];
	(function() {
	  var hm = document.createElement("script");
	  hm.src = "//hm.baidu.com/hm.js?ba67d2ff32de2e30f289292c1cbf41d4";
	  var s = document.getElementsByTagName("script")[0]; 
	  s.parentNode.insertBefore(hm, s);
	})();
	</script>
	<script type="text/javascript">
	 	var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
		if("${hasJoin}" == "true" && "${hasNotice}" == "false"){
			$(".erweima").show();
			$("#masking").show();
		}
// 		if("${hasJoin}" == "true" && "${hasNotice}" == "true"){
// 			window.location.href = "http://weixin.keepyoga.com/weixin/jieshao.html";  
// 		}
		
		wx.config({
		    debug: false,
		    appId: '${appId}',
		    timestamp:'${timeStamp}' ,
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
		
		$("#goShoping").on("click", function () {
			if("${nologin}" == "true"){
			    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";				
			}
			if ($(this).text() == "立刻购买") {
				$("#submitBox").animate({
					bottom: 0
				}, 500);
				$("#submitBtn").show();
			}
		});
		
		/*购买成功函数*/
		function Success() {
			$("#goShoping").css("background", "#c0c0c0").text("已购买");
			$.post("${ctx}/w/payforsignup/"+$("#signupid").val()+".html",function(data){
				if(!data.status){
					alert("系统异常，请联系客服人员！");
				}else{
					if("${hasNotice}" == "false"){
						$(".erweima").show();
						$("#masking").show();
					}else{
						window.location.href = "http://weixin.keepyoga.com/weixin/jieshao.html";
					}
				}
			});
		}
		
		/*取消付款，删除订单*/
		function cancle(){
			$.post("${ctx}/w/deleteforsignup/"+$("#signupid").val()+".html");
		}

		$("#submitBtn").on("click", function () {
			var name = $("#name").val(),
				phone = $("#phone").val(),
				city = $("#city").val();
			if(name == ""){
				alert("请输入真实姓名！")
				return;
			}
			if(phone == ""){
				alert("请输入手机号！")
				return;
			}
			if(!check_phone(phone)){
				alert("请输入正确的手机号！");
				return;
			}
			if(city == ""){
				alert("请输所在城市！")				
				return;
			}
			$("#submitBtn").hide();
			$.post("${ctx}/w/updateuser/info.html",{"name":name, "phone":phone, "city":city,"sign":"${sign}","ordernumber":$("#ordernumber").val()},function(data){
				if(data.status){
					$("#signupid").val(data.signupid);
					weixinPay();
				}else{
				}
			});

		});
		
		function check_phone(phone) {
	        var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
	        if (!reg.test(phone)) {
	            return false;
	        }
	        return true;
	    }
		$("#masking").on("click", function () {

			$("#masking").hide();
			$(".erweima").hide();
		})
		function weixinPay(){
			wx.ready(function(res){
				wx.chooseWXPay({
		  		    timestamp: "${paytimestamp}", // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
				    nonceStr: "${paynonceStr}", // 支付签名随机串，不长于 32 位
				    package: "${paypackage}", // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
				    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
				    paySign: "${paySign}", // 支付签名
				    success: function (res) {
				    	//alert(JSON.stringify(res))
				        // 支付成功后的回调函数
				    	if( res.errMsg == 'chooseWXPay:ok'){
		                	$("#submitBox").animate({
		        				bottom: -17 + "rem"
		        			}, 500);
		        			Success();
		                }else{
		                	$("#submitBox").animate({
		        				bottom: -17 + "rem"
		        			}, 500);
		                	cancle();
		                }
				    },
				    cancel:function(res){
				    	//alert(JSON.stringify(res))
				    	$("#submitBox").animate({
	        				bottom: -17 + "rem"
	        			}, 500);
	                	cancle();
				    }
				    
				    
				});
			});
			$(".close").on("click", function () {

				$("#masking").hide();
				$(".erweima").hide();
			})
/* 		 wx.error(function (res) {
		     alert("error:" + JSON.stringify(res));
		 }); */
	  }
	</script>
</body>
</html>