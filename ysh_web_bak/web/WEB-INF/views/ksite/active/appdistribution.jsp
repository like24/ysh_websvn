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
	<title>随心瑜掌馆-实战经管集训营课程</title>
	<link rel="stylesheet" href="http://wimg.keepyoga.com/distribution3.css">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="http://weixin.keepyoga.com/js/setfontsize.js?v=201121S2"></script>
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script> 
	<style type="text/css">
		body{-webkit-overflow-scrolling : touch; }
		.bj{display:block;}
		img{display:block;}
	</style>
</head>
<body>
	<div id="masking" style="display: none;"></div>
	<input type="hidden" id="signupid" value="0" />
	<input type="hidden" id="ordernumber" value="${ordernumber}" />

	<div class="submitBox" id="submitBox">
		<div class="titleBox">
			<div>
				<img src="http://wimg.keepyoga.com/703800838396079815.png" alt="">
			</div>
			<h4>随心瑜掌馆-实战经管集训营课程</h4>
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
			<label for="pwd">
				<i>*</i>
				<span>验证码：</span>
				<input type="text" id="pwd">
				<span class="sendMes" id="getpwd">发送验证码</span>
			</label>
		</div>
		<p class="subP">
			<a href="javascript:;" class="submitBtn" id="submitBtn">提交订单</a>
		</p>
	</div>
	<div class="bj">
		<img src="http://wimg.keepyoga.com/images/yja_01.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/yja_02.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/yja_03.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/yja_04.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/yja_05.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/yja_06.jpg" alt="">
		<img src="http://wimg.keepyoga.com/images/yja_07.jpg" alt="">
	</div>
	<footer>
		<c:if test="${hasJoin}">
			<a href="${ctx}/w/app/distribution/success.html" style="background-color: #c0c0c0;width:9rem;margin-left:-4.5rem;color:#41C3A8;font-weight:bold;font-size:.8rem">听课流程</a>
		</c:if>
		<c:if test="${not hasJoin}">
		 <!-- 
			<a href="javascript:;" id="goShoping" style="background-color:#F49352;width:9rem;margin-left:-4.5rem;font-size:.8rem">立刻购买</a>
		 -->
		</c:if>
	</footer>
	<script src="${ctx}/js/wblog.js?v=${version}"></script>
	<script type="text/javascript">
	    var title1 = "随心瑜掌馆-实战经管集训营课程";
		var desc1  = "随心瑜会员管理系统,最懂瑜伽馆的经营管理工具";
		var link1  = location.href;
		var img1   = "http://wimg.keepyoga.com/703800838396079815.png" ;
		
		var loggerid = 0 ;
	 	var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
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
			    menuList: ["menuItem:copyUrl","menuItem:openWithQQBrowser","menuItem:openWithSafari","menuItem:share:email"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
	   });
		$(document).on("click", "#getpwd", function () {
			var phone=$("#phone").val();
			$.ajax({     
	            url: '${ctx}/w/app/distribution/sendcode.html',
	            type: 'post',   
	            dataType: "json",    
	            data: {'phone':phone},   
	            async: false,
	            success: function(data) { 
		            if (data.status) {
		            	
		            }else{
		            	Modal.tips("<font color='#ccc'>短信发送失败！</font>","error",1500);
		            }   
	            },     
	            error: function(err) {     
	            	Modal.tips("<font color='#ccc'>短信请求失败！</font>","error",1500);
	            }     
	        });     
				
			var time = 60;
			$("#getpwd").html(time);
			$("#getpwd").css({
				borderColor: "transparent",
				left: -40 + "px"
			});
			var timer = setInterval(function () {
				time--;
				$("#getpwd").html(time);
				if (time == 0) {
					clearInterval(timer);
					$("#getpwd").html("重新获取");
					$("#getpwd").css({
						borderColor: "#07d2ed",
						left: -120 + "px"
					});
				}
			}, 1000)
		})
		$("#goShoping").on("click", function () {
			console.log("------nologin=${nologin}");
			if("${nologin}" == "true"){
			    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";				
			}else{
				if ($(this).text() == "立刻购买") {
					$("#submitBox").animate({
						bottom: 0
					}, 500);
					$("#submitBtn").show();
				}
			}
		});
		/*购买成功函数*/
		function Success() {
			$("#goShoping").css("background", "#c0c0c0").text("已购买");
			$.post("${ctx}/w/app/payforsignup/"+$("#signupid").val()+".html?o=${ordernumber}&p="+loggerid,function(data){
				if(!data.status){
					Modal.tips("<font color='#ccc'>系统异常，请联系客服人员！</font>","error",1500);
				}else{
					window.location.href = "${ctx}/w/app/distribution/success.html";
				}
			});
		}
		function cancle(){
			$.post("${ctx}/w/app/deleteforsignup/"+$("#signupid").val()+".html");
		}
		$("#submitBtn").on("click", function () {
			var name = $("#name").val(),
				phone = $("#phone").val(),
				pwd = $("#pwd").val();
			if(name == ""){
				Modal.tips("<font color='#ccc'>请输入真实姓名！</font>","error",1500);
				return;
			}
			if(phone == ""){
				Modal.tips("<font color='#ccc'>请输入手机号！</font>","error",1500);
				return;
			}
			if(!check_phone(phone)){
				Modal.tips("<font color='#ccc'>请输入正确的手机号！</font>","error",1500);
				return;
			}
			if(pwd == ""){
				Modal.tips("<font color='#ccc'>请输入验证码！</font>","error",1500);
				return;
			}
			$.post("${ctx}/w/app/updateuser/info.html",{"name":name, "phone":phone, "pwd":pwd,"sign":"${sign}","ordernumber":$("#ordernumber").val()},function(data){
				if(data.status){
					console.log("------signupid="+data.signupid);
					$("#signupid").val(data.signupid);
					pay();
				}else{
					Modal.tips("<font color='#ccc'>验证码错误！</font>","error",1500);
				}
			});

		});
		function pay(){
			console.log("logurl=${ctx}/w/logger/3/${money}/${uid}.html?o=${ordernumber}");
			$.ajax({
				type:"post",
				dataType:"json",
				url:  "${ctx}/w/logger/3/99/${uid}.html?o=${ordernumber}",
				error:function(XMLHttpRequest,textStatus,error){},
				success:function(msg){
					console.log("logger.msg:"+msg.id);
					  if( msg.id > 0 ){
						  loggerid = msg.id; 
					      weixinPay();
					  }
					 
				}
		 });
		}
		
		function check_phone(phone) {
	        var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
	        if (!reg.test(phone)) {
	            return false;
	        }
	        return true;
	    }
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
	  }
	</script>
</body>
</html>