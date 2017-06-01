<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %> 
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
	<title>2016第二届暖冬行动</title>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link rel="stylesheet" href="${ctx}/css/active.css?v=${version}">
    <style>
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
    
    </style>
    <script src="${ctx}/js/zepto.js"></script>
    <script src="${ctx}/js/iscroll4.js"></script> 
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript">
        var nodata = 0;
        /*倒计时*/
        function getTime(oTime,str, fn) {
        	var reg = new RegExp("-", "g"); 
        	oTime = oTime.replace(reg,"/");
            function GetRTime() {
                var EndTime = new Date(oTime);
                var NowTime = new Date();
                var t = EndTime.getTime() - NowTime.getTime();
              	 if(t <= 0){
                	$(".li"+str).addClass("event-huodon");
                	$(".countdown"+str).remove();
                	fn();
                	return;
                }  
                var h = Math.floor(t / 1000 / 60 / 60 % 24);
                var m = Math.floor(t / 1000 / 60 % 60);
                var s = Math.floor(t / 1000 % 60);
                if (h == 0) {
                    document.getElementById("t_h"+str).innerHTML = "00";
                } else if (h <= 9) {
                    document.getElementById("t_h"+str).innerHTML = "0" + h;
                } else {
                    document.getElementById("t_h"+str).innerHTML = h;
                }
                if (m == 0) {
                    document.getElementById("t_m"+str).innerHTML = "00";
                } else if (m <= 9) {
                    document.getElementById("t_m"+str).innerHTML = "0" + m;
                } else {
                    document.getElementById("t_m"+str).innerHTML = m;
                }
                if (s == 0) {
                    document.getElementById("t_s"+str).innerHTML = "00";
                } else if (s <= 9) {
                    document.getElementById("t_s"+str).innerHTML = "0" + s;
                } else {
                    document.getElementById("t_s"+str).innerHTML = s;
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
  <div class ="share"><img src ="http://wimg.keepyoga.com/images/activity-list-share.png"></div>
   <div class ="success">
   		<img src ="http://wimg.keepyoga.com/images/acvility-list-success1_02.png">
   		<button type="button" id="cancel">取消</button>
   		<button type="button" id="see">查看课程</button>
   		</div>
    <div class="wrapper">
        <section class="mainBox" id="mainBox">
            <div>
             <input type="hidden" value="" id="SB120"> 
                <a href="javascript:;" class="banner">
                     <img id="nd18" style="display:none" src="http://wimg.keepyoga.com/zhuanye.png" alt="">
                     <img id="ll17" style="display:none" src="http://wimg.keepyoga.com/20161008091300294_978.jpg"alt="">
                </a>
                <ul id="list" class="list">
               	<div class="btn-box" style="display:none">
               		<div id="clickBtn"><img src="http://wimg.keepyoga.com/images/active-list-btn.png"></div>
               		<p>赢取中印国际瑜伽节高清视频</p>	
                </div>
                   <c:forEach items="${courselist.results}" var="course" varStatus="status">
                    <li <c:if test="${course.status == 0}">class="event-countdown li${status.index} }"</c:if> <c:if test="${course.status == 1}">class="event-huodon"</c:if> <c:if test="${course.status == 2}">class="event-huoodngover"</c:if> data-url="${ctx}/w/jxy/item/${course.id}.html" course-url="${ctx}/w/faq/course.html?p=${course.cid}" >
                        <div>
                            <h4><a href="javascript:;">${course.name}</a></h4>
                            <p class="jieshao"><a href="javascript:;">${course.remark }</a></p>
                            <p class='but'>
                               <c:forTokens items="${course.taglist }" delims="," var="str">
		                          <span>${str}</span> 
		                       </c:forTokens>
                            </p>
                            <c:if test="${course.status == 0 }">
	                            <div class="countdown${status.index } countdown" data-num="${course.status }">
	                             <span id="t_h${status.index}">00</span> <span id="t_m${status.index}">00</span> <span id="t_s${status.index}">00</span> 
	                                
	                            </div>
	                            <div style="display:none" id="player" data-url="${course.title}" ></div>
	                            <script type="text/javascript">
	                                getTime("${course.opentime}","${status.index}", function () {});
	                            </script>
                            </c:if>
                             <c:if test="${status.index == 0 }" >
			                 	<script type="text/javascript">
				                  if( ${course.aid} == 18  ){
	                             	   $("#nd18").show();
	                              }else{
	                             	 $("#ll17").show();
	                             	$(".btn-box").remove();
	                              }             
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
	    var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=http://weixin.keepyoga.com/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
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
	 		wx.showOptionMenu();
			wx.hideMenuItems({
			    menuList: ["menuItem:copyUrl","menuItem:openWithQQBrowser","menuItem:openWithSafari","menuItem:share:email"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			});
	    });  
	 	
	 	var title1 ="${shareTitle}";
	 	var desc1 = "${shareDesc}";
	 	var link1 = "${shareLink}";
	 	var img1 = "${shareImage}";
	 	if(title1.length==0){
	 		title1 = "92位瑜伽行业精英喊你加入随心瑜“瑜伽暖冬行动” ";
	 	}
	 	if(desc1.length==0){
	 		desc1  = "60场精择优选课程，8场精彩绝伦主题论坛，你还在等什么？";
	 	}
	 	if(link1.length==0){
	 		link1  = "${ctx}/w/jxy${aid}.html";
	 	}
	 	if(img1.length==0){
	 		img1   = "http://wimg.keepyoga.com/124408275958278060.jpg";
	 	}
	 	
		wx.ready(function () {
		 	wx.onMenuShareTimeline({
			    title: title1, // 分享标题
			    link: link1, // 分享链接
			    imgUrl: img1, // 分享图标
			    success: function (res) {
			    	var go=isOnline();
			    	if(go){
			    		if("${aid}"=="18"){
					    	if( res.errMsg == 'shareTimeline:ok'){
					    		$.post("${ctx}/w/actishare${aid}.html",function(data){
									if(data.status){
										//分享成功弹框
										$(".success").show();
									}else{
										alert(data.msg);
									}
								});
			                }else{
			                	alert("分享朋友圈失败");
			                }
				    	}
			    	}else{
			    		$(".share").hide();
			    	}
			    },
			    cancel: function () { 
// 			    	alert("取消分享到朋友圈");
			    }
			});
			wx.onMenuShareAppMessage({
			    title: title1, // 分享标题
			    desc: desc1, // 分享描述
			    link: link1, // 分享链接
			    imgUrl: img1, // 分享图标
			    type: '', // 分享类型,music、video或link，不填默认为link
			    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
			    success: function (res) {
			    	$(".share").hide();
// 			    	if("${aid}"==18){
// 			    		if( res.errMsg == 'sendAppMessage:ok'){
// 				    		$.post("${ctx}/w/actishare${aid}.html",function(data){
// 								if(data.status){
// 									//分享成功弹框
// 									$(".success").show();
// 								}else{
// 									alert(data.msg);
// 								}
// 							});
// 		                }else{
// 		                	alert("分享朋友失败");
// 		                }
// 			    	}
			    },
			    cancel: function () { 
// 			    	 alert("分享朋友失败");
			    }
			});
		 });
	    $("#list").on("tap","li",function(){ 
	    	if($(this).hasClass("event-huodon")){
	    		window.location.href = $(this).attr("data-url");  
	    	}
	    	else if($(this).hasClass("event-huoodngover")){
	    		window.location.href = $(this).attr("data-url");  
	    	}
	    })
	    $("#nd18").on("tap",function(){
// 	    	window.location.href="http://www.keepyoga.com";
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
        $("#see").on("click",function(){
        	window.location.href="${ctx}/w/my/mineprize.html";
        })
        
        function isOnline() {
        	var time_end = new Date("2017/01/21 23:59:59" ); //结束的时间
    	 	var endtime = time_end.getTime();
    		var nowtime=new Date().getTime();
    		if(endtime-nowtime>0){
    			 return true;
    		}else{
    			 return false;
    		}
        }
        function checkTime(obj) {
            var myDate = new Date();
            var year = myDate.getFullYear();
            var month = myDate.getMonth() + 1;
            var day = myDate.getDate();
            var hours = myDate.getHours();
            var minutes = myDate.getMinutes();
            if (obj.year >= year && obj.month >= month && obj.day >= day && obj.hours >= hours && obj.minutes >= minutes) {
                return true;
            } else {
                return false;
            }
        }

    </script>
</body>
</html> 
 