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
    <link rel="stylesheet" href="${ctx}/resources/css/distributionIncome.css" />
</head>

<body>
<div class="wrapper bg-e4" id="app" v-cloak>
    <header class="header">
        <a href="${ctx}/v2/my/enchashment/explain.shtml" class="flex">
            <h4>分销说明</h4>
            <i class="icon"></i>
        </a>
    </header>
    <!--    iscroll滚动    -->
    <section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
        <div class="iscrollBox " id="pullUpWrapper">
            <ul >
                <li class="item" v-for="(item,index) in contentlist">
                    <i class="absolute cicleL cicle"></i>
                    <i class="absolute cicleR cicle"></i>
                    <div class="tit flex">
                        <h6>订单号：</h6>
                        <p >{{item.ordernumber}}</p>
                    </div>
                    <dl class="flex">
                        <dt>
                            <img  :data-src="item.picUrl" class="loadingimg" alt="" />
                        </dt>
                        <dd>
                            <h1 class="ellipsis">{{item.productname}}</h1>
                            <time>{{item.createtime.substr(5)}}</time>
                            <span>
            							佣金：<small>￥</small><big>{{item.money_}}</big>
            						</span>
                        </dd>
                    </dl>
                </li>

            </ul>
        </div>
    </section>
    <!--    底部导航开始    -->
    <%@ include file="../footer.jsp" %>
</div>
<script src="${ctx}/resources/js/lib/vue.min.js"></script>
<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
<script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
<script src="${ctx}/resources/js/common.js"></script>
<script src="${ctx}/resources/js/modules/more.js"></script>
<script>
    vw.init("my/earning.json");
</script>
</body>

</html>
