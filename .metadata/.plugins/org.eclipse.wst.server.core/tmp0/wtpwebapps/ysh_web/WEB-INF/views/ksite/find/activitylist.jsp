<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="find" />
<!doctype html>
<html lang="en">
<head>
	<title>发现更多活动</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}"> 
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<script type="text/javascript">
	   var nodata = 0 ;
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <link rel="stylesheet" href="${ctx}/css/teach.css?v=${version}">
</head>	 
<body>
	<div>
	    <section id="mainBox">
	        <div>
	         <nav>
                <ul id="nav">
                    <li data-url="${ctx}/w/find/index.html" <c:if test="${p==0}">class="high"</c:if>>导师</li>
                    <li data-url="${ctx}/w/find/index.html?p=1" <c:if test="${p==1}">class="high"</c:if>>活动</li>
			    </ul>
			    <a href="${ctx}/w/search.html">搜索</a>
			</nav>
        	<div class="campaign"> 
        	  <ul id="list">
        	   <c:forEach items="${activitylist}" var="activity"  > 
        	      <a href="${ctx}/w/activity/${activity.id}.html" class="activity_banner">
        	          <img src="${activity.logo}" >
        	      </a>
        	      <li style="display:none">
				      <div <c:choose><c:when test="${activity.status == 2 }">class="bjcolor"</c:when><c:when test="${activity.status == 0}">class="bjcolor1"</c:when></c:choose>   data-url="${ctx}/w/activity/${activity.id}.html" onclick="enterActivity(this)">
                           <h1>${activity.name }</h1>
                           <p>${activity.shortremark}</p>
                      </div>
				  </li>
			    </c:forEach>
			    </ul>
			    <c:if test="${fn:length(activitylist) == 0}">
				    <div class="zanwu">
		                <img src="http://wimg.keepyoga.com/success.png">
		                <p>暂无活动~~</p >
		            </div>
	            </c:if>
			</div>
	        </div>
	    </section>
	    <%@ include file="../footer.jsp" %>
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
    <script>
    var pageIndex = 0;
    $("#nav").on("tap","li",function(){
            window.location.href= $(this).attr("data-url");
    }) 
    function enterActivity(o){
         	window.location.href= $(o).attr("data-url");
    }
    function loadStore(){
        	
    }
    </script>
</body>