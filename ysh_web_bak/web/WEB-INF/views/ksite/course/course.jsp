<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script> 
	<script type="text/javascript" src="${ctx}/js/jquery.form.js?v=${version}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <title>${u.nickname}的精品课程“${c.cname}”</title>
    <script type="text/javascript">
         var nodata = ${ commentlist.totalCount > 10 ? 1: 0 };
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
	<link rel="stylesheet" href="${ctx}/css/course_details.css?v=${version}">
	 <style>
   		 <c:if test="${c.ctype == 1}">
    		.audio_style{
    			background:transparent;
    		}
    	</c:if> 
    </style>
</head>
 <body>
	<div class="wrapper">
	<input type="hidden" value="${isbuy }"  id="isbuy" />
	<input type="hidden" value="${c.ctype}" id="ctype" />
	<input type="hidden" value="${playUrl}" id="filepath" />
		<section class="mainBox" id="mainBox">
			 <div class="iscrollBox">
			 <c:if test="${empty c.icon}">
				 <div class="audio_video" style="background:url(${ctx}/images/audio.jpg);background-size:100%;">
			 </c:if>
			 <c:if test="${not empty c.icon}">
				 <div class="audio_video" style="background:url(${c.icon});background-size:100%;">
			 </c:if>
				 <c:if test="${c.ctype == 0}">
				      <audio id="audio" class="video-audio"  src="${playUrl}">
				      	<input type="hidden" data-src="${playUrl}" id="srouce"/>
				      </audio>
					  <div class="controlBox">
					     <span id="play_pause"><span class="play-pause play-pause-pause"></span></span>
							<span class="long-time">${ocourse.longtime}</span>
							<span class="now-time">00:00</span>
							<div class="progressBar">
								<div class="progressBac"></div>
								<div class="speed" id="speed"></div>
								<div class="drag" id="drag">
									<div></div>
								</div>
							</div>
				</div>
				 </c:if>
				  <div class="audio_style"></div> 
				 <c:if test="${c.ctype == 1}">
				 	<c:if test="${empty c.icon}">
					    <video src="${playUrl}" height="200" id="audio" controls style="background:url(${ctx}/images/audio.jpg);background-size:100%;"></video>
				 	</c:if>
				 	<c:if test="${not empty c.icon}">
					    <video src="${playUrl}" height="200" id="audio" controls style="background:url(${c.icon});background-size:100%;"></video>
				 	</c:if>
				 </c:if>
				 <c:if test="${ isshow == false }">
  			        <div class="audioMask" id="audioMask"></div>
			     </c:if>
			 </div>
			 <div class="skill">
			 	<p>${c.cname} <c:if test="${ c.money > 0 }"><span>￥${c.money}元</span></c:if><c:if test="${ c.money == 0 }"><span>免费</span></c:if></p>
				 	 <c:if test="${ !empty c.taglist }">
				 	       <div class="but">
			                     <c:forTokens items="${c.taglist }" delims="," var="str">
			                          <b>${str}</b> 
			                     </c:forTokens>
			                </div>
		             </c:if> 
			 </div>
			 <div class="buy">
			    <c:if test="${ nologin == true || isfollow == false }">
			 	    <span id="shoucang" >收藏</span>
			 	</c:if>
			 	<c:if test="${ isfollow == true }">
			 	     <span class="high" id="shoucang">已收藏</span>
			 	</c:if>
			 	<span onclick="javascript:share();">分享</span>
			 	 <c:if test="${ c.money > 0 }"> 
			 	     <c:choose>
			 	        <c:when test="${ isbuy  }">
			 	           <button id="btn" onclick="playMV()">播放</button>
			 	        </c:when> 
			 	        <c:otherwise>
			 	           <button id="btn" onclick="pay()">购买</button>
			 	        </c:otherwise>
			 	     </c:choose>
			 	 </c:if>
			 </div>
			 <div class="content">
			 	<nav>
			 		<ul>
			 			<li class="high" spn="jieshao"><a href="javascript:;">介绍</a></li>
			 			<c:if test="${c.property == 1}">
			 				<li spn="mulu"><a href="javascript:;">目录</a></li>
			 			</c:if>
			 			<li spn="pingjia"><a href="javascript:;">评价</a></li>
			 		</ul>
			 	</nav>
			 	<div class="jieshao" >
			 	<h1>【 主讲人 】</h1>
			 	<dl>
			 		<dt><a href="${ctx}/w/faq/person.html?p=${u.id}&t=1">
			 		<c:choose>
						<c:when test="${ fn:indexOf(u.file_path,'http') > -1 }"><img src="${u.file_path}" id="hederr" class="icon"></c:when>
						<c:otherwise><img src="${ctx}/${u.file_path}" id="hederr" class="icon"></c:otherwise>    
					 </c:choose></a>
			 		</dt>
			 		<dd>
			 			<p><span>${u.nickname }</span>	${u.userpost }</p>
			 		</dd>
			 	</dl>
			 	<div class="ctent">
			 		${u.shortremark }
			 	</div>
			 	<h1>【 课程简介】</h1>
			 	<div class="course">
			 	   <c:if test="${fn:length(c.remark) > 0 }">${c.remark}</c:if>
			 	   <c:if test="${fn:length(c.remark) == 0 }">暂无介绍哦！</c:if> 
			 	</div>
			 	<h1>【 课程介绍 】</h1>
			 	<div class="course">
			 	   <c:if test="${!empty c.content }">
			 	     <p>${c.content}</p>
			 	   </c:if>
			 	</div>
			 	</div> 
			 	<div class="mulu catalog" style="display:none" >
			 	 	<ul>
			 	 		<c:forEach items="${items}" var="item">
			 	 		<li onclick="tapcatalog(${item.id})" 
			 	 			<c:if test="${item.id==currentItem}">
				 	 			 class="high"			 	 			
			 	 			</c:if>
			 	 			><i></i>${item.name}</li>
			 	 		</c:forEach>
			 	 	</ul>
			 	</div>
			 	
			 	<div class="pingjia" style="display:none" >
			 	 <div class="havecontent"  >
			 	       <div <c:if test="${ isbuy == false && c.money != '0' }">style="display:none"</c:if> id="showform">
					 	  <form action="${ctx}/w/course/comment.html" id="addComment"  onsubmit="return false;" method="post">
					 	     <input type="hidden" name="cid" id="cid" value="${c.id}">
					 		 <input type="text" name="comment" id="comment" placeholder="请填写评论内容" >
					 		 <button onclick="pinglun()" id="pingjia">评价</button>
				 	      </form>
				 	   </div>   
				 	<ul class="list" id="list">
				 	      <c:if test="${fn:length( commentlist.results ) > 0 }">
				 		  <c:forEach items="${commentlist.results}" var="cc" varStatus="status">
				 		      <li>
								  <dl>
						 				<dt><a href="${ctx}/w/faq/person.html?p=${cc.wid}">
						 				<c:choose>
												 <c:when test="${ fn:indexOf(cc.header,'http') > -1 }">
														 <img src="${cc.header}"  >
												 </c:when>
												 <c:otherwise>
														 <img src="${ctx}/${cc.header}"  >
												 </c:otherwise>    
										 </c:choose> 
						 				</a></dt>
						 				<dd><h3><a href="${ctx}/w/faq/person.html?p=${cc.wid}">${cc.username}</a></h3></dd>
						 			</dl>
						 			<div>
										<h4>${cc.content}</h4>
						 				<p>${cc.showtime }</p>
						 			</div>
						 		</li>
				 		  </c:forEach>
				 		  </c:if>
				 		  <c:if test="${fn:length( commentlist.results ) ==  0 }">
				 		   	<li class="zanwu">
					 		    <img src="http://wimg.keepyoga.com/error.png" alt="">
					 		    <p>还没有评价内容哦...</p>
					 		</li>
				 		  </c:if>
				 	</ul>
				 </div>
			 	</div>
			 	</div>
			</div>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
	<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
	<script src="${ctx}/js/wblog.js?v=${version}"></script>
	<script>
// 	alert("${signature}");
// alert(location.href.split('#')[0])
//URI - query属性查询

	var icon = $("#hederr").attr("src");
	var title1 = "${u.nickname}的精品课程“${c.cname}”";
	var desc1  = "课程干货仅售${c.money}元，随心瑜Live，专业的瑜伽培训教育平台。";
	var link1  = location.href; 
	var img1   = icon ;
	var loggerid = 0 ;
	
	var nologin = "${nologin}"; 
	if( nologin == "true" ) { 
	    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	}
	
	
// 	var l= link1.indexOf("&");
// 	link1 = link1.substring(0,l);
	$("#shoucang").on("tap",function(){
		var scURL = "${ctx}/w/course/follow/"+($("#shoucang").html()=='已收藏'?'2':'1')+"/${c.id}/2.html";
		if( nologin == "true"  ) { 
		     window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		     return;
		}
		$.ajax({
			type:"post",
			dataType:"json",
			url:  scURL,
			error:function(XMLHttpRequest,textStatus,error){},
			success:function(msg){
				  if( msg.status == true ){
					  if(  $("#shoucang").html() == '已收藏' ){ 
						   $("#shoucang").removeClass("high");
					       $("#shoucang").html("收藏 ");
				      }else{ 
				    	   $("#shoucang").addClass("high");
						   $("#shoucang").html("已收藏");
				      }
				  }
			}
		});
	})  
    /*导航切换*/
    $("nav>ul").on("tap","li",function(){
    	tab(this);
    })
    $("nav>ul").on("click","li",function(){
    	tab(this);
    })
    
    var isComment = false;
    function tab(o){
         $(o).addClass("high").siblings().removeClass("high"); 
		  if($(o).attr("spn") == "jieshao"){
		     $("div.jieshao").css({ display:'block' });
		     $("div.pingjia").css({  display:"none" });
		     $("div.mulu").css({  display:"none" });
		     isComment= false;
		 }else if($(o).attr("spn") == "mulu"){
			 $("div.mulu").css({  display:"block" });
             $("div.pingjia").css({  display:'none' })
             $("div.jieshao").css({  display:"none" })
             isComment= true;
         }else if($(o).attr("spn") == "pingjia"){ 
             $("div.pingjia").css({  display:'block' })
             $("div.jieshao").css({  display:"none" })
		     $("div.mulu").css({  display:"none" });
             isComment= true;
         }
		 myScroll.refresh();
    }
    
    var pageIndex = 1;
		function loadStore(){
			if( pageIndex > -1 && isComment ){
				$.ajax({
	 				type:"post",
	 				dataType:"json",
	 				url:  "${ctx}/w/faq/course/json.html?p=${c.id}&pageIndex="+(pageIndex+1),
	 				error:function(XMLHttpRequest,textStatus,error){},
	 				success:function(msg){
	 					if( msg.result != ''){
	 					    $("#list").append(msg.result);
	 					    pageIndex ++;
	 					}else{
	 						 nodata = 0;
	 						 $("#pullUp").remove();  
	 					     pageIndex = -1;
	 					}
	 				}
	 			});  
			}
		}
		wx.config({
		    debug: false,
		    appId: '${appid}',
		    timestamp:'${timestamp}' ,
		    nonceStr: '${nonceStr}',
		    signature: '${signature}',
		    jsApiList: [ 
		        'checkJsApi','onMenuShareTimeline','onMenuShareAppMessage',
		        'onMenuShareQQ','onMenuShareWeibo','hideMenuItems','showMenuItems','hideAllNonBaseMenuItem',
		        'showAllNonBaseMenuItem', 'chooseImage','previewImage','uploadImage',
		        'chooseWXPay','hideOptionMenu','showOptionMenu'
		      ]
		}); 
	
		
		wx.ready(function(Api){  
			  wx.hideAllNonBaseMenuItem();
			    // 
			  wx.showMenuItems({
				    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
			 });
		});
		
		
        function playerOK(){
				$("#audio").get(0).pause();
				$("#audio").get(0).src=$("#filepath").val();
				$("#audio").get(0).volume=1;
				$("#audio").get(0).play();
	  }
	  document.addEventListener("WeixinJSBridgeReady", function () {  
	   	     // playerOK();  
	  }, false);  
		
	  function payEndAndBuy(){
			if( nologin == "true" ) { 
			     window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			     return;
			}
			
			
			  $.ajax({
					type:"post",
					dataType:"json",
					url:  "${ctx}/w/course/${c.money}/${c.id}/buy.html?o=${ordernumber}&p="+loggerid,
					error:function(XMLHttpRequest,textStatus,error){},
					success:function(msg){
						  if( msg.status == true ){
							     /*  $("#audioMask").remove();
								  $("#filepath").val(msg.filepath);
								  $("#btn").html("播放");
								  $("#showform").show();
								  document.getElementById("btn").onclick = null;
								  document.getElementById("btn").onclick=function(){
									  playMV();
								  }
								  playMV(); */
								  //shopping(); 
							  location.href ="${ctx}/w/faq/course.html?p=${p}";
						  } 
					}
			 });
	  }
		
	  function onBridgeReady(){
	         WeixinJSBridge.invoke(
	             'getBrandWCPayRequest', {
	                "appId" : "${appid}",     //公众号名称，由商户传入     
	                 "timeStamp":"${paytimestamp}",         //时间戳，自1970年以来的秒数     
	                 "nonceStr" : "${paynonceStr}", //随机串     
	                 "package" : "${paypackage}",     
	                 "signType" : "${paysignType}",         //微信签名方式:     
	                 "paySign" : "${paySign}" //微信签名 
	            },
	            function(res){
	                if( res.err_msg == 'get_brand_wcpay_request:ok'){
 	                	payEndAndBuy();
	                }
	                if( res.err_msg == 'get_brand_wcpay_request:cancel'){
	                	location.href ="${ctx}/w/faq/course.html?p=${p}";// 放弃付款
	                }
	            }
	        ); 
	   }
		   
      $("#comment").keyup(function(){
         var textContent=$("#comment").val().trim().length;
          if(textContent>0){ $("#pingjia").css("background","#1d92fb");  }
          else{ $("#pingjia").css("background","#c0c0c0"); }
      })
	  
	  function pay(){  
		  $.ajax({
				type:"post",
				dataType:"json",
				url:  "${ctx}/w/logger/2/${c.money}/${c.id}.html?o=${ordernumber}",
				error:function(XMLHttpRequest,textStatus,error){},
				success:function( msg ){
					  if( msg.id > 0 ){
						  loggerid = msg.id; 
						  weixinPay();
					  }
				}
		 });   
	  }
	  
	  function weixinPay(){
		     if (typeof WeixinJSBridge == "undefined"){
		        if( document.addEventListener ){
		              document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
		          }else if (document.attachEvent){
		              document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
		              document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
		         }
		      }else{
		         onBridgeReady();
		      }
	  }
	  
	  function shopping(){
		    dialog({
		            wrapper:".wrapper",
		            id:"shopping",
		            close:true,
		            title1:"购买成功",
		            title2:"后自动跳转到播放页面...",
		            mask:true,
		            time:2500,
		            bodytap:true,
		            successImg:true,
		            autoPlay:function(){
		            	playMV();
		            },
		            bhtml:3//多少秒后跳到播放页面
		    })
		}
	  
	  function playMV(){
		  playerOK();
	  }
	  
	  function share(){
	      dialog({wrapper:".wrapper",id:"share",bodytap:true,close:true,title1:"点击屏幕右上角“...”",title2:"选择分享给朋友或分享到朋友圈",mask:true,time:2500 });
	  }
	  
	  $("#audioMask").on("tap",function(){
		  
		  var money ="${c.money}";
		  if( $("#isbuy").val() == 'true' || money == 0){
			   playerOK();
		  }else{
               dialog({
		                  wrapper:".wrapper",
		                  id:"noshop",
		                  close:true,
		                  title1:"您尚未购买课程，可免费"+($("#ctype").val()=='0'?'试听':'试看')+"三分钟",
		                  btnleft:"购买",
		                  btnright: ($("#ctype").val()=='0'?'试听':'试看'),
		                  mask:true,
		                  bodytap:true,
		                  goumai:function(){
		                	  pay();
		                	  $("#noshop").remove();
		                  },
		                  shikan:function(){
		                      $("#audioMask").css("display","none");
		                      $(".masking").remove();
		                      $("#noshop").remove();
		                      $("#audio").get(0).play();
		                  
		                      var timer= setInterval(function(){
		                          var times=$("#audio").get(0).currentTime;
		                          if( Math.ceil(times) == 180 ){
		                              $("#audio").get(0).pause();
		                                 dialog({
		                                          wrapper:".wrapper",
		                                          id:"over",
		                                          title1:"尊敬的用户，"+($("#ctype").val()=='0'?'试听':'试看')+"已结束 ",
		                                          title2:"购买"+($("#ctype").val()=='0'?'音频':'视频')+"可"+($("#ctype").val()=='0'?'听':'看')+"完整版本",
		                                          spanhtml:"重新"+($("#ctype").val()=='0'?'试听':'试看'),
		                                          errorImg:true,
		                                          again:function(){
		                                                  $("#over").remove();
		                                                  $("#audio").get(0).load();
		                                                  $("#audio").get(0).play();
		                                              }
		                                      })
		                         }
		                   },1000);
		              }
		      })
		  }
      })
      
      function pinglun(){
			  if( $("#comment").val() == ''){
				 	    		 Modal.tips("<font color='#ccc'>亲，写点内容吧！</font>","success",2500);
				 	    		 return ;
			  }
			   $('#addComment').ajaxSubmit(function(data){
				 	    		 if(  data.status == true ) { 
				 	    			 $("#list li").eq(0).before( data.html ); 
				 	    			 $("#comment").val('');
				 	    			 $(".zanwu").remove();
				 	    			 nodata = 1;
				 	    			 setTimeout(function(){
				 	    			    Modal.tips("<font color='#ccc'>亲，评论成功了哦！^^</font>","success",2500);
				 	    			 },500);
				 	    		 }else{
				 	    			setTimeout(function(){
				 	    			  Modal.tips("<font color='#ccc'>"+data.result+"</font>","error",2500);
				 	    			},500);
				 	 	 }
			  });
	   }
	 function tapcatalog(id){
		 window.location.href="${ctx}/w/faq/course.html?p="+$("#cid").val() + "&i="+id;
	 }
	 
	 
	 
	 
	 
 	 $(".audio_style").on("tap", function () {
			 var money ="${c.money}";
			var mianfei = ($("#isbuy").val() == 'true' || money == 0);
			if (mianfei) {
				$(this).hide();
				$("#audio").get(0).play();
				$(".controlBox").css("visibility", "visible");
				$(".audioMask").remove();
			} else {
				dialog({
					wrapper: ".wrapper",
					id: "noshop",
					close: true,
					title1: "您尚未购买课程，可免费" + ($("#ctype").val() == '0' ? '试听' : '试看') + "三分钟",
					btnleft: "购买",
					btnright: ($("#ctype").val() == '0' ? '试听' : '试看'),
					mask: true,
					bodytap: true,
					goumai: function () {
						pay();
						$("#noshop").remove();
					},
					shikan: function () {
						$("#audioMask").css("display", "none");
						$(".masking").remove();
						$("#noshop").remove();
						$("#audio").get(0).play();
						$(".audio_style").hide();
						$(".controlBox").css("visibility", "visible");
						var timer = setInterval(function () {
							var times = $("#audio").get(0).currentTime;
							if (Math.ceil(times) == 180) {
								$("#audio").get(0).pause();
								dialog({
									wrapper: ".wrapper",
									id: "over",
									title1: "尊敬的用户，" + ($("#ctype").val() == '0' ? '试听' : '试看') + "已结束 ",
									title2: "购买" + ($("#ctype").val() == '0' ? '音频' : '视频') + "可" + ($("#ctype").val() == '0' ? '听' : '看') + "完整版本",
									spanhtml: "重新" + ($("#ctype").val() == '0' ? '试听' : '试看'),
									errorImg: true,
									again: function () {
										$("#over").remove();
										$("#audio").get(0).load();
										$("#audio").get(0).play();
									}
								})
							}
						}, 1000);
					}
				})
			}
		})

	 /*暂停播放*/
		$("#play_pause").on("tap", function () {
			if ($(this).find("span").hasClass("play-pause-pause")) {
				$(this).find("span").removeClass("play-pause-pause");
				$("#audio").get(0).pause();
			} else {
				$(this).find("span").addClass("play-pause-pause");
				$("#audio").get(0).play();
				dragMove();
			}
		})

		/*音频开始*/
		Ios_video();
		var proLeft = $(".progressBar").offset().left;

		function Ios_video() {
			
			var src=$("#srouce").attr("data-src")
			$("#audio").attr('src',src)
			var ctr_box_w = $(".progressBar").width();

			var video_audio = $(".video-audio").get(0);

			/*双击播放或暂停开始*/
			/*双击播放或暂停结束*/


			$(".audio-video-mask-play").on("tap", function () {
				tapmask($(".video-audio"));
			})


			function tapmask(obj) {
				$(".controlBox").hide();
				$(".video-audio").get(0).play();
				obj.addClass("video-audio-play");
				dragMove();
			}
			addListenTouch()
			var startX, x, disx; //触摸时的坐标 //滑动的距离  //设一个全局变量记录上一次内部块滑动的位置   
			//1拖动监听touch事件  
			function addListenTouch() {
				document.getElementById("drag").addEventListener("touchstart", touchStart, false);
				document.getElementById("drag").addEventListener("touchmove", touchMove, false);
				document.getElementById("drag").addEventListener("touchend", touchEnd, false);
				var drag = document.getElementById("drag");
				var speed = document.getElementById("speed");
			}
			//touchstart,touchmove,touchend事件函数  
			function touchStart(e) {
				e.preventDefault();
				var touch = e.touches[0];
				startX = touch.pageX;
			}

			function touchMove(e) { //滑动            
				e.preventDefault();
				var touch = e.touches[0];
				x = touch.pageX - proLeft; //滑动的距离 
				console.log(x)
				if (x < 0) {
					drag.style.left = 0;
					speed.style.width = 0;
				} else if (x >= ctr_box_w) {
					drag.style.left = ctr_box_w;
					speed.style.width = ctr_box_w + "px";
				} else {
					drag.style.left = x + "px";
					speed.style.width = x + "px";
				}

				var touch = e.touches[0];
				var dragPaddingLeft = drag.style.left;
				var change = dragPaddingLeft.replace("px", "");
				numDragpaddingLeft = parseInt(change);
				var currentTime = numDragpaddingLeft / ctr_box_w * video_audio.duration + 1; //30是拖动圆圈的长度，减掉是为了让歌曲结束的时候不会跑到window以外  
				video_audio.currentTime = currentTime;
			}

			function touchEnd(e) { //手指离开屏幕  
				e.preventDefault();
				aboveX = parseInt(drag.style.left);
				var touch = e.touches[0];
				var dragPaddingLeft = drag.style.left;
				var change = dragPaddingLeft.replace("px", "");
				numDragpaddingLeft = parseInt(change);
				var currentTime = numDragpaddingLeft / ctr_box_w * video_audio.duration + 1; //30是拖动圆圈的长度，减掉是为了让歌曲结束的时候不会跑到window以外  
				video_audio.currentTime = currentTime;
			}


			//3拖动的滑动条前进  
			function dragMove() {
				setInterval(function () {
					drag.style.left = (video_audio.currentTime / video_audio.duration) * (window.innerWidth / 2) + "px";
					speed.style.width = (video_audio.currentTime / video_audio.duration) * (window.innerWidth / 2) + "px";

				}, 500);
			}
			video_audio.addEventListener("loadeddata", //歌曲一经完整的加载完毕( 也可以写成上面提到的那些事件类型)  
				function () {

					var allTime = video_audio.duration;

					$(".long-time").html(timeChange(allTime));
					var currentTime = video_audio.currentTime;
					var currentTime = video_audio.currentTime;

					$(".now-time").html(timeChange(currentTime));
					setInterval(function () {
						var currentTime = video_audio.currentTime;
						$(".now-time").html(timeChange(currentTime));
					}, 1000);
				}, false);

			function timeChange(time) { //默认获取的时间是时间戳改成我们常见的时间格式  
				//分钟  
				var minute = time / 60;
				var minutes = parseInt(minute);
				if (minutes < 10) {
					minutes = "0" + minutes;
				}
				//秒  
				var second = time % 60;
				seconds = parseInt(second);
				if (seconds < 10) {
					seconds = "0" + seconds;
				}
				var allTime = "" + minutes + "" + ":" + "" + seconds + ""
					/* $(".now-time").html(allTime);*/
				return allTime;
			}
			window.dragMove = dragMove;
		}
	</script>
	<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
</body>
</html>