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
    <link rel="stylesheet" href="http://weixin.keepyoga.com/css/reset.css?v=${version}">
    <link rel="stylesheet" href="http://weixin.keepyoga.com/css/common.css?v=${version}">
    <link rel="stylesheet" href="http://weixin.keepyoga.com/css/dialog.css?v=${version}">
    <script src="http://weixin.keepyoga.com/js/jquery.min.js?v=${version}"></script>
    <script type="text/javascript" src="http://weixin.keepyoga.com/js/jquery.form.js?v=${version}"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <title>${teacher.nickname }的线下培训课程“${lcourse.cname }”</title>
    <script src="http://weixin.keepyoga.com/js/setfontsize.js?v=${version}"></script>
    <style>
        .footBtn .enter {
            position: fixed;
            left: 0;
            right: 0;
            bottom: 0;
            height: 2.35rem;
            width: 100%;
            background: #1e94fb;
            color: white;
            font-size: 18px;
            outline: none;
            border: none;
        }
        
        .container {
            position: absolute;
            left: 0;
            right: 0;
            top: 0;
            bottom: 2.35rem;
            overflow: hidden;
            overflow-y: auto;
            -webkit-overflow-scrolling: touch;
        }
        
        .content1 {
            background: white;
            padding-bottom: .5rem;
        }
        
        .headBox img {
            height: 10.425rem;
            width: 100%;
        }
        
        .title {
            margin-bottom: 0.75rem;
            font-size: 0.8rem;
            line-height: 1.225rem;
            padding: .4rem .825rem 0;
        }
        
        .tag {
            display: inline-block;
            font-size: 0.6rem;
            border: 1px solid #40c4a7;
            border-radius: 4px;
            padding: 0 .5rem;
            height: 1rem;
            line-height: 1rem;
            color: #40c4a7;
            text-align: center;
            margin-bottom: 0.85rem;
            margin-left: .825rem;
        }
        
        ul {
            background: white;
            margin-top: .5rem;
        }
        
        li p {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            margin-right: .855rem;
        }
        
        ul li {
            line-height: 2.15rem;
            border-bottom: 1px solid #e8e8e8;
            padding-left: .825rem;
            font-size: 15px;
            color: #3f3f3f;
        }
        
        ul li span {
            color: #fa1c26;
            font-size: 15px;
            margin-right: .1rem;
        }
        
        ul p {
            line-height: 2rem;
            text-align: center;
            font-size: 12px;
            line-height: #9c9c9c;
        }
        
        .line {
            height: 1px;
            background: #e8e8e8;
            margin: 0 .825rem;
            margin-bottom: .75rem;
        }
        
        ol li {
            padding-left: .825rem;
            line-height: 1rem;
            font-size: .6rem;
            color: #3f3f3f;
        }
        
        ol li .icon {
            display: inline-block;
            float: left;
            width: .625rem;
            height: .8rem;
            margin-right: .4rem;
            position: relative;
            top: .15rem;
        }
        
        ol li .icon1 {
            background: url("http://wimg.keepyoga.com/images/under-line-icon1.png") no-repeat;
            background-size: contain;
        }
        
        ol li .icon2 {
            background: url("http://wimg.keepyoga.com/images/under-line-icon2.png") no-repeat;
            background-size: contain;
        }
        
        ol li .icon3 {
            background: url("http://wimg.keepyoga.com/images/under-line-icon3.png") no-repeat;
            background-size: contain;
        }
    </style>
    <div class="wraper">
        <div class="container">
            <div class="headBox"> 
               <img src="${lcourse.icon }" alt="">
            </div>
            <div class="content1">
                <p class="title">${lcourse.cname }</p> <span class="tag">线下培训课</span>
                <div class="line"></div>
                <ol>
                    <li> <i class="icon icon1"></i>
                        <p>${lcourse.address }</p>
                    </li>
                    <li> <i class="icon icon2"></i>
                        <p>开课时间：${fn:substring(lcourse.coursetime_start,0,10)} &nbsp;${fn:substring(lcourse.coursetime_start,11,19)}</p>
                    </li>
                    <li> <i class="icon icon3"></i>
                        <p>选择培训套餐：${itemcoursemoney.cname }&nbsp;${itemcoursemoney.money }元</p>
                    </li>
                </ol>
            </div>
            <ul>
                <li><span>*</span>姓&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;名:
                    <input type="text" placeholder="请输入您的姓名" id="username" name="username"> </li>
                <li><span>*</span>联系电话:
                    <input type="text" placeholder="请输入您的联系电话" id="mobile" name="mobile"> </li>
                <p>老师将给您预留的手机号联系，确定上课位置时间！</p>
            </ul>
        </div>
        <div class="footBtn">
            <button class="enter" class="submitBtn" id="submitBtn"  >立即报名</button>
        </div>
    </div>
    <body>
        <script src="http://weixin.keepyoga.com/js/zepto.js?v=${version}"></script>
        <script src="http://weixin.keepyoga.com/js/wblog.js?v=${version}"></script>
        <script src="http://weixin.keepyoga.com/js/model_dialog.js?v=${version}">
        </script>
        <script>
            $("ul li").on("click", function () {
                $(this).find("input").focus();
            })
            var icon = $("#header").attr("src");
			var title1 = "${teacher.nickname}的精品课程“${lcourse.cname}”";
			var desc1 = "线下培训${lcourse.money}元，随心瑜Live，专业的瑜伽培训教育平台。";
			var link1 = location.href;
			var img1 = icon;
			wx.config({
				debug: false,
				appId: '${appid}',
				timestamp: '${timestamp}',
				nonceStr: '${nonceStr}',
				signature: '${signature}',
				jsApiList: [
					'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
					'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
					'chooseWXPay','hideOptionMenu', 'showOptionMenu'
				]
			});
			
			wx.ready(function () {
				wx.checkJsApi({
					jsApiList: ['startRecord','stopRecord'],
					success: function (res) {
						if (res.checkResult.startRecord == false) {
							 
						} 
					}
				});
				wx.error(function (res) {
					alert("err==" + JSON.stringify(res));
				});
				wx.hideAllNonBaseMenuItem();
			});

			document.addEventListener("WeixinJSBridgeReady", function() {
				//onBridgeReady();  
			}, false);
			
			var loggerid = 0;
			
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
						"mid":"${itemcoursemoney.id}",
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
				if(typeof('WeixinJSBridge') == "undefined") {
					if( document.addEventListener) {
						document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
					} else if(document.attachEvent) {
						document.attachEvent('WeixinJSBridgeReady', onBridgeReady);
						document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
					}
				} else {
					onBridgeReady();
				}
			}

			function check_phone(phone) {
				var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
				if(!reg.test(phone)) {
					return false;
				}
				return true;
			}
			
			/*购买成功函数*/
			function Success() {
				$("#goShoping").css("background", "#c0c0c0").text("报名成功");
			}

			$("#submitBtn").on("click", function() {
				var name = $("#username").val(),
					phone = $("#mobile").val();
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
							if( parseInt(money) > 0 ) {
								weixinPay();
							} else {
								payEndAndBuy();
							}
						}
					}
				});
			})
			 
        </script> 
    </body> 
</html>