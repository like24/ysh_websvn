<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="my" /> 
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<title>瑜是乎Live</title>
		<script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
		<link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
		<link rel="stylesheet" href="${ctx}/resources/css/purchasedCourses.css" />
	</head>
	<body>
		<div class="wrapper bg-e4" id="app" v-cloak>
			<header class="header">
				<ul class="flex" id="nav">
					<li class="curr" @click="nav(0)">直播</li>
					<li @click="nav(1)">录播</li>
				</ul>
			</header>
			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper">
					<div class="hot-recommend bg-fff m30 m-b hot-recommend1" v-show="tab">
						<div>
							<dl class="item" v-for="item in zhibo">
								<a :href="'${ctx}/w/faq/course.html?p='+item.productid" class="flex"><dt class="relative"><img :data-src="item.picUrl" :src="item.picUrl" alt="系统学习经络轮棒瑜伽"> </dt>
									<dd class="ohidden relative">
										<h5 class="name ellipsis">{{item.productname}}</h5> <span class="type block ellipsis2">共{{item.zhiboItemCount}}集</span>
										<time>{{item.createtime}} 开课</time>
										<span class="time block">{{item.countNum}}人报名</span>
										<p class="money absolute"><small>￥</small><big>{{item.money}}</big></p>
									</dd>
								</a>
							</dl>
							<div v-if="!zhibo.length" class="no-content">
								<img src="${ctx}/resources/images/bad.png" alt="" />
								<p>您还未购买直播课程</p>
								<a href="${ctx}/v2/live/list.shtml">购买直播课程</a>
							</div>
						</div>
					</div>
					<div class="hot-recommend bg-fff m30 m-b" v-show="tab1">
						<div>
							<dl class="item" v-for="item in lubo">
								<a :href="'${ctx}/w/faq/course.html?p='+item.cid" class="flex"><dt class="relative"><img data-src="http://wimg.keepyoga.com/20170217152846637_183.jpeg" :src="item.icon" alt="“一年之计在于春”之瑜伽馆春季招聘培训课（上下）"> <i class="icon  absolute icon-audio"></i></dt>
									<dd class="ohidden relative">
										<h5 class="name ellipsis">{{item.cname}}</h5> <span class="type block ellipsis2">{{item.remark}}</span> <span class="time block">时长：<time>{{item.longtime}}</time></span>
										<p class="money absolute"><small>￥</small><big>{{item.tmoney}}</big></p>
									</dd>
								</a>
							</dl>
							<div  class="no-content" v-if="!lubo.length">
								<img src="${ctx}/resources/images/bad.png" alt="" />
								<p>您还未购买录播课程</p>
								<a href="${ctx}/v2/index/pay/more.shtml">购买录播课程</a>
							</div>
						</div>
					</div>
				</div>
			</section>
			<!--    底部导航开始    -->
			<%@ include file="../footer.jsp" %> 
		</div>
		<script src="${ctx}/resources/js/lib/vue.min.js"></script>
		<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
		<script src="${ctx}/resources/js/common.js"></script>
		<script src="${ctx}/resources/js/modules/purchasedCourses.js"></script>
	</body>
</html>