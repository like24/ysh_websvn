<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../taglibs.jsp" %>
<c:set var="footclass" value="v2index" />
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
		<meta content="yes" name="apple-mobile-web-app-capable">
		<meta content="yes" name="apple-touch-fullscreen">
		<meta content="telephone=no,email=no" name="format-detection">
		<title>随心瑜Live</title>
		<script src="${ctx}/resources/js/lib/setfontsize.min.js?v=${version}"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="${ctx}/resources/css/reset.css?v=${version}" />
		<link rel="stylesheet" href="${ctx}/resources/css/swiper-3.3.1.min.css?v=${version}" />
		<link rel="stylesheet" href="${ctx}/resources/css/index.css?v=${version}" />
	<style>
	.recommend .item a{
		align-items: center;
	}
	</style>
	</head>
	<body>
		<div class="wrapper bg-e4" id="app" v-cloak>
			<!--    搜索框开始   -->
			<div class="search-wrapper fixed bg-e4">
				<a href="${ctx}/v2/search/index.shtml" class="serarch-box relative bg-fff block"> <i class="icon search-icon absolute"></i>
					<p class="search-text text-c">搜索课程、问题和导师</p>
				</a>
			</div>
			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper" v-if="bannerlist.length">
					<!--    轮播图开始    -->
					<div class="swiper-container swiper-container1 picAutoBox">
						<div class="swiper-wrapper">
							<div class="swiper-slide" v-for="item in bannerlist">
								<a :href="item.url"> <img :src="item.icon" alt="轮播图片" /> </a>
							</div>
						</div>
						<!-- 如果需要分页器 -->
						<div class="swiper-pagination"></div>
					</div>
					<!--    轮播图结束    -->
					<!--     topNav     -->

					<div class="swiper-container swiper-container2  bg-fff" id="swiper2" v-if="classlist.length">
						<div class="swiper-wrapper">
							<div class="swiper-slide" v-for=" (item,index)  in classlist" :class="classlist.length>4 ? 'width22' :''">
								<a href="javascript:;" :data-id="item.id" :data-name="item.name" data-url="${ctx}/v2/cls/#/index.shtml" class="block" @click="topNav(index)"> <img :src="item.logo" alt="课程分类列表图片" /> <span>{{ item.name }}</span> </a>
							</div>
						</div>
					</div>

					<!--   直播课程   -->
					<div class="hot-recommend bg-fff m30 m-b" v-if="zhibolist.length">
						<!-- 标题 -->
						<div class="title flex">
							<h4  >直播课程</h4>
							<a href="${ctx}/v2/live/list.shtml" class="block">查看全部 ></a>
						</div>
						<div>
							<dl class="item" v-for="item in zhibolist">
								<a :href="'${ctx}/pay/live/detail/'+item.money+'_'+item.id+'.shtml'" class="flex"> <dt class="relative">
	            					<img :data-src="item.logo" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt="item.cname" />
	            				<p class="topic absolute" :class="item.status?'zb':'zb-ing'">
	            						<small></small>
	            					</p>
								</dt>
									<dd class="ohidden relative">
										<h5 class="name ellipsis" style="margin-bottom: .1rem;"><p class="topic  " :class="item.status?'zb-tit':'zb-tit'">
	            						<small></small>
	            					</p>	{{ item.title }}</h5>
	            					<span class="ellipsis">{{item.name}}</span>
	            					<span class="type block ellipsis2" >{{ item.starttime.substr(5) }}开课</span>
	            					<span class="time block"><time>{{ item.buycount }}</time>人报名</span>
										<p class='money absolute' v-if="item.money  > 0 "><small>￥</small><big>{{ item.money }}</big></p>
										<p class='money absolute free' v-if="item.money <=0 ">免费</p>
									</dd>
								</a>
							</dl>
						</div>
					</div>


					<!--   免费推荐   -->
					<div class="recommend bg-fff m30 m-b" v-if="fclist.length">
						<!-- 标题 -->
						<div class="title flex">
							<h4  >免费好课</h4>
							<a href="${ctx}/v2/index/free/more.shtml" class="block">查看全部 ></a>
						</div>
						<ul>
							<li class="item " v-for="item in fclist">
								<a :href="'${ctx}/w/faq/course.html?p='+item.cid+'&i=0'" class="flex"> <i class="icon" :class="item.ctype?'icon-video':'icon-audio'"></i>
									<p class="text ellipsis">{{ item.cname }} : {{ item.remark }} </p>
								</a>
							</li>
						</ul>
					</div>
					<!--   瑜伽导师   -->
					<div class="yoga-tutor-box bg-fff m30 m-b" v-if="tearcherlist.length">
						<!-- 标题 -->
						<div class="title flex">
							<h4  >瑜伽导师</h4>
							<a href="${ctx}/v2/index/tutor/more.shtml" class="block">查看全部></a>
						</div>
						<div>
							<dl class="item" v-for="item in tearcherlist">
								<a :href="'${ctx}/w/faq/person.html?p='+item.id+'&t=4'" class="flex"> <dt>
	            					<img :data-src="item.icon" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt=" item.name头像" />
	            				</dt>
									<dd class="ohidden">
										<h5 class="name">{{ item.name }}</h5> <span class="job ellipsis">{{ item.userpost }}</span>
										<p class="summary ellipsis" style="padding-top:.2 rem;">{{ item.shortremark }}</p>
									</dd>
								</a>
							</dl>
						</div>
					</div>
					<!--   热门推荐   -->
					<div class="hot-recommend bg-fff m30 m-b" v-if="pclist.length">
						<!-- 标题 -->
						<div class="title flex">
							<h4  >付费精选</h4>
							<a href="${ctx}/v2/index/pay/more.shtml" class="block">查看全部 ></a>
						</div>
						<div>
							<dl class="item" v-for="item in pclist">
								<a :href="'${ctx}/w/faq/course.html?p='+item.cid+'&i=0'" class="flex"> <dt class="relative">
	            					<img :data-src="item.icon" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt="item.cname" />
	            				</dt>
									<dd class="ohidden relative">
										<h5 class="name ellipsis">	<p class="topic  " :class="item.ctype?'blue':'orange'">
	            						<small></small>
	            					</p>{{ item.cname }}</h5> <span class="type block ellipsis2">{{ item.remark }}</span> <span class="time block">时长：<time>{{ item.longtime }}</time></span>
										<p class='money absolute' v-if="item.money  > 0 "><small>￥</small><big>{{ item.money }}</big></p>
										<p class='money absolute free' v-if="item.money <=0 ">免费</p>
									</dd>
								</a>
							</dl>
						</div>
					</div>
					<!--     瑜伽专题    -->
					<div class="yoga-topic bg-fff m30 m-b" v-if="activitylist.length">
						<!-- 标题 -->
						<div class="title flex">
							<h4>瑜伽专题</h4>
							<a href="${ctx}/v2/index/special/more.shtml" class="block">查看全部专题 ></a>
						</div>
						<ul>
							<li v-for="item in activitylist">
								<a :href="item.url"> <img :data-src="item.logo" src="${ctx}/resources/images/pixel.gif" :alt="item.name" class="loadingimg"> </a>
							</li>
						</ul>
					</div>
				</div>
			</section>
			<%@ include file="footer.jsp" %>
		</div>
		<script src="${ctx}/resources/js/lib/vue.min.js?v=${version}"></script>
		<script src="${ctx}/resources/js/lib/zepto.min.js?v=${version}"></script>
		<script src="${ctx}/resources/js/lib/iscroll4.min.js?v=${version}"></script>
		<script src="${ctx}/resources/js/lib/iscroll-pullup.js?v=${version}"></script>
		<script src="${ctx}/resources/js/lib/swiper-3.3.1.jquery.min.js?v=${version}"></script>
		<script src="${ctx}/resources/js/common.js?v=${version}"></script>
		<script src="${ctx}/resources/js/modules/index.js?v=${version}"></script>
	</body>
	<script type="text/javascript">
		var icon = "http://wimg.keepyoga.com/ask.png";
		var title1 = "";
		var desc1  = "随心瑜Live";
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

		wx.ready(function(Api){
		    // 隐藏右上角popup菜单入口
		   //wx.hideOptionMenu();
		    // 隐藏浏览器下方的工具栏
		    //wx.hideToolbar();

		    wx.hideAllNonBaseMenuItem();
		    //
		    wx.showMenuItems({
			    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
		    // 获取网络状态
		    wx.getNetworkType(function(network){
		        // 拿到 network 以后，做任何你想做的事
		    });
		    // 微信分享的数据
		    var wxData = {
		        "imgUrl":'http://www.baidufe.com/fe/blog/static/img/weixin-qrcode-2.jpg',
		        "link":'http://www.baidufe.com',
		        "desc":'一切精彩尽在瑜是好',
		        "title":"随心瑜Live|"
		    };
		    // 分享的回调
		    var wxCallbacks = {
		        // 分享操作开始之前
		        ready:function () {
		            // 你可以在这里对分享的数据进行重组
		        },
		        // 分享被用户自动取消
		        cancel:function (resp) {
		            // 你可以在你的页面上给用户一个小Tip，为什么要取消呢？
		        	 alert("分享取消了");
		        },
		        // 分享失败了
		        fail:function (resp) {
		            // 分享失败了，是不是可以告诉用户：不要紧，可能是网络问题，一会儿再试试？
		        	 alert("分享失败了");
		        },
		        // 分享成功
		        confirm:function (resp) {
		            // 分享成功了，我们是不是可以做一些分享统计呢？
		            alert("分享成功了");
		        },
		        // 整个分享过程结束
		        all:function (resp) {
		            // 如果你做的是一个鼓励用户进行分享的产品，在这里是不是可以给用户一些反馈了？
		        	 alert("分享过程结束");
		        }
		    };
		    // 用户点开右上角popup菜单后，点击分享给好友，会执行下面这个代码
		    wx.shareToFriend(wxData, wxCallbacks);
		    // 点击分享到朋友圈，会执行下面这个代码
		    wx.shareToTimeline(wxData, wxCallbacks);
		    // 点击分享到腾讯微博，会执行下面这个代码
		    wx.shareToWeibo(wxData, wxCallbacks);
		});



		var nologin = "${nologin}";
		if( nologin == "true" ) {
		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}

	</script>
</html>
