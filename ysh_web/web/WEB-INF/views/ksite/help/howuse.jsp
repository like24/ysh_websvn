<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="my" />
<!doctype html>
<html lang="en">
<head>
	<title>如何使用瑜是乎</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}"> 
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<link rel="stylesheet" href="${ctx}/css/help.css?v=${version}">
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
</head>	 
 <body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox">
	            <ul> 
	              <c:forEach items="${helplist}" var="help" varStatus="status">
	                <li>
	                   <p><span>${help.name }</span><b></b></p>
	                   <div>
	                        ${help.remark }                    
	                   </div>
	                </li>
	                </c:forEach>
	            </ul>
	            <div class="tel">
	                <p>如有疑问也可联系瑜是乎客服：<a href="tel:01059231599">4000186161</a></p>
	            </div>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/iscroll4.js"></script> 
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script>
       
        
        $("ul").on("tap", "li", function () {
            $("b").removeClass("rotate");
            $(this).siblings().find("div").hide();
            $(this).find("b").addClass("rotate");
            $(this).find("div").show(50);
        })
     
    </script>
</body>
</html>