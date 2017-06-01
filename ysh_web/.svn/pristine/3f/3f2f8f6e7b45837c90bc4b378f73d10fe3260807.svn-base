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
		<title>私教集训营</title>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<link rel="stylesheet" href="${ctx}/css/cursorDetaill.css?v=${version}">
		<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
		<script type="text/javascript">
			var nodata = 1;
		</script>
	</head>

	<body>
		<div class="wrapper">
			<div class="keymask"></div>
			<div id="keybox">
				<b class="close"></b>
				<h4>请输入您的验证码</h4>
				<input type="text" id="yzmcode" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" />
				<button id="entercode">确认</button>
				<p <c:if test="${ course.id == 13 || course.id == 14 }">style="display:none"</c:if> > 该课程是收费课程，观看需购买
					<a href="${ctx}/w/faq/course.html?p=${course.cid}">本节课程</a>。若有疑问，请联系客服4000186161
				</p>
			</div>
			<span id="video_play" <c:if test="${isbuy == true  }">style="display:none"</c:if>   ></span>
			<header>
				<div class="audio_video" <c:if test="${course.cid==0}">style="display:none"</c:if> >
					<audio id="audio" class="video-audio" src="${ocourse.realfilepath}">
						<c:choose>
							<c:when test="${ isbuy }">
								<!-- <source src="${ocourse.realfilepath}" />-->
								<input type="hidden" data-src="${ocourse.realfilepath}" id="srouce" />
							</c:when>
							<c:otherwise>

							</c:otherwise>
						</c:choose>
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
					<div class="audio_style"></div>
				</div>
				<p <c:if test="${course.cid==0}">style="display:none"</c:if> class="title">${course.name }<img src="${ctx}/images/arrow_up.png" id="arrow_up" alt=""></p>
				<dl id="person" data-url="${ctx}/w/faq/person.html?p=${teacher.id}&t=0">
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
			<!--导师页面才有提醒-->

			<!--导师页面才有提醒   如果是导师页的话，需要在section上加一个main类名-->
			<section class="mainBox ${course.cid==0 ? 'no-tip':''}" id="mainBox">
				<ul id="list" class="list">
					<li></li>
				</ul>
			</section>
			<footer>
				<c:if test="${ course.status == 2 }">
					<div class="foot-nav">
						<a href="${ctx}/w/faq/index.html" <c:if test="${footclass eq 'faq' }">class="footerhigh"</c:if>>问答</a>
				<a href="${ctx}/w/hot/course/index.html" <c:if test="${footclass eq 'course' }">class="footerhigh"</c:if>>课程</a>
				<a href="${ctx}/w/find/index.html" <c:if test="${footclass eq 'find' }">class="footerhigh"</c:if>>发现</a>
				<a href="${ctx}/w/my/index.html" <c:if test="${footclass eq 'my' }">class="footerhigh"</c:if>>我的</a>
				</div>
				</c:if>
				<!--馆主消息栏结束-->
			</footer>
		</div>
		<script src="${ctx}/js/zepto.js?v=${version}"></script>
		<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
		<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
		<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
		<script>
			
			var isConnection = false; // 链接是否有效
			var timer; // 登陆定时器
			var voice = { localId: '', serverId: '' };
			var isowninitiative = false; // 是否主动离开 ；
			var RecordTimer;
			var isReconnection = false; // 是否是用户本人确定了重连 
			var nologin = ${nologin};
			var isAdd = false;
			var tpageIndex = 1;
			var recordid;
			var mp3Timer;
			var recordtime = 0;
			var pageIndex = 0;
			var filepath = "";

			wx.config({
				debug: false,
				appId: '${appid}',
				timestamp: '${timestamp}',
				nonceStr: '${nonceStr}',
				signature: '${signature}',
				jsApiList: ['checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'startRecord', 'stopRecord', 'playVoice', 'pauseVoice', 'stopVoice', 'uploadVoice', 'downloadVoice', 'chooseImage', 'previewImage', 'uploadImage', 'downloadImage', 'hideOptionMenu', 'showOptionMenu', 'closeWindow']
			});

			/*语音播放开始*/
			var gifTrue = true;
			$("dl.music button").on("click", function() {
				if(gifTrue == true) {
					$(this).find("img").attr("src", "${ctx}/images/songif.gif");
					gifTrue = false;
				} else {
					$(this).find("img").attr("src", "${ctx}/images/son.png");
					gifTrue = true;
				}
			})
			/*语音播放结束*/
			/*语音文字切换开始*/
			$("#recold").on('tap', function() {
				if(!$(this).hasClass("YES")) {
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
			})

			/*导师录音结束*/
			/*馆主页面收起（）*/
			$("#arrow_up").on("click", function() {
				if(!$(this).hasClass("UP")) {
					if(!$("#mainBox").hasClass("main")) {
						$(".audio_video").slideUp(400, function() {
							$("#mainBox").addClass("mainBox1");
							$("#arrow_up").addClass("UP");
						});
					} else {
						$(".audio_video").slideUp(400, function() {
							$("#mainBox").addClass("main1");
							$("#arrow_up").addClass("UP");
							$("p.teach-remind").addClass("teach-remind1");
							$("#video_play").hide();
						});
					}
				} else {
					if(!$("#mainBox").hasClass("main")) {
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
			$(".list").on("tap", function() {
				if(!$("#mainBox").hasClass("main")) {
					$(".audio_video").slideUp(400, function() {
						$("#mainBox").addClass("mainBox1");
						$("#arrow_up").addClass("UP");
					});
				} else {
					$(".audio_video").slideUp(400, function() {
						$("#mainBox").addClass("main1");
						$("#arrow_up").addClass("UP");
						$("p.teach-remind").addClass("teach-remind1");
						$("#video_play").hide();
					});
				}
			})
			/*如果input获得焦点则视频区域隐藏*/
			$("#tex").focus(function() {
				$(".audio_video").slideUp(400, function() {
					$("#mainBox").addClass("main1");
					$("#arrow_up").addClass("UP");
					$("p.teach-remind").addClass("teach-remind1");
					$("#video_play").hide();
				});
			})
			/*密码药匙*/
			$("#play_pause").on("tap", function() {
				if($(this).find("span").hasClass("play-pause-pause")) {
					$(this).find("span").removeClass("play-pause-pause");
					$("#audio").get(0).pause();
				} else {
					$(this).find("span").addClass("play-pause-pause");
					$("#audio").get(0).play();
					dragMove();
				}
			})
			$(".audio_style").on("tap", function() {
				if(!$(this).hasClass("pause")) {
					$(".keymask").show();
					$("#keybox").show();

				}
			})

			$(".close").on("tap", function() {
				$(".keymask").hide();
				$("#keybox").hide();
			})
			$(".keymask").on("tap", function() {
				$(this).hide();
				$("#keybox").hide();
			})
			$("#person").on("tap", function() {
				window.location.href = $(this).attr("data-url");
			})

			$("#entercode").on("click", function() {
				if($("#yzmcode").val() == '') {
					Modal.tips("<font color='#ccc'>请输入课程的验证码</font>", "error", 1500);
					return;
				}
				$.ajax({
					type: "post",
					url: "${ctx}/w/phy/" + $("#yzmcode").val() + "/${course.id}/code.html",
					dataType: "JSON",
					async: false,
					success: function(data) {
						if(data.status == true) { // 上传过程OK 
							$("#yzmcode").val('');
							$(".keymask").hide();
							$("#keybox").hide();
							$("#video_play").hide();
							filepath = data.realpath;
							playMMp3(filepath);
						} else {
							Modal.tips("<font color='#ccc'>课程的验证码不正确</font>", "error", 1500);
						}
					}
				});
			})

			function playMMp3() {
				$("#audio").append("<source src='" + filepath + "' />");
				$("#audio").get(0).volume = 1;
				$("#audio").get(0).play();
				$(".audio_style").addClass("pause");
				$("#audio").get(0).play();
				dragMove();
				$(".controlBox").css("visibility", "visible");
				$(".audio_style").hide();
			}

			function playMp3(jdom) {
				$("button").find("img").attr("src", "${ctx}/images/son.png");
				$(jdom).find("img").attr("src", "${ctx}/images/songif.gif");
				$("#audio111").get(0).pause();
				var mp3source = $(jdom).attr("data-src");
				$("#audio111").get(0).pause();
				$("#audio111").get(0).src = mp3source;
				$("#audio111").get(0).volume = 1;
				$("#audio111").get(0).play();
				var a = $(jdom).next().html();
				var c = a.length - 1;
				var interTime = parseInt(a.substr(0, c));
				setTimeout(function() {
					$(jdom).find("img").attr("src", "${ctx}/images/son.png");
				}, interTime * 1000)

			}

			$("#yzmcode").on("keyup", function() {
				if($(this).val().length != 0) {
					$("#entercode").css("background", "#1d92fb");
				} else {
					$("#entercode").css("background", "#9c9c9c");
				}
			})

			loadStore();

			function loadStore() {
				if(pageIndex > -1) {
					$.ajax({
						type: "post",
						dataType: "json",
						url: "${ctx}/w/chat/msg/json.html?type=1&p=${course.id}&pageIndex=" + (pageIndex + 1),
						error: function(XMLHttpRequest, textStatus, error) {},
						success: function(msg) {
							if(msg != '' && msg != undefined) {

								var html = "",
									ouid = "${course.tid}";
								for(var i = 0; i < msg.length; i++) {

									var userid = "${user.id}";
									var wid = parseInt(msg[i].wid);
									var isteacher = parseInt(msg[i].isteacher);
									var type = parseInt(msg[i].type);
									var content = msg[i].content.replace('■', '|');
									var header = msg[i].header;
									var mp3path = msg[i].mp3path;
									var mp3time = msg[i].mp3time;

									if(header.indexOf('http') == -1) {
										header = "${ctx}/" + header;
									}

									if(ouid == wid && type == '0' && userid == wid) {
										html += '<li>' +
											'<dl class="self">' +
											'<dd>' +
											'<span class="triangle-left-self1">&#9670</span>' +
											'<span class="triangle-left-self">&#9670</span>' +
											'<div></div>' +
											'<p>' + content + '</p>' +
											'</dd>' +
											'<dt data-uid="' + wid + '">' +
											'<img src="' + header + '" alt="">' +
											'</dt>' +
											'</dl>' +
											'</li>';
									}
									if(ouid == wid && type == '0' && userid != wid) {
										html += '<li>' +
											'<dl class="teach">' +
											'<dt data-uid="' + wid + '">' +
											'<img src="' + header + '" alt="">' +
											'<span></span>' +
											'</dt>' +
											'<dd>' +
											'<span class="triangle-left-teach1">&#9670</span>' +
											'<span class="triangle-left-teach">&#9670</span>' +
											'<div></div>' +
											'<p>' + content + '</p>' +
											'</dd>' +
											'</dl>';
									}

									if(ouid == wid && type == '1' && userid != wid) {
										html += '<li>' +
											'<dl class="son music">' +
											'<dt data-uid="' + wid + '">' +
											'<img src="' + header + '" alt=""><span></span>' +
											'</dt>' +
											'<dd>' +
											'<button  data-src="' + mp3path + '" onclick="playMp3(this)"><img src="${ctx}/images/son.png" alt=""></button>' +
											'<span class="mp3time">' + mp3time + '"</span>' +
											'</dd>' +
											'</dl> ' +
											'</li>';
									}

									if(ouid == wid && type == '1' && userid == wid) {
										html += '<li>' +
											'<dl class="teach-son music">' +
											'<dd>' +
											'<span class="mp3time">' + mp3time + '"</span>' +
											'<button data-src="' + mp3path + '"  onclick="playMp3(this)"><img src="${ctx}/images/son.png" alt=""></button>' +
											'</dd>' +
											'<dt data-uid="' + wid + '">' +
											'<img src="' + header + '" alt="">' +
											'</dt>' +
											'</dl> ' +
											'</li>';
									}

									if(ouid != wid && type == '0' && userid != wid) {
										html += '<li>' +
											'<dl class="student">' +
											'<dt data-uid="' + wid + '">' +
											'<img src="' + header + '" alt="">' +
											'<img src="${ctx}/images/Gag.png" alt="" class="Gag">' +
											'<span></span>' +
											'</dt>' +
											'<dd>' +
											'<span class="triangle-left-student1">&#9670</span>' +
											'<span class="triangle-left-student">&#9670</span>' +
											'<div></div>' +
											'<p>' + content + '</p>' +
											'</dd>' +
											'</dl>' +
											'</li>';
									}
									if(ouid != wid && type == '0' && userid == wid) {
										html += '<li>' +
											'<dl class="self">' +
											'<dd>' +
											'<span class="triangle-left-self1">&#9670</span>' +
											'<span class="triangle-left-self">&#9670</span>' +
											'<div></div>' +
											'<p>' + content + '</p>' +
											'</dd>' +
											'<dt data-uid="' + wid + '">' +
											'<img src="' + header + '" alt="">' +
											'</dt>' +
											'</dl>' +
											'</li>';
									}
								}

								$("#list").append(html);
								pageIndex++;
							} else {
								nodata = 0;
								$("#pullUp").remove();
								pageIndex = -1;
							}
						}
					});
				}
			}

			if(nologin == "true") {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			}

			Ios_video();
			var proLeft = $(".progressBar").offset().left;

			function Ios_video() {
				var src = $("#srouce").attr("data-src")
				$("#audio").attr('src', src);
				var ctr_box_w = $(".progressBar").width();

				var video_audio = $(".video-audio").get(0);

				/*双击播放或暂停开始*/
				/*双击播放或暂停结束*/

				$(".audio-video-mask-play").on("tap", function() {
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
					if(x < 0) {
						drag.style.left = 0;
						speed.style.width = 0;
					} else if(x >= ctr_box_w) {
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
					var currentTime = numDragpaddingLeft / ctr_box_w * video_audio.duration + 1;  //30是拖动圆圈的长度，减掉是为了让歌曲结束的时候不会跑到window以外  
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
					setInterval(function() {
						drag.style.left = (video_audio.currentTime / video_audio.duration) * (window.innerWidth / 2) + "px";
						speed.style.width = (video_audio.currentTime / video_audio.duration) * (window.innerWidth / 2) + "px";

					}, 500);
				}
				video_audio.addEventListener("loadeddata", //歌曲一经完整的加载完毕( 也可以写成上面提到的那些事件类型)  
					function() {
						var allTime = video_audio.duration;
						if(allTime > 0) {
							$(".long-time").html(timeChange(allTime));
							
						}
						var currentTime = video_audio.currentTime;
						var currentTime = video_audio.currentTime;

						$(".now-time").html(timeChange(currentTime));
						setInterval(function() {
							var currentTime = video_audio.currentTime;
							$(".now-time").html(timeChange(currentTime));
						}, 1000);
					}, false);

				function timeChange(time) { //默认获取的时间是时间戳改成我们常见的时间格式  
					//分钟  
					var minute = time / 60;
					var minutes = parseInt(minute);
					if(minutes < 10) {
						minutes = "0" + minutes;
					}
					//秒  
					var second = time % 60;
					seconds = parseInt(second);
					if(seconds < 10) {
						seconds = "0" + seconds;
					}
					var allTime = "" + minutes + "" + ":" + "" + seconds + ""
					/* $(".now-time").html(allTime);*/
					return allTime;
				}
				window.dragMove = dragMove;
			}
		</script>
		<script src="${ctx}/js/wblog.js?v=${version}"></script>
		<div style="display:hidden">
			<audio id="audio111">
				<source src="" type="audio/mpeg">
			</audio>
		</div>
	</body>

</html>