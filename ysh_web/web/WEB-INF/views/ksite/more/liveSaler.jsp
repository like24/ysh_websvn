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
    <link rel="stylesheet" href="${ctx}/resources/css/distributionEdition.css" />
</head>
<body>
<div class="wrapper bg-e4" id="app" v-clock >
    <!—    iscroll滚动    —>
    <section class="iscroll-box absolute ohidden iscroll-box1 iscroll-box2" id="mainBox">
        <div class="iscrollBox " id="pullUpWrapper">
            <header class="flex header" v-if="isSaler">
                <p class="paiming">第<big>{{saler.rownum}}</big>名</p >
                <dl>
                        <dt>
                            <img :src="saler.header" alt="" />
                        </dt>
                        <dd>
                            {{saler.salename}}
                        </dd>
                </dl>

                <p class="money"><small>￥</small><big>{{saler.totlemoney}}.</big><small>00</small></p >
            </header>
            <div>
                <p></p>
            </div>
            <ul>
                <li class="item flex" v-for="(item,index) in items">
                    <div>
                        <i>{{index+1}}</i>
                         <img  :src="item.header" alt="" />
                        <span>{{item.salename}}</span>
                    </div>
                    <p>￥<big>{{item.totlemoney.split(".")[0]}}</big>.{{item.totlemoney.split(".")[1]}}</p >
                    <div class="border"></div>
                </li>
            </ul>
        </div>
    </section>

</div>
<script src="${ctx}/resources/js/lib/vue.min.js"></script>
<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
<script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
<script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
<script src="${ctx}/resources/js/common.js"></script>
<script src="${ctx}/resources/js/modules/more.js"></script>
<script>
    vw.init("live/saler/getList/${uid}/${zid}.json");
</script>
</body>
</html>
