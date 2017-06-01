<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="faq" />
<!doctype html>
<html lang="en">
<head>
	<title><c:if test="${p == 0 }">问题</c:if><c:if test="${p == 1 }">导师榜</c:if></title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}"> 
	<link rel="stylesheet" href="${ctx}/css/swiper-3.3.1.min.css?v=${version}"> 
	<script src="${ctx}/js/jquery.min.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<c:if test="${p == 0}">
	   <link rel="stylesheet" href="${ctx}/css/question_module.css?v=${version}">
	   <link rel="stylesheet" href="${ctx}/css/swiper-3.3.1.min.css?v=${version}">
	   <script src="${ctx}/js/swiper-3.3.1.min.js?v=${version}"></script>
	</c:if>
	<c:if test="${p == 1}"><link rel="stylesheet" href="${ctx}/css/tutor_module.css?v=${version}"></c:if>
    <script type="text/javascript">
       var nodata = ${resultlist.totalCount > 10 ? 1:0};
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <style type="text/css">
        .swiper-container {
			width: 100%;
			height: auto;
			margin-bottom: .5rem;
		}
		.swiper-container img {
			width: 100%;
		}
    </style>
</head>
<body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox">
	      <div class="iscrollBox">
			<div class="main">
				<nav class="nav" style="display:none">
					<ul>
						<li><a href="${ctx}/w/faq/index.html?p=0" <c:if test="${p == 0}">class="high"</c:if> >问题榜</a></li>
						<li><a href="${ctx}/w/faq/index.html?p=1" <c:if test="${p == 1}">class="high"</c:if>>导师榜</a></li>
					</ul>
					<a href="${ctx}/w/search.html" class="search"><img src="http://wimg.keepyoga.com/search.jpg"></a>
				</nav>
				<c:if test="${p == 0}">
				  <div class="swiper-container">
						<div class="swiper-wrapper">
						<c:forEach items="${bannerlist }" var="banner" varStatus="status">
							<div class="swiper-slide">
								<a href="${banner.url }"><img src="${banner.icon }" alt=""></a>
							</div> 
						</c:forEach>
						</div>
						<!--  如果需要分页器 -->
						<div class="swiper-pagination"></div>
					</div> 
				</c:if>
				<ul id="list" class="list">
				   <c:if test="${p == 0 }">
					  <c:forEach items="${resultlist.results}" var="faq" varStatus="status">
						<li data-url="${ctx}/w/faq/d.html?p=${faq.id}">
							<h2><a href="${ctx}/w/faq/d.html?p=${faq.id}">${faq.synopsis} </a></h2>
							<div>
								<p class="introduction"><span class="name">${faq.askusername }</span><b>|</b><span class="summary">${faq.askuserpost}</span></p>
								<dl>
									<dt>
										<a href="${ctx}/w/faq/person.html?p=${faq.askuserid}&t=0">
													<c:choose>
														 <c:when test="${ fn:indexOf(faq.askheader,'http') > -1 }">
															  <img src="${faq.askheader}" class="img-circle">
														 </c:when>
														 <c:otherwise>
															  <img src="${ctx}/${faq.askheader}" class="img-circle">
														 </c:otherwise>    
												   </c:choose>
												</a>
									</dt>
									<dd>
										<a href="${ctx}/w/faq/d.html?p=${faq.id}"><img src="http://wimg.keepyoga.com/son.png">免费听</a>
									    <span>${faq.asktlong}"</span>
									</dd>
								</dl>
							</div>
						</li>
						</c:forEach>
					</c:if>
					<c:if test="${p == 1 }">
					   <c:forEach items="${resultlist.results}" var="teacher" varStatus="status">
							 <li data-url="${ctx}/w/faq/person.html?p=${teacher.id}&t=1" >
							   <div>
								 <dl><dt><a href="${ctx}/w/faq/person.html?p=${teacher.id}&t=1">
							     <c:choose>
													 <c:when test="${ fn:indexOf(teacher.file_path,'http') > -1 }">
														  <img src="${teacher.file_path}" class="img-circle">
													 </c:when>
													 <c:otherwise>
														  <img src="${ctx}/${teacher.file_path}" class="img-circle">
													 </c:otherwise>    
								  </c:choose>              
							</a></dt>
												<dd>
													<h4><a href="javascript:;">${teacher.nickname}</a></h4>
                                                    <h5><a href="javascript:;">${teacher.userpost }</a></h5>
                                                    <p><span>${teacher.ask_count }个回答</span><span>${teacher.fensi_count }人关注</span>
												</dd>
								 </dl>
								 </div>
			                 </li> 
					   </c:forEach>
					</c:if>
				</ul>
			</div>
			</div>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
    <script src="${ctx}/js/zepto.js?v=${version}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
    <script src="${ctx}/js/swiper-3.3.1.min.js?v=${version}"></script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
	<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
	<script src="${ctx}/js/ajax_absolute.js?v=${version}" async></script>
	<script type="text/javascript">
			window.onload=function(){
				var mySwiper = new Swiper('.swiper-container', {
					autoplay: 5000,
					loop: true,
					pagination: '.swiper-pagination',
					lazyLoading: true,
					lazyLoadingInPrevNext: true,
					autoplayDisableOnInteraction : false,
					onTap: function (swiper, event) {
						var swiperInx = swiper.activeIndex;
						var imgsrc = $(".swiper-slide").eq(swiperInx).attr("data-src");
						window.location.href = imgsrc;
					}
					});
			}


		$("#list").on("tap", "li", function () {
            window.location.href = $(this).attr("data-url");
        })
        
		var pageIndex = 1;
		function loadStore(){
			if( pageIndex > -1 ){
				$.ajax({
	 				type:"post",
	 				dataType:"json",
	 				url:  "${ctx}/w/faq/index/json.html?p=${p}&pageIndex="+(pageIndex+1),
	 				error:function(XMLHttpRequest,textStatus,error){},
	 				success:function(msg){
	 					if( msg.result != ''){
	 					    $("#list").append(msg.result);
	 					    pageIndex ++;
	 					}else{
	 						 nodata = 0;
	 						 $("#pullUp").remove();  
	 					     pageIndex = -1;
	 					}
	 				}
	 			});  
			}
		}
		var icon = "http://wimg.keepyoga.com/ask.png"; 
		var title1 = "随心瑜Live|<c:if test="${p == 0 }">问题榜</c:if><c:if test="${p == 1 }">导师榜</c:if>";
		var desc1  = "一个瑜伽人的掌上家园";
		var link1  = location.href;
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
		
		wx.ready(function(Api){  
			  wx.hideAllNonBaseMenuItem();
			    // 
			  wx.showMenuItems({
				    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			 });
		});
		
		window.onload = function () {
			var mySwiper = new Swiper('.swiper-container', {
				autoplay: 5000,
				pagination: '.swiper-pagination',
				lazyLoading: true,
				lazyLoadingInPrevNext: true,
				preventClicks: false,
				preventLinksPropagation: false,
				autoplayDisableOnInteraction: false,
				touchMoveStopPropagation: false
			})
		};
	   
		var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
	</script>
</body>
</html> 
 