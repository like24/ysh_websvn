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
    <title>瑜是乎 | 您想要学的课程都在这里</title>
    <script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
    <link rel="stylesheet" href="${ctx}/resources/css/presentationDetails.css" />
</head>

<body>
<div class="wrapper bg-e4" id="app" v-cloak>
    <!--    iscroll滚动    -->
    <section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
        <div class="iscrollBox " id="pullUpWrapper">
            <ul >
                <p class="flex space-between header"><span>时间</span><span>提现状态</span><span>提现金额</span></p>
                <li class="item flex space-between" v-for="(item,index) in contentlist">
                    <time>{{item.createtime.substr(5)}}</time>
                    <span style="color:red;font-size: .28rem;" v-if="item.status">已结算</span>
                    <span style="color:green;font-size: .28rem;" v-if="!item.status">结算中</span>
                    <span><small>￥</small><big>{{item.money}}</big></span>
                </li>
            </ul>
        </div>
    </section>
    <!--    底部导航开始    -->
    <%@ include file="../footer.jsp" %>
</div>
<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
<script src="${ctx}/resources/js/lib/vue.min.js"></script>
<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
<script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
<script src="${ctx}/resources/js/common.js"></script>
<script src="${ctx}/resources/js/modules/more.js"></script>
<script>
    vw.init("my/enchashment.json");
</script>
</body>

</html>
