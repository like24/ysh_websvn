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
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<title>随心瑜Live|最受欢迎导师榜 </title>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" href="${ctx}/css/tutor_list.css?v=${version}">
	<script type="text/javascript">
	   var nodata = 1;
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
</head>
<body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox">
		<div>
			<nav class="nav">
				<ul style="width: 9.5rem;">
					<li><a href="${ctx}/w/hot/course/index.html">热门课程</a></li>
					<li><a href="${ctx}/w/hot/teacher/index.html" class="high">导师榜</a></li>
				</ul>
				<a href="${ctx}/w/search.html" class="search" id="search"><img src="http://wimg.keepyoga.com/search.jpg" alt=""></a>
			</nav>
			<ul id="list" class="list">
			 <c:forEach items="${resultlist.results}" var="teacher" varStatus="status">
			    <li data-url="${ctx}/w/faq/person.html?p=${teacher.id}&t=1" >
			            <div>
			           <dl>
			                <dt>
			                   <a href="${ctx}/w/faq/person.html?p=${teacher.id}&t=1">
													<c:choose>
														 <c:when test="${ fn:indexOf(teacher.file_path,'http') > -1 }">
															  <img src="${teacher.file_path}" class="img-circle">
														 </c:when>
														 <c:otherwise>
															  <img src="${ctx}/${teacher.file_path}" class="img-circle">
														 </c:otherwise>    
												   </c:choose>
								 </a>
			                </dt>
			                <dd>
			                    <h4><a href="${ctx}/w/faq/person.html?p=${teacher.id}&t=1">${teacher.nickname }</a></h4>
			                    <h5><a href="${ctx}/w/faq/person.html?p=${teacher.id}&t=1">${teacher.userpost }</a></h5>
			                    <p><span>${teacher.course_count }个课程</span><span>${teacher.fensi_count }人关注</span></p>
			                </dd>
			            </dl>
			        </div>
			      </li>
			  </c:forEach>
			</ul>
			</div>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
    <script src="${ctx}/js/zepto.js?v=${version}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
	<script>
        $("#list").on("tap","li",function(){
            window.location.href=$(this).attr("data-url");
        })
        var icon = ""; 
		var title1 = "随心瑜Live|最受欢迎导师榜 ";
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
        var pageIndex = 1;
		function loadStore(){
			if( pageIndex > -1 ){
				$.ajax({
	 				type:"post",
	 				dataType:"json",
	 				url:  "${ctx}/w/hot/teacher/json.html?pageIndex="+(pageIndex+1),
	 				error:function(XMLHttpRequest,textStatus,error){},
	 				success:function(msg){
	 					if( msg.result != ''){
	 					    $("#list").append(msg.result);
	 					    pageIndex ++;
	 					}else{
	 						 nodata = 0;
	 						 $("#pullUp").remove(); 
	 						// Modal.tips("<font color='#ccc'>亲，没有更多数据了！</font>",2500);
	 					     pageIndex = -1;
	 					}
	 				}
	 			});  
			}
		}
        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
    </script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
</body>
</html> 
 