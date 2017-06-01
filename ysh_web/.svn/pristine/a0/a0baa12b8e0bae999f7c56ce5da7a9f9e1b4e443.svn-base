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
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=201121S2">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=201121S2">
	<script src="${ctx}/js/jquery.min.js?v=201121S2"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<title>随心瑜Live中秋投票活动</title>
	<link rel="stylesheet" href="${ctx}/css/mid-autumn.css">
	<script src="${ctx}/js/setfontsize.js?v=201121S2"></script>
</head>
<body>
	<div class="wrapper">
	<!-- 所有的弹框开始 -->
		<div id="masking"></div>
		<div class="Success">
			<img src="${ctx}/images/close.jpg" class="close" alt="">
			<img src="${ctx}/images/success.png" alt="">
			<p class="goodLuck">恭喜您！您成功参与“中秋投票赢好礼”活动</p>
			<p class='tapRight'>点击屏幕右上角，选择发送给好友或分享到朋友圈，邀请更多小伙伴帮忙投票吧！</p>
			<button class="iKnow">我知道了</button>
		</div>
		<div class="toupiao">
			<div></div>
			<img src="${autorUser.file_path }" alt="" class="tou">
			<h4>${autorUser.nickname}</h4>
			<p>我正在参与“中秋豪礼-瑜伽重磅课程免费送”活动，快帮我投票吧</p>
			<c:if test="${hasvote == 1}">
				<button class="left">给他投票</button>
			</c:if>
			<c:if test="${hasvote == 0||isend}">
				<button class="leftot">给他投票</button>
			</c:if>
			<c:if test="${join||isend}">
				<button class="rightot">我也参与</button>
			</c:if>
			<c:if test="${not join}">
				<button class="right">我也参与</button>
			</c:if>
		</div>
		<div class="erweima">
			<img src="${ctx}/images/zq.jpg" alt="" class="img">
		</div>
		<div class="share">
			<img src="${ctx}/images/zq6.png" alt="">
		</div>
		<!-- 所有的弹框结束 -->
		<img src="${ctx}/images/zq2.jpg" alt="">
		<!--还未有人投票-->
		<!--<img src="${ctx}/images/zq5.jpg" alt="">-->
		<!--投票人数-->
		<div class="mainBj">
		<c:if test="${join}">
			<p class="manLen">共有${votecount}人为您投票</p>
			<c:if test="${votecount==0}">
					<img src="${ctx}/images/zq5.png" class="zq5" alt="">
				</c:if>
			<div class="man">
			<c:forEach items="${votelist}" var="vote">
				<img src="${vote.file_path}" alt="">
			</c:forEach>
			</div>
		</c:if>
		<c:if test="${!join}">
			<div style="width:100%;height:3.5rem;">
			</div>
		</c:if>
			<c:if test="${!isend}">
				<button class="btn fenxiang" id="sharebtn" style="display:${join?'':'none'}">分享</button>
				<button class="btn canyu" id="btn" style="display:${join?'none':''}">立即参与 赢取好礼</button>
			</c:if>
			<c:if test="${isend}">
				<button class="btn jieshu" style="background: #9b9b9b;color:#fff;">活动已结束</button>
			</c:if>
		</div>
		<img src="${ctx}/images/zqfooter.jpg" alt="">
	</div>
	<script src="${ctx}/js/zepto.js?v=201121S2"></script>
	<script>
        var pageIndex = 1;
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

        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
		
		wx.ready(function(){
			var linka = "${ctx}/weixin/${uid}/midautumn.html";
// 			wx.hideOptionMenu();
			wx.hideMenuItems({
// 			    menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
			if("${haseNotice}" == "true"&&"${ismine}"!="1"&&"${join}"!="false"){
				wx.hideOptionMenu();
			}
			wx.onMenuShareAppMessage({
			    title: '我正在参与随心瑜Live“中秋豪礼——瑜伽重磅课程免费送”活动，快来帮我投票吧', // 分享标题
			    desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
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
				 title: '我正在参与随心瑜Live“中秋豪礼——瑜伽重磅课程免费送”活动，快来帮我投票吧', // 分享标题
				 desc: '随心瑜Live——专业的瑜伽教学平台', // 分享描述
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
		
		
	</script>

	<script>
		if("${haseNotice}" == "false"){
			$("#masking").show();
			$(".erweima").show();
			$(".toupiao").hide();
			$(".wrapper").css("overflow-y","hidden");
		}else if("${ismine}"=="1"){
			$(".toupiao").hide();
			$(".erweima").hide();
//	 		if((("${hasvote}"=="1"||"${join}"=="false")&&"${haseNotice}" == "true"||"${ismine}"!="1")){
//	 			}
		}else{
			$("#masking").show();
			$(".toupiao").show();
			$(".erweima").hide();
		}
		$(".masking").on("click", function () {
			showhide();
		})
		$(".share").on("tap", function () {
			if ($(".share").is(':visible')) {
				$("#masking").hide();
				$(".share").hide();
			}
		})

		function showhide() {
			if ($(".Success").is(':visible')) {
				$("#masking").hide();
				$(".Success").hide();
			}
			if ($(".toupiao").is(':visible')) {
				$("#masking").hide();
				$(".toupiao").hide();
			}
			if ($(".erweima").is(':visible')) {
				$("#masking").hide();
				$(".erweima").hide();
			}
		}
		$(".iKnow").on("tap", function () {
			$("#masking").hide();
			$(".Success").hide();
		})
		$(".close").on("tap", function () {
			showhide()
		})
		$(".left").on("tap", function () {

		})
		$(".right").on("tap", function () {

		})
		$("#sharebtn").on("tap",function(){
			$("#masking").show();
			$(".share").show();
		})
		
		$("#btn").on("tap",function(){
// 			alert("00000");
			$.post("${ctx}/weixin/join/midautumn.html",function(data){
				if(data.status){
					$(".Success").show();
					$("#btn").hide();
					$("#sharebtn").show();
				}else{
					alert(data.msg);
				}
			});
		});
		$(".right").one("tap",function(){
			$(".toupiao").hide();
			window.location.href="${ctx}/weixin/active/midautumn.html";
// 			$.post("${ctx}/weixin/join/midautumn.html",function(data){
// 				if(data.status){
// 					window.location.reload();
// 				}else{
// 					alert(data.msg);
// 				}
// 			});
		});
		$(".left").one("tap",function(){
			$.post("${ctx}/weixin/vote${autorUser.id}/midautumn${actorid}.html",function(data){
				if(data.status){
// 					window.location.reload();
					$(".toupiao").hide();
					$("#masking").hide();
// 					window.location.href="${ctx}/weixin/active/midautumn.html";
				}else{
					alert(data.msg);
				}
			});
		});
		
	</script>
</body>

</html>
