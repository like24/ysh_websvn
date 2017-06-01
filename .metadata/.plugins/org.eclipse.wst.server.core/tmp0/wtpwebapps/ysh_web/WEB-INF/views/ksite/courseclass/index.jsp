<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="course" />
<html lang="en">

	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<title>随心瑜Live | 您想要学的课程都在这里</title>
		<script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
		<link rel="stylesheet" href="${ctx}/resources/css/index.css" />
		<link rel="stylesheet" href="${ctx}/resources/css/filter.css" /> </head>
	<body>
		<div class="wrapper bg-e4" id="app" v-cloak>
			<!--    头部   -->
			<header class="header-box fixed">
				<ul class="flex" id="topTab">
					<li class="item" @click="topTab(0)"> <span>{{ newHotTxt }}</span> <i class="icon arrow-icon relative"></i> </li>
					<li class="item active" @click="topTab(1)"> <span>{{ name }}</span> <i class="icon arrow-icon relative"></i> </li>
					<li class="item" @click="topTab(2)"> <span>筛选</span> <i class="icon arrow-icon relative"></i> </li>
				</ul>
			</header>
			<!--     分类选项   -->
			<div class="classfiy-box absolute bg-fff" v-show="show">
				<div id="triangleUp" class="absolute"></div>
				<!--     最热最新      -->
				<ul class="new-hot" v-show="showBox[0]">
					<li @click="newHot(0)">最新</li>
					<li @click="newHot(1)">最热</li>
				</ul>
				<!--      分类      -->
				<div class="classfiy flex" v-show="showBox[1]">
					<ul class="left" id="setLeftNav">
						<div>
							<li @click="oneALL"> <i class="icon relative"></i><span>全部</span> </li>
							<li v-for="(item,$index) in classlist" @click='changeLeft($index)'> <i class="icon relative" :data-id="item.id"></i><span>{{ item.name }}</span> </li>
						</div>
					</ul>
					<ul class="right" id="changedRight">
						<div class="loading">
							<li @click="twoALL">全部</li>
							<li v-for=" (item,$index) in rightList" @click='changeview($index)'><span :data-id="item.id">{{ item.name }}</span></li>
						</div>
						<!--<div v-show="loading" class="loading-box">
							<img src="${ctx}/resources/images/pullpu.gif" alt="" />
							正在加载...
						</div>-->
					</ul>

				</div>
				<!--       筛选     -->
				<div class="firter" v-show="showBox[2]" id="firter">
					<!--   课程类型  -->
					<div>
						<h6>课程类型</h6>
						<div class="flex item" @click="firtel($event)" data-inx="0"> <span data-inx='2'>全部</span> <span data-inx='0'>音频</span> <span data-inx='1'>视频</span> </div>
					</div>
					<!--   价格区间  -->
					<div>
						<h6>价格区间</h6>
						<div class="flex item" @click="firtel($event)" data-inx="1"> <span data-inx='2'>全部</span> <span data-inx='0'>免费</span> <span data-inx='1'>付费</span> </div>
					</div>
					<!--   适合人群  -->
					<div>
						<h6>适合人群</h6>
						<div class="flex item" @click="firtel($event)" data-inx="2"> <span data-inx='全部'>全部</span> <span data-inx='瑜伽爱好者'>瑜伽爱好者</span> <span data-inx='瑜伽教练'>瑜伽教练</span> </div>
					</div>
					<div class="check-box flex">
						<a href="javasscript:;" @click="clear">清空筛选</a>
						<button type="button" @click="enter">确定</button>
					</div>
				</div>
			</div>
			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden iscroll-box1" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper">
					<!--   热门推荐   -->
					<div class="hot-recommend bg-fff m30 m-b">
						<div>
							<dl class="item" v-for="item in items">
								<a href="javascript:;" :data-href="'${ctx}/w/faq/course.html?p='+item.cid" class="flex" @click="toUrl($event)"> <dt class="relative">
	            					<img :data-src="item.icon" src="${ctx}/resources/images/pixel.gif" :alt="item.cname" />
	            					<i class="icon  absolute" :class="item.ctype?'icon-video':'icon-audio'"></i>
	            					<!--<p class="topic  absolute" :class="item.ctype?'blue':'orange'">
	            						<small></small>
	            					</p>-->
	            				</dt>
									<dd class="ohidden relative">
										<h5 class="name ellipsis">{{ item.cname }}</h5> <span class="type block ellipsis2">{{ item.remark }}</span> <span class="time block">时长：<time>{{ item.longtime }}</time></span>
										<p class='money absolute' v-if="item.money  > 0 "><small>￥</small><big>{{ item.money }}</big></p>
										<p class='money absolute free' v-if="item.money <=0 ">免费</p>
									</dd>
								</a>
							</dl>
						</div>
					</div>
					<!--没有搜索到内容-->
					<div class="no-content text-c" v-show="noContent"> <i class="icon bad"></i> <span>尴尬了，没有找到</span>
						<a href="${ctx}/v2/index.shtml">去首页看看</a>
					</div>
				</div>
			</section>
			<!--    底部导航开始    -->
			<%@ include file="../footer.jsp" %>
			<div class="masking fixed" v-show="show" @click="hideBox"></div>
		</div>
		<script src="${ctx}/resources/js/lib/vue.min.js"></script>
		<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
		<script src="${ctx}/resources/js/common.js"></script>
		<script src="${ctx}/resources/js/modules/filter.js"></script>
		<script type="text/javascript">
			wx.ready(function(Api) {
				wx.hideAllNonBaseMenuItem();
				wx.showMenuItems({
					menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				});
			});
		</script>
	</body>

</html>