<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="my" /> 
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<style>
   		nav ul li{padding:0;}
   	</style>
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
    <title>购买的课程</title>
    <script type="text/javascript">
      var nodata = ${ contentlist.totalCount > 10 ? 1: 0 };
    </script> 
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <link rel="stylesheet" href="${ctx}/css/my_course.css?v=${version}">
   	<link rel="stylesheet" href="${ctx}/css/collection_classes.css?v=${version}">
 	<style>h2{margin-top:-2rem;}
 	li p.money {
    margin-top: .5rem;
}
  </style>
</head>
 <body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox" >
              <div >
              	<div>
                  <nav class="nav">
					<ul>					
						<li class="taplink">音视频</li>
						<li class="high">线下培训</li>
					</ul>
				  </nav>
				  <h2>共购买${ contentlist.totalCount }个线下培训
				  </div>
                  <ul id="list" class="list" >
                    <c:forEach items="${contentlist.results}" var="course" varStatus="status">
	                      <li data-url="${ctx}/w/faq/courseline.html?p=${course.cid}" >
	                          <h3>${course.cname}</h3>
	                          <h4>${course.remark }</h4>
	                          <c:if test="${ !empty course.taglist }">
		                          <p class="btn">
			                           <c:forTokens items="${course.taglist }" delims="," var="str">
				                          <b>${str}</b>
				                       </c:forTokens>
		                          </p>   
	                          </c:if>
	                          <dl>
	                              <dt>
	                                  <a href="${ctx}/w/faq/person.html?p=${course.uid}">
	                                    <c:choose>
											<c:when test="${ fn:indexOf(course.teacherheader,'http') > -1 }"><img src="${course.teacherheader}"  ></c:when>
											<c:otherwise><img src="${ctx}/${course.teacherheader}"  ></c:otherwise>    
										 </c:choose>  
	                                  </a>
	                              </dt>
	                              <dd>
	                                  <p><span>${course.teachername }</span><b>|</b><span class="summary">${course.teacherpost}</span></p>
	                              </dd>
	                          </dl>
	                          <p class="money"><span>${course.showtime}购买</span></p>
	                      </li>
                      </c:forEach>
                  </ul>
              </div>
            <c:if test="${ contentlist.totalCount == 0  }">
	            <div class="zanwu" >
	                    <img src="http://wimg.keepyoga.com/error.png" alt="">
	                    <p>您还没有购买课程哦~~</p>
	                    <a href="${ctx}/v2/index/pay/more.shtml">购买热门课程</a>
	            </div>
            </c:if>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script> 
	<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
	<script>
		$(".nav li.taplink").on("tap",function(){
			window.location.href="${ctx}/w/my/minebuy.html";
		})
        $("#list").on("tap","li",function(){
        	 window.location.href=$(this).attr("data-url");
        })
        var pageIndex = 0;
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
		wx.ready(function(Api){ 
		    wx.hideAllNonBaseMenuItem();
		    wx.showMenuItems({
			    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
		});
    </script>
</body>
</html>
 