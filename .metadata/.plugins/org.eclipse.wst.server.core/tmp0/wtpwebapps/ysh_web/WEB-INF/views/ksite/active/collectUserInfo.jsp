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
	<title>信息完善</title>
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/reset.css?v=${version}">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/common.css?v=${version}">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/informationPerfect.css?v=${version}">
</head>

<body>
	<div class="wrapper">
		<section>
				<ul>
					<li>
						<label for="">信息完善：</label>
					</li>
					<li>
						<label for="">姓名：</label>
						<input type="text" id="name" placeholder="请输入姓名">
					</li>
					<li>
						<label for="">银行卡号：</label>
						<input type="number" id="bankno" placeholder="请输入银行卡号">
					</li>
					<li style="padding-bottom:1.6rem;">
						<label for="">开户行：</label>
						<input type="text" id="bankaddress" placeholder="请输入银行卡的开户行支行网点">
						<p>示例：广东省广州市招商银行天河路支行<span>请务必按照示例格式填写</span></p>
					</li>

					<li>
						<label for="">手机号：</label>
						<input type="number" id="mobile" placeholder="请输入手机号">
					</li>
					<li class="lastChild">
						<label for="">身份证：</label>
						<div>
							<img id="img_idcard1" src="http://wimg.keepyoga.com/images/sf.jpg" alt="">
							<button id="zheng">上传身份证正面</button>
							<input type="hidden" id="idcard1"/>
						</div>
						<div>
							<img id="img_idcard2" src="http://wimg.keepyoga.com/images/sf1.jpg" alt="">
							<button id="fan">上传身份证反面</button>
							<input type="hidden" id="idcard2"/>
						</div>

					</li>
					<p>此身份证仅用于汇款信息核实，不会造成您的个人信息泄露</p>
					
				</ul>
		</section>
		<button id="_btn" style="background-color: #118eff;">确认</button>
		<p>注意：请务必保证填写信息准确无误！若因您填写的电话、银行卡号等信息错误，导致打款失败，由此造成的损失由您自行承担。</p>
	</div>
	<script src="http://wimg.keepyoga.com/js/setfontsize.js"></script>
	<script src="http://wimg.keepyoga.com/js/jquery.min.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
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
		wx.hideOptionMenu();
		
		
	});
	$("#zheng").on("click",function(){
		choseImages(1);
	});
	$("#fan").on("click",function(){
		choseImages(2);
	});
	
	function choseImages(type){
		wx.chooseImage({
		    count: 1, // 默认9
		    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
		    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
		    success: function (res) {
		        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
		        uploadmage(localIds,type);
		    }
		});
	}
	
	function uploadmage(localid,type){
		wx.uploadImage({
		    localId: localid.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
		    isShowProgressTips: 1, // 默认为1，显示进度提示
		    success: function (res) {
		        var serverId = res.serverId; // 返回图片的服务器端ID
		        $.post("${ctx}/weixin/uploadweixinimage.do",{"serverid":serverId},function(data){
					if(type == 1){
						$("#idcard1").val(data);
						$("#img_idcard1").attr("src",data);
					}else{
						$("#idcard2").val(data);					
						$("#img_idcard2").attr("src",data);
					}				      
		    	});
		    }
		});		
	}
	
	$("#_btn").on("click",function(){
		var name = $("#name").val(),
			bankno = $("#bankno").val(),
			bankaddress = $("#bankaddress").val(),
			mobile = $("#mobile").val(),
			idcard1 = $("#idcard1").val(),
			idcard2 = $("#idcard2").val();
		if(name == ""){
			alert("姓名不能为空");
			return;
		}
		if(bankno == ""){
			alert("银行卡号不能为空");
			return;
		}
		if(bankno.length < 16 || bankno.length > 19){
			alert("银行卡长度错误");
			return;
		}
		if(bankaddress == ""){
			alert("开户行信息不能为空");
			return;
		}
		if(mobile == ""){
			alert("手机号不能为空");
			return;
		}
		if(mobile.length != 11){
			alert("手机号不正确");
			return;
		}
		if(idcard1 == ""){
			alert("身份证正面图片还未上传");
			return;
		}
		if(idcard2 == ""){
			alert("身份证背面还未上传");
			return;
		}
		$.post("${ctx}/weixin/updateuserinfo.html",{"name":name,"bankno":bankno,"bankaddress":bankaddress,"mobile":mobile,"idcard1":idcard1,"idcard2":idcard2},
			function(data){
				if(data.status > 0){
					alert("操作完成！");
					window.location.href = "${ctx}/weixin/distribution2/${sign}.html"
				}else{
					alert(data.masg);
				}
			});
	});
	
	</script>
</body>

</html>