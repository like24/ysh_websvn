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
	<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache"> 
	<META HTTP-EQUIV="Expires" CONTENT="0"> 
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${v}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${v}">
	 <link rel="stylesheet" href="${ctx}/css/mildwinter.css?v=${v}" id="link">
	 <script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${v}"></script>
	 <style>
		*{
				-webkit-touch-callout:auto;
				-webkit-user-select:auto;
				-khtml-user-select:auto;
				-moz-user-select:auto;
				-ms-user-select:auto;
				user-select:auto;
		 	}
	 </style>
	 <title>2016瑜伽暖冬行动</title>
	 <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js?v=${v}"></script>
     <script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${v}"></script>
     <script type="text/javascript">
        var nodata = 0;
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
	 <!-- 分享弹框 -->
	  <div id="fxBox">
		 <div class="masking"></div>
		 <div class="fenxiang">
		 	<img src="http://wimg.keepyoga.com/images/zq6.png">;
		 </div>
	</div> 
	<!-- 在线人数 -->
	<!-- <div class="onlineBox" id="onlineBox"><i class="icon"></i><span id="manLen">1001</span>人</div> -->
	<!-- side  button -->
	<div class="sideBtn">
		<span class="icon icon1 " id="goTop"></span>
		<span class="icon icon2" id="goBottom"></span>
	    <span class="icon icon3" onclick="gapall(this)" id="gapall"></span> 
	</div>
	<!-- 页面正在加载提示框 -->
	<div class="stash">
      <span>拼命加载中，请稍候……</span>
    </div>
    <div class="wrapper">
        <header  >
            <p class="title">${course.name }</p>
        </header>
         <!--导师页面 提示点击用户头像可禁言该用户-->
        <p class="teach-remind hide" id="headTit">点击用户头像即可选择禁言该用户</p>
        <!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
        <section class="mainBox" id="mainBox">
            <ul id="list" class="list">
	            	<li class="systemMessages">
					<p><span>系统消息：</span>欢迎各位小伙伴加入第二届随心瑜“瑜伽暖冬计划”，希望导师的精彩课程可以帮到大家。大家拿上小板
                         凳认真听课吧~</p>	
				</li>
	            	<li id="_flg_li" style="display: block;width: 100%;height: 2.5rem;"></li>
            </ul>
        </section>
        <footer>
            <!--导师和管理员-->
            	<div class="ls student" id="lsOrGl">
				<form action="">
					<p class="all sendImage">
						<i></i>
						<span>图片</span>
					</p>
					<p class="share" id="recold">
						<i></i>
						<span>语音</span>
					</p>
					<p class="share tapShare">
							<i></i>
							<span>分享</span>
						</p>
					<div style="" id="tex">
						<div class="tex">
							<input type="text keyuptext" placeholder="在此输入消息"  maxlength="256" id="Itext">
						</div>
						<button id="Enter" type="button" onclick="addComment()">发送</button>
					</div>
					<div class="record" id="longTAP" style="display:none">按住&nbsp;&nbsp;说话</div>
				</form>
			</div>
			<!-- 学生 -->
            	<div class="student gl" id="xs">
	            	<form action="">
						<p class="all showtype">
							<i class=""></i>
							<span class="" id="_showtype">只看导师</span>
						</p>
						<p class="share tapShare">
							<i></i>
							<span>分享</span>
						</p>
						<div class="tex">
							<input type="text keyuptext" class="textPap"  maxlength="256" placeholder="快来提问吧" id="Itext">
						</div>
						<button id="Enter" type="button" onclick="addComment()">发送</button>
					</form>
				</div>
            <!--导师针对学员信息回复语音-->
			<div class="teachAnser" style="display:none">
				<div>
					<h1 class="name"></h1>
					<p class="text"></p>
					<img src="${ctx}/images/close.jpg" style="width:1rem;height:1rem;position:absolute;right:.5rem;top:.5rem;">
					<div class="record" id="longTAP1">按住&nbsp;&nbsp;说话</div>
				</div>
			</div>
        </footer>
    </div>
    <script src="${ctx}/js/zepto.js?v=${v}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${v}"></script>
    <script src="${ctx}/js/iscroll4.js" id="aa"></script>
    <script src="${ctx}/js/fastclick.min.js" id="aa"></script>
    <script>
    /*调用fastclick*/
	FastClick.attach(document.body);
    /* 全员禁言 */
	function gapall( v ){
	    var gapCommand = $(v);
	    if( !isConnection ){
		    	 console.log("gapall:::connection is not online!!!!!")
		    	 return;
	    }  
		if( gapCommand.hasClass("gapall") ){   // 当前禁言状态，恢复开放发言
			sendMsg("gapall|${course.id}|${user.id}|0");
			$(v).removeClass("gapall");
			Modal.tips("<font color='#ccc'>全员解禁成功!</font>","error",2500);
		}else{
			sendMsg("gapall|${course.id}|${user.id}|1");
		    $(v).addClass("gapall");
		    Modal.tips("<font color='#ccc'>全员禁言成功!</font>","error",2500);
		} 
	}
	/* 对单个学员禁言 */
    function stopUser( this_ ){ 
        	var su   = teacherids.split(",");
        	var cuid = "${course.tid}";
        	var uid  = "${user.id}";
        	var inlist = false;
        	for( var s in su ){
        		 if( su[s] == uid ){
        			 inlist = true;
        			 break;
        		 }
        	}
        	$this = $(this_); 
            var wid = $this.attr("data-uid");
            if( inlist ){
            	silence("禁言后不可取消，您确定要对该用户禁言吗？", function () {
            		 /*禁言*/
		         $this.siblings().show(); 
		         $(".self dt img.Gagtit").each(function (inx) {
	                    if ( $(".self dt img.Gagtit").eq(inx).attr("data-uid") == wid) {
	                    		 $(".self dt img.Gagtit").eq(inx).siblings().show();
	             		 }     
	       		 })
		         sendMsg("stopuser|${course.id}|"+wid);
			  }) 
            }
        }
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
				    title: '92位瑜伽行业精英喊你加入随心瑜“瑜伽暖冬行动”', // 分享标题的
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
			$("#audio111").get(0).pause();
			$("#audio111").get(0).volume=1;
			$("#audio111").get(0).play();
		});
		/* 只查看老师  异步获取获取 */
	   function getTeacherMsg(){
	    		$.ajax({
				type:"post",
				dataType:"json",
				url:  "${ctx}/w/chat/msg/json.html?p=${course.id}&pageIndex=1&type=9",
				error:function(XMLHttpRequest,textStatus,error){Modal.tips("<font color='#ccc'>加载失败，请稍后重试！</font>","error",2500);},
				success:function(msg){
					if( msg != '' && msg != undefined ){
						console.log(msg)	;
						var html = "",
							i = 0,
							len = msg.length;
		        	     for( ; i < len ;i ++){
		        	   			//console.log(JSON.stringify(msg[i]))
			 	         	var wid      = parseInt(msg[i].wid);
			 	         	var isteacher= parseInt(msg[i].isteacher);
			 	         	var type     = parseInt(msg[i].type); 
			 	         	var content  = msg[i].content.replace('■', '|'); 
			 	         	var header   = msg[i].header;
			 	         	var mp3path  = msg[i].mp3path;
				         	var mp3time  = msg[i].mp3time;
				         	var realname = msg[i].nickname;
				         	var serverid = msg[i].serverid;
				 	        var ls = isStudent(teacherids, wid);
				         /* 老师或管理员 */
				 	        if(ls){
				 	        	var dtHead=null;
				         		/* 如果是老师 */
				 				dtHead='<i>'+realname+'</i>' +
				 					'<img src="'+header+'" alt="" class="teachTap" data-num="'+wid+'" >' +
				 					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">'; 
				         		/* 老师和管理员的文字发言 */
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
				 	         					'<p >'+content+'</p>' +
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
				 	     		$(".show1").remove();
		        	   	 	    $("#_flg_li").before(html);
		        	   	 	   
					}
				} 
			}
		});
    }
    /*  全局变量    */
	var isConnection = false, // 链接是否有效
	    timer,  // 登陆定时器
	    voice = { localId: '', serverId: '' },
	    isowninitiative = false,  // 是否主动离开 ；
	    RecordTimer,  
	    isReconnection = false, // 是否是用户本人确定了重连 
	    nologin = ${nologin},
	    isAdd = false,
	    tpageIndex = 1,
	    recordid ,
	    mp3Timer ,
	    recordtime = 1 ,
	    realtime = 1,
	    pageSize =10,
	    nowH = 0 ,
	    playingId ,
	    btnnum = 1,
	    playnum = 0,
	    question = "0",
	    showtype = 1, //消息显示模式，0 只看导师  1查看全部
	    managerid = "${course.mamagerid}",
	    isteacher=0,
	    pullDown=null,
	    $heart= new Date().getTime();
		function startrecord() {
	        	interval(60);
	        	wx.startRecord({
			        success: function () {}, 
			        cancel: function () {  }
			    });   
		}
        function pauseVoice(){
	        	wx.pauseVoice({
	        	    localId: recordid.toString() // 需要暂停的音频的本地ID，由stopRecord接口获得
	        	});
        }
        function uploadrecord(){
	        	 clearInterval(mp3Timer);
	        	 pauseVoice();
	        	 wx.uploadVoice({
	 		        localId: recordid.toString(), // 需要上传的音频的本地ID，由stopRecord接口获得
	 		        isShowProgressTips: 1, // 默认为1，显示进度提示
	 		        success: function (res) { 
	 		        	$.post("${ctx}/weixin/uploadweixinmp3.do",{"serverid":res.serverId},function(data){
	 				       sendMsg("talk|"+isteacher+"|${course.id}|${user.id}|1|"+question+"|"+data+"|"+recordtime+"");
		 		            question = "0";
	 		    		});
	 		            $(".teachAnser").hide();
	 		        }
	        	});
        }
        function stoprecord() {  
	        	wx.stopRecord({
	                success: function (res) { 
	                   recordid = res.localId;
	                   uploadrecord();
	                }
	            });
        }
        function cutrecord() {  
	        	wx.stopRecord({
	                success: function (res) { 
	                   recordid = res.localId;
	                }
	            });
        }
        var minusTime=10;
        function interval(time) {
	        	realtime = 1;
	        	mp3Timer = setInterval(function () {
	        		realtime++;
	        		if(realtime>=50){
	        			minusTime--;
	        			$("#maskTime").html(minusTime+"s");
	        			$(".mask").find("img").hide();
	        			$(".mask").find("p").hide();
	        			$("#maskTitle").show();
						$("#maskTime").show();
						if(minusTime<=1){
							clearInterval(mp3Timer);
						}
	        		}
	        		else if ( realtime >= time) {
	        			$(".mask").remove();
	                	 stoprecord();
	                	 clearInterval(mp3Timer);
	                }
	            },1000)
        }
        // 转义HTML
		function escapeHtml( ctn ) {
			return ctn.replace(/&/g, '&amp;').replace('|', '■').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/\n/g, '<br>');
		}
		function ahtml( ctn ){
			return ctn.replace(/((https?|s?ftp):\/\/)?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)\b)\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?\b/ig, function(a, b) {
			    return '<a target="_blank" href="' + (b ? '' : 'http://') + a.replace(/&#38;/g, '&') + '">' + a + '</a>'
		    })
		}
       function downloadVoice( str ) {  
			 wx.downloadVoice({
				    serverId: str.toString(), // 需要下载的音频的服务器端ID，由uploadVoice接口获得
				    isShowProgressTips: 0, // 默认为1，显示进度提示
				    success: function (res) { 
				    	playingId = res.localId;
				    	playVoice(res.localId);
				 }
			 });
	    }
		document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
			  WeixinJSBridge.call('showOptionMenu');
		}); 
	  var keepyoga = {  
	            socket : null,  // WebSocket连接对象  
	            host : '',      // WebSocket连接 url  
	            connect : function() {  // 连接服务器  
	                window.WebSocket = window.WebSocket || window.MozWebSocket;  
	                if (!window.WebSocket) {    // 检测浏览器支持  
	                    Modal.tips("<font color='#ccc'>抱歉，您的浏览器不支持websocket网络通讯</font>","error",2500);
	                    return;  
	                }  
	                this.socket = new WebSocket(this.host); // 创建连接并注册响应函数  
	                this.socket.onopen = function(){
	                	isConnection = true;
	                };  
	                this.socket.onmessage = function(message) {
	                
	                	var commandList = message.data.toString().split("|");
	                	
	                	if( message.data != ''  ){
	                		if( commandList[0] == 'login'){ // 登陆成功 
	                			if( commandList[5] == 1 ){
	                				$(".sideBtn .icon3").addClass("gapall");
	                				Modal.tips("<font color='#ccc'>当前聊天室开启全员禁言!</font>","error",2500,function(){
	            						$(".textPap").attr(
	            							"readonly",true
	            						);
	            						$(".textPap").attr('placeholder','导师正在讲课，全员禁言中');
	            					});
	                			}
	                				$("#onlineBox").show();
	                		}else if(commandList[0] == 'heart'){
	                			$heart=new Date().getTime();
	                		}else if( commandList[0] == 'talk'){  // 聊天消息送达
		            			talk( commandList );
		            		}else if( commandList[0] == 'getmsg'){
		            			getmsg( commandList );
		            		}else if( commandList[0] == 'gapall' ){
		            			if( ${course.id} == commandList[1] && commandList[2] =='notice' ){
		            				
		            				if( commandList[3] == '0' ){ // 解禁
		            					Modal.tips("<font color='#ccc'>当前聊天室关闭全员禁言!</font>","success",2500,function(){
		            						$(".textPap").removeAttr("readonly");
		            						$(".textPap").attr('placeholder','在此输入消息');
		            					});
		            				}else{ // 禁言
		            					Modal.tips("<font color='#ccc'>当前聊天室开启全员禁言!</font>","error",2500,function(){
		            						$(".textPap").attr(
		            							"readonly",true
		            						);
		            						$(".textPap").attr('placeholder','导师正在讲课，全员禁言中');
		            					});
		            				}
		            			}
		            		}else if( commandList[0] == 'stopuser'){
		            			// todo
		            		}else if( commandList[0] == 'closerooms' ){
		            			if( ${course.id} == commandList[1] ){
			            			Modal.tips("<font color='#ccc'>当前聊天室被关闭了!</font>","error",2500,function(){
			            				 window.location.href="${ctx}/w/find/index.html?p=1";
			            			});
		            			}
		            		}else if( commandList[0] == 'roomusers'){
		            		}
	                		} 
	                };  
	                this.socket.onclose = function(){  
	                    windowClose();
	                };  
	            },  
	            send : function(message) {  // 发送消息方法  
	                if (this.socket && isConnection ) {  
	                    this.socket.send(message);  
	                    return true;  
	                }  
	                console.log('please connect to the server first !!!');  
	                return false;  
	            }  
	    }; 
	    // 初始化WebSocket连接 url  
	    keepyoga.host=(window.location.protocol == 'http:') ? 'ws://' : 'wss://' ;  
	    keepyoga.host += '${socketaddress}';
	    //keepyoga.host +=   '127.0.0.1:3001';
	    function sendMsg( message ){
	    	//alert( message )
	        if (!message) return;  
	        if (!keepyoga.send(message)) return;  
	    }
	    function reConnection(){
			 Modal.confirm( "网络连接已断开，是否重连？", function(){
		    	 keepyoga.connect();  
		     	 // 发送进入命令
		     	 var timer2=setInterval(function(){   // 等待1秒钟在进行命令发送
		     		if( isConnection ){ 
		     		   sendMsg("logout|${course.id}|${user.id}");
		     		   sendMsg("login|${course.id}|${user.id}");
			           sendMsg("getmsg|${course.id}|1|"+pageSize);
		     		   clearInterval(timer2);
		     		}
		         },1000);
			 });
		}
//	    setInterval(function  ({
//	    		if(new Date().getTime()-$heart >=20000){
//	    			console.log("20秒自动重连！")
//	    			//reConnection();
//	    		}
//	    },20000))
	    function getmsg( command ){
		    	if(command[1]!=${course.id}){
		    		return;
		    	}
	      	 var msglist = command[2];
	    	 		console.log(command)
	         if( msglist.length == 1 ){ // 暂无数据了
	        		 return ;
	         }
	         if( isReconnection ){ // 如果是重连，清空里面的内容
	        		 $("#list").html("<li></li>"); 
	         }
	         var results;
	         if( msglist.length > 5 ){
	        	    results =  jQuery.parseJSON( msglist );
	        	    var html = "", ouid = "${course.tid}";
        	   	 	var userid    = "${user.id}"; 
	        	    for( var i = 0 ; i < results.length ;i ++){
		 	         	var wid      = parseInt(results[i].wid);
		 	         	var isteacher= parseInt(results[i].isteacher);
		 	         	var type     = parseInt(results[i].type); 
		 	         	var content  = results[i].content.replace('■', '|'); 
		 	         	var header   = results[i].header;
		 	         	var serverid= results[i].serviceid;
			         	var mp3time  = results[i].mp3time;
			         	var realname = results[i].nickname;
		 	         	if( header.indexOf('http') == -1  ){
		  		        		header = "${ctx}/"+header;
		  		        }
		 		        var ls = isStudent(teacherids, wid),
		 				gl = isStudent(holderids, wid);
		 	        /* 老师或管理员 */
		 		        if(ls||gl){
		 		        	var dtHead=null;
		 	        		/* 如果是管理员 */
		 	        		if(gl){
		 					 var realname = "主持人",
		 					 header = "http://wimg.keepyoga.com/112670388829777145.jpg";
		 					dtHead='<i>'+realname+'</i>' +
		 					'<img src="'+header+'" alt="">';
		 	        		}
		 	        		/* 如果是老师 */
		 				if(ls){
		 					dtHead='<i>'+realname+'</i>' +
		 					'<img src="'+header+'" alt="" class="teachTap" data-num="'+wid+'" >' +
		 						'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">';
		 				}
		 	        		/* 老师和管理员的文字发言 */
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
		 		         			html += '<li class="show1">' +
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
		 						'<img src="'+serverid+'" class="picArray"/>' +
		 						'</dd>' +
		 						'</dl>' +
		 						'</li>';
		 				}
		 	        } 
		 	        else{
		 		        	/* 学生 */
		 		        	var ans = '';
		 					ans='<i class="answer" onclick="answer(\''+realname+'\',\''+content+'\')">回复</i>';
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
	        	    if(tpageIndex == 1){
		        	    $("#_flg_li").before(html);
	        	    }else{
	        	   		$("#list li").eq(0).after(html);
	        	    }
	        	 	
	         }
	         
	    }
	    function talk( message ){
	    		console.log( message );
	        if( message.length  == 4 && ${course.id} == message[2] ){
	        	  if( message[3]  == 'stop' ){
		  	        	Modal.tips("<font color='#ccc'>您已经被限制性发言!</font>","error",2500);
		  	        	return ;
	  	       }
	        	  if( message[3]  == 'gapall'  ){
		  	        	Modal.tips("<font color='#ccc'>当前聊天室已被禁言！</font>","error",2500);
		  	        	return ;
		  	      }
	        	  if( message[3]  == 'system' ){
		  	        	Modal.tips("<font color='#ccc'>当前聊天室不存在！</font>","error",2500);
		  	        	return ;
		  	      }
	        	  if( message[3]  == 'nologin' ){
		  	        	Modal.tips("<font color='#ccc'>您未登录，请重新登录！</font>","error",2500,function(){
		  	        		window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		  	        	});
		  	        	return ;
		  	      }
	        }
	   	 	var userid    = "${user.id}";
	        var isteacher = message[1];
	        var roomid = message[2];
	        	if(${course.id} != roomid){
	        		return;
	        	}
	        var wid    = message[3];
	        var type   = message[4];
	        var content= message[5].replace('■', '|');
	        var serverid = message[6];
	        var mp3time  = message[7];
	        var realname = message[8];
	        var header   = message[9];
	        if( header.indexOf('http') == -1 ){
	        		header = "${ctx}/"+header;
	        } 
	        var html = "";
	        var ls = isStudent(teacherids, wid),
			gl = isStudent(holderids, wid);
        /* 老师或管理员 */
	        if(ls||gl){
	        	var dtHead=null;
        		/* 如果是管理员 */
        		if(gl){
				 var realname = "主持人",
				 header = "http://wimg.keepyoga.com/112670388829777145.jpg";
				dtHead='<i>'+realname+'</i>' +
				'<img src="'+header+'" alt="">';
        		}
        		/* 如果是老师 */
			if(ls){
				dtHead='<i>'+realname+'</i>' +
				'<img src="'+header+'" alt="" class="teachTap" data-num="'+wid+'" >' +
					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">';
				
			}
        		/* 老师和管理员的文字发言 */
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
					'<img src="'+serverid+'" class="picArray"/>' +
					'</dd>' +
					'</dl>' +
					'</li>';
			}
        } 
        else{
	        	/* 学生 */
	        	var ans = '';
				/* ans = '<a href="javascript:answer(\''+realname+'\',\''+content+'\');" class="answer">回复</a>'; */
				ans='<i class="answer" onclick="answer(\''+realname+'\',\''+content+'\')">回复</i>';
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
	        	$("#_flg_li").before(html);
	       			 topOrBottom('li:last-child');
	    }
	    
	    
	    
	    function addComment(){
		    	if( !isConnection ){  // 网络端口的情况
		    		reConnection();
		    		return;
		    	}
		    	if( nologin ) {   
		      		window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		      	}else{
					if( isAdd ) {
						Modal.tips("<font color='#ccc'>您的发送过于频繁，请稍后再进行发送!</font>","error",2500);
			        		return;
					}
					else if( $("#Itext").val() == '' ){
				        	Modal.tips("<font color='#ccc'>写点什么吧!</font>","error",2500);
				        	return ;
			        }  
			        var content = ahtml(escapeHtml($("#Itext").val()));
			        sendMsg("talk|"+isteacher+"|${course.id}|${user.id}|0|"+content+"|0|0");
			        $("#Itext").val(""); 
			        $("#Enter").css({"background-color":"#9c9c9c"});
			        if(!isStu){
					    	isAdd = true;
					    	brush_frequency(5000);	        	
			        }
		      	}
	    }
	    function windowClose(){
	    	//alert("windowClose");
		    	if ( keepyoga.socket && !nologin ){
		    		 sendMsg("logout|${course.id}|${user.id}");
		    		 isConnection = false;
		     		 keepyoga.socket.close();  
		    	}
	    }
	    
	    function fclose(){  // 页面关闭，朝服务器发送离开命令
	    	//alert("fclose");
	    	if( isConnection ){ 
	    	    sendMsg("logout|${course.id}|${user.id}");
	    	    isConnection = false;
	    		keepyoga.socket.close();  
	    	}
	    }
       if( !nologin ){
		  if (!keepyoga.socket) {
			   keepyoga.connect();  
			   timer=setInterval(function(){  // 等待1秒钟在进行命令发送
			      if( isConnection ){
			    		  sendMsg("logout|${course.id}|${user.id}");
			    	      sendMsg("login|${course.id}|${user.id}");
				      sendMsg("getmsg|${course.id}|1|"+pageSize); 			    		  
			    	  	  clearInterval(timer);
			      }
			   },1000);
		  }else 
			   console.log('websocket already exists .');  
	  }
	  if( nologin) {   
		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
      }
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
				$("#audio111").get(0).pause();
				$("#audio111").get(0).volume=1;
				$("#audio111").get(0).play();	
				clearTimeout(playtimer);
		}
		function playstart(){
			var interTime=parseInt($playjdom.attr("data-time"))+2;
			$playjdom.find("img").css({"width":"1rem"}).attr("src", "${ctx}/images/songif.gif");
			playtimer = setTimeout(function(){
				$playjdom.find("img").attr("src", "${ctx}/images/son.png");
					var $b =$playjdom.parents(".show3").nextAll(".show3").eq(0).find("button");
						if($b.length){
							playNextMp3($b);
							return;
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
	window.onload = function () {
		/* loading */
		$(".stash").css("display","none");
		var isTeach=isStudent(teacherids,"${ user.id }"),
			isHolder=isStudent(holderids,"${ user.id }");
			window.isStudent = isStudent;
		if(isTeach || isHolder) {
			isStu=true;
			isteacher=1;
			$("#headTit").show();
			$("#mainBox").addClass("noteach");
			$("#gapall").css("display","block");
			$("#onlineBox").addClass("onlineBox1");
			/* 底部消息区域显示 */
			$("#lsOrGl").show();
			$("#xs").remove();
			if(isTeach){
				var link1=$("<link rel='stylesheet' href='${ctx}/css/mildwinter1.css'/>");
				$("#link").after(link1);
			}
		}else{
			isStu=false;
			/* 底部消息区域显示 */
			$("#xs").show();
			$("#lsOrGl").remove();
		}
		/*输入框有内容，按钮变色*/
		 $("#Itext").on("keyup", function () {
			 if ($("#Itext").val().length != 0) {
	             $("#Enter").css("background", "#1d92fb");
	         } else {
	             $("#Enter").css("background", "#9c9c9c");
	         }   
		  }); 
		 /* 点击去顶部或底部 */
		$("#goBottom").on("tap",function(){
				// myiscroll.scrollToElement('li:last-child', 400, true);
				 topOrBottom('li:last-child');
			})
			$("#goTop").on("tap",function(){
				 topOrBottom('li:first-child');
			})
			$("footer").on("tap",function(){
				  topOrBottom('li:last-child');
			})
			$("#Itext").on("focus",function(){
				  topOrBottom('li:last-child');
			})
			$("footer").on("tap",function(){
        	  		 topOrBottom('li:last-child')
        		})
			/* share弹框 */
		    $(".tapShare").on("tap",function(){
			   $("#fxBox").show();
		    })
		    $("#fxBox").on("tap",function(){
			   $("#fxBox").hide();
		   })
		   	/*语音文字切换开始*/
			$("#recold").on('tap', function () {
				if (!$(this).hasClass("YES")) {
					$("#tex").hide();
					$("#longTAP").show();
					$(this).find("span").html("文字");
					$(this).find("i").addClass("wz");
					$(this).addClass("YES");
				} else {
					$("#tex").show();
					$("#longTAP").hide();
					$(this).find("span").html("语音");
					$(this).find("i").removeClass("wz");
					$(this).removeClass("YES");
				}								
			})
			/* 点击关闭按钮  关闭 老师针对学员回复区域 */
	       $(".teachAnser img").on("tap",function(){
        	 		$(".teachAnser").hide();
        	   })
	}
	/* 判断函数，当消息不止一频幕的时候才能goTop or  goBottom */
		function topOrBottom(str){
			var bodyH = $("#mainBox").height(),
				ulH = $("#list").height();
				if( ulH > bodyH ){
					 myiscroll.scrollToElement(str, 400, true);
				}
		}
        /*弹框*/
		function dialog1() {
			var maskDiv = $("<div class='mask'>");
			$("<img src='${ctx}/images/wx_recold.gif'>").appendTo(maskDiv);
			$("<p>松开手指，发送消息</p>").appendTo(maskDiv);
			$("<h4 id='maskTitle'>请您在<b id='maskTime'>10</b><span id='recoldOver'>内松手发送！！！</span></h4>").appendTo(maskDiv);
		
			/* $("<b id='maskTime'>10</b>").appendTo(maskDiv); */
			maskDiv.appendTo($(".wrapper"));
		}
        /*调用tips*/
        function silence(title, gag) {
            dialog({
                wrapper: ".wrapper",
                id: "noshop",
                close: true,
                title1: title,
                bodytap: true,
                btnleft: "确定",
                btnright: "取消",
                mask: true,
                goumai: function () {
                    /*确定禁言*/
                    gag();
                    $("#noshop").remove();
                    $(".masking").remove();
                },
                shikan: function () {
                    /*取消*/
                    $("#noshop").remove();
                    $(".masking").remove();
                }
            })
        }
        /*禁止刷频*/
        function brush_frequency(time) {
            setTimeout(function () {
          	  isAdd = false;
            }, time)
        } 
        /*聊天系统开始*/
           pullDown=function() {
	  		tpageIndex = tpageIndex + 1;
	  		sendMsg("getmsg|${course.id}|"+tpageIndex+"|"+pageSize); 
	      	clearInterval(timer);
         }
        var Sucess = false;
        function loaded() {
            myiscroll = new iScroll("mainBox", {
           	 	preventDefault: false,
                useTransition: false,
                vScrollbar: false,
                checkDOMChanges: true,
                onBeforeScrollStart:function(e){
                	console.log(e.target.tagName);
                	if(e.target.className!="iscrollPrevent"||e.target.tagName!="BUTTON"){
                		e.preventDefault();
                	}
                },
                onScrollMove: function () {
                    if (myiscroll.y >= 30) {
                        Sucess = true;
                    } else {
                        Sucess = false;
                    }
                },
                onScrollEnd: function () {
                    if (Sucess) {
                        pullDown();
                        $("#mainBox").addClass("p_t20")
                    }
                }
            })
        }
        document.addEventListener('touchmove', function (e) {
            e.preventDefault();
        }, false);
        document.addEventListener('DOMContentLoaded', loaded, false);
    
        /*聊天系统结束*/
         /*导师录音开始*/
        $.fn.longPress = function (record, stopRecord, Enterfn) {
                var nowTime = null,
                    timeout = null,
                    longtap = false;
                /*手指按下*/
                $(this)[0].addEventListener('touchstart', function (event) {
                	wx.checkJsApi({
                	    jsApiList: ['startRecord'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
                	    success: function(res) {
                	       console.log("success");
                	    },error:function(res){
                	    	Modal.tips("<font color='#ccc'>res！</font>","error",2500)
                	    }
                	});
                    $(this).html("松开&nbsp;&nbsp;结束");
                    $(this).css("background", "#e8e8e8");
                    timeout = setTimeout(function () {
                        longtap = true;
                        record();
                        nowTime = new Date().getTime();
                    }, 300);
                    event.preventDefault();
                    
                }, false);
                /*手指松开*/
                $(this)[0].addEventListener('touchend', function (event) {
	                	recordtime = realtime;
	                	realtime = 1;
	                    if (longtap) {
		                	clearInterval(mp3Timer);
	                        if (new Date().getTime() - nowTime >= 3000) {
	                            $(".mask").remove();
	                            Enterfn();
	                        } else if (new Date().getTime() - nowTime < 3000) {
	                        	cutrecord();
	                            $(".mask").find("img").attr("src", "${ctx}/images/no_son.png");
	                            $(".mask").find("img").addClass("short-time");
	                            $(".mask").find("p").html("录音时间太短！");
	                            setTimeout(function () {
	                                $(".mask").remove();
	                            }, 500);
	                        }else{
	                        	$(".mask").remove();
	                        }
	                    }
	                    $(this).html("按住&nbsp;&nbsp;说话");
	                    $(this).css("background", "white");
	                    clearTimeout(timeout);
	                    longtap = false;
	                    event.preventDefault();
                }, false);
            }
        /* 导师录音功能结束 */
        /* 长按录音开始 */
        function longTap (str) {
       	        	if ($(str).length) {
       	            $(str).longPress(
       	                function () {
       	                		dialog1();
                               console.log("开始录音");
                               startrecord();   
       	                },
       	                function () {
                           },
                           function () {
                               console.log("发送语音");
                               stoprecord();
                           }    
       	             )
       	         }
               }
               longTap("#longTAP");
               longTap("#longTAP1");
               /* 长按录音结束 */       
               /* 点击切花只看导师开始 */
                $(".showtype").on("click",function(){
				    	 if( nologin ) {   
				        	 window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
				      };
			    		 tpageIndex = 1;
				    	if(showtype == 0){
				    		showtype =1;
				    		$(this).find("i").css({
				    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon3.png')",
				    			"background-repeat":"no-repeat"
				    		});
				    		$(this).find("span").html("只看导师");
				    		$("#list").find(".show1").remove();
				    		sendMsg("getmsg|${course.id}|1|"+pageSize); 			    		  
					    	clearInterval(timer);
					    	 pullDown=function() {
					 	  		tpageIndex = tpageIndex + 1;
					 	  		sendMsg("getmsg|${course.id}|"+tpageIndex+"|"+pageSize); 
					 	      	clearInterval(timer);
					          };
				    	}else{
				    		pullDown=function() {};
				    		showtype =0;
				    		$(this).find("i").css({
				    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon2.png')",
				    			"background-repeat":"no-repeat"
				    		});
				    		$(this).find("span").html("查看全部");
				    		getTeacherMsg();
				    	}
				    	
			});
            	/*点击回复显示*/
    			function answer(name,content) {
    				question = content;
    				$(".text").html(content);
    				$(".name").html("回复"+name+":");
    				$(".teachAnser").show();
    			}
    		 	/* 发送图片相关逻辑 */
    			$(".sendImage").on("click",function(){
    				choseImages();
    			});
    		    function choseImages(){
    				wx.chooseImage({
    				    count: 1, // 默认9
    				    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
    				    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
    				    success: function (res) {
    				        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
    				        uploadmage(localIds);
    				    }
    				});
    			}
    		    function uploadmage(localid){
    				wx.uploadImage({
    				    localId: localid.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
    				    isShowProgressTips: 1, // 默认为1，显示进度提示
    				    success: function (res) {
    				        var serverId = res.serverId; // 返回图片的服务器端ID
    				        uploadToCDN(serverId);
    				    }
    				});		
    			}      
    		    function uploadToCDN(serverid){
			    	$.post("${ctx}/weixin/uploadweixinimage.do",{"serverid":serverid},function(data){
					   sendMsg("talk|"+isteacher+"|${course.id}|${user.id}|2|"+question+"|"+data+"|"+recordtime);
			    	});
		    }	  
    		    function downloadImage(serverid){
    			    wx.downloadImage({
    			        serverId: serverid.toString(), // 需要下载的图片的服务器端ID，由uploadImage接口获得
    			        isShowProgressTips: 1, // 默认为1，显示进度提示
    			        success: function (res) {
    			            var localId = res.localId; // 返回图片下载后的本地ID
    			            alert(JSON.stringify(res))
    			        }
    			    });	    	
    		    }
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
     /* 进入导师个人主页 */
    	$("#list").on("tap",".teachTap",function(){
    		var teachNum = $(this).attr("data-num");
    		window.location.href="${ctx}/w/faq/person.html?p="+teachNum;
    	})
    $("#Itext").on("keydown",function(e){
    	if(e.keyCode==13){
    		addComment();
    		e.preventDefault();
    	}
    })
    </script>
    <script src="${ctx}/js/wblog.js?v=${v}"></script>
   
    <div style="display:hidden" ><audio id="audio111" preload autoplay onplaying="playstart()" ><source src="" type="audio/mp3"></audio></div>
</body>
</html> 
 