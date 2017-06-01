<%--
  Created by IntelliJ IDEA.
  User: yinlu
  Date: 17/5/9
  Time: 下午2:14
  To change this template use File | Settings | File Templates.
--%>
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
    <title>提现</title>
    <script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
    <link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
    <link rel="stylesheet" href="${ctx}/resources/css/presentation.css" />
</head>

<body>
<div class="wrapper bg-e4" id="app" >
    <header>
        <h1>
            <small>￥</small><big>1222222.</big><small>72</small>
        </h1>
        <p>可提现金额</p>
    </header>
    <section class="money-box ">
        <h1>提现金额</h1>
        <div class="inputDiv">
            <span>￥</span><input type="number" placeholder="请输入提现金额" />
        </div>
        <p class="title">满100元可提现，每笔提现金额上限2万元</p>
        <button type="button" id="btn" class="btn">提现</button>
        <div class="detaills-box">
            <a href="" class="shouyi">收益明细</a>|<a href="" class="tixian">提现明细</a>
        </div>
    </section>
    <section class="explain-box">
        <h1><i class="icon"></i>提现说明</h1>
        <ul>
            <li>1.满100元可提现</li>
            <li>2.每笔提现金额上限1万元</li>
            <li>3.每自然月只能提现一次</li>
        </ul>
        <a href="">《用户协议》</a>
    </section>
</div>
<script src="${ctx}/resources/js/lib/vue.min.js"></script>
<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
<script src="${ctx}/resources/js/common.js"></script>
<script src="${ctx}/resources/js/modules/more.js"></script>
<script src="${ctx}/resources/js/modules/my.js"></script>
</body>
</html>
