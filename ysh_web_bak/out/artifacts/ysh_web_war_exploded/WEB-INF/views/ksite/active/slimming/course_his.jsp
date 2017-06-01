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
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/slimming-course.css?v=${v}" id="link">
	<title>${course.name }</title>
	<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${v}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js?v=${v}"></script>
    <script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript">
        var nodata = 1;
        /* 判断是不是安卓 */
   	 	var u = navigator.userAgent;
   		 var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
   			 if(isAndroid){
   				var linkDom=$("<link rel='stylesheet' href='${ctx}/css/tlq1.css'>");
   				$("#link").after($(linkDom));
   		 }
   			 	if(!${isbuy}){
				window.location.href="http://wx.keepyoga.com/pay/nvshenM4643.html";
			}
    </script>
</head>
 <body>
 	    <div style="display:hidden" ><audio id="audio111" onplaying="playstart()"><source src="" type="audio/mpeg"></audio></div>
 <div class="sideBtn">
		<span class="icon icon1 " id="goTop"></span>
		<span class="icon icon2" id="goBottom"></span>
	</div>
	<!--是否显示视频区域-->
		<div id="arrow_up">隐藏</div>
    <div class="wrapper">
        <header>
				<div class="audio_video" >
					<!--<video width="100%;" height="10rem;" id="audio" controls style="background:url('${course.code}');background-size:100%;">
						<source src="${course.title}"> </video>-->
					<div class="audioMask" id="audioMask" data-source="${course.title}"></div>
					<div class="audio_style"></div>
				</div>
			</header>${course.code}
        <!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
        <section class="mainBox <c:if test="${user.id != course.tid}">main2</c:if> " id="mainBox"> 
            <ul id="list" class="list">
            </ul>
        </section>
        <footer>
            <c:if test="${course.tid != user.id }">
            	<div class="student gl">
	            	<form action="">
						<p class="all showtype" style="margin: 0 auto;">
							<i class=""></i>
							<span class="" id="_showtype">查看导师</span>
						</p>
					</form>
				</div>
            </c:if>
            <c:if test="${course.tid == user.id }">
            	<h1 style="text-align:center;font-size:18px;color:#3f3f3f;line-height:2.6rem;">互动已结束</h1>
            </c:if>
        </footer>
    </div>
    <div class="loading" id="loading"><img src="${ctx}/resources/images/pullpu.gif" alt="" />
			数据正在加载中...
		</div>
    <script src="${ctx}/js/zepto.js?v=${v}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${v}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${v}"></script> 
    <script src="http://wimg.keepyoga.com/js/fastclick.min.js"></script>
    	<script>
    			/*初始化一些后端参数*/
		var title1 = "【瑜伽瘦身集训营】";
		var desc1  = "8天4位顶级瑜伽瘦身大咖，经典瘦身秘籍倾囊相授，教你绕过减肥那些坑";
		var link1  = location.href;
		var img1   = "http://wimg.keepyoga.com/images/shou-share-iocn.jpg" ;
		
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
		        'checkJsApi','onMenuShareTimeline','onMenuShareAppMessage',
		        'hideMenuItems','showMenuItems','hideAllNonBaseMenuItem',
		        'showAllNonBaseMenuItem','chooseWXPay','hideOptionMenu','showOptionMenu'
		      ]
		});
	   wx.ready(function(){
		    wx.hideAllNonBaseMenuItem();
		    wx.showMenuItems({
			    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
		    wx.onMenuShareTimeline({
			    title: title1, // 分享标题
			    link: link1, // 分享链接
			    imgUrl: img1, // 分享图标
			    success: function (res) { 
			    	if( res.errMsg == 'shareTimeline:ok'){
			    		tips('恭喜，分享成功！');
			    	}
			    },
			    cancel: function () { }
			});
			wx.onMenuShareAppMessage({
			    title: title1, // 分享标题
			    desc: desc1, // 分享描述
			    link: link1, // 分享链接
			    imgUrl: img1, // 分享图标
			    type: '', // 分享类型,music、video或link，不填默认为link
			    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
			    success: function (res) {
			    	if( res.errMsg == 'sendAppMessage:ok'){
			    		tips('恭喜，分享成功！');
	                }
			    },
			    cancel: function () {}
			});
			$("#audio111").get(0).pause();
			$("#audio111").get(0).volume = 1;
			$("#audio111").get(0).play();
	   });
			
			/*初始化一些后端参数*/
			var PARAMETERS = {
				nologin:'${nologin}',
				courseMamagerid:'${course.mamagerid}',
				appid:'${appid}',
				timestamp:'${timestamp}',
				nonceStr:'${nonceStr}',
				signature:'${signature}',
				courseTeacherids:'${course.teacherids}',
				courseHolderids:'${course.holderids}',
				ctx:'${ctx}',
				courseId:'${course.id}',
				courseTid:'${course.tid}',
				userId:'${user.id}',
				isflow:${isfollow}
			}
			
		</script>
		<script src="${ctx}/js/slimming-course-his.js?v=${v}""></script>
</body>
</html> 
 