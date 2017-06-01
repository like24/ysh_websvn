<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="course" />
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
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<title>随心瑜Live|${special.name}专题 </title>
	<script type="text/javascript">
	   var nodata  = 0;
	</script>
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" href="${ctx}/css/venue.css?v=${version}">
</head>
 <div class="wrapper">
		<section class="mainBox" id="mainBox">
		<div>
			<ol>
			    <h3>${special.name }</h3>
			    <p>${special.course_count }个课程</p>
			</ol>
			
			<c:if test="${fn:length(courselist) > 0  }">
					<ul id="list" class="list">
					   <c:forEach items="${courselist}" var="course" varStatus="status">
						    <li data-url="${ctx}/w/faq/course.html?p=${course.id}" >
						        <div>
						            <h4><a href="${ctx}/w/faq/course.html?p=${course.id}">${course.cname }</a></h4>
						            <p class="jieshao"><a href="${ctx}/w/faq/course.html?p=${course.id}">${course.remark }</a></p>
						            <p class='but'>
						             <c:forTokens items="${course.taglist }" delims="," var="str">
				                          <span>${str}</span> 
				                       </c:forTokens>
						            </p>
						            <dl>
						                <dt>
						                     <a href="${ctx}/w/faq/person.html?p=${course.uid}">
					                        <c:choose>
												  <c:when test="${ fn:indexOf(course.teacherheader,'http') > -1 }">
														 <img src="${course.teacherheader}"  >
												  </c:when>
												  <c:otherwise>
														 <img src="${ctx}/${course.teacherheader}"  >
												  </c:otherwise>    
											 </c:choose>
					                     </a>
						                </dt>
						                <dd>
						                   <p><a href="${ctx}/w/faq/person.html?p=${course.uid}"><span>${course.teachername }</span><b>|</b><span  class="summary" >${course.teacherport }</span></a></p>
						                </dd>
						            </dl>
						        </div>
						    </li>
					    </c:forEach>
					</ul>
			</c:if>
			<c:if test="${fn:length(courselist) == 0  }">
			     <div class="zanwu">
			       <img src="http://wimg.keepyoga.com/error.png" alt="">
			       <p>小乎君还没有课程放进来呢 ^^ !</p>
			     </div>
			</c:if>
			</div>
		</section> 
		<%@ include file="../footer.jsp" %>
	</div>
    <script src="${ctx}/js/zepto.js?v=${version}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${version}"></script> 
	<script>
        $("#list").on("tap","li",function(){
            window.location.href=$(this).attr("data-url");
        })
        var pageIndex = 0;
        var icon = ""; 
		var title1 = "随心瑜Live|名师课程排行榜";
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
        
        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
    </script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script> 
    <script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
</body>
</html> 
 