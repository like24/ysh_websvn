<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %>
<c:set var="footclass" value="find" /> 
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
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
    <title>${u.nickname },${u.userpost},导师精品课程、语音问答尽在随心瑜Live</title>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link rel="stylesheet" href="${ctx}/css/tutor_details.css?v=${version}">
    <style>
      .nav{width:80%;margin:0 auto}
    .nav ul {
    height: 1.375rem;
    display:flex;
    border: 1px solid #1d92fb;
    width: 100%;
    height: 1.5rem;
    border-radius: 3px;
    margin: .8875rem auto;
}
   .nav ul li{
flex:1;
width:1%;}
    </style>
    <script type="text/javascript">
        var nodata = ${resultlist.totalCount > 10 ? 1:0};
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
</head>
<body>
    <div class="wrapper">
        <section class="mainBox" id="mainBox">
            <div class="iscrollBox">
            <div class="white">
           <div class="info">
                <p class="info_1">
                     <c:choose>
						<c:when test="${ fn:indexOf(u.file_path,'http') > -1 }"><img id="uh" src="${u.file_path}" class="icon"></c:when>
						<c:otherwise><img src="${ctx}/${u.file_path}" id="uh" class="icon"></c:otherwise>    
					 </c:choose>  
					 <c:if test="${ !nologin && followuser }">
                        <img src="http://wimg.keepyoga.com/question_yes.png" alt="" class="follow">
                     </c:if>
                </p>
                <p class="info_2">
                    <span>${u.nickname }</span>    
                    <c:choose>
                        <c:when test="${ nologin == false && u.id == loginuser.id }">
                            <span class='guanzhu' style="visibility:hidden"></span>
                        </c:when>
                        <c:otherwise>
	                        <c:if test="${ nologin == true || followuser == false }">
		                        <span class='guanzhu' style="background:#1d92fb" data-link="false" id="guan">+关注</span>
		                    </c:if>
		                    <c:if test="${ followuser == true }">
		                        <span class='guanzhu' style="background:#9c9c9c" data-link="true" id="guan">已关注</span>
		                    </c:if>
                        </c:otherwise>
                    </c:choose>
                </p>
                <p class="info_3">${u.userpost}</p>
                <p class="info_4">${u.shortremark}</p>
            </div>
         <nav class="nav">
           <nav class="nav">
                   <ul>
	                  	 <li><a href="${ctx}/w/faq/person.html?p=${p}&t=4" <c:if test="${t==4 || t == 1}">class="high"</c:if>>课程 </a></li>
		                    <li><a href="${ctx}/w/faq/person.html?p=${p}&t=3" <c:if test="${t==3 || t == 0 }">class="high"</c:if>>问答</a></li>
		                   
		                    <li><a href="${ctx}/w/faq/person.html?p=${p}&t=5" <c:if test="${t==5 || t == 2}">class="high"</c:if>>线下培训</a></li>
	                </ul>
           </nav> 
              </nav> 
           </div>
            <c:if test="${u.isacceptask == 1}">
	            <div class="noOpen" id="noOpen">
					<img src="http://wimg.keepyoga.com/747606438608904323.jpg" alt="">
					<p>很抱歉该老师暂未开通课程</p>
				</div>
            </c:if>
            <c:if test="${u.isacceptask != 1}">
           <div class="content">
              <h3>共 ${resultlist.totalCount} 个课程</h3>
              <ol id="list">
                 <c:if test="${ resultlist.totalCount > 0 }">
	                <c:forEach items="${resultlist.results}" var="course" varStatus="status">
		                <li class="taplist"  onclick="sel(this)" data-url="${ctx}/w/faq/course.html?p=${course.id}&i=0">
		                  <h1>${course.cname }</h1>
		                   <p>${course.remark }</p>
		                    <c:if test="${ !empty course.taglist }">
			                   <ul>
			                       <c:forTokens items="${course.taglist }" delims="," var="str">
			                          <li>${str}</li> 
			                       </c:forTokens>
			                   </ul>
		                   </c:if>
		                </li>
                    </c:forEach>
                  </c:if>
                  <c:if test="${ resultlist.totalCount  == 0 }">
                         <div class="zanwu">
			                    <img src="http://wimg.keepyoga.com/error.png" alt="">
			                    <p>暂无课程</p>
			                </div>
                  </c:if>
              </ol>
           </div> 
            </c:if>
            </div>
        </section>
        <%@ include file="../footer.jsp" %> 
    </div>
    <script src="${ctx}/js/zepto.js"></script>
    <script src="${ctx}/js/iscroll4.js"></script>
    <script src="${ctx}/js/ajax_iscroll.js"></script>
    <script type="text/javascript">
		var icon = $("#uh").attr("src");
  	    var title1 = "${u.nickname },${u.userpost},导师精品课程、语音问答尽在随心瑜Live";
  		var desc1  = "随心瑜Live，专业的瑜伽培训教育平台。";
		var link1  = location.href;
		var img1   = icon ;
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
		wx.ready(function (Api) {
            wx.hideAllNonBaseMenuItem();
            wx.showMenuItems({
                menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
            });
        });
		var nologin = "${nologin}"; 
		if( nologin == "true" ) { 
		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
    </script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
    <script>
	    var gz = false;
	    $("span.guanzhu").on("tap",function(){
	  	    var link  = $(this).attr("data-link");
	  	    if( gz == true ){
	  	    	Modal.tips("<font color='#ccc'>亲，不要反复的点，会疼的！</font>","error",2500);
	  	    	return;
	  	    }
	  	    var lid="${loginuser.id}";
	  	    var tid="${u.id}";
	  	    if( lid == tid ){
	  	    	Modal.tips("<font color='#ccc'>这么自恋，自己关注自己！</font>","error",2500);
	  	    	return;
	  	    }
	  	    gz = true;
	  	    $.ajax({
					type:"post",
					dataType:"json",
					url:  "${ctx}/w/follow/${u.id}/"+link+".html",
					error:function(XMLHttpRequest,textStatus,error){},
					success:function(msg){
						  if( msg.status == true ){
							  if( link == 'true'){
								  $("#guan").attr("data-link","false");
								  $("#guan").css({"background":"#1d92fb"})
								  $("#guan").html('+关注');
							  }else{
								  $("#guan").attr("data-link","true");
								  $("#guan").css({"background":"#9c9c9c"})
								  $("#guan").html('已关注');
							  }  
							  gz = false;
						  }
					}
			});  
	    })
	    
	    function sel(o){
	    	 window.location.href=$(o).attr("data-url");
	    }
	    
	    var pageIndex = 1;
		function loadStore(){
			if( pageIndex > -1 ){
				$.ajax({
	 				type:"post",
	 				dataType:"json",
	 				url:  "${ctx}/w/faq/person/json.html?p=${p}&t=1&pageIndex="+(pageIndex+1),
	 				error:function(XMLHttpRequest,textStatus,error){},
	 				success:function(msg){
	 					if( msg.result != ''){
	 					    $("#list").append(msg.result);
	 					    pageIndex ++;
	 					}else{
	 						$("#pullUp").remove(); 
	 					    //Modal.tips("<font color='#ccc'>亲，没有更多数据了！</font>",2500);
	 					    pageIndex = -1;
	 					}
	 				}
	 			});  
			}
		}
	</script>
</body>

</html>
 