<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="find" />
<!doctype html>
<html lang="en">
<head>
	<title>${ activity.name }</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}"> 
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <link rel="stylesheet" href="${ctx}/css/teach_details.css?v=${version}">
</head>	 
 
<body>
    <div class="wrapper">
        <section class="mainBox" id="mainBox">
            <a href="javascript:;" class="activity_banner">
        	     <img src="${activity.logo}" >
        	</a>
            <div>
                <div class="campaign">
                    <div <c:choose><c:when test="${activity.status == 2 }">class="bjcolor"</c:when><c:when test="${activity.status == 0}">class="bjcolor1"</c:when></c:choose>  >
                        <h1>${ activity.name }</h1>
                        <p>${activity.shortremark}</p>
                    </div> 
                    </li>
                </div>
                <div class="tex">
                 <p>${activity.remark}</p>
                </div>
                
        </section>
         <%@ include file="../footer.jsp" %>
        </div>
</body>
</html>