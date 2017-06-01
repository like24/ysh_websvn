<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.yoga.dao.Weixin_blog_user" %>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="v2index"/>
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
	<link rel="stylesheet" href="${ctx}/resources/css/courseArrangement.css?v=1" />
	 <script>
		 <%--var nologin  = "${nologin}";--%>
//         if (nologin == "true" || nologin == "") {
             <%--window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";--%>
//         };
	 </script>
	</head>
	<body >
	<div class="stash" id="stash">
		<span>拼命加载中，请稍候……</span>
	</div>
		<div class="wrapper bg-e4" id="app" v-clock>
			<!--    iscroll滚动    -->
			<section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
				<div class="iscrollBox " id="pullUpWrapper">
					<header class="header">
						<div class="banner-box relative">
							<img :src="detaills.logo" alt="" class="img" />
							<div class="headMask"></div>
							<p class="manLen absolute"><i class="icon"></i>${buycount}人报名</p>
						</div>
						<div class="courseInfo">
							<h1 class="ellipsis2 tit">
								{{detaills.name}}
							</h1>
							<span class="money">
								￥<big>{{detaills.money}}</big>
							</span>
                </div>
                <div class="distributionEdition-box " style="display: none;">
                    <a href="${ctx}/v2/live/saler/${zid}.shtml" class="flex">
                        <div class="distributionEdition">
                            <h4>分销榜</h4>
                            <p>{{totlesaler}}人</p>
                        </div>
                        <div class="icon-box ">
                            <div class="flex" id="iconBox">
                                <img v-for="item in shareLen" :src="item.header" alt=""/>
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
                        <span v-html="detaills.content"></span>
                    </div>
                    <!--导师-->
                    <div class="venue-box">
                        <h2>老师介绍</h2>
                        <ul>
                            <li class="flex relative" v-for="(item,index) in teachs">

                                <img :src="item.file_path" alt=""/>
                                <div class="info">
                                    <h3>{{item.nickname}}</h3>
                                    <p class="ellipsis2">{{item.shortremark}}</p>
                                </div>
                                <div class="btn-box">
                                    <button class="yes" v-show="item.followuser"
                                            @click="gz(item.id,item.followuser,index)"
                                            :data-a="item.followuser"></button>
                                    <button class="no" v-show="!item.followuser"
                                            @click="gz(item.id,item.followuser,index)" :data-a="item.followuser">+关注
                                    </button>
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
                            <a href="javascript:;" class="flex"
                               @click="toLiveRoom('${ctx}/v2/live/zhibo/item'+item.id+'.shtml',item.starttime)">
                                <dt class="relative">
                                    <img :src="item.logo" class="loadingimg" :alt="item.cname"/>
                                    <!--即将开始-->
                                    <span class="icon abslute icon2" v-if="item.status==0"></span>
                                    <!--正在直播-->
                                    <span class="icon abslute icon1" v-if="item.status==1"></span>
                                    <!--直播结束-->
                                    <span class="icon abslute icon3" v-if="item.status==2"></span>
                                </dt>
                                <dd class="ohidden relative course">
                                    <h5 class="name ellipsis2" style="margin-bottom: .1rem;-webkit-line-clamp:2;">
                                        <p class="topic  " :class="item.status?'zb-tit':'zb-tit'">
                                            <small></small>
                                        </p>
                                        <span>{{ item.name }}</span>
                                    </h5>
                                    <span class="type block startTime">{{ item.starttime.substr(5) }}开课</span>
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
            <li class="zixun" id="consult" @click="zixun"><i class="icon"></i><span>咨询</span></li>
            <li class="money" id="share" @click="getMoney">赚学费</li>
            <li class="enter"><span id="goShoping" @click="goShoping" v-if="!pay">立即报名</span>
                <a href="javascript:;" v-if="pay">已购买</a>
            </li>
        </ul>
    </footer>
    <div class="masking fixed none" id="masking" style="z-index:999999999" @click="maskingHide">
        <img src="http://wimg.keepyoga.com/images/sxyLivezhiboshare2.png" alt="" style="width:80%;margin-left:20%;"/>
    </div>
    <div class="pop none" id="consultPop">
        <img src="http://wimg.keepyoga.com/images/sxyLivezhibozixun1.png">
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
<script src="${ctx}/resources/js/common.js?v=2"></script>
<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/js/layer/layer.js"></script>
<script>
    var JspElement = {
        wxid: '${wxid}',
        uid: '${uid}',
        uuid: '${uuid}',
        ordernumber: '${ordernumber}',
        ctx: '${ctx}',
        urlsecret: '${urlsecret}',
        nologin: '${nologin}',
        appid: '${appid}',
        timestamp: '${timestamp}',
        nonceStr: '${nonceStr}',
        signature: '${signature}',
        paytimestamp: '${paytimestamp}',
        paynonceStr: '${paynonceStr}',
        paypackage: '${paypackage}',
        paySign: '${paySign}',
        detaillsId: "${zid}",
        payStatus:${hasJoin},
        realname: "${wxuser.realname}",
        mobile: "${wxuser.mobile}",
        sharename:"${zhibo.sharename}",
        zhiboremark:"${zhibo.remark}"
    };
    var link1 = "${BACKURL}";
    var userID = APP.URLSEARCH().p;
    if (typeof userID == 'undefined') {
        userID = 0;
    }
    if (JspElement.payStatus) {
        $("#jieshao").hide();
        $("#anpai").show();
        $("#tab li").removeClass("curr");
        $("#tab li.right").addClass("curr");
        $("#tab div").removeClass("curr");
        $("#tab div.bottom1").addClass("curr");
    }
</script>
<script src="${ctx}/resources/js/modules/courseArrangement.js?v=6"></script>
<!-- weixin.keepyoga.com Baidu tongji analytics -->
<script>
    var _hmt = _hmt || [];
    (function () {
        var hm = document.createElement("script");
        hm.src = "https://hm.baidu.com/hm.js?ba67d2ff32de2e30f289292c1cbf41d4";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    $(document).on("touchMove", function (e) {
        e.preventDefault();
    })
</script>
</body>
</html>
