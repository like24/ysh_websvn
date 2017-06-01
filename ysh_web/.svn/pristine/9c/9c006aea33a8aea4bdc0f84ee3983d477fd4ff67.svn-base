<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../../taglibs.jsp" %>
<c:set var="footclass" value="course" />
<!doctype html>
<%
   request.setAttribute("v", System.currentTimeMillis());
%>
<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="0">
		<link rel="stylesheet" href="${ctx}/css/reset.css?v=${v}">
		<link rel="stylesheet" href="${ctx}/css/common.css?v=${v}">
		<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${v}">
		<link rel="stylesheet" href="${ctx}/css/slimming-course.css?v=${v}" id="link">
		<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${v}"></script>
		<title>孕产瑜伽私教集训营</title>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js?v=${v}"></script>
		<script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${v}"></script>
		<script type="text/javascript">
			var nodata = 0;
			/* 判断是不是安卓 */
			var u = navigator.userAgent;
			var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
			if(isAndroid) {
				var linkDom = $("<link rel='stylesheet' href='${ctx}/css/tlq1.css'>");
				$("#link").after($(linkDom));
			}
// 			if(!${isbuy}) {
// 				window.location.href = "http://weixin.keepyoga.com/pay/ycA0342.html";
// 			}
		</script>
	</head>

	<body>
		<div style="display:hidden">
			<audio id="audio111" preload autoplay onplaying="playstart()">
				<source src="" type="audio/mp3">
			</audio>
		</div>
		<img src="http://wimg.keepyoga.com/images/shou-share-iocn.jpg" alt="" style="position: absolute;z-index: -99;" />
		<!--是否显示视频区域-->
		<div id="arrow_up">隐藏</div>
		<!-- side  button -->
		<div class="sideBtn">
			<span class="icon icon1 " id="goTop"></span>
			<span class="icon icon2" id="goBottom"></span>
			<span class="icon icon3" onclick="gapall(this)" id="gapall"></span>
		</div>
		<!-- 页面正在加载提示框 -->
		<div class="stash">
			<span>拼命加载中，请稍候……</span>
		</div>
		<div class="wrapper">
			<header>
				<div class="audio_video">
						<!--<video width="100%;" height="10rem;" id="audio" controls style="background:url('${course.code}');background-size:100%;">
						<source src="${course.title}"> </video>-->
					<div class="audioMask" id="audioMask" data-source="${course.title}"></div>
					<div class="audio_style"></div>
				</div>
			</header>
			<!--导师页面 提示点击用户头像可禁言该用户-->
			<p class="teach-remind hide" id="headTit">点击用户头像即可选择禁言该用户</p>
			<!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
			<section class="mainBox" id="mainBox">
				<ul id="list" class="list">
					<li class="systemMessages">
						<p><span>系统消息：</span>您好,欢迎进入随心瑜Live直播间。本次课程的视频课件已上传,请提前学习,准备提问的问题。导师在线直播答疑时间：晚上20:30-21:15，请准时上线与老师互动！课程笔记获取及交流，加官方微信：keepyoga002
						</p>
					</li>
					<li id="_flg_li" style="display: block;width: 100%;height: 2rem;margin-bottom: 0;"></li>
				</ul>
			</section>
			<footer>
				<!--导师和管理员-->
				<div class="ls student" id="lsOrGl">
					<form action="">
						<p class="all sendImage">
							<i></i>
							<span>图片</span>
						</p>
						<p class="share" id="recold">
							<i></i>
							<span>语音</span>
						</p>
						<!--<p class="share tapShare">
							<i></i>
							<span>分享</span>
						</p>-->
						<div style="" id="tex">
							<div class="tex">
								<input type="text keyuptext" placeholder="在此输入消息" maxlength="256" id="Itext" onkeyup="keyup()">
							</div>
							<button id="Enter" type="button" onclick="addComment()">发送</button>
						</div>
						<div class="record" id="longTAP" style="display:none">按住&nbsp;&nbsp;说话</div>
					</form>
				</div>
				<!-- 学生 -->
				<div class="student gl" id="xs">
					<form action="">
						<p class="all showtype">
							<i class=""></i>
							<span class="" id="_showtype">只看导师</span>
						</p>
						<!--<p class="share tapShare">
							<i></i>
							<span>分享</span>
						</p>-->
						<div class="tex">
							<input type="text keyuptext" class="textPap" maxlength="256" placeholder="快来提问吧" id="Itext" onkeyup="keyup()">
						</div>
						<button id="Enter" type="button" onclick="addComment()">发送</button>
					</form>
				</div>
				<!--导师针对学员信息回复语音-->
				<div class="teachAnser" style="display:none">
					<div>
						<h1 class="name"></h1>
						<p class="text"></p>
						<img src="${ctx}/images/close.jpg" style="width:1rem;height:1rem;position:absolute;right:.5rem;top:.5rem;">
						<div class="record" id="longTAP1">按住&nbsp;&nbsp;说话</div>
					</div>
				</div>
			</footer>
		</div>
		<div class="loading" id="loading"><img src="${ctx}/resources/images/pullpu.gif" alt="" />
			数据正在加载中...
		</div>
		<script src="${ctx}/js/zepto.js?v=${v}"></script>
		<script src="${ctx}/js/iscroll4.js" id="aa"></script>
		<script src="${ctx}/js/fastclick.min.js" id="aa"></script>
		<script src="${ctx}/js/wblog.js?v=${v}"></script>
		<script>
			/*初始化一些后端参数*/
			var title1 = "地表最强三大孕产瑜伽名师线上工作坊，只要199";
			var desc1 = "王昕、陈蕙、Jennifer三大名师手把手教你是一种怎样的体验";
			var link1 = "${ctx}/pay/yc${uuid}.html"
			var img1 = "http://wimg.keepyoga.com/images/Pregnant_yoga10.jpg";

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
					'checkJsApi', 'openLocation',
					'getLocation', 'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
					'onMenuShareQQ', 'onMenuShareWeibo', 'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
					'showAllNonBaseMenuItem', 'chooseImage', 'previewImage', 'uploadImage', 'startRecord', 'stopRecord', 'closeWindow',
					'chooseWXPay', 'downloadImage', 'getNetworkType', 'openLocation', 'playVoice', 'pauseVoice', 'stopVoice', 'uploadVoice', 'downloadVoice',
					'getLocation', 'hideOptionMenu', 'showOptionMenu'
				]
			});
			wx.ready(function() {
				wx.hideAllNonBaseMenuItem();
				wx.showMenuItems({
					menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				});
				wx.onMenuShareTimeline({
					title: title1, // 分享标题
					link: link1, // 分享链接
					imgUrl: img1, // 分享图标
					success: function(res) {
						if(res.errMsg == 'shareTimeline:ok') {
							tips('恭喜，分享成功！');
						}
					},
					cancel: function() {}
				});
				wx.onMenuShareAppMessage({
					title: title1, // 分享标题
					desc: desc1, // 分享描述
					link: link1, // 分享链接
					imgUrl: img1, // 分享图标
					type: '', // 分享类型,music、video或link，不填默认为link
					dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
					success: function(res) {
						if(res.errMsg == 'sendAppMessage:ok') {
							tips('恭喜，分享成功！');
						}
					},
					cancel: function() {}
				});
				$("#audio111").get(0).pause();
				$("#audio111").get(0).volume = 1;
				$("#audio111").get(0).play();
			});

			var PARAMETERS = {
				ctx: '${ctx}',
				appid: '${appid}',
				timestamp: '${timestamp}',
				nonceStr: '${nonceStr}',
				signature: '${signature}',
				courseId: ${course.id},
				userId: ${user.id},
				courseTid: ${course.tid},
				courseMamagerid:${ course.mamagerid},
				socketaddress: '${socketaddress}',
				wxId: '${wxid}',
				urlsecret: '${urlsecret}',
				courseTeacherids: '${course.teacherids}',
				courseHolderids: '${course.holderids}',
				nologin: ${nologin},
				isbuy: ${isbuy},
				isflow: ${isfollow}
			}
		</script>
		<script src="${ctx}/js/model_dialog.js"></script>
		<script src="${ctx}/js/slimming-course.js"></script>

	</body>

</html>