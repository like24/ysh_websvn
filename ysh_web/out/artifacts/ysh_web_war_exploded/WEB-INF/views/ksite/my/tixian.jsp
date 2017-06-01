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
    <div class="stash" id="stash">
        <span>拼命加载中，请稍候……</span>
    </div>
    <header>
        <h1>
            <small>￥</small><big id="big"></big><small id="small"></small>
        </h1>
        <p>可提现金额</p>
    </header>
    <section class="money-box ">
        <h1>提现金额</h1>
        <div class="inputDiv">
            <span>￥</span><input type="number" placeholder="请输入提现金额" id="money"/>
        </div>
        <p class="title">满100元可提现，每笔提现金额上限2万元</p>
        <button type="button" id="btn" class="btn">提现</button>
        <div class="detaills-box">
            <a href="${ctx}/v2/my/earning.shtml" class="shouyi">收益明细</a>|<a href="${ctx}/v2/my/enchashment.shtml" class="tixian">提现明细</a>
        </div>
    </section>
    <section class="explain-box">
        <h1><i class="icon"></i>提现说明</h1>
        <ul>
            <li>1.满100元可提现</li>
            <li>2.每笔提现金额上限1万元</li>
            <li>3.每自然月只能提现一次</li>
        </ul>
        <a href="${ctx}/w/help/agreement.html">《用户协议》</a>
    </section>
</div>
<div class="showBox" id="success">
    <img src="${ctx}/resources/images/withdrawsCash1.png" alt="" />
    <h2>申请成功</h2>
    <p>预计7日内到微信钱包，请查收！</p>
    <a href="javascript:;" id="ok">完成</a>
</div>
<script src="${ctx}/resources/js/lib/zepto.min.js"></script>
<script src="${ctx}/resources/js/common.js"></script>
<script src="${ctx}/js/layer/layer.js"></script>
<script>
    $(function () {
        var abcdefg = APP.URLSEARCH().abcdefg;
        $("#stash").hide();
        abcdefg= Number(abcdefg);
        abcdefg=abcdefg.toFixed(2);
        var abcdefgh = abcdefg.toString();
        var Aobj = abcdefgh.split(".");
        $("#big").html(Aobj[0]);
        $("#small").html("."+Aobj[1]);
        var Dvalue = 0;
        function tips(msg) { //实例化tips
            msg = "<font color='0xFFFFFF'>" + msg + "</font>"
            layer.open({
                content: msg,
                skin: 'msg',
                time: 2 //2秒后自动关闭
            });
        };

        $("#btn").click(function () {
            var money = $("#money").val();
            money =  Number(money);
            money = money.toFixed(2);
            if(money<100){
                tips("提现金额，不能低于100元！");
            }else if(money>20000){
                tips("对不起，单次提现金额不能超过20000元！")
            }else if(money>abcdefg){
                tips("对不起，超过提现额度！");
            }else {
                $.post(APP.API_PATH + "my/tixian.json?money="+money, function (res) {
                    if (res.status) {
                            $("#success").show();
                            Dvalue = abcdefg - money;

                    }else{
                        tips("网络繁忙，请重试！");
                    };
                }, 'json')
            }

        })
    $("#ok").on("click",function () {
        window.location.href="${ctx}/v2/my/tixian.shtml?abcdefg="+Dvalue;
    })
    });

</script>
</body>
</html>
