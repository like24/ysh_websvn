<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../../taglibs.jsp" %> 
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
	<title>孕产瑜伽私教集训营</title>    
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link rel="stylesheet" href="${ctx}/css/active.css?v=${version}">
    <style>
    	body{-webkit-overflow-scrolling: touch;}
    	.btn-box{width: 100%;height: 4.225rem;background: white;margin: .625rem 0;}
    	.btn-box p{color: #f77221;text-align: center;font-size: .65rem;padding-top: .5rem;}
    	 #clickBtn{    width: 9.3rem;height: 1.925rem;display: block; margin: 0 auto; padding-top: .5rem;}
    	 #clickBtn img{width: 9.3rem;height: 1.925rem;margin: 0 auto;display: block;}
    	.share{
		    position: absolute;
		    z-index: 999;
		    left: 0;
		    top: 0;
		    right: 0;
		    bottom: 0;
		    background: rgba(0,0,0,.9);
		    display:none;
    	}
    	.share img{
    		width:100%;
    	}
    	.success{
    		display:none;
    		position:absolute;
    		left:0;
    		right:0;
    		top:0;
    		bottom:0;
    		background:rgba(0,0,0,.9);
    		    z-index: 999;
    	}
    	.success img{width:100%;}
    	#cancel{color: white;
			    width: 5.5rem;
			    height: 2rem;
			    background: #9c9c9c;
			    border: none;
			    outline: none;
			    font-size: .8rem;
			    border-radius: .3rem;
			    position: absolute;
			    z-index: 99999999;
			    left: 2.5rem;
			    top: 22rem;
			}
    #see{   
		    color: white;
		    width: 5.5rem;
		    height: 2rem;
		    background: #f7721f;
		    border: none;
		    outline: none;
		    font-size: .8rem;
		    border-radius: .3rem;
		    position: absolute;
		    z-index: 99999999;
		    right: 2.5rem;
		    top: 22rem;
    }
    	.class-box{
		width:100%;
		height: 100%;
		position: fixed;
		left: 0;
		top:0;
		right:0;
		bottom: 0;
		overflow-y: scroll;
		z-index: 99999999;
		display: none;
	}
	#close_box{
	    position: fixed;
    right: 0;
    width: 3rem;
    z-index: 99999999999;
    display: none;}
    #class{
    		position: fixed;
    		right:0;
    		top:2rem;
    		z-index: 99999;
    		width:34%;
    }
    img{
    	display: block;
    }
    </style>
    <script src="${ctx}/js/zepto.js"></script>
    <script src="${ctx}/js/iscroll4.js"></script> 
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script> 
</head>
 <body>
 	<img src="http://wimg.keepyoga.com/images/ycyoga-money.png" alt="" id="class" style="display:none"/>
 	     	<img src="http://wimg.keepyoga.com/images/Pregnant_yoga_close.png" alt="" id="close_box"/>
 	     <div class="class-box" id="classBox" >
 	     		<div>
						<img src="http://wimg.keepyoga.com/images/yc-07.jpg" alt=""  style="width:100%;height:auto;"/>
						<img src="http://wimg.keepyoga.com/images/yc-08.jpg" alt=""  style="width:100%;height:auto;"/>
						<img src="http://wimg.keepyoga.com/images/yc-09.jpg" alt=""  style="width:100%;height:auto;"/>
						</div>
			</div>
    <div class="wrapper">
        <section class="mainBox" id="mainBox">
            <div>
             <a href="javascript:;" class="banner">
                     <img src="http://wimg.keepyoga.com/images/1.pic_hd.jpg" alt="">
                </a>
                <ul id="list" class="list">  	
             
                   <c:forEach items="${courselist.results}" var="course" varStatus="status">
                    <li <c:if test="${course.status == 0}">class="event-countdown li${status.index} }"</c:if> <c:if test="${course.status == 1}">class="event-huodon"</c:if> <c:if test="${course.status == 2}">class="event-huoodngover"</c:if> data-url="${ctx}/w/yc/item/${course.id}.html"  >
                        <div>
                            <h4><a href="javascript:;">${course.name}</a></h4>
                            <p class="jieshao"><a href="javascript:;">${course.remark }</a></p>
                            <p class='but'>
                               <c:forTokens items="${course.taglist }" delims="," var="str">
		                          <span>${str}</span> 
		                       </c:forTokens>
                            </p> 
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
                            </dl>
                        </div>
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </section>
        <%@ include file="../../footer.jsp" %>
    </div>

    <script>
    		$("#close_box").on("click",function(){
				$("#classBox").hide();
			$("#close_box").hide();
			})
			$("#class").on("click", function() {
				$("#close_box").show();
				$('#classBox').css("display","block");
				  var myscroll=new iScroll("classBox",{hScrollbar:false, vScrollbar:false});
			});
	    var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
		 wx.config({
		    debug: false,
		    appId: '${appid}',
		    timestamp:'${timestamp}' ,
		    nonceStr: '${nonceStr}',
		    signature: '${signature}',
		    jsApiList: [ 
		        'checkJsApi','openLocation',
		        'getLocation','checkJsApi','onMenuShareTimeline','onMenuShareAppMessage',
		        'onMenuShareQQ','onMenuShareWeibo','hideMenuItems','showMenuItems','hideAllNonBaseMenuItem',
		        'showAllNonBaseMenuItem', 'chooseImage','previewImage','uploadImage',
		        'chooseWXPay','downloadImage','getNetworkType','openLocation',
		        'getLocation','hideOptionMenu','showOptionMenu'
		      ]
		}); 
	 	wx.ready(function(){
	 		    wx.hideAllNonBaseMenuItem();
			    wx.showMenuItems({
				    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				});
			    wx.onMenuShareTimeline({
				    title: title1, // 分享标题
				    link: link1, // 分享链接
				    imgUrl: img1, // 分享图标
				    success: function (res) { 
				    	if( res.errMsg == 'shareTimeline:ok'){
				    		tips('恭喜，分享成功！');
				    	}
				    },
				    cancel: function () { }
				});
				wx.onMenuShareAppMessage({
				    title: title1, // 分享标题
				    desc: desc1, // 分享描述
				    link: link1, // 分享链接
				    imgUrl: img1, // 分享图标
				    type: '', // 分享类型,music、video或link，不填默认为link
				    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
				    success: function (res) {
				    	if( res.errMsg == 'sendAppMessage:ok'){
				    		tips('恭喜，分享成功！');
		                }
				    },
				    cancel: function () {}
				});
	    });  
	 	
	 	var title1 = "地表最强三大孕产瑜伽名师线上工作坊，只要199";
		var desc1  = "王昕、陈蕙、Jennifer三大名师手把手教你是一种怎样的体验";
	 	var link1 = "${ctx}/pay/yc${uuid}.html";
	 	var img1 = "http://wimg.keepyoga.com/images/Pregnant_yoga10.jpg";
	 	  
	    $("#list").on("tap","li",function(){ 
	    	if($(this).hasClass("event-huodon")){
	    		window.location.href = $(this).attr("data-url");  
	    	}
	    	else if($(this).hasClass("event-huoodngover")){
	    		window.location.href = $(this).attr("data-url");  
	    	}
	    }) 
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
        $("#clickBtn").on("click",function(){
        	$(".share").show();
        })
        $(".share").on("click",function(){
        	$(this).hide();
        })
        $("#cancel").on("click",function(){
        	$(".success").hide();
        	$(".share").hide();
        }) 
      
    </script>
</body>
</html> 
 