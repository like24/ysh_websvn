<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../../taglibs.jsp" %>
<!doctype html>
<html lang="en">
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<title>信息完善</title>
	<script src="${ctx }/resources/js/lib/setfontsize.min.js"></script>
	<link rel="stylesheet" href="${ctx }/resources/css/reset.css" />
		<style type="text/css">
			html,
		body {
			width: 100%;
			height: 100%;
			background: #F4F4F4;
			overflow: hidden;
		}
		
		.wrapper {
			width: calc(100% - .6rem);
			height: calc(100% - .6rem);
			background: white;
			margin: .3rem 0 0 .3rem;
		}
		
		.item {
			width: calc(100% - .5rem);
			height: 1rem;
			margin-left: .25rem;
			align-items: center;
			margin-bottom: .2rem;
		}
		
		.item1 {
			border-bottom: 1px solid #F3F3F3;
		}
		
		.item span {
			width: 1.9rem;
			font-size: .34rem;
			color: #7d7d7d;
		}
		
		.title {
			font-size: .36rem;
			color: #252525;
		}
		
		input {
			flex: 1;
			height: .8rem;
			background: #F8F8F8;
			border-radius: 5px;
			font-size: .34rem;
			text-indent: .2rem;
			color: #252525;
		}
		
		input.focus {
			background: none;
			border: 1px solid #C6C6C6;
		}
		
		button {
			width: calc(100% - .5rem);
			margin-left: .25rem;
			height: 1.1rem;
			background: #F7934A;
			border-radius: 5px;
			font-size: .44rem;
			color: #FFFFFF;
			transition: opacity .2s;
		}
		
		button:active {
			opacity: .8;
		}
		
		.tit {
			font-size: .26rem;
			text-align: center;
			color: #7D7D7D;
			margin-bottom: .3rem;
		}
		
		.tit b {
			color: #131313;
		}
		
		.again {
			background: #E6E6E6;
		}
		
		.mask-box {
			width: 100%;
			height: 100%;
			background: rgba(0, 0, 0, .8);
			position: fixed;
			left: 0;
			top: 0;
			z-index: 99;
			display: none;
		}
		
		.mask-box button {
			width: 2.56rem;
			height: .84rem;
			font-size: .34rem;
		}
		
		.mask-box .cancel {
			background: #C0C0C0;
			color: #252525;
			margin: 0;
		}
		
		.mask-box .enter {
			background: #2EC4A8;
			color: white;
		}
		
		.mask-box h1 {
			font-size: .34rem;
			text-align: center;
			color: #252525;
			padding: .5rem 0 .7rem 0;
		}
		
		.mask {
			background: white;
			width: calc(100% - 1.1rem);
			height: 3rem;
			border-radius: 5px;
			margin-left: .55rem;
			position: absolute;
			top: 50%;
			margin-top: -1.5rem;
		}
		
		.btn-group {
			justify-content: space-around;
		}
		
		.icon {
			display: block;
			width: .4rem;
			height: .4rem;
/* 			background: url(${ctx}/resources/images/sxy-libe-close-panle.png) no-repeat; */
			background-size: contain;
			position: absolute;
			right: .2rem;
			top: .2rem;
		}
		
		.tips {
			justify-content: center;
			align-items: center;
			position: fixed;
			left: 0;
			top: 0;
			width: 100%;
			height: 100%;
			display: flex;
			visibility: hidden;
			z-index:99999;
		}
		
		.tips div {
			display: inline-block;
			background: rgba(0, 0, 0, .8);
			color: white;
			font-size: .3rem;
			padding: .2rem .3rem;
			border-radius: 5px;
			display: none;
		}
		</style> 
	</head>

	<body>
		<div class="wrapper">
			<div class="item item1 flex" <span style="color: #2EC5A8;">信息完善：</span>
				<p class="title">孕产瑜伽课代表</p>
			</div>
			<div class="item flex <c:if test="${isadd }"> focus</c:if> ">
				<span>真实姓名：</span>
				<input type="text" maxlength="20" <c:if test="${isadd }"> readonly value="${disInfo.cname }"</c:if> placeholder="请填写真实姓名" />
			</div>
			<div class="item flex <c:if test="${isadd }"> focus</c:if> ">
				<span>电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</span>
				<input type="number" <c:if test="${isadd }"> readonly value="${disInfo.mobile }"</c:if> placeholder="请填写课代表手机号" />
			</div>
			<p class="tit" style="margin-top: 5rem;">请认真填写正确信息，一经提交将<b>不能修改</b>，将无法进行结算。</p>
			<p class="tit">客服微信号：keepyoga002</p>

			<button type="button" id="tj" <c:if test="${isadd }">style="display:none"</c:if>>提交</button>
			
			
			<button type="button" class="again"  <c:if test="${!isadd }">style="display:none"</c:if>>已提交</button>
			
		</div>
		<div class="mask-box" id="mask">
			<div class="mask">
				<i class="icon"></i>
				<h1>是否确认提交</h1>
				<div class="flex btn-group">
					<button type="button" class="cancel">取消</button><button type="button" class="enter">确认</button></div>
			</div>
		</div>
		<div class="tips" id="tips">
			<div>aaaa</div>
		</div>
		<script src="http://weixin.keepyoga.com/js/jquery.min.js?v=${version}"></script>
		<script type="text/javascript">
		$(function() {
			if("${nologin}" == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
				return;
			}
			var Dom = {
				tj: $("#tj"),
				mask: $("#mask"),
				name: $("input:text"),
				phone: $("input[type=number]"),
				tips: $("#tips")
			};
			var variable = {
				name: "",
				phone: ""
			};
			Dom.tj.click(function() {
				variable.name = Dom.name.val().trim();
				variable.phone = Dom.phone.val().trim();
				if(variable.name == "") {
					showTips("姓名不能为空", 1000);
					return;
				} else if(variable.phone == "") {
					showTips("手机号不能为空", 1000);
					return;
				} else if(!checkPhone(variable.phone)) {
					showTips("请填写正确的手机号", 1000);
					return;
				} else {
					hide_show_Mask("fadeIn");
				};
			});
			Dom.mask.on("click", function(e) {
				var target = e.target,
					targetId = target.id,
					targetName = target.tagName.toLocaleLowerCase(),
					targetClass = target.className;

				if(targetId == "mask" || targetName == "i" || targetClass == "cancel") {
					hide_show_Mask("fadeOut");
					return;
				} else if(targetClass == "enter") {
					enter();
					return;
				} else {
					return;
				};
			});

			function hide_show_Mask(OR) {
				Dom.mask[OR](100);
			};

			function showTips(text, time, cb) {
				Dom.tips.css("visibility", "visible");
				Dom.tips.find("div").text(text).fadeIn(100);
				setTimeout(function() {
					Dom.tips.css("visibility", "hidden");
					Dom.tips.find("div").fadeOut(100, function() {
						if(typeof cb == "function") cb();
					});
				}, time);
			};

			function checkPhone(phone) { //验证是否为手机号
				var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
				if(!reg.test(phone)) {
					return false;
				}
				return true;
			};

			function enter() {
				$.post("${ctx}/w/faq/distributor/info.html", {
					name: variable.name,
					phone: variable.phone
				}, function(res) {
					if(res.status){
						showTips("您的信息已经提交成功", 1000, function() {
							hide_show_Mask("fadeOut");
						});
						setInput();
					}else{
						showTips(res.msg, 1000);
					}
				}, "json");

			};

			function setInput() {
				Dom.name.attr("readonly", true);
				Dom.phone.attr("readonly", true);
				Dom.name.addClass("focus")
				Dom.phone.addClass("focus")
				Dom.tj.hide();
				$("button.again").show();
			}

		})
		</script>
	</body>
</html>