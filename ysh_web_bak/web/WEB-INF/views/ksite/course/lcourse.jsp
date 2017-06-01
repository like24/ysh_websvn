<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
		<script type="text/javascript" src="${ctx}/js/jquery.form.js?v=${version}"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<title>${teacher.nickname }的线下培训课程“${lcourse.cname }”</title>
		<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
		<link rel="stylesheet" href="${ctx}/css/course_details.css?v=${version}">
		<style>
			#list {
				display: block;
			}
			
			.buy button {
				margin-left: 3.5rem;
			}
			
			.buy button.over {
				background: #ccc;
			}
			
			.submitBox {
				position: absolute;
				left: 0;
				right: 0;
				bottom: -17rem;
				z-index: 99;
				background: #f4f4f4;
			}
			
			label {
				display: block;
				background: white;
				height: 2.8rem;
				width: 100%;
				line-height: 2.8rem;
			}
			
			.phone {
				border-top: 1px solid #e8e8e8;
				border-bottom: 1px solid #e8e8e8;
			}
			
			.buy span:nth-of-type(1) {
				margin-left: 0;
			}
			
			label i {
				color: red;
				margin: .3rem .2rem 0 .8rem;
			}
			
			label span {
				color: #3f3f3f;
				font-size: 15px;
			}
			
			label input {
				color: #3f3f3f;
				font-size: .85rem;
				width: 70%;
			}
			
			.subP {
				width: 100%;
				background: #f4f4f4;
				padding: .5rem 0;
				height: 2.35rem;
			}
			
			.submitBtn {
				background: #118fff;
				border-radius: 3px;
				display: block;
				text-align: center;
				color: white;
				line-height: 2.3rem;
				font-size: 15px;
				position: absolute;
				left: .85rem;
				right: .85rem;
			}
			
			div.titleBox {
				width: 100%;
				height: 3.6rem;
				background: white;
				margin-bottom: .625rem;
				position: relative;
			}
			
			div.titleBox div {
				width: 3.5rem;
				height: 3.5rem;
				background: white;
				border-radius: 3px;
				position: absolute;
				left: 1rem;
				top: -.5rem;
				box-shadow: 0 0 10px 0px #ccc;
			}
			
			div.titleBox div img {
				width: 3.1rem;
				height: 3.1rem;
				border-radius: 3px;
				margin: .2rem;
			}
			
			div.titleBox h4 {
				position: relative;
				left: 4.8rem;
				top: .85rem;
				width: 10rem;
				line-height: 1.2rem;
				font-size: .85rem;
				color: #3f3f3f;
				overflow: hidden;
				white-space: nowrap;
				text-overflow: ellipsis;
			}
			
			div.titleBox span {
				position: absolute;
				top: 1rem;
				color: red;
				right: .85rem;
				font-size: .85rem;
			}
			
			#masking {
				width: 100%;
				height: 100%;
				position: absolute;
				left: 0;
				top: 0;
				background: rgba(0, 0, 0, .6);
				z-index: 99;
				display: none;
			}
			
			.header {
				height: 10.425rem;
				width: 100%;
			}
			
			.header img {
				height: 100%;
				width: 100%;
			}
			
			.payment {
				padding: .55rem .7125rem .1rem .7125rem;
				background-color: #fff;
			}
			
			.payment .title-and-price {
				color: #3f3f3f;
				border-bottom: 1px solid #e8e8e8;
				overflow: hidden;
			}
			
			.title-and-price .title {
				margin-bottom: 0.55rem;
				font-size: 0.8rem;
				line-height: 1.225rem;
			}
			
			.title-and-price .type {
				font-size: 0.6rem;
				border: 1px solid #fc9427;
				border-radius: 4px;
				padding: 0 .1rem;
				height: .8rem;
				line-height: .8rem;
				color: #fc9427;
				text-align: center;
				float: left;
				margin-bottom: 0.65rem;
			}
			
			.title-and-price .price {
				color: #fa1d26;
				font-size: 0.8rem;
				float: right;
				margin-bottom: 0.75rem;
			}
			
			.address-and-time {
				font-size: 0.6rem;
				color: #9c9c9c;
				padding: 0.75rem 0;
				position: relative;
				border-bottom: 1px solid #e8e8e8;
			}
			
			.address-and-time .address {
				margin-bottom: 0.325rem;
			}
			
			.address-and-time .content {
				width: 11.5rem;
				display: inline-block;
				vertical-align: middle;
				color: #9c9c9c;
			}
			
			.address-and-time .icon-address {
				width: 0.575rem;
				height: 0.75rem;
				margin-right: 0.4rem;
				vertical-align: top;
				margin-top: 2px;
			}
			
			.address-and-time .icon-time {
				width: 0.575rem;
				height: 0.625rem;
				margin-right: 0.4rem;
				vertical-align: middle;
			}
			
			.address-and-time .date,
			.address-and-time .hour {
				margin-left: 0.45rem;
			}
			
			.address-and-time .call {
				width: 1.275rem;
				height: 1.275rem;
				position: absolute;
				top: 50%;
				margin-top: -0.7375rem;
				right: 0;
				padding: 0.2875rem 0.3375rem 0.2875rem 1.05rem;
				border-left: 1px solid #e8e8e8;
			}
			
			.address-and-time .call img {
				width: 100%;
				height: 100%;
			}
			
			.collect-share-buy {
				overflow: hidden;
			}
			
			.collect-share-buy .collect,
			.collect-share-buy .share {
				float: left;
				width: 3rem;
				height: 1.45rem;
				margin-top: 0.975rem;
			}
			
			.collect-share-buy .share {
				margin-left: 0.45rem;
			}
			
			.collect-share-buy .buy {
				width: 4.95rem;
				background-color: #fc9427;
				float: right;
				text-align: center;
				line-height: 1.7rem;
				color: #fff;
				font-size: 0.75rem;
				margin-top: 0.875rem;
			}
			
			.course-desc {
				margin-top: 0.5rem;
				padding: 0.95rem 0.7125rem;
				background-color: #fff;
			}
			
			.course-desc .title {
				font-size: 0.8rem;
				color: #3f3f3f;
				margin-bottom: 0.85rem;
			}
			
			.course-desc .blue {
				display: inline-block;
				width: 0.15rem;
				height: 0.7rem;
				background-color: #118eff;
				margin-right: 0.25rem;
			}
			
			.course-desc .content {
				font-size: 0.65rem;
				color: #9c9c9c;
				line-height: 1rem;
			}
			
			.coach-info {
				margin-top: 0.5rem;
				background-color: #fff;
				padding: 0.95rem 0.7125rem;
			}
			
			.coach-info .title {
				font-size: 0.8rem;
				color: #3f3f3f;
				margin-bottom: 0.55rem;
			}
			
			.coach-info .blue {
				display: inline-block;
				width: 0.15rem;
				height: 0.7rem;
				background-color: #118eff;
				margin-right: 0.25rem;
			}
			
			.coach-info .content {
				position: relative;
			}
			
			.coach-info .avatar {
				width: 2.85rem;
				height: 2.85rem;
				position: absolute;
				top: 50%;
				margin-top: -1.425rem;
			}
			
			.coach-info .avatar img {
				width: 100%;
				height: 100%;
				border-radius: 50%;
			}
			
			.coach-info .coach-desc {
				margin-left: 3.7rem;
				width: 11rem;
			}
			
			.coach-info .name {
				margin-right: 0.7rem;
				font-size: 0.65rem;
			}
			
			.coach-info .desc {
				font-size: 0.65rem;
				color: #9c9c9c;
			}
			
			.coach-info .word {
				margin-top: 0.7rem;
				font-size: 0.6rem;
				color: #9c9c9c;
				display: -webkit-box;
				padding-right: .1rem;
				-webkit-box-orient: vertical;
				-webkit-line-clamp: 2;
				overflow: hidden;
			}
			
			.coach-info .right-arrow {
				position: absolute;
				top: 50%;
				right: 0;
				height: 0.625rem;
				margin-top: -0.3125rem;
				width: 0.325rem;
			}
			
			.coach-info .right-arrow img {
				width: 100%;
				height: 100%;
			}
			
			.set-meal-box {
				word-break: break-all;
				border-bottom: 1px solid #e8e8e8;
			}
			
			.set-meal-box .tit {
				font-size: 16px;
				color: #fc9427;
				margin-bottom: .6rem;
				font-weight: 600;
				margin-top: .6rem;
			}
			
			.set-meal-box .tag {
				padding: .4rem .5rem;
				background: #f4f4f4;
				border-radius: 3px;
				display: inline-block;
				font-size: .6rem;
				color: #3f3f3f;
				margin-right: .6rem;
				margin-bottom: .6rem;
				font-weight: 600;
			}
			
			.set-meal-box .tag.active {
				background: #fc9527;
				color: white;
			}
			
			.see-more {
				font-size: .6rem;
				color: #1d92fb;
			}
			
			.buy span {
				font-size: .62rem;
			}
			
			.buy {
				padding: .2rem 0;
			}
		</style>
		<script type="text/javascript">
			var nodata = 1;
			var nologin = "${nologin}";
			if(nologin == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}
		</script>
	</head>

	<body>
		<div id="masking"></div>
		<div class="submitBox" id="submitBox">
			<!-- 
		<div class="titleBox">
			<div>
				<img src="../images/fx.jpg" alt="">
			</div>
			<h4>${lcourse.cname }</h4>
			<span>${lcourse.money }</span>
		</div>
		 -->
			<div class="inputBox">
				<label for="name">
				<i>*</i>
				<span>姓名：</span>
				<input type="text" id="name" value="">
			</label>
				<label for="phone" class="phone">
				<i>*</i>
				<span>手机：</span>
				<input type="tel" id="phone" maxlength="11" value="">
			</label>
			</div>
			<p class="subP">
				<a href="javascript:;" class="submitBtn" id="submitBtn">提交订单</a>
			</p>
		</div>
		<div class="wrapper">
			<section class="mainBox" id="mainBox">
				<div class="iscrollBox">
					<header class="header">
						<img src="${lcourse.icon } " id="header" alt="">
					</header>
					<div class="payment">
						<div class="title-and-price">
							<p class="title">${lcourse.cname }</p>
							<p class="type">线下培训课</p>
							<c:if test="${lcourse.money == 0 }">
								<p class="price">免费</p>
							</c:if>
							<c:if test="${lcourse.money != 0 && havaChildMoneyList == false}">
								<p class="price">￥${lcourse.money }</p>
							</c:if>
						</div>
						<div class="address-and-time">
							<div class="address">
								<img class="icon-address" src="${ctx }/images/icon_address.png" alt="">
								<p class="content">${lcourse.address }</p>
							</div>
							<div class="time">
								<img class="icon-time" src="${ctx }/images/icon_time.png" alt="">
								<p class="content">
									<span>开课时间:</span><span class="date">${fn:substring(lcourse.coursetime_start,0,10)}</span>
									<span class="hour">${fn:substring(lcourse.coursetime_start,11,19)}</span>
								</p>
							</div>
							<div class="call">
								<a href="tel:4000186161">
									<img class="icon-phone" src="${ctx }/images/icon_phone.png" alt="">
								</a>
							</div>
						</div>
						<c:if test="${havaChildMoneyList  == true }">
							<div class="set-meal-box">
								<h1 class="tit">选择培训套餐</h1>
								<div class="set-meal" id="setMeal">
									<c:forEach items="${moneylist}" var="cmoney">
										<span class="tag <c:if test=" ${cmoney.id==mid} ">active</c:if> " data-url="${ctx}/w/faq/courseitem.html?p=${lcourse.id}&it=${cmoney.id}">${cmoney.cname}&nbsp;￥${cmoney.money}</span>
									</c:forEach>
								</div>
							</div>
						</c:if>
						<div class="buy">
							<c:if test="${ nologin == true || isfollow == false }">
								<span id="shoucang">收藏</span>
							</c:if>
							<c:if test="${ isfollow == true }">
								<span class="high" id="shoucang">已收藏</span>
							</c:if>
							<span onclick="javascript:share();">分享</span>

							<c:if test="${end==1}">
								<button class="over">报名结束</button>
							</c:if>
							<c:if test="${ end == 0 && !ismy }">
								<c:if test="${isjoin}">
									<button>报名成功</button>
								</c:if>
								<c:if test="${!isjoin}">
									<button id="goShoping">立即报名</button>
								</c:if>
							</c:if>
						</div>
					</div>
					<div class="course-desc">
						<div class="title">
							<div class="blue"></div>课程简介
						</div>
						<div class="content">${lcourse.remark }</div>
					</div>
					<div class="course-desc">
						<div class="title">
							<div class="blue"></div>课程详情
						</div>
						<div class="content">${lcourse.content }</div>
					</div>
					<div class="coach-info" id="enter">
						<div class="title">
							<div class="blue"></div>老师介绍
						</div>
						<div class="content">
							<div class="avatar"><img src="${teacher.file_path }"></div>
							<div class="coach-desc">
								<a href="javascript:;">
									<div><span class="name">${teacher.nickname }</span><span class="desc">${teacher.userpost }</span></div>
									<div class="word">${teacher.shortremark }</div>
								</a>
							</div>
							<div class="right-arrow">
								<img src="${ctx }/images/right_arrow.jpg" alt="">
							</div>
						</div>
					</div>
				</div>
				<div id="list"></div>
			</section>
			<%@ include file="../footer.jsp" %>
		</div>
		<script src="${ctx}/js/zepto.js?v=${version}"></script>
		<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
		<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
		<script src="${ctx}/js/wblog.js?v=${version}"></script>
		<script>
			var icon = $("#header").attr("src");
			var title1 = "${teacher.nickname}的精品课程“${lcourse.cname}”";
			var desc1 = "线下培训${lcourse.money}元，随心瑜Live，专业的瑜伽培训教育平台。";
			var link1 = location.href;
			var img1 = icon;
			var curl = "";
			var havaChildCourse = ${havaChildMoneyList};
			var mid = ${mid };
		
			wx.config({
				debug: false,
				appId: '${appid}',
				timestamp: '${timestamp}',
				nonceStr: '${nonceStr}',
				signature: '${signature}',
				jsApiList: [
					'checkJsApi', 'openLocation',
					'getLocation', 'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
					'onMenuShareQQ', 'onMenuShareWeibo', 'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
					'showAllNonBaseMenuItem', 'chooseImage', 'previewImage', 'uploadImage',
					'chooseWXPay', 'downloadImage', 'getNetworkType', 'openLocation',
					'getLocation', 'hideOptionMenu', 'showOptionMenu'
				]
			});

			var loggerid = 0;
			$("#shoucang").on("tap", function() {
				$.ajax({
					type: "post",
					dataType: "json",
					url: "${ctx}/w/course/follow/" + ($("#shoucang").html() == '已收藏' ? '2' : '1') + "/${lcourse.id}/3.html",
					error: function(XMLHttpRequest, textStatus, error) {},
					success: function(msg) {
						if(msg.status == true) {
							if($("#shoucang").html() == '已收藏') {
								$("#shoucang").removeClass("high");
								$("#shoucang").html("收藏 ");
							} else {
								$("#shoucang").addClass("high");
								$("#shoucang").html("已收藏");
							}
						}
					}
				});
			})
			/*导航切换*/
			$("nav>ul").on("tap", "li", function() {
				tab(this);
			})
			$("nav>ul").on("click", "li", function() {
				tab(this);
			})

			function playerOK() {
				$("#audio").get(0).pause();
				$("#audio").get(0).src = $("#filepath").val();
				$("#audio").get(0).volume = 1;
				$("#audio").get(0).play();
			}

			function payEndAndBuy() {
				$.ajax({
					type: "post",
					dataType: "json",
					data: {
						"c": "${lcourse.id}",
						"m": "${money}",
						"name": $("#name").val(),
						"phone": $("#phone").val(),
						"o": "${ordernumber}",
						"p": loggerid
					},
					url: "${ctx}/w/course/line/buy.html",
					error: function(XMLHttpRequest, textStatus, error) {},
					success: function(msg) {
						if(msg.status == true) {
							location.href = "${ctx}/w/faq/courseline.html?p=${lcourse.id}";
						}
					}
				});
			}

			function onBridgeReady() {
				WeixinJSBridge.invoke(
					'getBrandWCPayRequest', {
						"appId": "${appid}", //公众号名称，由商户传入     
						"timeStamp": "${paytimestamp}", //时间戳，自1970年以来的秒数     
						"nonceStr": "${paynonceStr}", //随机串     
						"package": "${paypackage}",
						"signType": "${paysignType}", //微信签名方式:     
						"paySign": "${paySign}" //微信签名 
					},
					function(res) {
						if(res.err_msg == 'get_brand_wcpay_request:ok') {
							payEndAndBuy();
						}
						if(res.err_msg == 'get_brand_wcpay_request:cancel') {
							location.href = "${ctx}/w/faq/courseline.html?p=${lcourse.id}"; // 放弃付款
						}
					}
				);
			}

			function weixinPay() {
				if(typeof WeixinJSBridge == "undefined") {
					if(document.addEventListener) {
						document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
					} else if(document.attachEvent) {
						document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
						document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
					}
				} else {
					onBridgeReady();
				}
			}

			function share() {
				dialog({
					wrapper: ".wrapper",
					id: "share",
					bodytap: true,
					close: true,
					title1: "点击屏幕右上角“...”",
					title2: "选择分享给朋友或分享到朋友圈",
					mask: true,
					time: 2500
				});
			}

			function tapcatalog(id) {
				window.location.href = "${ctx}/w/faq/course.html?p=" + $("#cid").val() + "&i=" + id;
			}
			$("#goShoping").on("click", function() {
				if("${nologin}" == "true") {
					window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
				}
				if($(this).text() == "立即报名") {

					if(havaChildCourse && curl == '') {
						Modal.tips("<font color='#ccc'>请选择你要报名的套餐！</font>", "error", 1500);
						return;
					}
					if(curl != '') {
						location.href = curl;
					} else {
						$("#submitBox").animate({
							bottom: 0
						}, 500);
						$("#masking").show();
					}
				}
			})
			$("#masking").on("click", function() {
				$("#submitBox").animate({
					bottom: -17 + "rem"
				}, 500);
				$("#masking").hide();
			})

			/*购买成功函数*/
			function Success() {
				$("#goShoping").css("background", "#c0c0c0").text("报名成功");
			}

			$("#submitBtn").on("click", function() {
				var name = $("#name").val(),
					phone = $("#phone").val();
				if(name == "") {
					Modal.tips("<font color='#ccc'>请输入真实姓名！</font>", "error", 1500);
					return;
				}
				if(phone == "") {
					Modal.tips("<font color='#ccc'>请输入您的手机！</font>", "error", 1500);
					return;
				}
				if(!check_phone(phone)) {
					Modal.tips("<font color='#ccc'>请输入正确的手机号！</font>", "error", 1500);
					return;
				}
				var usephone = name + "|" + phone;
				$.ajax({
					type: "post",
					dataType: "json",
					url: "${ctx}/w/logger/4/${money}/${lcourse.id}.html?o=${ordernumber}&usephone=" + usephone,
					error: function(XMLHttpRequest, textStatus, error) {},
					success: function(msg) {
						if(msg.id > 0) {
							loggerid = msg.id;
							var money = "${money}";
							if(parseInt(money) > 0) {
								weixinPay();
							} else {
								payEndAndBuy();
							}
						}
					}
				});
			})

			function successCallBack() {
				$("#submitBox").animate({
					bottom: -17 + "rem"
				}, 500);
				$("#masking").hide();
				Success();
			}

			function check_phone(phone) {
				var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
				if(!reg.test(phone)) {
					return false;
				}
				return true;
			}
			$("#enter").on("tap", function() {
				window.location.href = "${ctx}/w/faq/person.html?p=${teacher.id}&t=0";
			})
			//套餐
			$("#seeMore").on("tap", function() {
				$(this).remove();
				$("#setMeal").css("height", "auto");
			})

			$("#setMeal").on("tap", ".tag", function() {
				if(mid > 0) {
					return;
				}
				$("#setMeal").find(".tag").removeClass("active");
				$(this).addClass("active");
				curl = $(this).attr("data-url");
			})
		</script>
		<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
	</body>

</html>