<%--
  Created by IntelliJ IDEA.
  User: yinlu
  Date: 17/5/9
  Time: 上午11:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="com.yoga.dao.Weixin_blog_user" %>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="my"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="yes" name="apple-touch-fullscreen">
    <meta content="telephone=no,email=no" name="format-detection">
    <title>用户中心</title>
    <script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css"/>
    <link rel="stylesheet" href="${ctx}/resources/css/my.css"/>
</head>

<body>
<div class="masking"></div>
<div id="two_dimension_code">
    <img src="http://wimg.keepyoga.com/close.jpg" class="close">
    <c:choose>
        <c:when test="${ fn:indexOf(user.file_path,'http') > -1 }">
            <img id="tx" class="two_dimension" src="${user.file_path}">
        </c:when>
        <c:otherwise>
            <img id="tx" class="two_dimension" src="${ctx}/${user.file_path}">
        </c:otherwise>
    </c:choose>
    <p class="two_dimension_img" id="jrcode"></p>
    <h1>${user.nickname }(ysh${user.id}16)</h1>
    <p class="title1">${user.userpost }</p>
    <p class="title2">扫一扫上面的二维码图案，加我微信</p>
</div>
<div class="wrapper bg-e4" id="app">
    <!--    iscroll滚动    -->
    <section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
        <div class="iscrollBox " id="pullUpWrapper">
            <header class="header relative">
                <dl class="flex">
                    <dt>
                        <c:choose>
                            <c:when test="${ fn:indexOf(user.file_path,'http') > -1 }">
                                <img id="tx" src="${user.file_path}">
                            </c:when>
                            <c:otherwise>
                                <img id="tx" src="${ctx}/${user.file_path}">
                            </c:otherwise>
                        </c:choose>
                    </dt>
                    <dd>
                        <h1>
                            ${user.nickname}
                            <c:if test="${user.isteacher == 1}">
                                <i class="icon daoshi"></i>
                            </c:if>
                        </h1>
                        <p>${user.id}</p>
                    </dd>
                </dl>
                <c:if test="${user.isteacher == 1 }">
                    <i class="icon erweima absolute" id="tapqr"></i>
                </c:if>
            </header>
            <div class="distribution-box flex">
                <i class="icon"></i>
                <h1>分销收益</h1>
                <a href="${ctx}/v2/my/tixian.shtml?abcdefg=${ketixian}" class="button">微信提现</a>
            </div>
            <div class="money-box">
                <div>
                    <p>￥<big>${totalIncome}</big></p>
                    <span>历史总金额</span>
                </div>
                <div>
                    <p>￥<big>${todayIncome}</big></p>
                    <span>今日最新收益</span>
                </div>
                <div>
                    <p>￥<big>${ketixian}</big></p>
                    <span>可提现金额</span>
                </div>
            </div>
            <c:if test="${user.isteacher == 1 }">
                <ul class="my">
                    <li style="display: none">
                        <i class="icon left"></i>
                        <p>录播课程收益</p>
                        <i class="icon right"></i>
                        <div class="border"></div>
                    </li>
                    <li data-url="${ctx}/w/my/course.html">
                        <i class="icon left"></i>
                        <p>我的录播课程</p>
                        <i class="icon right"></i>
                        <div class="border"></div>
                    </li>
                    <li data-url="${ctx}/w/my/line/course.html">
                        <i class="icon left"></i>
                        <p>我的线下培训</p>
                        <i class="icon right"></i>
                        <div class="border"></div>
                    </li>
                        <li data-url="${ctx}/w/my/1/ask.html">
                            <i class="icon left"></i>
                            <p>我的回答</p>
                            <i class="icon right"></i>
                            <div class="border"></div>
                        </li>
                </ul>
            </c:if>
            <ul class="guanzhu">
                <li data-url="${ctx}/w/my/mineask.html">
                    <i class="icon left"></i>
                    <p>我的提问</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
                <li data-url="${ctx}/w/my/minebuy.html">
                    <i class="icon left"></i>
                    <p>已购课程</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
                <li data-url="${ctx}/w/my/minebuy/line.html">
                    <i class="icon left"></i>
                    <p>已报线下培训</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
                <li data-url="${ctx}/w/my/minecol.html">
                    <i class="icon left"></i>
                    <p>收藏的课程</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
                <li data-url="${ctx}/w/my/minefol.html">
                    <i class="icon left"></i>
                    <p>已关注老师</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
            </ul>
            <ul class="about">
                <li data-url="${ctx}/w/help/index.html">
                    <i class="icon left"></i>
                    <p>如何使用瑜是乎Live</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
                <li data-url="${ctx}/w/help/about.html">
                    <i class="icon left"></i>
                    <p>关于</p>
                    <i class="icon right"></i>
                    <div class="border"></div>
                </li>
            </ul>
            <p class="tit">瑜是乎客服热线：<a href="tel:400186161">400186161</a></p>
        </div>
    </section>
    <%@ include file="../footer.jsp" %>
</div>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/js/zepto.js?v=${version}"></script>
<script src="${ctx}/js/qrcode.min.js?v=${version}"></script>
<script>
    $(function () {
        $("#mainBox").show();
    })
    var nologin = "${nologin}";
    if (nologin == "true") {
        window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
    }
    var title1 = "我是${user.nickname }，有问题，欢迎来「随心瑜Live」问我";
    var desc1 = "${user.nickname }|${user.userpost}";
    var link1 = "${ctx}/w/faq/person.html?p=${user.id}";
    var img1 = $("#tx").attr("src");

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
    wx.ready(function (Api) {
        wx.hideAllNonBaseMenuItem();
        wx.showMenuItems({
            menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
        });
    });

    $(document).find("li").click(function () {
        var url1 = $(this).attr("data-url");
        window.location.href = url1;
    });
    var qrcode = new QRCode("jrcode", {
        text: "${ctx}/w/faq/person.html?p=${user.id}",
        width: 200,
        height: 200
    });
    $(".masking").on("touchend", function() {
        $(".masking").css("display", "none");
        $("#two_dimension_code").css("display", "none");
    });
    $(".close").on("touchend", function() {
        $(".masking").css("display", "none");
        $("#two_dimension_code").css("display", "none");
    });
    $("#tapqr").on("touchend", function() {
        $(".masking").css("display", "block");
        $("#two_dimension_code").css("display", "block");
    })
</script>
</body>

</html>
