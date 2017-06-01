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
	 <link rel="stylesheet" href="${ctx}/css/mildwinter.css?v=${v}" id="link">
	<title>${course.name }</title>
	 <style>
	*{
			-webkit-touch-callout:auto;
			-webkit-user-select:auto;
			-khtml-user-select:auto;
			-moz-user-select:auto;
			-ms-user-select:auto;
			user-select:auto;
	 	}
	 	#list{padding-top:1rem;padding-bottom:1rem;}
	 </style>
	<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${v}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js?v=${v}"></script>
    <script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript">
        var nodata = 1;
        /* 判断是不是安卓 */
   	 	var u = navigator.userAgent;
   		 var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
   			 if(isAndroid){
   				var linkDom=$("<link rel='stylesheet' href='${ctx}/css/tlq1.css'>");
   				$("#link").after($(linkDom));
   		 }
    </script>
</head>
 <body>
 <div class="sideBtn">
		<span class="icon icon1 " id="goTop"></span>
		<span class="icon icon2" id="goBottom"></span>
	</div>
    <div class="wrapper">
        <header  >
            <p class="title">${course.name }</p>
        </header>
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
							<span class="" id="_showtype">查看导师</span>
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
    <script src="http://wimg.keepyoga.com/js/fastclick.min.js"></script>
    <script>
    	/*调用fastclick*/
	FastClick.attach(document.body);
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
	    var pageIndex = 1;
	    /*  初始化微信  */
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
			        'showAllNonBaseMenuItem', 'chooseImage','previewImage','uploadImage','startRecord','stopRecord','closeWindow',
			        'chooseWXPay','downloadImage','getNetworkType','openLocation','playVoice','pauseVoice','stopVoice','uploadVoice','downloadVoice',
			        'getLocation','hideOptionMenu','showOptionMenu'
			      ]
			}); 
		  wx.ready(function(){
				var linka = window.location.href; 
				var imgurl = "http://wimg.keepyoga.com/images/mindwintersharelog.jpg";
				wx.hideMenuItems({
					menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
				});
				/* 分享对象 */
				var shareObj={
					    title: '92位瑜伽行业精英喊你加入随心瑜“瑜伽暖冬行动”', // 分享标题
					    desc: '60场精择优选课程，8场精彩绝伦主题论坛，你还在等什么？', // 分享描述
					    link: linka, // 分享链接
					    imgUrl: imgurl, // 分享图标
					    type: '', // 分享类型,music、video或link，不填默认为link
					    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
					    success: function () { 
					    },
					    cancel: function () { 
					        // 用户取消分享后执行的回调函数
					    }
					};
				wx.onMenuShareAppMessage(shareObj);
				wx.onMenuShareTimeline(shareObj);
				$("#audio111").get(0).src="";
				$("#audio111").get(0).pause();
				$("#audio111").get(0).volume=1;
				$("#audio111").get(0).play();
			});
   	/* 点击图片变轮播--微信 */
	$(document).on('click', 'dd img.picArray',function(event) {
	    var imgArray = [];
	    var curImageSrc = $(this).attr('src');
	   	 $('dd .picArray').each(function(index, el) {
	            var itemSrc = $(this).attr('src');
	            imgArray.push(itemSrc);
	        });
	        wx.previewImage({
	            current: curImageSrc,
	            urls: imgArray
	        });
	});
        // 转义HTML
		function escapeHtml( ctn ) {
			return ctn.replace(/&/g, '&amp;').replace('|', '■').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/\n/g, '<br>');
		}
		function ahtml( ctn ){
			return ctn.replace(/((https?|s?ftp):\/\/)?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)\b)\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?\b/ig, function(a, b) {
			    return '<a target="_blank" href="' + (b ? '' : 'http://') + a.replace(/&#38;/g, '&') + '">' + a + '</a>'
		    })
		}
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
			  WeixinJSBridge.call('showOptionMenu');
		}); 
		/* 针对导师管理员学员做出的不同判断 */
		window.teacherids="${ course.teacherids }";
		window.holderids = "${ course.holderids }";
		function isStudent(str,obj){
		 	 if(str!=""){
		 		var teachArray = str.split(",");
		 		var i=0,len=teachArray.length,noStudent=false;
		 		for(;i<len;i++){
		 			if ( teachArray[i] == obj){
		 				noStudent=true;
		 				break;
		 			}
		 		}
		 		return noStudent;
	 		 }
		} 
     function loadStore(){
    	 
    	    var getdaturl = "${ctx}/w/chat/msg/json.html?p=${course.id}&pageIndex="+(pageIndex) + "&type=1";
    	    
    	    //console.log( getdaturl )
			$.ajax({
 				type:"post",
 				dataType:"json",
 				url:  getdaturl,
 				error:function(XMLHttpRequest,textStatus,error){},
 				success:function(msg){
 					if( msg != '' && msg != undefined ){
 						var html = "", ouid = "${course.tid}";
 		        	    for( var i = 0 ; i < msg.length ;i ++){
 		        	    	var userid    = "${user.id}"; 
 			 	         	var wid      = parseInt(msg[i].wid);
 			 	         	var isteacher= parseInt(msg[i].isteacher);
 			 	         	var type     = parseInt(msg[i].type); 
 			 	         	var content  = msg[i].content.replace('■', '|'); 
 			 	         	var header   = msg[i].header;
 			 	         	var mp3path  = msg[i].mp3path;
 				         	var mp3time  = msg[i].mp3time;
 				         	var realname = msg[i].nickname;
 				         	var serverid = msg[i].serverid;
 				         	console.log(header);
 			 	         	if( header.indexOf('http') == -1  ){
 			  		        	header = "${ctx}/"+header;
 			  		        }
 			 	          var ls = isStudent(teacherids, wid),
				 			gl = isStudent(holderids, wid);
				         /* 老师或管理员 */
 			 			/* 如果是老师 */
				 	        	var dtHead=null;
				         		/* 如果是管理员 */
				         		if(gl){
				 				 var realname = "主持人",
				 				 header = "http://wimg.keepyoga.com/112670388829777145.jpg";
				 				dtHead='<i>'+realname+'</i>' +
				 				'<img src="'+header+'" ';
				         	
				 			if(type == '0'){
				      			html += '<li class="show1">' +
				      					'<dl class="student" id="teachText">' +
				      					'<dt>' +
				      					dtHead +
				      					'</dt>' +
				      					'<dd>' +
				      					'<span class="triangle-left-student1">&#9670</span>' +
				      					'<span class="triangle-left-student">&#9670</span>' +
				      					'<div></div>' +
				      					'<p class="iscrollPrevent" style="color:#1d93fa;">'+content+'</p>' +
				      					'</dd>' +
				      					'</dl>' +
				      					'</li>';
				      		}else if(type == '1'){
				      			if(content == "0"){
				      				html += '<li class="show1 show2 show2">' +
				 						'<dl class="son" id="teachSon">' +
				 						'<dt>' +
				 						dtHead +
				 						'</dt>' +
				 						'<dd>' +
				 						'<button number="'+btnnum+'"  data-url="'+ serverid +'" data-time="'+mp3time+'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
				 						'<b class="_unread"></b>' +	
				 						'<i class="time">'+mp3time+'"</i>' +
				    						'</dd>' +
				       					'</dl>' +
				       					'</li>';
				          			}else{
				 	         			html += '<li class="show1 show2 show3">' +
				 	         					'<dl class="student teacherAns" id="teachText">' +
				 	         					'<dt>' +
				 	         					dtHead +
				 	         					'</dt>' +
				 	         					'<dd>' +
				 	         					'<span class="triangle-left-student1">&#9670</span>' +
				 	         					'<span class="triangle-left-student">&#9670</span>' +
				 	         					'<div></div>' +
				 	         					'<p>'+content+'</p>' +
				 	         					'<ol></ol>' +
				 	         					'<button number="'+btnnum+'" data-url="'+ serverid +'" data-time="'+mp3time+'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
				 	         					'<b class="_unread"></b>' +
				 	         					'<i class="time">'+mp3time+'"</i>' +
				 	         					'</dd>' +
				 	         					'</dl>' +
				 	         					'</li>';
				          			}
				      			btnnum++;
				      		}else{
				 				html += '<li class="show1">' +
				 					'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
				 					'<dt >' +
				 					dtHead +
				 					'</dt>' +
				 					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
				 					'<img src="'+serverid+'" class="picArray" />' +
				 					'</dd>' +
				 					'</dl>' +
				 					'</li>';
				 			}
				         } else if(ls){
				 					dtHead='<i>'+realname+'</i>' +
				 					'<img src="'+header+'" alt="" class="teachTap" data-num="'+wid+'" >' +
				 					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">'; 	
				 					if(type == '0'){
						      			html += '<li class="show1">' +
						      					'<dl class="student" id="teachText">' +
						      					'<dt>' +
						      					dtHead +
						      					'</dt>' +
						      					'<dd>' +
						      					'<span class="triangle-left-student1">&#9670</span>' +
						      					'<span class="triangle-left-student">&#9670</span>' +
						      					'<div></div>' +
						      					'<p class="iscrollPrevent" style="color:#1d93fa;">'+content+'</p>' +
						      					'</dd>' +
						      					'</dl>' +
						      					'</li>';
						      		}else if(type == '1'){
						      			if(content == "0"){
						      				html += '<li class="show1 show3">' +
						 						'<dl class="son" id="teachSon">' +
						 						'<dt>' +
						 						dtHead +
						 						'</dt>' +
						 						'<dd>' +
						 						'<button number="'+btnnum+'"  data-url="'+ serverid +'" data-time="'+mp3time+'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
						 						'<b class="_unread"></b>' +	
						 						'<i class="time">'+mp3time+'"</i>' +
						    						'</dd>' +
						       					'</dl>' +
						       					'</li>';
						          			}else{
						 	         			html += '<li class="show1 show3">' +
						 	         					'<dl class="student teacherAns" id="teachText">' +
						 	         					'<dt>' +
						 	         					dtHead +
						 	         					'</dt>' +
						 	         					'<dd>' +
						 	         					'<span class="triangle-left-student1">&#9670</span>' +
						 	         					'<span class="triangle-left-student">&#9670</span>' +
						 	         					'<div></div>' +
						 	         					'<p>'+content+'</p>' +
						 	         					'<ol></ol>' +
						 	         					'<button number="'+btnnum+'" data-url="'+ serverid +'" data-time="'+mp3time+'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
						 	         					'<b class="_unread"></b>' +
						 	         					'<i class="time">'+mp3time+'"</i>' +
						 	         					'</dd>' +
						 	         					'</dl>' +
						 	         					'</li>';
						          			}
						      			btnnum++;
						      		}else{
						 				html += '<li class="show1">' +
						 					'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
						 					'<dt >' +
						 					dtHead +
						 					'</dt>' +
						 					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
						 					'<img src="'+serverid+'" class="picArray" />' +
						 					'</dd>' +
						 					'</dl>' +
						 					'</li>';
						 			}
				 			}
				         else{
				 	        	/* 学生 */
				 	        	var ans = '';
				 				ans = '<a href="javascript:answer(\''+realname+'\',\''+content+'\');" class="answer">回复</a>';
				 				html += '<li class="show1">' +
				 					'<dl class="self">' +
				 					ans +
				 					'<dd>' +
				 					'<span class="triangle-left-self1">&#9670</span>' +
				 					'<span class="triangle-left-self">&#9670</span>' +
				 					'<div></div>' +
				 					'<p>'+content+'</p>' +
				 					'</dd>' +
				 					'<dt>' +
				 					'<i>'+realname+'</i>' +
				 					'<img src="'+header+'" class="Gagtit" data-uid="'+wid+'"  onclick="stopUser(this)">' +
				 					'<img src="http://wimg.keepyoga.com/images/Gag.png" alt="" class="Gag">' +
				 					'<span></span>' +
				 					'</dt>' +
				 					'</dl>' +
				 					'</li>';
				         }
 		        	    }
 		        	   	   $("#list").append( html );
					  		 pageIndex ++;
 					}
 				}
			});
        }
     window.sessionStorage.clear();
     var linka = $("<link rel='stylesheet' href='${ctx}/css/mildwinter3.css' id='minldwinter3'>");
        loadStore();
	    $(".showtype").on("click",function(){
	    	if(showtype == 1){
	    		showtype =0;
	    		$(this).find("i").css({
	    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon2.png')",
	    			"background-repeat":"no-repeat"
	    		});
	    		$(this).find("span").html("只看导师");
	    		$("#minldwinter3").remove();
	    		
	    	}else{
	    		showtype =1;
	    		$(this).find("i").css({
	    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon3.png')",
	    			"background-repeat":"no-repeat"
	    		});
	    		$(this).find("span").html("查看全部");
   				$("#link").after(linka);
	    		
	    	}
	   	 	topOrBottom('li:first-child');
	    });
	    /* 语音联播开始 */
		 $('body').one('touchstart',function(){
			 $("#audio111").get(0).src='';
			 $("#audio111").get(0).play();     
	    })
		var base = "http://wimg.keepyoga.com/";
		var playtimer,$playjdom;
		function playMp3( jdom ){ 
			var mp3source =$(jdom).attr("data-url");
			$("#audio111").get(0).src = '';
			$("#audio111").get(0).src= base + mp3source;
			$("button").find("img").attr("src", "${ctx}/images/son.png").css({"width":"1rem"});
			$playjdom = $(jdom);
			$playjdom.next("b").css("visibility","hidden");
			$playjdom.find("img").css({"width":"4.56rem"}).attr("src", "http://wimg.keepyoga.com/loding_002.gif");	
			clearTimeout(playtimer);
			$("#audio111").get(0).pause();
			$("#audio111").get(0).volume=1;
			$("#audio111").get(0).play();
						
			}
			function playstart(){
				var interTime=parseInt($playjdom.attr("data-time"))+2;
				$playjdom.find("img").css({"width":"1rem"}).attr("src", "${ctx}/images/songif.gif");
				playtimer = setTimeout(function(){
					$playjdom.find("img").attr("src", "${ctx}/images/son.png");
						var $b =$playjdom.parents(".show3").nextAll(".show3").eq(0).find("button");
							if($b){
								playNextMp3($b);
							}
							clearTimeout(playtimer);
				},interTime*1000)
			}
			function playNextMp3(btn){
				$("button").find("img").attr("src", "${ctx}/images/son.png");
				$("#audio111").get(0).pause();
				btn.next("b").css("visibility","hidden");
				btn.find("img").css({"width":"4.56rem"}).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
				$playjdom = btn;
				
				var mp3source = btn.attr("data-url");
				$("#audio111").get(0).pause();
				$("#audio111").get(0).src= base + mp3source;
				$("#audio111").get(0).volume=1;
				$("#audio111").get(0).play();
			
			}
			/* 语音联播结束 */
				/* 判断函数，当消息不止一频幕的时候才能goTop or  goBottom */
			$("#goBottom").on("tap",function(){
				// myiscroll.scrollToElement('li:last-child', 400, true);
				 topOrBottomIscroll('li:last-child');
			})
			$("#goTop").on("tap",function(){
				topOrBottomIscroll('li:first-child');
			})
			 /* 进入导师个人主页 */
	    	$("#list").on("tap",".teachTap",function(){
	    		var teachNum = $(this).attr("data-num");
	    		window.location.href="${ctx}/w/faq/person.html?p="+teachNum;
	    	})
    </script>
    <div style="display:hidden" ><audio id="audio111" onplaying="playstart()"><source src="" type="audio/mpeg"></audio></div>
</body>
</html> 
 