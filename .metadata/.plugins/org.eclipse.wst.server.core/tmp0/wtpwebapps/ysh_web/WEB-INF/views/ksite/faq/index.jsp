<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="faq" />
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
	<title>${d.askusername }回答了“${d.title}”</title>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/question_details.css?v=${version}">
	<style>
		.main{width:100%;height:100%;}
		.main>div{width:100%;height:auto;}
		.main>div:nth-child(1)>dl, .main>div:nth-child(2)>dl {width: 100%;height: auto;margin-bottom: .362rem;}
		.main h2+dl button {display:block;border-radius:20px;}
		.main h2+dl span{position:relative;left:106%;top:-1.5rem;}
		.mainBox {overflow-y: auto;}
	</style>
    <script type="text/javascript">
        var nodata = 1 ;
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    
</head>
<body onbeforeunload="stopVoice();">
	<div class="wrapper">
		<section class="mainBox">
			<div class="main">
				<div>
					<dl>
						<dt>
							<a href="javascript:;" id='loadImg'>
								<c:choose>
									<c:when test="${ fn:indexOf(d.header,'http') > -1 }">
										<img src="${d.header}"  >
									</c:when>
									<c:otherwise>
										<img src="${ctx}/${d.header}"  >
									</c:otherwise>    
								</c:choose> 
							</a>
						</dt>
						<dd>
							<h6>${d.username }</h6>
							<c:if test="${d.askmoney > 0 }">
							    <span>￥${d.askmoney}元</span>
							</c:if>
							<c:if test="${d.askmoney == 0 }">
							    <span>免费</span>
							</c:if>
						</dd>
					</dl>
					<h2>${d.content }</h2>
					<c:if test="${ d.hasanswer == 1 }">
						<dl class="son">
							<dt><a href="${ctx}/w/faq/person.html?p=${d.askuserid}&t=0">
									<c:choose>
										 <c:when test="${ fn:indexOf(d.askheader,'http') > -1 }">
											<img id="uh" src="${d.askheader}"  >
										 </c:when>
										 <c:otherwise>
											<img id="uh" src="${ctx}/${d.askheader}"  >
										 </c:otherwise>    
									 </c:choose>
									 </a>  
								</dt>
								 <dd>
									 <c:forEach items="${d.answers}" var="ans" varStatus="status">
									  	<button id="music_${ans.id}" onclick="play(this,'${ans.id}')" data-src="${cdn}/${ans.mp3path}"><img src="http://wimg.keepyoga.com/son.png">免费听</button> 
										<span id="aa_${ans.id}">${ans.timelong}</span>
									 </c:forEach>
								 </dd>
							</dl>
						</c:if>
						<p class="ago">
							<span>${showtime}</span>
							<!-- 点赞标签开始 -->
							<span class="zan"><b id="like"></b><i>${d.up_count }</i></span>
							<!-- 点赞标签结束 -->
							<span class="listening">听过&nbsp;&nbsp;<span id="pc">${d.play_count}</span> 人</span>
						</p>
					</div>
					<!-- 追问的内容 -->
<%-- 				<c:if test="${not empty d.subcontent}"> --%>
					<c:if test="${not empty d.submp3path||(ismine&&not empty d.subcontent)}">
					<div>
						<dl>
							<dt>
								<a href="javascript:;"> <c:choose>
										<c:when test="${ fn:indexOf(d.header,'http') > -1 }">
											<img src="${d.header}">
										</c:when>
										<c:otherwise>
											<img src="${ctx}/${d.header}">
										</c:otherwise>
									</c:choose>
								</a>
							</dt>
							<dd>
								<h6>${d.username }</h6>
							</dd>
						</dl>
						<h2>${d.subcontent }</h2>
						<c:if test="${ not empty d.subcontent}">
							<dl class="son">
								<dt>
									<a href="${ctx}/w/faq/person.html?p=${d.askuserid}&t=0"> <c:choose>
											<c:when test="${ fn:indexOf(d.askheader,'http') > -1 }">
												<img id="uh" src="${d.askheader}">
											</c:when>
											<c:otherwise>
												<img id="uh" src="${ctx}/${d.askheader}">
											</c:otherwise>
										</c:choose>
									</a>
								</dt>
							  	<dd>
								  	<c:forEach items="${d.answers_expand}" var="ans" varStatus="status">
										<button id="music_${ans.id}" onclick="play(this,'${ans.id}')"
											data-src="${cdn}/${ans.mp3path }">
											<img src="http://wimg.keepyoga.com/son.png">免费听
										</button>
										<span id="aa_${ans.id}">${ans.timelong}</span>
									</c:forEach>
								</dd>
							</dl>
						</c:if>
					</div>
				</c:if>
				<!-- 追问的内容 -->
					
				<div id="goDetails" onclick="seeAnswer()">
					<h3>${d.askusername }</h3>
					<p>${d.askuserpost }<a href="${ctx}/w/faq/person.html?p=${d.askuserid}"><img src="http://wimg.keepyoga.com/sanjiao.jpg" alt=""></a></p>
				</div> 
				<div class="hide_or_show" id="hide_or_show" style="display:none;" >
					<textarea class="content_1" id="c" name="c"  placeholder="向导师免费追问"></textarea><span class="number" id="zs">0/60</span>
					<p class="content_4"><button class="write" onclick="writeOk(this)">写好了</button></p>
				</div>
				<div>
					<c:if test="${canask}">
						<a href="javascript:;" class="again" id="again">还有疑问?点击这里免费追问</a> 
					</c:if>
				</div>
			</div>
		</section> 
		<%@ include file="../footer.jsp" %>
		<div style="display:hidden" ><audio id="audio111"><source src="" type="audio/mpeg"></audio></div> 
	</div>
	 <script src="${ctx}/js/zepto.js?v=${version}"></script>
	 <script type="text/javascript">
	      function seeAnswer(){ 
	    	  window.location.href="${ctx}/w/faq/person.html?p=${d.askuserid}";
	      }
	      var playcount = false;
	      function play(jdom,sid){
	    	     var button = jdom;
				 if(!$(button).attr("play")){
				     	var a = $("#aa_"+sid).html();
					    var b = parseInt(a.substring(3, 5));
		                setTimeout(function () {
		                    $(button).find("img").attr("src", "http://weixin.keepyoga.com/images/son.png");
		                    $("#audio111").get(0).pause();
		                    $(button).removeAttr("play");
		                }, b * 1000 + 3000);
						var mp3source = $(jdom).attr("data-src");
						$("#audio111").get(0).pause();
						$("#audio111").get(0).src=mp3source;
						$("#audio111").get(0).volume=1;
						$("#audio111").get(0).play();
						$(button).attr("play","play");
						$("button").find("img").attr("src", "http://wimg.keepyoga.com/son.png");
						$(button).find("img").attr("src", "http://wimg.keepyoga.com/songif.gif"); 
						if( playcount == false){
							playcount = true;
							$.ajax({
				 				type:"post",
				 				dataType:"json",
				 				url:  "${ctx}/w/faq/count/play.html?p=${d.id}",
				 				error:function(XMLHttpRequest,textStatus,error){},
				 				success:function(msg){
				 					 if( msg.status == true){
				 						 $("#pc").html( Number($("#pc").html())+1);
				 					 }
				 				}
				 			}); 
						} 
				 }else{
					 $(button).find("img").attr("src", "http://wimg.keepyoga.com/son.png");
					 $("#audio111").get(0).pause();
					 $(button).removeAttr("play");
				 }
	      	}
	      
	        var icon = $("#uh").attr("src"); 
			var title1 = "导师回答";
			var desc1  = "价值${d.askmoney}元，现在免费听，随心瑜Live，专业瑜伽培训教育平台。";
			var link1  = location.href;
			var img1   = icon ;
			var serviceId="${d.serverid}";
			var slocalId  ="";
			
			wx.config({
			    debug: false,
			    appId: '${appid}',
			    timestamp:'${timestamp}' ,
			    nonceStr: '${nonceStr}',
			    signature: '${signature}',
			    jsApiList: ['checkJsApi','onRecordEnd','playVoice','pauseVoice', 'stopVoice','downloadVoice','onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareWeibo','hideMenuItems','hideOptionMenu']
			}); 
			var nologin = "${nologin}"; 
			if( nologin == "true" ) { 
			    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}
			wx.ready(function () {  
				 wx.hideAllNonBaseMenuItem();
				    // 
				 wx.showMenuItems({
					    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				 });
			});
			
			function downloadVoice( str ) {  
				wx.downloadVoice({
				    serverId: str, // 需要下载的音频的服务器端ID，由uploadVoice接口获得
				    isShowProgressTips: 1, // 默认为1，显示进度提示
				    success: function (res) {
				    	slocalId = res.localId; // 返回音频的本地ID
				    }
				});
		     }
			 
			function playVoice(){
	        	wx.playVoice({
	        	    localId: slocalId.toString() // 需要播放的音频的本地ID，由stopRecord接口获得
	        	});
	        }

	        function stopVoice(){
	        	wx.stopVoice({
	        	    localId: slocalId.toString() // 需要暂停的音频的本地ID，由stopRecord接口获得
	        	});
	        }
	    	/*点赞*/
			$("#like").one("tap", function () {
				$(this).addClass("like");
				var num = $(".zan>i").html();
				$(".zan>i").html(parseInt(num) + 1);
				$.post("${ctx}/w/content/zan${d.id}.html");
			})
			$("#again").on("click",function(){
				$(this).remove();
				$("#hide_or_show").show();
			})
			
			function writeOk(){
				writeOk=null;
				 var c = $("#c").val();
		    	  c = encodeURI(encodeURI(c));
		          $.ajax({
		 				type:"post",
		 				dataType:"json",
		 				url:  "${ctx}/w/teacher/subask.html?c="+c + "&d=${d.id}",
		 				error:function(XMLHttpRequest,textStatus,error){},
		 				success:function(msg){
		 					  if( msg.status){
		 						  $("#c").val('');
		 						  setTimeout(function(){
		 							 Modal.tips("<font color='#ccc'>亲，您的问题已提交给导师，请关注回复</font>","success",1500,function(){
// 		 								location.href="${ctx}/w/faq/d.html?p="+msg.sid;
		 								window.location.reload();
		  						     });
		 						  },300); 
		 					  }else{
		 						 setTimeout(function(){
		 						    Modal.tips("<font color='#ccc'>"+msg.result+"</font>","error",1500);
		 						 },300); 
		 					  }
		 				}
		 		 }); 
	    	}

			$("#loadImg img").on("error",function(){
				$(this).attr("src",'${ctx}/images/default_avatar.jpg')
			})
 
	 </script>
	 <script src="${ctx}/js/wblog.js?v=${version}"></script>
	 <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
</body>
</html> 
 