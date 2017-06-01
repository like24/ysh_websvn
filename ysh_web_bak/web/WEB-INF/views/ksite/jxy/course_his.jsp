<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="course" />
<!doctype html>
<%
   request.setAttribute("v", System.currentTimeMillis());
%>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/cursorDetaill.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/tlq.css?v=${v}">
	<title>${course.name }</title>
	<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${v}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js?v=${v}"></script>
    <script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript">
        var nodata = 1;
    </script>
    <script>
   		 /* 判断是不是安卓 */
    	 var u = navigator.userAgent;
    	 var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    		 if(isAndroid){
    			var linkDom=$("<link rel='stylesheet' href='${ctx}/css/tlq1.css'>");
    			$("#linkId").after($(linkDom));
    		 }
    </script>
    <style>
    div.masking{
    	z-index: 1000;
    }
    .buyTip button {
   	 	margin-left: 4.3rem;
    }
    .buyTip{
    		height: 10rem;
    }
   		 <c:if test="${ocourse.ctype == 1}">
    		.audio_style{
    			background:transparent;
    		}
    	</c:if> 
    </style>
    
</head>
 <body>
	 <div id="fxBox">
	 <div class="masking"></div>
	 <div class="fenxiang">
	 	<img src="http://wimg.keepyoga.com/images/zq6.png">;
	 </div>
	</div>
	<!-- 购买提示弹框 -->
	<div class="buyTipBox">
		<div class="masking"></div>
		<div class="buyTip">
			<img src="${ctx}/images/close.jpg" id="buyClose">
			<p><img src="http://wimg.keepyoga.com/images/tlqicon.png" class="icon">该课程是收费课程，观看需购买<a href="${ctx}/w/faq/course.html?p=${ocourse.id}">本节课程</a>，或者<a href="${ctx}/w/faq/distributionq.html">2016瑜伽私教集训营</a>全部课程。若有疑问，请联系客服4000186161。</p>
			<button type="button" id="OK" onclick="buyBoxHide();">确定</button>
		</div>
	</div>
    <div class="wrapper">
        <header  >
              <div class="audio_video" style="background:url(${ocourse.icon});background-size:100%;">
              <c:if test="${ocourse.ctype == 0}">
				      <audio id="audio" class="video-audio" >
				      		<source src="${ocourse.realfilepath}" >
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
				 <c:if test="${ocourse.ctype == 1}">
					    <video  height="10rem;"  id="audio" controls style="background:url(${ocourse.icon});background-size:100%;">
					    	<source src="${ocourse.realfilepath}" >
					    </video>
				 </c:if>
  			        <div class="audioMask" id="audioMask"></div>
			        <div class="audio_style"></div>
            </div>
            <p class="title">${course.name }<img src="${ctx}/images/arrow_up.png" id="arrow_up" alt=""></p>
            <dl id="person" data-url="${ctx}/w/faq/person.html?p=${teacher.id}&t=0" >
                <dt>
					<img src="${teacher.file_path}"  >
                </dt>
                <dd>
                    <h2>${teacher.nickname }<span>${teacher.userpost }</span></h2>
                    <p>${teacher.shortremark }</p>
                </dd>
                <span class = "sanjiao" > </span>
            </dl>
        </header>
        <!--导师页面才有提醒-->
        
        <!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
        <section class="mainBox <c:if test="${user.id != course.tid}">main2</c:if> " id="mainBox">
            <ul id="list" class="list">
            </ul>
        </section>
        <footer>
            <c:if test="${course.tid != user.id }">
            	<div class="student gl">
	            	<form action="">
						<p class="all showtype" style="margin: 0 auto;">
							<i class=""></i>
							<span class="" id="_showtype">查看全部</span>
						</p>
					</form>
				</div>
            </c:if>
            <c:if test="${course.tid == user.id }">
            	<h1 style="text-align:center;font-size:18px;color:#3f3f3f;line-height:2.6rem;">互动已结束</h1>
            </c:if>

        </footer>
    </div>
    <script src="${ctx}/js/zepto.js?v=${v}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${v}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${v}"></script>
    <script src="${ctx}/js/ajax_iscroll.js?v=${v}"></script>
    <script>
    if("${empty ocourse}" == "true"){
    	$(".audio_video").hide();
			$("#mainBox").addClass("main1");
			$("#arrow_up").hide();
			$(".teach-remind").addClass("teach-remind1");
			var teachId=${course.tid};
			if(teachId){
				$("section").css("top","5.5rem");
			}
    }
    /*  全局变量    */
	var isConnection = false, // 链接是否有效
	    timer,  // 登陆定时器
	    voice = { localId: '', serverId: '' },
	    isowninitiative = false,  // 是否主动离开 ；
	    RecordTimer,  
	    isReconnection = false, // 是否是用户本人确定了重连 
	    nologin = "${nologin}" == "true",
	    isAdd = false,
	    tpageIndex = 0,
	    recordid ,
	    mp3Timer ,
	    recordtime = 1 ,
	    realtime = 1,
	    pageSize =10,
	    nowH = 0 ,
	    playingId ,
	    btnnum = 1,
	    playnum = 1,
	    question = "0",
	    showtype = 0,
	    managerid = "${course.mamagerid}";
	    var pageIndex = 0,type = 0;
	    
	/*  初始化微信  */
	wx.config({
		debug: false, 
		appId:'${appid}',
		timestamp:'${timestamp}' , 
		nonceStr: '${nonceStr}', 
		signature: '${signature}', 
		jsApiList: ['checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'startRecord','stopRecord', 'playVoice','pauseVoice','stopVoice','uploadVoice','downloadVoice','chooseImage','previewImage','uploadImage','downloadImage','hideOptionMenu','showOptionMenu','closeWindow']
	});
	
	wx.ready(function(){
		var linka = window.location.href;
		var title = "快来免费收听！瑜伽私教直播间，60多个代表性问答任你学习！ ";
		var imgurl = "${teacher.file_path}";
		wx.hideMenuItems({
			menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
		});

		wx.onMenuShareAppMessage({
		    title: title, // 分享标题
		    desc: '著名瑜伽导师${teacher.nickname},为你解疑', // 分享描述
		    link: linka, // 分享链接
		    imgUrl: imgurl, // 分享图标
		    type: '', // 分享类型,music、video或link，不填默认为link
		    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		    success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		wx.onMenuShareTimeline({
			 title: title, // 分享标题
			 desc: '著名瑜伽导师${teacher.nickname},为你解疑', // 分享描述
			 link: linka, // 分享链接
			 imgUrl: imgurl, // 分享图标
		     success: function () { 
		        // 用户确认分享后执行的回调函数
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
	});
	
        
   
        /*聊天系统开始*/
         var Sucess = false;
        /*聊天系统开始*/
        var h = $("#list").height();
        var mainbox_h = $(document).height() - $("footer").height() - $("header").height();
        var bodyDist = undefined;

        function loaded() {
            myiscroll = new iScroll("mainBox", {
                useTransition: false,
                vScrollbar: false,
                checkDOMChanges: true,

                onScrollMove: function () {
                    //console.log(myiscroll.y);
                    if (myiscroll.y >= 30) {
                        Sucess = true;
                    } else {
                        Sucess = false;
                    }
                    if (this.distY > 30 && this.absDistY) {
                        bodyScroll = null;
                    }
                },
                onScrollLimit: function () {
                    bodyScroll = function () {
                        myiscroll.scrollToElement('li:last-child', 400, true);
                    }
                },
                onScrollEnd: function () {
                    if (Sucess) {
                        pullDown();
                    }
                }
            })
            bodyScroll();
        }

        document.addEventListener('touchmove', function (e) {
            e.preventDefault();
        }, false);
        document.addEventListener('DOMContentLoaded', loaded, false);
        

        function bodyScroll() {
            myiscroll.scrollToElement('li:last-child', 400, true);
        }
        /*聊天系统结束*/

        // 转义HTML
		function escapeHtml( ctn ) {
			return ctn.replace(/&/g, '&amp;').replace('|', '■').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/\n/g, '<br>');
		}
		
		// 
		function ahtml( ctn ){
			return ctn.replace(/((https?|s?ftp):\/\/)?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)\b)\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?\b/ig, function(a, b) {
			    return '<a target="_blank" href="' + (b ? '' : 'http://') + a.replace(/&#38;/g, '&') + '">' + a + '</a>'
		    })
		}
		
		$("section,footer").on("touchstart",function(){
			  var cl = ${course.tid == user.id};
			  $(".audio_video").slideUp(400, function() {
					$("#mainBox").addClass("main1");
					if(!cl){
						$("#mainBox").addClass("main3");
					}
					$("#arrow_up").addClass("UP");
					$(".teach-remind").addClass("teach-remind1");
				});
		  })
		  
		   $(document).on("click","dd>img",function(){
		var thisSrc=$(this).prop("src");
		var newMask=$("<div id='bigPic'><div class='masking' style='opacity:.8;'></div></div>");
		var newImg=$("<img id='moveid'>");
		$(newImg).attr("src",thisSrc);
		var screenW=$(window).width();
		$(newImg).css({
			"width":screenW,
			"height":"auto"
		});
		$(newMask).append($(newImg));
		$("body").append(newMask);
		var imgW=$(newImg).width()/2,
		imgH=$(newImg).height()/2;
		$(newImg).css({
			marginTop:-imgH+"px",
			marginLeft:-imgW+"px",
			left:50+"%",
    	    top:50+"%"
		});
		$("#moveid").on("tap",function(){
			setTimeout(function(){
				$("#bigPic").remove();
			},10);
		})
		 var isdrag=false;   
		  var ty,y,x;   
		$(function(){
	    	document.getElementById("moveid").addEventListener('touchend',start);  
		    document.getElementById("moveid").addEventListener('touchstart',selectmouse);  
		    document.getElementById("moveid").addEventListener('touchmove',movemouse);  
		});
	  });
	  function start(e){
  			
	        isdrag = false;  
  	}
	function movemouse(e){
	  if (isdrag){   
	   var ImgT = ty + e.touches[0].pageY - y;
	   $("#moveid").css({
		   "top":ImgT
	   });  
	   return false;   
	   }   
	}   
	 
	function selectmouse(e){   
	   isdrag = true;
	   ty = parseInt(document.getElementById("moveid").style.top+0);   
	   y = e.touches[0].pageY;    
	   x= e.touches[0].pageX; 
	   console.log(y)
	   return false;   
	}   


	/*馆主页面收起（）*/
	$("#arrow_up").on("click", function() {
		var cl = ${course.tid == user.id};
		
		if (!$(this).hasClass("UP")) {
			$(".audio_video").slideUp(400, function() {
				$("#mainBox").addClass("main1");
				if(!cl){
					$("#mainBox").addClass("main3");
				}
				$("#arrow_up").addClass("UP");
				$(".teach-remind").addClass("teach-remind1");
			});
		} else {
			$("#mainBox").removeClass("main1");
			$("#arrow_up").removeClass("UP");
			if(!cl){
				$("#mainBox").removeClass("main3");
			}
			$(".teach-remind").removeClass("teach-remind1");
			$(".audio_video").slideDown(400);
		}
	});
	 $(".list").on("tap", function () {
		 var cl = ${course.tid == user.id};
		   $(".audio_video").slideUp(400, function() {
			   $("#mainBox").addClass("main1");
				$("#arrow_up").addClass("UP");
				$(".teach-remind").addClass("teach-remind1");
				if(!cl){
					$("#mainBox").addClass("main3");
				}
			});   
		});
	   
        /*密码药匙*/
        $("#video_play").on("tap", function () {
            $(".keymask").show();
            $("#keybox").show();
        })
        $(".close").on("tap", function () {
            $(".keymask").hide();
            $("#keybox").hide();
        })
        $(".keymask").on("tap", function () {
            $(this).hide();
            $("#keybox").hide();
        })
        $("#person").on("tap", function () {
            window.location.href = $(this).attr("data-url");
        })
        
        
        
		// 页面切换到后台
		function onVisibilityChanged(event) {
			 var hidden = event.target.webkitHidden;
			 if( hidden){
				 //fclose();
			 }
		}
        
        
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
			  WeixinJSBridge.call('showOptionMenu');
		}); 
		document.addEventListener("visibilitychange", onVisibilityChanged, false);
		document.addEventListener("webkitvisibilitychange", onVisibilityChanged, false);
	
     function loadStore(){
			if( pageIndex < 0 ){
				return;
			}
			$.ajax({
 				type:"post",
 				dataType:"json",
 				url:  "${ctx}/w/chat/msg/json.html?p=${course.id}&pageIndex="+(pageIndex+1) + "&type=" + type,
 				error:function(XMLHttpRequest,textStatus,error){},
 				success:function(msg){
 					if( msg != '' && msg != undefined ){
 						var html = "", ouid = "${course.tid}";
 		        	    for( var i = 0 ; i < msg.length ;i ++){
 		        	    	console.log(JSON.stringify(msg[i]))
 		        	    	var userid    = "${user.id}"; 
 			 	         	var wid      = parseInt(msg[i].wid);
 			 	         	var isteacher= parseInt(msg[i].isteacher);
 			 	         	var type     = parseInt(msg[i].type); 
 			 	         	var content  = msg[i].content.replace('■', '|'); 
 			 	         	var header   = msg[i].header;
 			 	         	var mp3path  = msg[i].mp3path;
 				         	var mp3time  = msg[i].mp3time;
 				         	var realname = msg[i].realname;
 				         	var serverid = msg[i].serverid;
 			 	         	if( header.indexOf('http') == -1  ){
 			  		        	header = "${ctx}/"+header;
 			  		        }
 			 	         	
 			 	          if(ouid == wid){  //导师发言
 				         		if(type == '0'){
 				         			html += '<li>' +
 				         					'<dl class="student" id="teachText">' +
 				         					'<dt>' +
 				         					'<i>'+realname+'</i>' +
 				         					'<img src="'+header+'" alt="">' +
 				         					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
 				         					'</dt>' +
 				         					'<dd>' +
 				         					'<span class="triangle-left-student1">&#9670</span>' +
 				         					'<span class="triangle-left-student">&#9670</span>' +
 				         					'<div></div>' +
 				         					'<p>'+content+'</p>' +
 				         					'</dd>' +
 				         					'</dl>' +
 				         					'</li>';
 				         		}else if(type == '1'){
 				         			if(content == "0"){
 				         				html += '<li>' +
 											'<dl class="son" id="teachSon">' +
 											'<dt>' +
 											'<i>'+realname+'</i>' +
 											'<a href="javascript:;"><img src="'+header+'" alt=""><img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead"></a>' +
 											'</dt>' +
 											'<dd>' +
 											'<button number="'+btnnum+'"  data-src="'+ mp3path +'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
 											'<b class="_unread"></b>' +	
 											'<i class="time">'+mp3time+'"</i>' +
 					   						'</dd>' +
 					      					'</dl>' +
 					      					'</li>';
 			 	         			}else{
 					         			html += '<li>' +
 					         					'<dl class="student teacherAns" id="teachText">' +
 					         					'<dt>' +
 					         					'<i>'+realname+'</i>' +
 					         					'<img src="'+header+'" alt="">' +
 					         					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
 					         					'</dt>' +
 					         					'<dd>' +
 					         					'<span class="triangle-left-student1">&#9670</span>' +
 					         					'<span class="triangle-left-student">&#9670</span>' +
 					         					'<div></div>' +
 					         					'<p>'+content+'</p>' +
 					         					'<ol></ol>' +
 					         					'<button number="'+btnnum+'" data-src="'+ mp3path +'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
 					         					'<b class="_unread"></b>' +
 					         					'<i class="time">'+mp3time+'"</i>' +
 					         					'</dd>' +
 					         					'</dl>' +
 					         					'</li>';
 			 	         			}
 				         			btnnum++;
 				         		}else{
 				         			html += '<li>' +
 			     					'<dl class="student" id="teachText">' +
 			     					'<dt>' +
 			     					'<i>'+realname+'</i>' +
 			     					'<img src="'+header+'" alt="">' +
 			     					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
 			     					'</dt>' +
 			     					'<dd>' +
 			     					'<span class="triangle-left-student1">&#9670</span>' +
 			     					'<span class="triangle-left-student">&#9670</span>' +
 			     					'<div></div>' +
 			     					'<img src="'+serverid+'"/>' +
 			     					'</dd>' +
 			     					'</dl>' +
 			     					'</li>';
 				         		}
 				         	}else{
 								if(managerid == wid){
 									header = "http://wimg.keepyoga.com/112670388829777145.jpg";
 									realname = "主持人";
 								}
 								if(type == '0'){
 									if(managerid == wid){
 										html += '<li>' +
 				         					'<dl class="student" id="teachText">' +
 				         					'<dt>' +
 				         					'<i>'+realname+'</i>' +
 				         					'<img src="'+header+'" alt="">' +
 				         					'</dt>' +
 				         					'<dd>' +
 				         					'<span class="triangle-left-student1">&#9670</span>' +
 				         					'<span class="triangle-left-student">&#9670</span>' +
 				         					'<div></div>' +
 				         					'<p style="color:#1d93fa;">'+content+'</p>' +
 				         					'</dd>' +
 				         					'</dl>' +
 				         					'</li>';
 									}else{
 						
 										html += '<li>' +
 												'<dl class="self">' +
 												'<dd>' +
 												'<span class="triangle-left-self1">&#9670</span>' +
 												'<span class="triangle-left-self">&#9670</span>' +
 												'<div></div>' +
 												'<p>'+content+'</p>' +
 												'</dd>' +
 												'<dt>' +
 												'<i>'+realname+'</i>' +
 												'<img src="'+header+'" alt="" data-uid="'+wid+'"  onclick="stopUser(this)">' +
 												'<img src="http://wimg.keepyoga.com/images/Gag.png" alt="" class="Gag">' +
 												'<span></span>' +
 												'</dt>' +
 												'</dl>' +
 												'</li>';
 									}
 				         		}else if(type == '1'){
 				         			if(content == "0"){
 				         				html += '<li>' +
 											'<dl class="son" id="teachSon">' +
 											'<dt>' +
 											'<i>'+realname+'</i>' +
 											'<a href="javascript:;"><img src="'+header+'" alt=""></a>' +
 											'</dt>' +
 											'<dd>' +
 											'<button number="'+btnnum+'"  data-src="'+ mp3path +'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
 											'<b class="_unread"></b>' +	
 											'<i class="time">'+mp3time+'"</i>' +
 					   						'</dd>' +
 					      					'</dl>' +
 					      					'</li>';
 			 	         			}else{
 					         			html += '<li>' +
 					         					'<dl class="student teacherAns" id="teachText">' +
 					         					'<dt>' +
 					         					'<i>'+realname+'</i>' +
 					         					'<img src="'+header+'" alt="">' +
 					         					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
 					         					'</dt>' +
 					         					'<dd>' +
 					         					'<span class="triangle-left-student1">&#9670</span>' +
 					         					'<span class="triangle-left-student">&#9670</span>' +
 					         					'<div></div>' +
 					         					'<p>'+content+'</p>' +
 					         					'<ol></ol>' +
 					         					'<button number="'+btnnum+'" data-src="'+ mp3path +'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
 					         					'<b class="_unread"></b>' +
 					         					'<i class="time">'+mp3time+'"</i>' +
 					         					'</dd>' +
 					         					'</dl>' +
 					         					'</li>';
 			 	         			}
 				         			btnnum++;
 				         		}else{
 				         			html += '<li>' +
 					     					'<dl class="student" id="teachText">' +
 					     					'<dt>' +
 					     					'<i>'+realname+'</i>' +
 					     					'<img src="'+header+'" alt="">' +
 					     					'</dt>' +
 					     					'<dd>' +
 					     					'<span class="triangle-left-student1">&#9670</span>' +
 					     					'<span class="triangle-left-student">&#9670</span>' +
 					     					'<div></div>' +
 					     					'<img src="'+serverid+'"/>' +
 					     					'</dd>' +
 					     					'</dl>' +
 					     					'</li>';
 				         		}
 				         	}
 		        	    }
 		        	   $("#list").append( html );
					   pageIndex ++;
 					}
 				}
			});
				
        }
        loadStore();
 
        
		function playMp3( jdom ){ 
			$("button").find("img").attr("src", "${ctx}/images/son.png");
			$(jdom).next().remove();
			$(jdom).find("img").attr("src", "${ctx}/images/songif.gif");
			$("#audio111").get(0).pause();
			var mp3source = $(jdom).attr("data-src");
			playnum = $(jdom).attr("number");
			$("#audio111").get(0).pause();
			$("#audio111").get(0).src=mp3source;
			$("#audio111").get(0).volume=1;
			$("#audio111").get(0).play();
			var a= $(jdom).next().html();
			var c=a.length-1;
			var interTime=parseInt(a.substr(0,c));
			setTimeout(function(){
				$(jdom).find("img").attr("src", "${ctx}/images/son.png");
				var num = parseInt(playnum) + 1;
     	        var b = $("button[number='"+num+"']")
     	        playmp3(b);
			},interTime*1000)
			
		}
        
		function playmp3( jdom ){ 
			if(jdom.next("._unread").is("b")){
				jdom.next().remove();
				jdom.find("img").attr("src", "${ctx}/images/songif.gif");
				$("#audio111").get(0).pause();
				var mp3source = jdom.attr("data-src");
				$("#audio111").get(0).pause();
				$("#audio111").get(0).src=mp3source;
				$("#audio111").get(0).volume=1;
				$("#audio111").get(0).play();
				var a= jdom.next().html();
				var c=a.length-1;
				var interTime=parseInt(a.substr(0,c));
				setTimeout(function(){
					jdom.find("img").attr("src", "${ctx}/images/son.png");
					var num = parseInt(playnum) + 1;
	     	        var b = $("button[number='"+num+"']")
	     	        playmp3(b);
				},interTime*1000)
			}
		}
        
        
        
	    $(".showtype").on("click",function(){
	    	if(showtype == 0){
	    		showtype =1;
	    		type = 1;
	    		$(this).find("i").css({
	    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon2.png')",
	    			"background-repeat":"no-repeat"
	    		});
	    		
	    		$(this).find("span").html("只看导师");
	    	}else{
	    		showtype =0;
	    		type = 0;
	    		$(this).find("i").css({
	    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon3.png')",
	    			"background-repeat":"no-repeat"
	    		});
	    		$(this).find("span").html("查看全部");
	    	}
    		$("#list").empty();
    		pageIndex = 0;
    		loadStore();
	    });

	    $("#yzmcode").on("keyup", function () {
            if ($(this).val().length != 0) {
                $("#entercode").css("background", "#1d92fb");
            } else {
                $("#entercode").css("background", "#9c9c9c");
            }
        });
        
	    /* 图片预览 */
        $(document).on("click","dd>img",function(){
		var thisSrc=$(this).prop("src");
		var newMask=$("<div id='bigPic'><div class='masking' style='opacity:.8;'></div></div>");
		var newImg=$("<img id='moveid'>");
		$(newImg).attr("src",thisSrc);
		var screenW=$(window).width();
		$(newImg).css({
			"width":screenW,
			"height":"auto"
		});
		$(newMask).append($(newImg));
		$("body").append(newMask);
		var imgW=$(newImg).width()/2,
		imgH=$(newImg).height()/2;
		$(newImg).css({
			marginTop:-imgH+"px",
			marginLeft:-imgW+"px",
			left:50+"%",
    	    top:50+"%"
		});
	
	  });
        $(document).on("tap","#moveid",function(){
			$("#bigPic").remove();
	})
	    
	  if( nologin == "true" ) {   
		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
      }
	    
	 
     
	  function pullDown() {
		  tpageIndex = tpageIndex + 1;
		 
    	  clearInterval(timer);
		  
       }
	  
      if (${course.cid != 0} ) {
          if (${course.tid == user.id} ) {
        	  $("#mainBox").addClass("main");
          } else {
        	  $("#mainBox").addClass("mainBox");
          }
      } else {
          if (${course.tid == user.id}) {
        	  $("#mainBox").addClass("have-tip");
              $("p.teach-remind").addClass("have-tip");
          } else {
              $("#mainBox").addClass("no-tip");
          }

      }
	  /* share弹框 */
	  $(".share").on("tap",function(){
		  $("#fxBox").show();
	  })
	  $("#fxBox").on("tap",function(){
		  $("#fxBox").hide();
	  })
	  $("#buyClose").on("tap",function(){
		$(".buyTipBox").hide();
		});
	  function buyBoxHide(){
    	  $(".buyTipBox").hide();
      }
	   $(".audio_style").on("tap", function () {
    		 var isbuy=${isbuy};
				if(!isbuy){
					
					$(".buyTipBox").css("display","block");
				}
				else{
					$(this).hide();
					$("#audioMask").remove();
					$("#audio").get(0).play();
					$(".controlBox").css("visibility", "visible");	
					
				}
					$("#audio").get(0).onended = function() {
						 Modal.tips("<font color='#ccc'>亲,视频播放结束了哦！</font>","success",5500);
				
		   			
		   		}
				
      });
	  
    </script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
     <c:if test="${ocourse.ctype==0}">
    	<script type="text/javascript">
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
		/*音频结束*/
    	</script>
    </c:if>
    <div style="display:hidden" ><audio id="audio111"><source src="" type="audio/mpeg"></audio></div>
    <script>
		var _hmt = _hmt || [];
		(function() {
		  var hm = document.createElement("script");
		  hm.src = "//hm.baidu.com/hm.js?ba67d2ff32de2e30f289292c1cbf41d4";
		  var s = document.getElementsByTagName("script")[0]; 
		  s.parentNode.insertBefore(hm, s);
		})();
		</script>
</body>
</html> 
 