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
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<title>${course.name }</title>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link rel="stylesheet" href="${ctx}/css/cursorDetaill.css?v=${version}">
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <script type="text/javascript">
        var nodata = 0;
    </script>
</head>
 <body>
    <div class="wrapper">
        <div class="keymask"></div>
        <div id="keybox">
            <b class="close"></b>
            <h4>请输入您的验证码</h4>
            <input type="text" id="yzmcode" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"  />
            <button id="entercode">确认</button> 
            <p <c:if test="${ course.id == 13 || course.id == 14}">style="display:none"</c:if> >
                该课程是收费课程，观看需购买<a href="${ctx}/w/faq/course.html?p=${course.cid}">本节课程</a>。若有疑问，请联系客服4000186161
            </p>
        </div>
        <span id="video_play" <c:if test="${isbuy == true}">style="display:none"</c:if> <c:if test="${course.cid==0}" >style="display:none"</c:if>   ></span>
        <header  >
            <div class="audio_video" <c:if test="${course.cid==0}" >style="display:none"</c:if> >
                <input type="hidden" id="mp3sourse" <c:if test="${isbuy == true }">value="${ocourse.realfilepath}"</c:if><c:if test="${isbuy == false }">value="${ocourse.filepath}"</c:if> />
                <audio id="audio" controls ><c:if test="${isbuy == true }"><source src="${ocourse.realfilepath}" /></c:if></audio>
            </div>
            <p <c:if test="${course.cid==0}" >style="display:none"</c:if> class="title">${course.name }<img src="${ctx}/images/arrow_up.png" id="arrow_up" alt=""></p>
            <dl id="person" data-url="${ctx}/w/faq/person.html?p=${teacher.id}&t=0" >
                <dt>
                    <c:choose>
						 <c:when test="${ fn:indexOf(teacher.file_path,'http') > -1 }">
							 <img src="${teacher.file_path}"  >
						 </c:when>
						 <c:otherwise>
							 <img src="${ctx}/${teacher.file_path}"  >
					    </c:otherwise>    
					 </c:choose>
                </dt>
                <dd>
                    <h2>${teacher.nickname }<span>${teacher.userpost }</span></h2>
                    <p>${teacher.shortremark }</p>
                </dd>
                <span class="sanjiao">
                </span>
            </dl>
        </header>
        <p class="teach-remind"  <c:if test="${user.id != course.tid}">style="display:none"</c:if> >点击用户头像即可选择禁言该用户</p>
        <!--导师页面才有提醒-->
        
        <!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
        <section class="mainBox" id="mainBox">
            <ul id="list" class="list">
            	<li id="_flg_li" style="display: block;width: 100%;height: 2.5rem;"></li>
            </ul>
        </section>
        <footer>
            <!--导师消息栏开始-->
            <c:if test="${course.tid == user.id }">
	            <div class="teach">
	                    <span class="son" id="recold"></span>
	                    <div>
	                        <div class="tex">
	                             <input type="text" name="tex" id="tex"  maxlength="256"> 
	                        </div>
	                        <div class="record" id="longTAP">按住&nbsp;&nbsp;说话</div>
	                    </div>
	                    <button  id="Enter" onclick="addComment()">发送</button>
	            </div>
            </c:if>
            <c:if test="${course.tid != user.id }">
	           <div class="student" >
	                    <div class="tex">
	                        <input type="text" name="tex" id="tex"   maxlength="256"> 
	                    </div>
	                    <button id="Enter" onclick="addComment()" >发送</button>
	            </div>
            </c:if>
            
            <!--馆主消息栏结束-->
        </footer>
    </div>
    <script src="${ctx}/js/zepto.js?v=${version}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script>
    
	    var isConnection = false; // 链接是否有效
	    var timer;  // 登陆定时器
	    var voice = { localId: '', serverId: '' };
	    var isowninitiative = false;  // 是否主动离开 ；
	    var RecordTimer ;  
	    var isReconnection = false; // 是否是用户本人确定了重连 
	    var nologin = ${nologin};
	    var isAdd = false;
	    var tpageIndex = 1;
	    var recordid ;
	    var mp3Timer ;
	    var recordtime = 1 ,realtime = 1;
	    var pageSize =10;
	    var nowH = 0 ;
	    var playingId ;
	    wx.config({
		    debug: false, 
		    appId:'${appid}',
		    timestamp:'${timestamp}' , 
		    nonceStr: '${nonceStr}', 
		    signature: '${signature}', 
		    jsApiList: ['checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'startRecord','stopRecord', 'playVoice','pauseVoice','stopVoice','uploadVoice','downloadVoice','chooseImage','previewImage','uploadImage','downloadImage','hideOptionMenu','showOptionMenu','closeWindow']
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
 		             sendMsg("talk|${user.isteacher}|${course.id}|${user.id}|1|0|"+res.serverId+"|"+recordtime);
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
        var gifTrue = true;
        function buttionClick( this_ ) { 
               	wx.stopVoice({
               	    localId: playingId
               	});
                if (gifTrue == true) {
                	$("button").find("img").attr("src", "${ctx}/images/son.png");
                	$(this_).find("img").attr("src", "${ctx}/images/songif.gif");
                    gifTrue = false;
                    downloadVoice($(this_).attr("data-url"));
                } else {
                    $(this_).find("img").attr("src", "${ctx}/images/son.png");
                    gifTrue = true;
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
        
        
        function playVoice( playlocalid ){
        	wx.playVoice({
        	    localId: playlocalid.toString() // 需要播放的音频的本地ID，由stopRecord接口获得
        	});
        	wx.onVoicePlayEnd({
        	    success: function (playlocalid) {
        	        var localId = playlocalid; // 返回音频的本地ID
        	        $("button").find("img").attr("src", "${ctx}/images/son.png");
        	    }
        	});
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
        $("#recold").on('tap', function () {
                if (!$(this).hasClass("YES")) {
                    $(".tex").hide();
                    $(".record").show();
                    $(this).removeClass("son");
                    $(this).addClass("son-tex");
                    $(this).addClass("YES");
                } else {
                    $(".tex").show();
                    $(".record").hide();
                    $(this).removeClass("son-tex");
                    $(this).removeClass("YES");
                    $(this).addClass("son");
                    $("#tex").focus();
                }
            });
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

        /*弹框*/
        function dialog1() {
            var maskDiv = $("<div class='mask'>");
            $("<img src='${ctx}/images/wx_recold.gif'>").appendTo(maskDiv);
            $("<p>松开手指，发送消息</p>").appendTo(maskDiv);
            maskDiv.appendTo($(".wrapper"));
        }

        /*导师录音结束*/
        /*馆主页面收起（）*/
        $("#arrow_up").on("click", function () {
                if (!$(this).hasClass("UP")) {
                    if (!$("#mainBox").hasClass("main")) {
                        $(".audio_video").slideUp(400, function () {
                            $("#mainBox").addClass("mainBox1");
                            $("#arrow_up").addClass("UP");
                        });
                    } else {
                        $(".audio_video").slideUp(400, function () {
                            $("#mainBox").addClass("main1");
                            $("#arrow_up").addClass("UP");
                            $("p.teach-remind").addClass("teach-remind1");
                            $("#video_play").hide();
                        });
                    }
                } else {
                    if (!$("#mainBox").hasClass("main")) {
                        $("#mainBox").removeClass("mainBox1");
                        $("#arrow_up").removeClass("UP");
                        $(".audio_video").slideDown(400);
                    } else {
                        $("#mainBox").removeClass("main1");
                        $("#arrow_up").removeClass("UP");
                        $("p.teach-remind").removeClass("teach-remind1");
                        $(".audio_video").slideDown(400);
                        $("#video_play").show();
                    }
                }
            })
            /*点击聊天区域视频区域隐藏*/
        $(".list").on("tap", function () {
                if (!$("#mainBox").hasClass("main")) {
                    $(".audio_video").slideUp(400, function () {
                        $("#mainBox").addClass("mainBox1");
                        $("#arrow_up").addClass("UP");
                    });
                } else {
                    $(".audio_video").slideUp(400, function () {
                        $("#mainBox").addClass("main1");
                        $("#arrow_up").addClass("UP");
                        $("p.teach-remind").addClass("teach-remind1");
                        $("#video_play").hide();
                    });
                }
            })
            /*如果input获得焦点则视频区域隐藏*/
        $("#tex").focus(function () {
                $(".audio_video").slideUp(400, function () {
                    $("#mainBox").addClass("main1");
                    $("#arrow_up").addClass("UP");
                    $("p.teach-remind").addClass("teach-remind1");
                    $("#video_play").hide();
                });
            })
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
        
        $("#entercode").on("click", function () {
            if( $("#yzmcode").val() == '' ){
            	Modal.tips("<font color='#ccc'>请输入课程的验证码</font>","error",2500);
            	return;
            } 
            $.ajax({
                type: "post",
                url:  "${ctx}/w/phy/"+$("#yzmcode").val() +"/${course.id}/code.html" ,
                dataType: "JSON",
                success: function (data) {
                    if (data.status == true ) {  // 上传过程OK 
                    	Modal.tips("<font color='#ccc'>验证码正确</font>","success",2500,function(){
                    		$("#mp3sourse").val( data.realpath );
                    		$("#audio").append("<source src='"+data.realpath+"' />");
                    		$("#yzmcode").val('');
                    		$(".keymask").hide();
                            $("#keybox").hide();
                            $("#video_play").hide();
                    	});
                    } else {
                    	Modal.tips("<font color='#ccc'>课程的验证码不正确</font>","error",2500);
                    }
                }
            });
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
	        	    for( var i = 0 ; i < results.length ;i ++){
	        	    	
	        	    	var userid    = "${user.id}"; 
		 	         	var wid      = parseInt(results[i].wid);
		 	         	var isteacher= parseInt(results[i].isteacher);
		 	         	var type     = parseInt(results[i].type); 
		 	         	var content  = results[i].content.replace('■', '|'); 
		 	         	var header   = results[i].header;
		 	         	var serverid= results[i].serviceid;
			         	var mp3time  = results[i].mp3time;
			         	
		 	         	if( header.indexOf('http') == -1  ){
		  		        	header = "${ctx}/"+header;
		  		        }
		 	         	if( ouid == wid && type == '0' && userid == wid ){
		 	                html+='<li>'+ 
		 	   	            '<dl class=" self">'+
		 	   	                '<dd>'+
		 	   		                '<span class="triangle-left-self1">&#9670</span>'+
		 	   		                '<span class="triangle-left-self">&#9670</span>'+
		 	   		                '<div></div>'+
		 	   		                '<p>'+content+'</p>'+
		 	   	                '</dd>'+
		 	   	                '<dt data-uid="'+wid+'">'+
		 	   						'<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)"  >'+
		 	   					'</dt>'+ 
		 	   	            '</dl>'+ 
		 	   	          '</li>'; 
		 	   	        }
		 	   	        if( ouid == wid && type == '0' && userid != wid ){
		 	   	        html+='<li>'+ 
		 	   		        	'<dl class="teach">'+
		 	   	                '<dt data-uid="'+wid+'">'+
		 	   					'<img src="'+ header +'" data-uid="'+wid+'" onclick="stopUser(this)" >'+
		 	   					'<span></span>'+
		 	   				'</dt>'+
		 	   	                '<dd>'+
		 	   	                    '<span class="triangle-left-teach1">&#9670</span>'+
		 	   	                    '<span class="triangle-left-teach">&#9670</span>'+
		 	   	                    '<div></div>'+
		 	   	                    '<p>'+content+'</p>'+
		 	   	                '</dd>'+
		 	   	            '</dl>'; 
		 	   	        }
		 	   	        
		 	   	        if( ouid == wid && type == '1' && userid != wid ){
		 	   	        html+='<li>'+ 
		 	   	                '<dl class="son music">'+
		 	   	                    '<dt data-uid="'+wid+'">'+
		 	   			                  '<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)"  ><span></span>'+
		 	   			            '</dt>'+
		 	   	                    '<dd>'+
		 	   	                        '<button  data-url="'+ serverid +'" onclick="buttionClick(this)"><img src="${ctx}/images/son.png" alt=""></button>'+
		 	   	                        '<span class="mp3time">'+ mp3time +'"</span>'+
		 	   	                    '</dd>'+
		 	   	                '</dl> '+
		 	   	            '</li>'; 
		 	   	        }
		 	   	        
		 	   	        
		 	   	        if( ouid == wid && type == '1' && userid == wid  ){
		 	   	        html+='<li>'+ 
		 	   	                '<dl class="teach-son music">'+
		 	   	                '<dd>'+
		 	   	                    '<span class="mp3time">'+ mp3time +'"</span>'+
		 	   	                     '<button data-url="'+ serverid +'" onclick="buttionClick(this)"><img src="${ctx}/images/son.png" alt=""></button>'+
		 	   	                 '</dd>'+
		 	   	                    '<dt data-uid="'+wid+'">'+
		 	   			                  '<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)" >'+
		 	   			            '</dt>'+
		 	   	                '</dl> '+
		 	   	            '</li>'; 
		 	   	        }
		 	   	        
		 	   	        if( ouid != wid && type == '0' && userid != wid ){
		 	   	        html+='<li>'+ 
		 	                   '<dl class="student">'+
		 	                   '<dt data-uid="'+wid+'">'+
		 	   					'<img src="'+header+'" class="pic" data-uid="'+wid+'" onclick="stopUser(this)"  >'+
		 	   					'<img src="${ctx}/images/Gag.png" alt="" class="Gag">'+
		 	   					'<span></span>'+
		 	   				'</dt>'+
		 	                       '<dd>'+
		 	                           '<span class="triangle-left-student1">&#9670</span>'+
		 	                           '<span class="triangle-left-student">&#9670</span>'+
		 	                           '<div></div>'+
		 	                           '<p>'+content+'</p>'+
		 	                       '</dd>'+
		 	                   '</dl>'+ 
		 	                  '</li>'; 
		 	   	        } 
		 	   	        if( ouid != wid && type == '0' && userid == wid ){
		 	   	        html+='<li>'+ 
		 	                   '<dl class="student self">'+
		 	   	                '<dd>'+
		 	   		                '<span class="triangle-left-self1">&#9670</span>'+
		 	   		                '<span class="triangle-left-self">&#9670</span>'+
		 	   		                '<div></div>'+
		 	   		                '<p>'+content+'</p>'+
		 	   	                '</dd>'+
		 	   	                '<dt data-uid="'+wid+'">'+
		 	   						'<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)" >'+
		 	   					'</dt>'+ 
		 	                   '</dl>'+ 
		 	                 '</li>';
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
	        var header   = message[8];
	        
	        if( header.indexOf('http') == -1 ){
	        	header = "${ctx}/"+header;
	        }
	       
	        if( ouid == wid && type == '0' && userid == wid ){
	               var html='<li>'+ 
	   	            '<dl class=" self">'+
	   	                '<dd>'+
	   		                '<span class="triangle-left-self1">&#9670</span>'+
	   		                '<span class="triangle-left-self">&#9670</span>'+
	   		                '<div></div>'+
	   		                '<p>'+content+'</p>'+
	   	                '</dd>'+
	   	                '<dt data-uid="'+wid+'">'+
	   						'<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)"  >'+
	   					'</dt>'+ 
	   	            '</dl>'+ 
	   	          '</li>';
	   	          $("#_flg_li").before(html);
	   	        }
	   	        if( ouid == wid && type == '0' && userid != wid ){
	   	        	var html='<li>'+ 
	   		        	'<dl class="teach">'+
	   	                '<dt data-uid="'+wid+'">'+
	   					'<img src="'+ header +'" data-uid="'+wid+'" onclick="stopUser(this)" >'+
	   					'<span></span>'+
	   				'</dt>'+
	   	                '<dd>'+
	   	                    '<span class="triangle-left-teach1">&#9670</span>'+
	   	                    '<span class="triangle-left-teach">&#9670</span>'+
	   	                    '<div></div>'+
	   	                    '<p>'+content+'</p>'+
	   	                '</dd>'+
	   	            '</dl>'; 
	   	        	$("#_flg_li").before(html);
	   	        }
	   	        
	   	        if( ouid == wid && type == '1' && userid != wid ){
	   	        	var html='<li>'+ 
	   	                '<dl class="son music">'+
	   	                    '<dt data-uid="'+wid+'">'+
	   			                  '<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)"  ><span></span>'+
	   			            '</dt>'+
	   	                    '<dd>'+
	   	                        '<button  data-url="'+ serverid +'" onclick="buttionClick(this)"><img src="${ctx}/images/son.png" alt=""></button>'+
	   	                        '<span class="mp3time">'+ mp3time +'"</span>'+
	   	                    '</dd>'+
	   	                '</dl> '+
	   	            '</li>';
	   	        	$("#_flg_li").before(html);
	   	        }
	   	        
	   	        if( ouid == wid && type == '1' && userid == wid  ){
	   	        	var html='<li>'+ 
	   	                '<dl class="teach-son music">'+
	   	                '<dd>'+
	   	                    '<span class="mp3time">'+ mp3time +'"</span>'+
	   	                     '<button data-url="'+ serverid +'" onclick="buttionClick(this)"><img src="${ctx}/images/son.png" alt=""></button>'+
	   	                 '</dd>'+
	   	                    '<dt data-uid="'+wid+'">'+
	   			                  '<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)" >'+
	   			            '</dt>'+
	   	                '</dl> '+
	   	            '</li>'; 
	   	        	$("#_flg_li").before(html);
	   	        }
	   	        
	   	        if( ouid != wid && type == '0' && userid != wid ){
	   	        	var html='<li>'+ 
	                   '<dl class="student">'+
	                   '<dt data-uid="'+wid+'">'+
	   					'<img src="'+header+'" class="pic" data-uid="'+wid+'" onclick="stopUser(this)"  >'+
	   					'<img src="${ctx}/images/Gag.png" alt="" class="Gag">'+
	   					'<span></span>'+
	   				'</dt>'+
	                       '<dd>'+
	                           '<span class="triangle-left-student1">&#9670</span>'+
	                           '<span class="triangle-left-student">&#9670</span>'+
	                           '<div></div>'+
	                           '<p>'+content+'</p>'+
	                       '</dd>'+
	                   '</dl>'+ 
	                  '</li>'; 
	   	        	$("#_flg_li").before(html);
	   	        } 
	   	        if( ouid != wid && type == '0' && userid == wid ){
	   	        	var html='<li>'+ 
	                   '<dl class="student self">'+
	   	                '<dd>'+
	   		                '<span class="triangle-left-self1">&#9670</span>'+
	   		                '<span class="triangle-left-self">&#9670</span>'+
	   		                '<div></div>'+
	   		                '<p>'+content+'</p>'+
	   	                '</dd>'+
	   	                '<dt data-uid="'+wid+'">'+
	   						'<img src="'+header+'" data-uid="'+wid+'" onclick="stopUser(this)" >'+
	   					'</dt>'+ 
	                   '</dl>'+ 
	                 '</li>';
	   	        	$("#_flg_li").before(html);
	   	        }  
	        
	        nowH = $("ul").height();
	       
	        bodyScroll();
	    }
	    
	    function addComment(){
	    	if( !isConnection ){  // 网络端口的情况
	    		reConnection();
	    		return;
	    	}
			if( isAdd ) {
				Modal.tips("<font color='#ccc'>您的发送过于频繁，请稍后再进行发送!</font>","error",2500);
	        	return;
			}
	        if( $("#tex").val() == '' ){
	        	Modal.tips("<font color='#ccc'>写点什么吧!</font>","error",2500);
	        	return ;
	        }  
	        var content = ahtml(escapeHtml($("#tex").val()));
	        sendMsg("talk|${user.isteacher}|${course.id}|${user.id}|0|"+content+"|0|0");
	        $("#tex").val(""); 
	        $("#Enter").css({"background-color":"#9c9c9c"});
	        if(${course.tid != user.id}){
		    	isAdd = true;
		    	brush_frequency(10000);	        	
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
        })
        
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
	 
	    
	  if( nologin == "true" ) {   
		   window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
      }
	    
	 
     
	  function pullDown() {
		  tpageIndex = tpageIndex + 1;
		  sendMsg("getmsg|${course.id}|"+tpageIndex+"|"+pageSize); 
    	  clearInterval(timer);
		  
       }
	  
	  /*输入框有内容，按钮变色*/
      $("#tex").on("keyup", function () {
          if ($("#tex").val().length != 0) {
              $("#Enter").css("background", "#1d92fb");
          } else {
              $("#Enter").css("background", "#9c9c9c");
          }
      })
	  
	  /*禁止刷频*/
      function brush_frequency(time) {
          setTimeout(function () {
        	  isAdd = false;
          }, time)
      }
	  
	  
      if (${course.cid != 0}) {
          if (${course.tid == user.id}) {
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
  
	   
    </script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
    <div style="display:hidden" ><audio id="audio111"><source src="" type="audio/mpeg"></audio></div>
</body>
</html> 
 