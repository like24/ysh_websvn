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
	<link rel="stylesheet" href="${ctx}/css/tlq.css?v=${v}" id='linkId'>
	<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${v}"></script>
	<title>${course.name }</title>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js?v=${v}"></script>
	<script>
   		 /* 判断是不是安卓 */
    	 var u = navigator.userAgent;
    	 var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
    		 if(isAndroid){
    			var linkDom=$("<link rel='stylesheet' href='${ctx}/css/tlq1.css'>");
    			$("#linkId").after($(linkDom));
    		 }
    </script>
    <script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${v}"></script>
    <script type="text/javascript">
        var nodata = 0;
    </script>
    <style>
	    
    </style>
</head>
 <body>
	 <!-- 分享弹框 -->
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
        <span id="video_play"></span>
        <header  >           
             <div class="audio_video" style="background:url(${ocourse.icon});background-size:100%;">
              <c:if test="${ocourse.ctype == 0}">
				      <audio id="audio" class="video-audio" ><source src="${ocourse.realfilepath}" ></audio>
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
					    <video src="${ocourse.realfilepath}" height="200" id="audio" controls style="background:url(${ocourse.icon});background-size:100%;"></video>
				 </c:if>
				 <c:if test="${ isbuy == false }">
  			        <div class="audioMask" id="audioMask"></div>
			     </c:if>
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
        <p class="teach-remind"  <c:if test="${user.id != course.tid}">style="display:none"</c:if> >点击用户头像即可选择禁言该用户</p>
        <!--导师页面才有提醒-->
        
        <!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
        <section class="mainBox <c:if test="${user.id != course.tid}">main2</c:if> " id="mainBox">
            <ul id="list" class="list">
            	<li class="systemMessages">
					<p><span>系统消息：</span>欢迎宝宝们回家！导师在“随心瑜Live”社区进行互动问答（20：00-21：00），大家可提出与课程相关的问题，老师精选代表性问题进行解答。</p>
					<p>想让名师指路吗？点击页底输入框，快来提问吧，导师在等你！</p>
				</li>
            	<li id="_flg_li" style="display: block;width: 100%;height: 2.5rem;"></li>
            </ul>
        </section>
        <footer>
            <!--导师消息栏开始-->
            <c:if test="${course.tid == user.id}">
            	<div class="ls student">
				<form action="">
					<p class="all sendImage">
						<i></i>
						<span>图片</span>
					</p>
					<p class="share" id="recold">
						<i></i>
						<span>语音</span>
					</p>
					<div style="" id="tex">
						<div class="tex">
							<input type="text" placeholder="在此输入消息"  maxlength="256" id="Itext">
						</div>
						<button id="Enter" type="button" onclick="addComment()">发送</button>
					</div>
					<div class="record" id="longTAP" style="display:none">按住&nbsp;&nbsp;说话</div>
				</form>
			</div>
            </c:if>
            
            <c:if test="${course.tid != user.id}">
            	<div class="student gl">
	            	<form action="">
						<p class="all showtype">
							<i class=""></i>
							<span class="" id="_showtype">只看导师</span>
						</p>
						<c:if test="${course.mamagerid == user.id}">
							<p class="all sendImage">
								<i ></i>
								<span>图片</span>
							</p>
						</c:if>
						<p class="share tapShare">
							<i></i>
							<span>分享</span>
						</p>
	
						<div class="tex">
							<input type="text"   maxlength="256" placeholder="快来提问吧" id="Itext">
						</div>
						<button id="Enter" type="button" onclick="addComment()">发送</button>
					</form>
				</div>
            </c:if>
            
            
            
            <!--导师针对学员信息回复语音-->
			<div class="teachAnser" style="display:none">
				<div>
					<h1 class="name"></h1>
					<p class="text"></p>
					<img src="${ctx}/images/close.jpg" style="width:1rem;height:1rem;position:absolute;right:.5rem;top:.5rem;">
					<div class="record" id="longTAP1">按住&nbsp;&nbsp;说话</div>
				</div>
			</div>
            <!--馆主消息栏结束-->
        </footer>
    </div>
    <script src="${ctx}/js/zepto.js?v=${v}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${v}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${v}"></script>
    <script>
    
    if("${empty ocourse}" == "true"){
    	    $(".audio_video").hide();
			$("#mainBox").addClass("main1");
			$("#arrow_up").hide();
			$(".teach-remind").addClass("teach-remind1");
			var teachId=${course.tid};
			if( teachId ){
				$("section").css("top","5.5rem");
			}
    }
    
   function getTeacherMsg(){
    	$.ajax({
				type:"post",
				dataType:"json",
				url:  "${ctx}/w/chat/msg/json.html?p=${course.id}&pageIndex=1&type=9",
				error:function(XMLHttpRequest,textStatus,error){},
				success:function(msg){
					if( msg != '' && msg != undefined ){
						var html = "";
		        	    for( var i = 0 ; i < msg.length ;i ++){
		        	    	console.log(JSON.stringify(msg[i]))
			 	         	var wid      = parseInt(msg[i].wid);
			 	         	var isteacher= parseInt(msg[i].isteacher);
			 	         	var type     = parseInt(msg[i].type); 
			 	         	var content  = msg[i].content.replace('■', '|'); 
			 	         	var header   = msg[i].header;
			 	         	var mp3path  = msg[i].mp3path;
				         	var mp3time  = msg[i].mp3time;
				         	var realname = msg[i].realname;
				         	var serverid = msg[i].serverid;
				         	if(type == '0'){
		 	         			html += '<li class="show1">' +
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
		 	         					'<p style="color:#1d93fa;">'+content+'</p>' +
		 	         					'</dd>' +
		 	         					'</dl>' +
		 	         					'</li>';
		 	         		}else if(type == '1'){
		 	         			if(content == "0"){
		 	         				html += '<li class="show1">' +
		 	   								'<dl class="son" id="teachSon">' +
		 	   								'<dt>' +
		 	   							'<i>'+realname+'</i>' +
		 	   							'<a href="javascript:;"><img src="'+header+'" alt=""><img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead"></a>' +
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
			 	         					'<button number="'+btnnum+'"  data-url="'+ serverid +'" data-time="'+mp3time+'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
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
 	         					'<i>'+realname+'</i>' +
 	         					'<img src="'+header+'" alt="">' +
 	         					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
 	         					'</dt>' +
 	         					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
 	         					'<img src="'+serverid+'"/>' +
 	         					'</dd>' +
 	         					'</dl>' +
 	         					'</li>';
		 	         		}
				         	
		        	    }
		        	  
		        	    $("#_flg_li").before(html);
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
	    isteacher = "${user.id == course.tid ? 1 : 0}";
/* 	    if(isteacher == "1"){
	    	showtype = 1;
	    } */
	    
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
		var title = "今晚资深瑜伽导师${teacher.nickname} ，免费陪你1小时";
		var imgurl = "${teacher.file_path}";
		wx.hideMenuItems({
			menuList: ["menuItem:copyUrl"] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
		});

		wx.onMenuShareAppMessage({
		    title: title, // 分享标题
		    desc: '瑜伽私教【互动答疑直播间】正在进行中...', // 分享描述
		    link: linka, // 分享链接
		    imgUrl: imgurl, // 分享图标
		    type: '', // 分享类型,music、video或link，不填默认为link
		    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
		    success: function () { 
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
		wx.onMenuShareTimeline({
			 title: title, // 分享标题
			 desc: '瑜伽私教【互动答疑直播间】正在进行中...', // 分享描述
			 link: linka, // 分享链接
			 imgUrl: imgurl, // 分享图标
		     success: function () { 
		    },
		    cancel: function () { 
		        // 用户取消分享后执行的回调函数
		    }
		});
	});
	
        
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
 				       sendMsg("talk|"+isteacher+"|${course.id}|${user.id}|1|"+question+"|"+data+"|"+recordtime+"|${user.realname}");
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
	    
        function interval(time) {
        	realtime = 1;
        	mp3Timer = setInterval(function () {
        		realtime++;
                if ( realtime >= time) {
                	 stoprecord();
                	 clearInterval(mp3Timer);
                }
            },1000)
        }
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
        $("footer").on("tap",function(){
        	   myiscroll.scrollToElement('li:last-child', 400, true);
        })
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

        /*禁言逻辑*/
        /*定义一个变量检查该用户是否已禁烟*/

     
        

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
        /*语音播放开始*/
        function buttionClick( this_ ) { 
	      	    if( nologin ) {  
	      		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	      	    }else{
	               	wx.stopVoice({
	               	    localId: playingId
	               	});
	               	if(playnum == $(this_).attr("number")){
	                    $(this_).find("img").attr("src", "${ctx}/images/son.png");
	                    playnum = 0;
	               	}else{
		               	$(this_).next("._unread").css("visibility","hidden").attr("played","1");
		               	playnum = $(this_).attr("number");
	                	$("button").find("img").attr("src", "${ctx}/images/son.png");
	                	$(this_).find("img").attr("src", "${ctx}/images/songif.gif");
	                    downloadVoice($(this_).attr("data-url")); 
	               	}
	      	    }
              
        }
        
        function buttionPlay( this_ ) {
            if(this_.next("._unread").has("attr[played='1']")){
	           	this_.next("._unread").css("visibility","hidden");
	           	playnum = this_.attr("number");
	           	$("button").find("img").attr("src", "${ctx}/images/son.png");
	           	this_.find("img").attr("src", "${ctx}/images/songif.gif");
	            downloadVoice(this_.attr("data-url"));           		            	
            }
    	}
        
        function stopUser( this_ ){ 
        	var su   = "${sulist}".split(",");
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
			              sendMsg("stopuser|${course.id}|"+wid);
			              $(".student dt img.pic").each(function (inx) {
			                    if ($(".student dt img.pic").eq(inx).attr("data-uid") == wid) {
			                        $(".student dt img.pic").eq(inx).siblings().show();
			              }
			        })
			    }) 
			    return;
            }
        	if( cuid != uid ){
        		return;
        	}
        	if( wid == uid ){
        		return;
        	}
		    silence("禁言后不可取消，您确定要对该用户禁言吗？", function () {
		              /*禁言*/
		              $this.siblings().show(); 
		              sendMsg("stopuser|${course.id}|"+wid);
		              $(".student dt img.pic").each(function (inx) {
		                    if ($(".student dt img.pic").eq(inx).attr("data-uid") == wid) {
		                        $(".student dt img.pic").eq(inx).siblings().show();
		              }
		        })
		    }) 
        }
        $(".teachAnser img").on("tap",function(){
        	 $(".teachAnser").hide();
        })
        
        function playVoice( playlocalid ){
        	wx.playVoice({
        	    localId: playlocalid.toString() // 需要播放的音频的本地ID，由stopRecord接口获得
        	});
        	wx.onVoicePlayEnd({
        	    success: function (playlocalid) {
        	        var localId = playlocalid; // 返回音频的本地ID
        	        $("button").find("img").attr("src", "${ctx}/images/son.png");
        	        gifTrue = true;
        	        var num = parseInt(playnum) + 1;
        	        var b = $("button[number='"+num+"']")
        	        buttionPlay(b);
        	    }
        	});
        }
      function buyBoxHide(){
    	  $(".buyTipBox").hide();
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
         
         
        /*语音文字切换开始*/
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
        /*导师录音开始*/
        $.fn.longPress = function (record, stopRecord, Enterfn) {
                var nowTime = null,
                    timeout = null,
                    longtap = false;
                /*手指按下*/
                $(this)[0].addEventListener('touchstart', function (event) {
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
                        if (new Date().getTime() - nowTime >= 500) {
                            $(".mask").remove();
                            Enterfn();
                        } else if (new Date().getTime() - nowTime < 500) {
                        	cutrecord();
                            $(".mask").find("img").attr("src", "${ctx}/images/no_son.png");
                            $(".mask").find("img").addClass("short-time");
                            $(".mask").find("p").html("录音时间太短！");
                            setTimeout(function () {
                                $(".mask").remove();
                            }, 500);
                        }
                    }
                    $(this).html("按住&nbsp;&nbsp;说话");
                    $(this).css("background", "white");
                    clearTimeout(timeout);
                    event.preventDefault();
                }, false);
            }
            /*调用语音功能*/
        if ($("#longTAP").length) {
            $('#longTAP').longPress(
                function () {
                    dialog1();
                    console.log("开始录音");
                    startrecord();
                    /*录音逻辑*/
                },
                function () {
                },
                function () {
                    /*发送语音*/
                    console.log("发送语音");
                    stoprecord();
                }
            )
        }
            
        if ($("#longTAP1").length) {
            $('#longTAP1').longPress(
                function () {
                    dialog1();
                    console.log("开始录音");
                    startrecord();
                    /*录音逻辑*/
                },
                function () {
                },
                function () {
                    /*发送语音*/
                    console.log("发送语音");
                    stoprecord();
                }
            )
        }

        /*弹框*/
        function dialog1() {
            var maskDiv = $("<div class='mask'>");
            $("<img src='${ctx}/images/wx_recold.gif'>").appendTo(maskDiv);
            $("<p>松开手指，发送消息</p>").appendTo(maskDiv);
            maskDiv.appendTo($(".wrapper"));
        }

        /*导师录音结束*/
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
		 $(".teachAnser").hide();
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
	   $("#tex").focus(function () {
		   $(".audio_video").slideUp(400, function() {
			   $("#mainBox").addClass("main1");
				$("#arrow_up").addClass("UP");
				$(".teach-remind").addClass("teach-remind1");
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
		
		/*点击回复显示*/
		function answer(name,content) {
			question = content;
			$(".text").html(content);
			$(".name").html("回复"+name+":");
			$(".teachAnser").show();
		}
		
		
	 
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
	                	console.log( message.data );
	                	var commandList = message.data.toString().split("|");
	                	if( message.data != ''  ){
	                		if( commandList[0] == 'login'){  // 登陆成功 
	                			
	                		}else if( commandList[0] == 'talk'){  // 聊天消息送达
		            			talk( commandList );
		            		}else if( commandList[0] == 'getmsg'){
		            			getmsg( commandList );
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
		     		   sendMsg("login|${course.id}|${user.id}");
			           sendMsg("getmsg|${course.id}|1|"+pageSize);
		     		   clearInterval(timer2);
		     		}
		         },1000);
			 });
		}
	    
	    function getmsg( command ){
	    	 var msglist = command[1];
	         if( msglist.length == 1 ){ // 暂无数据了
	        	 return ;
	         }
	         if( isReconnection ){ // 如果是重连，清空老是里面的内容
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
			         	var realname = results[i].realname;
			         	
		 	         	if( header.indexOf('http') == -1  ){
		  		        	header = "${ctx}/"+header;
		  		        }
		 	         	
		 	         	if(ouid == wid){  //导师发言
		 	         		if(type == '0'){
		 	         			html += '<li class="show1">' +
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
		 	         					'<p style="color:#1d93fa;">'+content+'</p>' +
		 	         					'</dd>' +
		 	         					'</dl>' +
		 	         					'</li>';
		 	         		}else if(type == '1'){
		 	         			if(content == "0"){
		 	         				html += '<li class="show1">' +
		 	   								'<dl class="son" id="teachSon">' +
		 	   								'<dt>' +
		 	   							'<i>'+realname+'</i>' +
		 	   							'<a href="javascript:;"><img src="'+header+'" alt=""><img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead"></a>' +
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
			 	         					'<button number="'+btnnum+'"  data-url="'+ serverid +'" data-time="'+mp3time+'" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
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
 	         					'<i>'+realname+'</i>' +
 	         					'<img src="'+header+'" alt="">' +
 	         					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
 	         					'</dt>' +
 	         					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
 	         					'<img src="'+serverid+'"/>' +
 	         					'</dd>' +
 	         					'</dl>' +
 	         					'</li>';
		 	         		}
		 	         	}else{
							if(showtype == 1){
								if(managerid == wid){
									header = "http://wimg.keepyoga.com/112670388829777145.jpg";
									realname = "主持人";
								}
								if(type == '0'){
									if(managerid == wid){
										html += '<li class="show1" >' +
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
										var ans = '';
										if(userid == ouid){
											ans = '<a href="javascript:answer(\''+realname+'\',\''+content+'\');" class="answer">回复</a>';
										}
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
												'<img src="'+header+'" alt="" data-uid="'+wid+'" onclick="stopUser(this)">' +
												'<img src="http://wimg.keepyoga.com/images/Gag.png" alt="" class="Gag">' +
												'<span></span>' +
												'</dt>' +
												'</dl>' +
												'</li>';
									}
			 	         		}else{
			 	         			html += '<li class="show1">' +
	 	         					'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
	 	         					'<dt >' +
	 	         					'<i>'+realname+'</i>' +
	 	         					'<img src="'+header+'" alt="">' +
	 	         					'</dt>' +
	 	         					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
	 	         					'<img src="'+serverid+'"/>' +
	 	         					'</dd>' +
	 	         					'</dl>' +
	 	         					'</li>';
			 	         		}
							}else{
								if(userid == wid){
									html += '<li class="show1">' +
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
							}
							
							
		 	         	}
	        	    } 
	        	    
	        	    if(tpageIndex == 1){
		        	    $("#_flg_li").before(html);
	        	    }else{
	        	   		$("#list li").eq(0).before(html);
	        	    }
	        	   
	         }
	         nowH = $("ul").height();
	         bodyScroll();
	    }
	    
	    
	    function talk( message ){
	    	
	    	 
	        if( message.length  == 2 ){
	        	Modal.tips("<font color='#ccc'>您已经被限制性发言!</font>","error",2500);
	        	return ;
	        }
	        if( message.length  == 3 ){
	        	Modal.tips("<font color='#ccc'>活动已经结束!</font>","error",2500);
	        	return ;
	        }
	    	
	    	var userid    = "${user.id}", ouid = "${course.tid}";
	        var isteacher = message[1];
	        var roomid = message[2];
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
	        if(ouid == wid){  //导师发言
	         		if(type == '0'){
	         			html += '<li class="show1">' +
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
	         					'<p  style="color:#1d93fa;">'+content+'</p>' +
	         					'</dd>' +
	         					'</dl>' +
	         					'</li>';
	         		}else if(type == '1'){
	         			if(content == "0"){
	         				html += '<li class="show1">' +
								'<dl class="son" id="teachSon">' +
								'<dt>' +
								'<i>'+realname+'</i>' +
								'<a href="javascript:;"><img src="'+header+'" alt=""><img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead"></a>' +
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
      					'<i>'+realname+'</i>' +
      					'<img src="'+header+'" alt="">' +
      					'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">' +
      					'</dt>' +
      					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
      					'<img src="'+serverid+'"/>' +
      					'</dd>' +
      					'</dl>' +
      					'</li>';
	         		}
	         	}else{
					if(showtype == 1){
						if(managerid == wid){
							header = "http://wimg.keepyoga.com/112670388829777145.jpg";
							realname = "主持人";
						}
						if(type == '0'){
							if(managerid == wid){
								html += '<li class="show1">' +
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
								var ans = '';
								if(userid == ouid){
									ans = '<a href="javascript:answer(\''+realname+'\',\''+content+'\');" class="answer">回复</a>';
								}
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
										'<img src="'+header+'" alt="" data-uid="'+wid+'"  onclick="stopUser(this)">' +
										'<img src="http://wimg.keepyoga.com/images/Gag.png" alt="" class="Gag">' +
										'<span></span>' +
										'</dt>' +
										'</dl>' +
										'</li>';
							}
		         		}else{
		         			html += '<li class="show1">' +
	      					'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
	      					'<dt >' +
	      					'<i>'+realname+'</i>' +
	      					'<img src="'+header+'" alt="">' +
	      					'</dt>' +
	      					'<dd style="padding:0;border:none;background:#f4f4f4;">' +
	      					'<img src="'+serverid+'"/>' +
	      					'</dd>' +
	      					'</dl>' +
	      					'</li>';
		         		}
					}else{
						if(userid == wid){
							html += '<li class="show1">' +
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
					}
					
	         	}
	        	$("#_flg_li").before(html);
	        
	        nowH = $("ul").height();
	       	var aLeft=$(".self dt").width()+$(".self dd").width();
	       	$(".self a").css("right",aLeft+'px');
	        bodyScroll();
	    }
	    
	    $(".showtype").on("click",function(){
	    	 if( nologin ) {   
	      		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	      	  }
	    	$(".show1").remove();
	    	tpageIndex = 1;
	    	if(showtype == 0){
	    		showtype =1;
	    		$(this).find("i").css({
	    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon3.png')",
	    			"background-repeat":"no-repeat"
	    		});
	    		sendMsg("getmsg|${course.id}|1|"+pageSize); 			    		  
		    	clearInterval(timer);
	    		$(this).find("span").html("只看导师");
	    	}else{
	    		showtype =0;
	    		$(this).find("i").css({
	    			"background-image":"url('http://wimg.keepyoga.com/images/interact_icon2.png')",
	    			"background-repeat":"no-repeat"
	    		});
	    		getTeacherMsg();
	    		$(this).find("span").html("查看全部");
	    	}
	    });
	    
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
			       sendMsg("talk|"+isteacher+"|${course.id}|${user.id}|2|"+question+"|"+data+"|"+recordtime+"|${user.realname}");
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
	    
	    
	    
	    function addComment(){
	    	if( !isConnection ){  // 网络端口的情况
	    		reConnection();
	    		return;
	    	}
	    	if( nologin) {   
	      		window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	      	}else{
				if( isAdd ) {
					Modal.tips("<font color='#ccc'>您的发送过于频繁，请稍后再进行发送!</font>","error",2500);
		        	return;
				}
		        if( $("#Itext").val() == '' ){
		        	Modal.tips("<font color='#ccc'>写点什么吧!</font>","error",2500);
		        	return ;
		        }  
		        var content = ahtml(escapeHtml($("#Itext").val()));
		        sendMsg("talk|"+isteacher+"|${course.id}|${user.id}|0|"+content+"|0|0|${user.realname}");
		        $("#Itext").val(""); 
		        $("#Enter").css({"background-color":"#9c9c9c"});
		        if(${ course.tid != user.id && course.mamagerid != user.id}){
			    	isAdd = true;
			    	brush_frequency(10000);	        	
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
	    
	    $("#yzmcode").on("keyup", function () {
            if ($(this).val().length != 0) {
                $("#entercode").css("background", "#1d92fb");
            } else {
                $("#entercode").css("background", "#9c9c9c");
            }
        });
        
       if( !nologin ){
		  if (!keepyoga.socket) {
			   keepyoga.connect();  
			   timer=setInterval(function(){  // 等待1秒钟在进行命令发送
			      if( isConnection ){
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
	    
	 
     
	  function pullDown() {
		  tpageIndex = tpageIndex + 1;
		  sendMsg("getmsg|${course.id}|"+tpageIndex+"|"+pageSize); 
    	  clearInterval(timer);
		  
       }
	  
	  /*输入框有内容，按钮变色*/
      $("#Itext").on("keyup", function () {
          if ($("#Itext").val().length != 0) {
              $("#Enter").css("background", "#1d92fb");
          } else {
              $("#Enter").css("background", "#9c9c9c");
          }
      });
	  
	  /*禁止刷频*/
      function brush_frequency(time) {
          setTimeout(function () {
        	  isAdd = false;
          }, time)
      }
	  
	  
      if (${course.cid != 0}) {
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
	  $(".tapShare").on("tap",function(){
		  $("#fxBox").show();
	  })
	  $("#fxBox").on("tap",function(){
		  $("#fxBox").hide();
	  } )
	  
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
	$("footer").on("tap",function(){
		  myiscroll.scrollToElement('li:last-child', 400, true);
		 
	})
	$("#Itext").on("focus",function(){
		  myiscroll.scrollToElement('li:last-child', 400, true);
	})
	$("#buyClose").on("tap",function(){
		$(".buyTipBox").hide();
	})
	 $(".audio_style").on("tap", function () {
    		 var isbuy=${isbuy};
				if(!isbuy){
					
					$(".buyTipBox").css("display","block");
				}
				else{
					$(this).hide();
					$("#audio").get(0).play();
					$(".controlBox").css("visibility", "visible");	
				}
				
      });
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	var base = "http://wimg.keepyoga.com/";
	var playtimer,$playjdom;
	function playMp3( jdom ){ 
			$("button").find("img").attr("src", "${ctx}/images/son.png");
			$("#audio111").get(0).pause();
			if($(jdom).attr("number") == playnum){
				clearInterval(playtimer);
				playnum = 0;
				return;
			}
			playnum = $(jdom).attr("number");
			$playjdom = $(jdom);
			$playjdom.next("b").remove();
			$playjdom.find("img").css({"width":"4.56rem"}).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
			var mp3source = $playjdom.attr("data-url");
			playnum = $(jdom).attr("number");
			$("#audio111").get(0).pause();
			$("#audio111").get(0).src= base + mp3source;
			$("#audio111").get(0).volume=1;
			$("#audio111").get(0).play();
		}
		function playstart(){
			var interTime=parseInt($playjdom.attr("data-time")) + 1;
			$playjdom.find("img").css({"width":"1rem"}).attr("src", "${ctx}/images/songif.gif");
			playtimer = setTimeout(function(){
				$playjdom.find("img").attr("src", "${ctx}/images/son.png");
			},interTime*1000)
		}
	
	
	
    </script>
    <script src="${ctx}/js/wblog.js?v=${v}"></script>
    <c:if test="${ocourse.ctype==0}">
    	<script type="text/javascript">
    	 $(".audio_style").on("tap", function () {
    		 var isbuy=${isbuy};
				if( !isbuy ){
					$(".buyTipBox").css("display","block");
				} else{
					$(this).hide();
					$("#audio").get(0).play();
					$(".controlBox").css("visibility", "visible");	
				}
				
      });
    	
      /*暂停播放*/
		$("#play_pause").on("tap", function () {
      	    if( nologin ) {  
      		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
      	    }else{			
				if ($(this).find("span").hasClass("play-pause-pause")) {
					$(this).find("span").removeClass("play-pause-pause");
					$("#audio").get(0).pause();
				} else {
					$(this).find("span").addClass("play-pause-pause");
					$("#audio").get(0).play();
					dragMove();
				}
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
    
    
    <div style="display:hidden" ><audio id="audio111" onplaying="playstart()"><source src="" type="audio/mpeg"></audio></div>
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
 