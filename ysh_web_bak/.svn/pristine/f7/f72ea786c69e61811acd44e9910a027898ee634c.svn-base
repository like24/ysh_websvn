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
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
	<link rel="stylesheet" href="${ctx}/css/how_to_make.css?v=${version}">
</head>	 
<body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox">
	            <ul>
	                <li data-url="${ctx}/w/help/agreement.html" >
	                     <h1>用户协议</h1>
	                     <span></span>
	                </li>
	                <li data-url="${ctx}/w/help/use.html" >
	                     <h1>使用帮助</h1>
	                     <span></span>
	                </li>
	            </ul>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	 <script>
         $("#mainBox").on("tap","li",function(){
              window.location.href=$(this).attr("data-url");
         })
         $("#mainBox").on("click","li",function(){
              window.location.href=$(this).attr("data-url");
         })
    </script>
</body>
</html>