<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
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
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<title>2016理疗瑜伽线上集训营</title>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link rel="stylesheet" href="${ctx}/css/active.css?v=${version}">
    <script src="${ctx}/js/zepto.js"></script>
    <script src="${ctx}/js/iscroll4.js"></script> 
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript">
        var nodata = 0;
        
        /*倒计时*/
        function getTime(oTime, fn) {
        	var reg = new RegExp("-", "g"); 
        	oTime = oTime.replace(reg,"/");
            function GetRTime() {
                var EndTime = new Date(oTime);
                var NowTime = new Date();
                var t = EndTime.getTime() - NowTime.getTime();
                var h = Math.floor(t / 1000 / 60 / 60 % 24);
                var m = Math.floor(t / 1000 / 60 % 60);
                var s = Math.floor(t / 1000 % 60);
                if (h == 0) {
                    document.getElementById("t_h").innerHTML = "00";
                } else if (h <= 9) {
                    document.getElementById("t_h").innerHTML = "0" + h;
                } else {
                    document.getElementById("t_h").innerHTML = h;
                }
                if (m == 0) {
                    document.getElementById("t_m").innerHTML = "00";
                } else if (m <= 9) {
                    document.getElementById("t_m").innerHTML = "0" + m;
                } else {
                    document.getElementById("t_m").innerHTML = m;
                }
                if (s == 0) {
                    document.getElementById("t_s").innerHTML = "00";
                } else if (s <= 9) {
                    document.getElementById("t_s").innerHTML = "0" + s;
                } else {
                    document.getElementById("t_s").innerHTML = s;
                }
                if (h == 0 && m == 0 && s == 0) {
                    fn();
                }
            }
            setInterval(GetRTime, 1000);
        }
    </script>
</head>
 <body>
    <div class="wrapper">

        <section class="mainBox" id="mainBox">

            <div>
                <a href="http://mp.weixin.qq.com/s?__biz=MzIwMDAwMDM2Nw==&mid=2650132995&idx=1&sn=b06802af591adc5ac9f98b8323015ba4&scene=0#wechat_redirect" class="banner">
                    <img src="${ctx}/images/phy_banner.jpg" alt="">
                </a>
                <ul id="list" class="list">
                   <c:forEach items="${courselist.results}" var="course" varStatus="status">
                    <li <c:if test="${course.status == 0}">class="event-countdown"</c:if> <c:if test="${course.status == 1}">class="event-huodon"</c:if> <c:if test="${course.status > 0}">data-url="${ctx}/w/phy/item/${course.id}.html"</c:if> >
                        <div>
                            <h4><a href="javascript:;">${course.name}</a></h4>
                            <p class="jieshao"><a href="javascript:;">${course.remark }</a></p>
                            <p class='but'>
                               <c:forTokens items="${course.taglist }" delims="," var="str">
		                          <span>${str}</span> 
		                       </c:forTokens>
                            </p>
                            <c:if test="${course.status == 0 }">
	                            <div class="countdown">
	                                <span id="t_h">00</span> <span id="t_m">00</span> <span id="t_s">00</span>
	                            </div>
	                            <div style="display:none" id="player" data-url="${course.title}" ></div>
	                            <script type="text/javascript">
	                                getTime("${course.opentime}", function () {})
	                            </script>
                            </c:if>
                            <dl>
                                <dt>
			                     <a href="javascript:;">
			                        <c:choose>
										  <c:when test="${ fn:indexOf(course.theader,'http') > -1 }">
												 <img src="${course.theader}"  >
										  </c:when>
										  <c:otherwise>
												 <img src="${ctx}/${course.theader}"  >
										  </c:otherwise>    
									 </c:choose>
			                     </a>
			                </dt>
                                <dd>
                                    <p><a href="javascript:;"><span>${course.tname }</span><b>|</b><span class="summary">${course.tpost }</span></a></p>
                                </dd>
                                <c:if test="${ !empty course.title && course.status == 0 }">
                                   <a href="javascript:;" class="check" id="check">查看预告片</a>
                                </c:if>
                            </dl>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </section>
        <%@ include file="../footer.jsp" %>
    </div>
    <script>
       
	    $("#list").on("tap","li",function(){
	    	var url =$(this).attr("data-url");
	    	if( url != undefined ){
	            window.location.href=$(this).attr("data-url");
	    	}
	    })
        /*日期格式*/
       
        function loaded() {
            myiscroll = new iScroll("mainBox", {
                useTransition: false,
                vScrollbar: false,
                checkDOMChanges: true,
                
            })
        }
        document.addEventListener('touchmove', function (e) {
            e.preventDefault();
        }, false);
        document.addEventListener('DOMContentLoaded', loaded, false);
        
        
        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
		
		$("#check").on("tap", function () {
            var masking = $("<div class='masking'>");
            $(".wrapper").append(masking);
            var video = $("<video id='video' webkit-playsinline controls>");
            $(".wrapper").append(video);
            $("#video").get(0).src = $("#player").attr("data-url"); 
            $(".masking").on("tap", function () {
                $(this).remove();
                $("#video").remove();
            })
        })
        
        
    </script>
</body>
</html> 
 