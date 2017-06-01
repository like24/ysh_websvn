<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp"%>
<c:set var="footclass" value="find" /> 
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<title>瑜伽导师</title>
		<script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
	    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
		<link rel="stylesheet" href="${ctx}/resources/css/index.css" />
	</head>

	<body>
		<div class="wrapper bg-e4" id="app" v-cloak>

			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden iscroll-box1" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper">
					<!--   瑜伽导师   -->
					<div class="yoga-tutor-box bg-fff m30 m-b">
						<div>
							<dl class="item" v-for="item in items">
								<a :href="'${ctx}/w/faq/person.html?p='+item.id+'&t=4'" class="flex"> <dt>
	            					<img :data-src="item.icon" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt=" item.name头像" />
	            				</dt>
									<dd class="ohidden">
										<h5 class="name">{{ item.name }}</h5> <span class="job ellipsis">{{ item.userpost }}</span>
										<p class="summary ellipsis " style="padding-top:.4rem;">{{ item.shortremark }}</p>
									</dd>
								</a>
							</dl>  
						</div>
					</div>

				</div>
			</section>
			<!--    底部导航开始    -->
			<%@ include file="../footer.jsp" %> 
		</div>
		<script src="${ctx}/resources/js/lib/vue.min.js"></script>
		<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
		<script src="${ctx}/resources/js/common.js"></script>
		<script src="${ctx}/resources/js/modules/more.js"></script>
		<script>
			vw.init("index/teacher/more.json");
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
			wx.ready(function(Api){
				  wx.hideAllNonBaseMenuItem();
				    // 
				  wx.showMenuItems({
					    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				 });
			});
			var nologin = "${nologin}"; 
			if( nologin == "true" ) {   
			    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=http://weixin.keepyoga.com/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}
		</script>
	</body>

</html>
 