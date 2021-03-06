<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../../../taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no,email=no" name="format-detection">
<title>随心瑜live</title>
<script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
<link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
<link rel="stylesheet" href="${ctx}/resources/css/sxy-live.css" />
</head>
<body>

	<div id="app">
		<div class="stash" id="stash">
			<span>拼命加载中，请稍候……</span>
		</div>
		<!--隐藏显示课件start-->
		<div class="show-hide-courseware fixed flex" id="showHideCourse">
			<img src="${course.logo}"
				alt="隐藏显示按钮" class="icon" /> <span class="text text1">隐藏课件</span> <span
				class="none text text2">显示课件</span>
		</div>
		<!--隐藏显示课件end-->
		<!--视频播放区域start-->
		<header class="video-box relative" id="videoBox">
			<!--视频源-->
			<video class="video absolute" controls="controls" id="video">
				<source src="${course.filepath}"
					type="audio/ogg">
				<source src="${course.filepath}?v=2"
					type="audio/ogg">
			</video>
			<div class="video-palyer-box absolute removeVideoMask"
				@click="playVideo">
				<img src="${ctx}/resources/images/sxylive-banner.jpg" alt="课程背景图"
					class="video-img removeVideoMask" /> <i
					class="icon video-play-btn "></i>
				<div class="mask"></div>
			</div>
		</header>
		<!--视频播放区域end-->
		<!--结束直播start-->
		<div class="close-live-box fixed" id="closeLive" v-if="identity!=0"
			@click="closeLive">
			<div class="close-live flex">
				<img src="${ctx}/resources/images/sxy-live-close.png" alt="" />
			</div>
			<span>关闭直播</span>
		</div>
		<!--结束直播end-->
		<!--在线人数start-->
		<div class="online-box fixed">
			<i class="icon"></i> <span class="text"><b>0</b>人次</span>
		</div>
		<!--在线人数end-->
		<!--操作按钮start-->
		<div class="btn-broup-box fixed" id="btnBroupBox">
			<span class="ask-size">22222</span>
			<div class="btn-box btn-box-ask" id="btnBoxAsk">
				<button type="button">
					<div class="flex">
						<i class="icon"></i>
					</div>
					<span class="text">提问</span>
				</button>
			</div>
			<div class="btn-box btn-box-top" id="btnBoxTop">
				<button type="button">
					<div class="flex">
						<i class="icon"></i>
					</div>
					<span class="text">顶部</span>
				</button>
			</div>
			<div class="btn-box btn-box-bottom" id="btnBoxBottom">
				<button type="button">
					<div class="flex">
						<i class="icon"></i>
					</div>
					<span class="text">底部</span>
				</button>
			</div>
		</div>
		<!--操作按钮end-->
		<!--直播倒计时start-->
		<div class="count-down-box flex" id="countDownBox">
			<p>本次直播将于2017年3月18日 18：00开始</p>
			<div class="count-down">
				<span class="day">01</span>天<span class="hour">11</span>时<span
					class="minutes">01</span>分<span class="seconds">45</span>秒
			</div>
		</div>
		<!--直播倒计时end-->
		<!--导师消息start-->
		<section class="teach-wrapper absolute" id="mainBox">
			<ul>
			<!-- 首页消息渲染 item.status！==0的时候，就是导师或者管理员的消息，则在此页面显示 -->
				<li class="ls-zcr flex item" v-for="(item,index) in datas" v-if="item.status==1||item.status==2">
					<div class="flex">
						<!--头像-->
						<div class="head-box">
							<img :src="item.userHeaderImg" alt="" class="head" />
						</div>
						<div class="border-box">
							<!--姓名和身份-->
							<div>
								<h6 class="name">{{item.userNickName}}</h6>
								<span class="type-zcr type" v-if="item.status == 1">主持人</span>
								 <span class="type-ls type" v-if="item.status == 2">老师</span>
							</div>
							<!--消息-->
							<div class="text-box">{{item.content}}</div>
						</div>
						<!--撤回按钮-->
						<div class="chehui-btn" data-id="1"></div>
					</div>
				<li>
					<!--老师和管理员单独发送的文字 start-->
				<li class="ls-zcr item">
					<div class="flex">
						<!--头像-->
						<div class="head-box">
							<img src="${ctx}/images/a.png" alt="" class="head" />
						</div>
						<div class="border-box">
							<!--姓名和身份-->
							<div>
								<h6 class="name">于是花</h6>
								<span class="type-zcr type">主持人</span> <span
									class="type-ls type">老师</span>
							</div>
							<!--消息-->
							<div class="text-box">卡大煞风景开始的减肥按时看风景卡萨丁放假速度开飞机速度开飞机的刷卡缴费</div>
						</div>
						<!--撤回按钮-->
						<div class="chehui-btn" data-id="1"></div>
					</div>
				</li>
				<!--老师和管理员单独发送的文字 end-->
				<!--老师和管理员单独发的语音 start-->
				<li class="ls-zcr flex item">
					<!--头像-->
					<div class="head-box">
						<img src="${ctx}/images/a.png" alt="" class="head" />
					</div>
					<div class="border-box">
						<!--姓名和身份-->
						<div>
							<h6 class="name">于是花</h6>
							<span class="type-zcr type">主持人</span> <span class="type-ls type">老师</span>
						</div>
						<!--语音-->
						<div class="audio-btn-box">
							<button type="button" class="btn"
								data-src="http://wimg.keepyoga.com/20170420203517304_653.mp3">
								<img src="http://wimg.keepyoga.com/image/son.png" alt="" />
							</button>
							<div class="inline-block audio-time-box">
								<i class="cicle"></i> <span class="audio-time">21"</span>
							</div>
						</div>
					</div> <!--撤回按钮-->
					<div class="chehui-btn" data-id="2"></div>
				</li>
				<!--老师和管理员单独发的语音 end-->
				<!--老师和管理员单独发的图片 start-->
				<li class="ls-zcr flex item">
					<!--头像-->
					<div class="head-box">
						<img src="${ctx}/images/a.png" alt="" class="head" />
					</div>
					<div class="border-box">
						<!--姓名和身份-->
						<div>
							<h6 class="name">于是花</h6>
							<span class="type-zcr type">主持人</span> <span class="type-ls type">老师</span>
						</div>
						<div class="pic-box">
							<img src="${ctx}/images/create-class-bg.jpg" alt="" />
						</div>
					</div>
					<div class="chehui-btn" data-id="3"></div>
				</li>
				<!--老师和管理员单独发的图片 end-->
				<!--老师和管理员对学员信息做回复 start-->
				<li class="ls-zcr flex item">
					<!--头像-->
					<div class="head-box">
						<img src="${ctx}/images/a.png" alt="" class="head" />
					</div>
					<div class="border-box">
						<!--姓名和身份-->
						<div>
							<h6 class="name">于是花</h6>
							<span class="type-zcr type">主持人</span> <span class="type-ls type">老师</span>
						</div>
						<!--回复内容主体-->
						<div class="bj-box">
							<div class=" question-box flex">
								<i class="icon question-icon "></i>
								<!--学员问的问题-->
								<div>
									<div class="question-text-box flex ">
										<p class="inline-block ">
											<span>二师兄：</span>四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。
										</p>
										<button type="button " class="answer-btn "></button>
									</div>
								</div>
							</div>
							<!--老师回复消息主体-->
							<div class="answer-msg-box flex">
								<i class="icon answer-icon "></i>
								<div>
									<div class="audio-btn-box">
										<button type="button" class="btn"
											data-src="http://wimg.keepyoga.com/20170420203517304_653.mp3">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="" />
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn"></div>
									</div>
									<div class="audio-btn-box">
										<button type="button" class="btn"
											data-src="http://wimg.keepyoga.com/20170420203700539_928.mp3">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="" />
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn"></div>
									</div>
									<div class="audio-btn-box">
										<button type="button" class="btn"
											data-src="http://wimg.keepyoga.com/20170420203759580_849.mp3">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="" />
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn" data-id="4"></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</li>
				<!--老师和管理员对学员信息做回复 end-->
			</ul>
		</section>
		<!--导师消息start-->
		<section class="all-msg-box absolute" id="mainBox1">
			<header class="btn-group-box flex" id="backGap">
				<button type="button" class="btn back">回到直播</button>
				<button type="button" class="btn gap" v-if="identity!=0">全员禁言</button>
			</header>
			<nav id="tab" class="tab relative">
				<ul class="flex">
					<li class="left curr">全部</li>
					<span>|</span>
					<li class="right">提问</li>
				</ul>
				<div class="bottom absolute curr"></div>
				<div class="none"></div>
				<div class="bottom1 absolute "></div>
			</nav>
			<!--全部消息-->
			<div class="answer-all-wrapper">
				<ul class="msg-box absolute " id="allBoxAll">
					<li class="item" v-for="(item,index) in datas"
						v-if="item.status==0">
						<div class="question-box">
							<div class="top flex">
								<img :src="item.userHeaderImg" alt="" class="head" /> <span>{{item.userNickName}}</span>
								<button type="button" class="button icon answer-btn"></button>
							</div>
							<div class="botton flex">
								<i class="icon question-icon"></i>
								<p>{{item.content}}</p>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="question-box">
							<div class="top flex">
								<img src="${ctx}/images/a.png" alt="" class="head" /> <span>大师兄</span>
								<button type="button" class="button icon answer-btn"></button>
							</div>
							<div class="botton flex">
								<i class="icon question-icon"></i>
								<p>
									四季的血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。
								</p>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="question-box">
							<div class="top flex">
								<img src="${ctx}/images/a.png" alt="" class="head" /> <span>大师兄</span>
								<button type="button" class="button icon answer-btn"></button>
							</div>
							<div class="botton flex">
								<i class="icon question-icon"></i>
								<p>
									四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。
								</p>
							</div>
						</div> <!--回复-->
						<div class="answer-box">
							<div class="top flex">
								<img src="${ctx}/images/a.png" alt="" class="head" />
								<h6 class="name">于是花</h6>
								<span class="type-zcr type">主持人</span> <span
									class="type-ls type">老师</span>
							</div>
							<!--回复-->
							<div class="text-box ">
								<i class="icon answer-icon"></i>
								<div>
									<!--文字回复-->
									<div class="flex text">
										<p>大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好</p>
										<div class="chehui-btn"></div>
									</div>
									<div class="flex text">
										<p>大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好</p>
										<div class="chehui-btn"></div>
									</div>
									<div class="flex text">
										<p>大家好大家好</p>
										<div class="chehui-btn"></div>
									</div>
									<!--语音回复-->
									<div class="audio-btn-box">
										<button type="button" class="btn">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="">
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn"></div>
									</div>
									<div class="audio-btn-box">
										<button type="button" class="btn">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="">
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn" data-id="11"></div>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
				<!--  提问-->
				<ul class="msg-box absolute all-box-question" id="allBoxQuestion">
					<li class="item" v-for="(item,index) in datas" v-if="item.isAsk">
						<div class="question-box">
							<div class="top flex">
								<img :src="item.userHeaderImg" alt="" class="head" /> <span>{{item.userNickName}}</span>
								<button type="button" class="button icon answer-btn"></button>
							</div>
							<div class="botton flex">
								<i class="icon question-icon"></i>
								<p>{{item.content}}</p>
							</div>
						</div>
					</li>
					<li class="item">
						<div class="question-box">
							<div class="top flex">
								<img src="${ctx}/images/a.png" alt="" class="head" /> <span>大师兄</span>
								<button type="button" class="button icon answer-btn"></button>
							</div>
							<div class="botton flex">
								<i class="icon question-icon"></i>
								<p>
									四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。四季的瑜伽理疗，气血亏虚，失眠，颈肩痛等瑜伽理疗方案，以及一眼知健康的气色诊断。
								</p>
							</div>
						</div> <!--回复-->
						<div class="answer-box">
							<div class="top flex">
								<img src="${ctx}/images/a.png" alt="" class="head" />
								<h6 class="name">于是花</h6>
								<span class="type-zcr type">主持人</span> <span
									class="type-ls type">老师</span>
							</div>
							<!--回复-->
							<div class="text-box ">
								<i class="icon answer-icon"></i>
								<div>
									<!--文字回复-->
									<div class="flex text">
										<p>大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好</p>
										<div class="chehui-btn"></div>
									</div>
									<div class="flex text">
										<p>大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好大家好</p>
										<div class="chehui-btn"></div>
									</div>
									<div class="flex text">
										<p>大家好大家好</p>
										<div class="chehui-btn"></div>
									</div>
									<!--语音回复-->
									<div class="audio-btn-box">
										<button type="button" class="btn"
											data-src="http://wimg.keepyoga.com/2-1xiaoyuanyuan_clip.mp3">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="">
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn"></div>
									</div>
									<div class="audio-btn-box">
										<button type="button" class="btn"
											data-src="http://wimg.keepyoga.com/11.7dinglun.mp3">
											<img src="http://wimg.keepyoga.com/image/son.png" alt="">
										</button>
										<div class="inline-block audio-time-box">
											<i class="cicle"></i> <span class="audio-time">21"</span>
										</div>
										<div class="chehui-btn" data-id="33"></div>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
		</section>
		<!--禁言弹出框-->
		<div class="start-gap-box" id="startGapBox" v-if="identity!=0">
			<div class="gap-box">
				<i class="icon close"></i>
				<h1 class="title">全员禁言模式</h1>
				<p>全员禁言后，全员不能提问</p>
				<div class="flex group-box">
					<button type="button" class="cancel">取消</button>
					<button type="button" class="ok">确认</button>
				</div>
			</div>
		</div>
		<!--tips-->
		<div id="tips">
			<div class="tips flex">
				<div>
					<h1>禁言成功</h1>
				</div>
			</div>
		</div>
		{{identity}}
		<!--导师消息end-->
		<!--学员发消息start-->
		<footer class="student-ask-box fixed" v-if="identity==0">
			<div class="student-box flex" id="studentBox">
				<div class="input-box relative" id="inputBox">
					<div class="input-text" contenteditable="true" id="inputText"></div>
					<p class="absolute placeholder" id="placeholder">提问或发表你的看法</p>
					<div class="checked-ask flex absolute" id="checkBox">
						<i class="icon" :class="{checked:dataCheck}"></i> <span class="text">提问</span>
					</div>
				</div>
				<button type="button" class="enter-btn" id="enterBtn">发送</button>
			</div>
		</footer>
		<!--老师输入框和发送语音宽start-->
		<div class="nost-msg-box none" id="teachAudioBox">
			<!--学员消息-->
			<div class="st-msg-box">
				<span>二师兄：</span>
				如何找到他们需求并且安全、舒适、专业的去满足他们的需求？如何找到他们需求并且安全、舒适、专业的去满足他们的需求？为何要选择13周这个阶段作为孕期瑜伽的开始？具体的我们怎样去教学呢？孕期孕妇的心理状态和身体状态？快速入门，跟孕产瑜伽专家王昕老师学习孕期瑜伽教学重点吧！
			</div>
			<!--语音盒子-->
			<div class="sed-audio-box ">
				<h1>松开手指，立即发送</h1>
				<div class="flex djs-box">
					<img src="${ctx}/resources/images/sxy-live-djsl.png" alt="" />
					<div class="djs">
						<span id="time">0</span>s : 60s
					</div>
					<img src="${ctx}/resources/images/sxy-live-djsr.png" alt="" />
				</div>
				<!--录音按钮-->
				<div class="keyframesBox">
					<div id="keyframes"></div>
				</div>
				<div class="start-audio-btn flex none" id="recordBox">
					<div class="start-audio flex">
						<img src="${ctx}/resources/images/sxy-live-start-audio-btn.png"
							alt="" />
					</div>
				</div>
			</div>
			<!--文字输入框-->
			<footer class="student-ask-box none">
				<div class="student-box flex" id="studentBox">
					<div class="input-box relative" id="inputBox">
						<div class="input-text" contenteditable="true" id="inputText"></div>
						<p class="absolute placeholder" id="placeholder">提问或发表你的看法</p>
					</div>
					<button type="button" class="enter-btn" id="enterBtn">发送</button>
				</div>
			</footer>
		</div>
		<!--老师输入框和发送语音宽end-->
		<!--导师和管理员发消息start-->
		<footer class="send-msg-box flex fixed" id="teachSendBox"
			v-if="identity!==0">
			<div class="yy">
				<i class="icon"></i> <span>语音</span>
			</div>
			<div class="wz">
				<i class="icon"></i> <span>文字</span>
			</div>
			<div class="tp">
				<i class="icon"></i> <span>图片</span>
			</div>
		</footer>
		<!--导师和管理员发消息end-->
		<!--audio-->
		<audio>
			<source :src="audioSrc" type="audio/ogg">
			<source :src="audioSrc+'?v=1'" type="audio/ogg">
		</audio>
	</div>
	<script src="${ctx}/resources/js/lib/fastclick.min.js "></script>
	<script src="${ctx}/resources/js/lib/jquery.min.js "></script>
	<script type="text/javascript"
		src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script src="${ctx}/resources/js/lib/vue.min.js"></script>
	<scirpt src="${ctx}/resources/js/common.js"}></scirpt>
	<script>
	
		var jspS = {
			ctx:"${ctx}",
			userid:"${user.id}",
			nickname:"${user.nickname}",
			pic:"${user.file_path}",
			roomid:"${course.id}",
			teacherids:"${course.teacherids}",
			holderids:"${course.holderids}"
		}
	</script>
	<script src="${ctx}/resources/js/modules/sxy-live.js "></script>
</body>

</html>