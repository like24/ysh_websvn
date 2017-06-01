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
	<link rel="stylesheet" href="http://weixin.keepyoga.com/css/reset.css?v=${version}">
	<link rel="stylesheet" href="http://wimg.keepyoga.com/css/toupiao2.css?v=${version}">
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script src="${ctx}/js/setfontsize.js"></script>
	<script src="http://weixin.keepyoga.com/js/jquery.min.js"></script>
	<title>随心瑜国庆送礼活动</title>
	<style type="text/css">
		html,body{
		width:100%;
		height:100%;
		overflow:hidden;}
		.wrapper{
		width:100%;
		height:100%;
		overflow:scroll;
		}
	</style>
</head>
<body>
	<script>
		var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
	</script>
	<div id="masking"></div>
	<div class="share">
		<img src="http://wimg.keepyoga.com/images/zq6.png" alt="">
	</div>
	<div class="erweima">
		<img src="http://wimg.keepyoga.com/images/zq.jpg" alt="" class="img">
	</div>
	<div class="toupiao1" style="display:none">
		<div></div>
		<img src="${fromuser.file_path}" alt="" class="tou">
		<h4>${fromuser.nickname}</h4>
		<p>我在参与“随心瑜国庆送礼”活动，快来帮我投票吧</p>
<!-- 		<button class="left" >给Ta投票</button> -->
<!-- 		<button class="right" >我也参与</button> -->
		<button style="background:#DCDCDC;">给Ta投票</button>
		<button style="background:#DCDCDC;">我也参与</button>
	</div>
	<div class="wrapper">
		<div class="top">
			<img src="http://wimg.keepyoga.com/images/tp1.jpg" alt="">
			<img src="http://wimg.keepyoga.com/images/tp3.jpg" alt="">
			<button type="button" id="goshare">
			<!--活动结束隐藏第一个-->
<!-- 			<img src="http://wimg.keepyoga.com/images/ljfx-2.png" alt=""> -->
				<img src="http://wimg.keepyoga.com/images/over.png" alt=""></button>
			</button>
		</div>

		<img src="http://wimg.keepyoga.com/images/tpdz.jpg" alt="" class="tp2">
		<div class="bottom">
			<img src="http://wimg.keepyoga.com/images/tp5.jpg" alt="">
			<!--无人投票时不显示-->
			<c:if test="${votelist.size()==0}">
				<b>还没有人为您投票，赶快分享给您的小伙伴吧！</b>
			</c:if>
			<c:if test="${votelist.size()>0}">
				<b>已有${votelist.size()}人为您投票</b>
			</c:if>
		</div>
		<div class="toupiao">
			<ul>
				<li>
				<c:forEach items="${votelist}" var="vote" varStatus="status">
					<img src="${vote.file_path}" alt="">
					<c:if test="${(status.index+1)%10==0}">
				      </li>
				      <li>
				 	</c:if>
				</c:forEach>
				</li>
			</ul>
		</div>
		<img src="http://wimg.keepyoga.com/images/tp4.jpg" alt="" class="foot">
	</div>
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
			wx.hideMenuItems({
 			    menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
 			});
			var linka = "${ctx}/weixin/${cur_uid}/sharevote.html";
			wx.onMenuShareAppMessage({
			    title: '我在参与“随心瑜国庆送礼”活动，快来帮我投票吧', // 分享标题
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
				 title: '我在参与“随心瑜国庆送礼”活动，快来帮我投票吧', // 分享标题
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
		
		if("${hasnotice}" == "false"){//没有关注
			$("#masking").show();
			$(".erweima").show();
			$(".share").hide();
			$(".toupiao1").hide();
			$(".wrapper").css("overflow","hidden");
		}else if("${hasvote}"=="false"){//没有投票
			$("#masking").show();
			$(".toupiao1").show();
			$(".erweima").hide();
			$(".share").hide();
		}else{//已投票已关注
			$("#masking").hide();
			$(".erweima").hide();
			$(".share").hide();
			$(".toupiao1").hide();
		}
		
		$(".left").one("click",function(){
			$.post("${ctx}/weixin/${from_uid}/dovote${from_actid}.html",function(data){
				if(data.status){
					$(".toupiao1").hide();
					$("#masking").hide();
				}else{
					alert(data.msg);
				}
			});
		});
		$(".right").one("click",function(){
			$(".toupiao1").hide();
			$("#masking").hide();
		});
// 		$("#goshare").on("click", function () {
// 			$("html,body").animate({
// 				scrollTop: 0
// 			}, 0);
// 			$("#masking").show();
// 			$(".share").show();
// 		$(".wrapper").css("overflow","hidden");
// 		});
		$(".share").on("click", function () {
			$("#masking").hide();
			$(".share").hide();
			$(".wrapper").css("overflow","scroll")
		});
		// 	alert('${nologin}'+"hasnotice:"+'${hasnotice}'+",hasvote:"+'${hasvote}'+",cur_id:"+'${cur_uid}');
	</script>
	<script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?ba67d2ff32de2e30f289292c1cbf41d4";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
	</script>
</body>
</html>