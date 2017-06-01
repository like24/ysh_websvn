<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
		<%@page import="com.yoga.dao.Weixin_blog_user"%>
			<%@ include file="../../taglibs.jsp" %>
				<c:set var="footclass" value="my" />
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
					<title>回答问题</title>
					<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
					<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
					<link rel="stylesheet" href="${ctx}/css/teach_answer.css?v=${version}">   
					<script type="text/javascript" src="${ctx}/js/jquery.form.js?v=${version}"></script>
					<style>
						#sendAllMask {
							width: 4rem;
							height: 2.1rem;
							position: absolute;
							right: .4rem;
							top: .1rem;
							display: none;
						}
						.main{width:100%;height:100%;}
						.main>div{width:100%;height:auto;}
						.main>div:nth-child(1)>dl {width: 100%;height: auto ;margin-bottom: .362rem;}
						.main>div:nth-child(1)>dl dd{width:100%;height:auto;}
						.main h2+dl button {display:block;}
						.main h2+dl span {color: #c6c6c6; font-size: 15px;   position: relative;    left: 62%;    top: -1.3rem;}
						 .main h2+dl button img{position: absolute; width: 1rem; height: 1rem;left: 1rem;}  

					</style>
				</head>
				<body>
					<div style="display:none">
						<form action="${ctx}/w/faq/adk/ask.html" method="post" id="askQuestion">
							<input type="hidden" name="qid" id="qid" value="${d.id}" />
							<input type="hidden" name="serverid" id="serverid" value="" />
							<input type="hidden" name="mp3" id="mp3" value="" />
							<input type="hidden" name="asktlong" id="asktlong" value="" />
						</form>
					</div>
					<div class="wrapper">
						<section class="mainBox" id="mainBox">
							<div class="main">
							<c:if test="${hasSubAsk}">
								<div>
										<dl>
									<dt>
										<c:choose>
											<c:when test="${ fn:indexOf(d.header,'http') > -1 }">
												<img  src="${d.header}"  >
											</c:when>
											<c:otherwise>
												<img  src="${ctx}/${d.header}"  >
											</c:otherwise>    
										</c:choose> 
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
									<h2 class="old">${d.content }</h2>
									<dl class="son">
									<dt>
										<c:choose>
											 <c:when test="${ fn:indexOf(d.askheader,'http') > -1 }">
												<img id="uh" src="${d.askheader}"  >
											 </c:when>
											 <c:otherwise>
												<img id="uh" src="${ctx}/${d.askheader}"  >
											 </c:otherwise>    
										 </c:choose>  
										</dt>
										<dd>
										 <c:forEach items="${d.answers}" var="ans" varStatus="status">
										  	<button id="music_${ans.id}" onclick="playmp3(this,'${ans.mp3path }','${ans.timelong}')" data-src="${cdn}/${ans.mp3path}"><img src="http://wimg.keepyoga.com/son.png">免费听</button> 
											<span id="aa_${ans.id}">${ans.timelong}</span>
										 </c:forEach>
										</dd>
									</dl>
									 <p class="ago">
										<span>${d.showtime}</span>
										<!-- 点赞标签开始 -->
										<span class="zan"><b id="like"></b><i>${d.up_count }</i></span>
										<!-- 点赞标签结束 -->
										<span class="listening">听过&nbsp;&nbsp;<span id="pc">${d.play_count}</span> 人</span>
									</p>		
								</div>
								<ul id="list" class="list">
									<li>
										<dl class="again">
											<dd>
												<h3>追问内容：</h3>
											</dd>
										</dl>
										<h4>${d.subcontent}</h4>
										<time>${d.showtime }</time>
									</li>
								</ul>
								</c:if>
								<c:if test="${not hasSubAsk}">
									<header>
										<h3>超过${dic*24}小时未回答，将全额退款给提问人</h3>
									</header>
									<ul id="list" class="list">
										<li>
											<dl>
												<dt>
	                               					<c:choose>
												  		<c:when test="${ fn:indexOf(d.header,'http') > -1 }">
														  <img src="${d.header}"  >
												  		</c:when>
												   		<c:otherwise>
														  <img src="${ctx}/${d.header}" >
												    	</c:otherwise>    
											  		</c:choose>
	                             				 </dt>
												<dd>
													<h3>${d.username }</h3>
												</dd>
											</dl>
											<h4>${d.synopsis}</h4>
											<time>${d.showtime }</time>
										</li>
									</ul>
								</c:if>
								
								<ol>
									<c:forEach items="${answers}" var="answer" varStatus="st">
										<li>
											<img src="${user.file_path}">
											<button onclick="playmp3(this,'${answer.mp3path}',${answer.timelong})"><img src="http://wimg.keepyoga.com/son.png" alt=""></button>
											<span>${answer.timelong}"</span>
											<c:if test="${!st.last}"><b style="display:none;" onclick='removeRecord(this,${answer.id})'>删除</b></c:if>
											<c:if test="${st.last}"><b onclick='removeRecord(this,${answer.id})'>删除</b></c:if>
										</li>
									</c:forEach>
								</ol>
							</div>
						</section>
<!-- 						<p class="entertip">点击"全部发送",您的语音会合并成一条发送</p> -->
						<footer class="footer" id="footer">
							<div class="recold" id="longTAP" >按住 说话</div>
							<button id="sendAll">全部发送</button>
							<span id="sendAllMask"></span>
						</footer>
					</div>

					<script src="${ctx}/js/zepto.js?v=${version}"></script>
					<script type="text/javascript">
						var icon = "http://wimg.keepyoga.com/ask.png";
						var title1 = "回答问题";
						var desc1 = "回答问题";
						var link1 = location.href;
						var img1 = icon;
						wx.config({
							debug: false,
							appId: '${appid}',
							timestamp: '${timestamp}',
							nonceStr: '${nonceStr}',
							signature: '${signature}',
							jsApiList: [
		        'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage', 'onMenuShareQQ', 'onMenuShareWeibo', 'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem', 'showAllNonBaseMenuItem', 'startRecord', 'stopRecord', 'onRecordEnd', 'playVoice', 'pauseVoice', 'stopVoice', 'uploadVoice', 'downloadVoice', 'hideOptionMenu', 'showOptionMenu'
		      ]
						});
						wx.ready(function () {
							wx.hideAllNonBaseMenuItem();
							wx.showMenuItems({
								    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
							});
							wx.checkJsApi({
								jsApiList: [
							        'startRecord','stopRecord'
							    ],
								success: function (res) {
									if (res.checkResult.startRecord == false) {
										Modal.tips("<font color='#ccc'>微信录音接口初始化错误，系统进行重新初始化 </font>", "error", 1500, function () {
											location.href = "${ctx}/w/faq/d/ask.html?p=${d.id}&r=1";
										});
									} 
								}
							});
							wx.error(function (res) {
								alert("err==" + JSON.stringify(res));
							});
						});
					</script>
					<script src="${ctx}/js/wblog.js?v=${version}"></script>
					<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
					<script>
						/*导师录音开始*/
						var interTime = 0, interval = null;
						$.fn.longPress = function (record, stopRecord, Enterfn) {
								var nowTime = null,
									timeout = null,
									longtap = false,
									time1 = 1,
									time2 = 10,
									timer1 = null;
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
									if (longtap) {
										if (new Date().getTime() - nowTime >= 2000) {
											$(".mask").remove();
											Enterfn();
											clearInterval(interval);
										} else if (new Date().getTime() - nowTime < 2000) {
											stoprecord1();
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
									/*录音逻辑*/
									startrecord()
								},
								function () {
									console.log("停止录音");
								},
								function () {
									/*发送语音*/
									console.log("发送语音");
									stoprecord1();
								}
							)
						}
						/*弹框*/
						function dialog1() {
							var maskDiv = $("<div class='mask'>");
							$("<img src='${ctx}/images/wx_recold.gif'>").appendTo(maskDiv);
							$("<p>松开手指，发送消息</p>").appendTo(maskDiv);
							$("<h4 id='maskTitle'>您还可以录制：</h4>").appendTo(maskDiv);
							$("<h4 id='maskTitle1'>录音结束！！！</h4>").appendTo(maskDiv);
							$("<b id='maskTime'>10</b>").appendTo(maskDiv);
							maskDiv.appendTo($(".wrapper"));
						}

						function removeRecord(it, aid) {
							$.post("${ctx}/weixin/removeSingleRecord/" + aid + ".html", function (data) {
								if (data.code == 1) {
									$(it).parent("li").remove();
									$("ol li b:last").show();
								}
							});
						}

						function stoprecord1() { 
							
							wx.stopRecord({
								success: function (res) { 
									if( interTime <= 2 ){
										interTime = 0;
										return;
									}else{
										recordid = res.localId; 
										addVoiceLi(recordid);
									}
								}
							});
						}


						function startrecord() {
							
							time2 = 10;
							wx.startRecord({
								success: function () {
									interTime=0;
									interval = setInterval(function () {
										interTime++;
										if (interTime >= 55) {
											clearInterval(interval);
											$(".mask").remove();
											$("#maskTitle").hide();
											$("#maskTime").hide();
											$("#maskTitle1").show();
											stoprecord1();
										} else if (interTime >= 45) {
											time2--;
											$("#maskTitle").show();
											$("#maskTime").show();
											$(".mask").find("img").hide();
											$(".mask").find("p").hide();
											$("#maskTime").html(time2); 
										} 
									}, 1000);


								},
								cancel: function () {
									afresh();
								}
							});
						}

						function playVoice(jdom, recordid, timelen) {

							if (!$(jdom).attr("play")) {
								setTimeout(function () {
									$(jdom).find("img").attr("src", "http://weixin.keepyoga.com/images/son.png");
									$("#audio111").get(0).pause();
									$(jdom).removeAttr("play");
								}, timelen * 1000 + 400);
								wx.playVoice({
									localId: recordid.toString() // 需要播放的音频的本地ID，由stopRecord接口获得
								});
								$(jdom).attr("play", "play");
								$(jdom).find("img").attr("src", "http://wimg.keepyoga.com/songif.gif");
							} else {
								$(jdom).find("img").attr("src", "http://wimg.keepyoga.com/son.png");
								wx.pauseVoice({
									localId: recordid.toString() // 需要暂停的音频的本地ID，由stopRecord接口获得
								});
								$(jdom).removeAttr("play");
							}



						}

						function pauseVoice() {
							wx.pauseVoice({
								localId: recordid.toString() // 需要暂停的音频的本地ID，由stopRecord接口获得
							});
						}


						function addVoiceLi(recordid) {
							var img = "${user.file_path}";
							var html = '<li  data_id="' + recordid + '"><img src="' + img + '"/><button onclick="playVoice(this,\'' + recordid + '\',' + interTime + ')"><img src="http://wimg.keepyoga.com/son.png" alt=""></button><span>' + interTime + '"</span></li>';
							$("ol").append(html);
							uploadSingleRecord(recordid);
						}

						function uploadSingleRecord(recordid) {
							var cid = $("#qid").val();
							wx.uploadVoice({
								localId: recordid.toString(), // 需要上传的音频的本地ID，由stopRecord接口获得
								isShowProgressTips: 1, // 默认为1，显示进度提示
								success: function (res) {
									$.ajax({
										type: "post",
										url: "${ctx}/weixin/uploadSingleRecord/" + cid + "-" + interTime + "/" + res.serverId + ".html",
										dataType: "JSON",
										success: function (data) {
											$("ol li b:last").hide();
											$("ol").find("li[data_id='" + recordid + "']").append("<b onclick='removeRecord(this," + data.aid + ")'>删除</b>");
										},
										error: function () {
											$("ol").find("li[data_id='" + recordid + "']").append("<span onclick='uploadSingleRecord(\'" + recordid + "\')'>●</span>");
										}
									});

								}
							});
						}

						function playmp3(jdom, path, timelong) {
							$("#audio111").get(0).pause();
							var button = jdom;
							var b = parseInt(timelong.substring(1,3))*60 + parseInt(timelong.substring(3, 5));
							path = "http://wimg.keepyoga.com/" + path;
							if (!$(button).attr("play")) {
								setTimeout(function () {
									$(button).find("img").attr("src", "http://weixin.keepyoga.com/images/son.png");
									$("#audio111").get(0).pause();
									$(button).removeAttr("play");
								}, b * 1000 + 400);
								$("#audio111").get(0).pause();
								$("#audio111").get(0).src = path;
								$("#audio111").get(0).volume = 1;
								$("#audio111").get(0).play();
								$(button).attr("play", "play");
								$("button").find("img").attr("src", "http://wimg.keepyoga.com/son.png");
								$(button).find("img").attr("src", "http://wimg.keepyoga.com/songif.gif");
							} else {
								$(button).find("img").attr("src", "http://wimg.keepyoga.com/son.png");
								$("#audio111").get(0).pause();
								$(button).removeAttr("play");
							}
						}

						var filename = "";

						$("#sendAll").on("click", function () {
							if(${nologin}){
								window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";		
							}
							dialog({
								wrapper: ".wrapper",
								id: "noshop",
								close: true,
								title1: "您确认全部发送吗？",
								btnleft: "取消",
								btnright: "发送",
								mask: true,
								bodytap: true,
								shikan: function () {
									if ($("ol li").has("b")) {
										$("#sendAllMask").show();
										myAnswer();
									} else {
										Modal.tips("<font color='#ccc'>还有录音没有上传完成，咱不能提交答案！</font>", "error", 2500);
									}
								},
								goumai: function () {
									$(".masking").remove();
									$("#noshop").remove();
								}
							}) 

						});

						function myAnswer() {
							$('#askQuestion').ajaxSubmit(function (data) {
								if (data.status == true) {
									$("#sendAllMask").hide();
									Modal.tips("<font color='#ccc'>回复成功，感谢回答！^-^</font>", "success", 2500, function () {
										location.href = "${ctx}/w/my/1/ask.html";
									});
								} else {
									Modal.tips("<font color='#ccc'>" + data.result + " </font>", "error", 2500);
								}
							});
						}
						var nologin = "${nologin}";
						if (nologin == "true") {
							window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
						}

						function turnBack() {
							dialog({
								wrapper: ".wrapper",
								id: "noshop",
								close: true,
								title1: "您的回复还未发送，确定要放弃吗？",
								btnleft: "继续编辑",
								btnright: "放弃编辑",
								mask: true,
								bodytap: true,
								goumai: function () {
									return;
								},
								shikan: function () {

								}
							})
						}
					</script>
					<div style="display:hidden">
						<audio id="audio111">
							<source src="" type="audio/mpeg">
						</audio>
					</div>
				</body>

				</html>