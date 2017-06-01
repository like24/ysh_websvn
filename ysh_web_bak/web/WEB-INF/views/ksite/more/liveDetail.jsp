<%@page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp"%>
<c:set var="footclass" value="v2index" /> 
<!DOCTYPE html>
<html lang="en">
 <head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<title>瑜是乎 | 您想要学的课程都在这里</title>
	<script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
	<link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
	<link rel="stylesheet" href="${ctx}/resources/css/courseArrangement.css" />
	</head>

	<body >
		<div class="wrapper bg-e4" id="app" v-clock>
			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper">
					<header class="header">
						<div class="banner-box relative">
							<img :src="detaills.logo" alt="" class="img" />
							<p class="manLen absolute"><i class="icon"></i>{{detaills.buycount}}人报名</p>
						</div>
						<div class="courseInfo">
							<h1 class="ellipsis2 tit">
								{{detaills.name}}
							</h1>
							<span class="money">
								￥<big>{{detaills.money}}.00</big>
							</span>
						</div>
						<div class="distributionEdition-box ">
							<a href="${ctx}/v2/live/saler/${zid}.shtml" class="flex">
								<div class="distributionEdition">
									<h4>分销榜</h4>
									<p>{{totlesaler}}人</p>
								</div>
								<div class="icon-box ">
									<div class="flex" id="iconBox" >
										<img  v-for="item in shareLen" :src="item.header" alt="" />

									</div>
								</div>
								<i class="icon"></i>
							</a>
						</div>
					</header>
					<!--介绍课程安排tab-->
					<nav class="tab relative" id="tab">
						<ul class="flex">
							<li class="curr" @click="changeNav($event)">介绍</li>
							<span>|</span>
							<li @click="changeNav($event)" class="right">课程安排</li>
						</ul>
						<div class="bottom absolute curr"></div>
						<div class="none"></div>
						<div class="bottom1 absolute"></div>
					</nav>
					<div class="content">
						<!--介绍-->
						<div class="jieshao-box " id="jieshao">
							<div class="jieshao">
								<h2>内容介绍</h2>
								<p>{{detaills.remark}}</p>
							</div>
							<!--导师-->
							<div class="venue-box">
								<h2>老师介绍</h2>
								<ul>
									<li class="flex relative"  v-for="(item,index) in teachs">
										
										<img :src="item.file_path" alt="" />
										<div class="info">
											<h3>{{item.nickname}}</h3>
											<p class="ellipsis2">{{item.remark}}</p>
										</div>
										<div class="btn-box">
											<button class="yes" v-show="item.followuser" @click="gz(item.id,item.followuser,index)" :data-a="item.followuser"></button>
											<button class="no"  v-show="!item.followuser" @click="gz(item.id,item.followuser,index)" :data-a="item.followuser">+关注</button>
										</div>
										<div class="absolute bottom"></div>
									</li>
								</ul>
							</div>

						</div>
						<!--课程安排 start-->
						<div class="hot-recommend bg-fff m30 m-b none" id="anpai">
							<div>
								<dl class="item" v-for="item in classList">
									<a :href="'${ctx}/w/faq/course.html?p='+item.cid+'&i=0'" class="flex"> <dt class="relative">
										<img :src="item.logo"  class="loadingimg" :alt="item.cname" />
												<!--正在直播-->
												<span class="icon abslute icon1" v-if="item.status==0"></span>
												<!--即将开始-->
												<span class="icon abslute icon2" v-if="item.status==1"></span>
												<!--直播结束-->
												<span class="icon abslute icon3" v-if="item.status==2"></span>
									</dt>
										<dd class="ohidden relative">
											<h5 class="name ellipsis" style="margin-bottom: .1rem;"><p class="topic  " :class="item.status?'zb-tit':'zb-tit'">
	            						<small></small>
	            					</p>	{{ item.title }}</h5>
											<span class="ellipsis">{{item.name}}</span>
											<span class="type block ellipsis2">{{ item.starttime.substr(5) }}开课</span>
											<span class="time block"><time>{{ item.buycount }}</time>人报名</span>
											<p class='money absolute' v-if="item.money  > 0 "><small>￥</small><big>{{ item.money }}</big></p>
											<p class='money absolute free' v-if="item.money <=0 ">免费</p>
										</dd>
									</a>
								</dl>
							</div>
						</div>
						<!--课程安排 end-->
					</div>
				</div>
			</section>
			<!--    底部导航开始    -->
			<footer class="footer bg-fff fixed">
				<ul class="flex">
					<li class="zixun" id="consult" @click="zixun"><i class="icon"></i><span>资讯</span></li>
					<li class="money" id="share" @click="getMoney">赚{{money.substr(4)/10*detaills.money}}元</li>
					<li class="enter"><span id="goShoping" @click="goShoping"  v-if="pay">立即报名</span>
						<a href="${ctx}/v2/live/zhibo/item730.shtml" v-if="!pay">进入教室</a>
					</li>
				</ul>
			</footer>
			<div class="masking absolute none" id="masking" @click="maskingHide">
				<img src="${ctx}/resources/images/courseArrangement_share.png" alt="" />
			</div>
			<div class="pop none" id="consultPop">
				<img src="http://wimg.keepyoga.com/images/ycyoga-share11.png">
				<div class="consult-hide" id="consultHide" @click="consultPopHide"></div>
			</div>
			<div class="masking absolute none" id="masking2" @click="masking2Hide"></div>
			<div class="submitBox" id="submitBox">
				<div class="titleBox">
					<div>
						<img :src="detaills.logo" alt="">
					</div>
					<h4>{{detaills.name}}</h4>
					<span>￥{{detaills.money}}</span>
				</div>
				<div class="inputBox">
					<label for="name">
				<i>*</i>
				<span>姓名：</span>
				<input type="text" id="name" v-model="name">
			</label>
					<label for="phone" class="phone">
				<i>*</i>
				<span>手机：</span>
				<input type="text" id="phone" v-model="phone">
			</label>
					<label for="pwd">
			<i>*</i> 
				<span>验证码：</span>
				<input type="text" id="pwd" placeholder="请输入验证码" v-model="pwd">
				<span class="sendMes" id="getpwd" @click="getpwd">发送验证码</span> 
			</label>
				</div>
				<p class="subP">
					<a href="javascript:;" class="submitBtn" id="submitBtn" @click="submitBtn">提交订单</a>
				</p>
			</div>
		</div>

		<script src="${ctx}/resources/js/lib/vue.min.js"></script>
		<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
		<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
		<script src="${ctx}/resources/js/common.js"></script>
		<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script src="${ctx}/js/layer/layer.js"></script>
		<script>	
			var JspElement = {
				wxid:'${wxid}',
				uid:'${uid}',
				uuid:'${uuid}',
				ordernumber:'${ordernumber}',
				ctx:'${ctx}',
				urlsecret:'${urlsecret}',
				nologin :'${nologin}',
				appid:'${appid}',
				timestamp:'${timestamp}',
				nonceStr:'${nonceStr}',
				signature:'${signature}',
				paytimestamp:'${paytimestamp}',
				paynonceStr:'${paynonceStr}',
				paypackage:'${paypackage}',
				paySign:'${paySign}',
				detaillsId:"${zid}"
				
			}
			
		</script>
		<script src="${ctx}/resources/js/modules/courseArrangement.js"></script>
	</body>

</html>