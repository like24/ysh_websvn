/*调用fastclick*/
FastClick.attach(document.body);
var getTeach = false;
var getAll=true;
var inx = 1;
var firtStudent=false;
if(PARAMETERS.isflow == 2) {
	var sHTML = "<div class='masking-box' id='codeBox1'></div><div class='code-box' id='codeBox2'><img src='" + PARAMETERS.ctx + "/images/close.jpg' class='close' id='close'><p class='tit'>您未关注随心瑜Live，请先关注!!!</p><img src='http://wimg.keepyoga.com/images/ysh-logo.jpg'><p>长按二维码，即可关注</p></div>"
	$('body').append(sHTML);
}
//动态创建video
function createVideo() {
	
	var source = $("#audioMask").attr("data-source");
	var $video = $("<video src='" + source + "' controls style='width:100%;height:10rem;' id='audio'></video>");
	$(".audio_video").append($video);
	$("#audio").get(0).addEventListener("play", function() {
		var $audio111 = $("#audio111").get(0);
		if(!$audio111.paused) {
			$("#mainBox button").removeClass('playing');
			$("#audio111").get(0).pause();
			$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({
				"width": "1rem"
			});
		}
	})
}
createVideo();
/* 只查看老师  异步获取获取 */
function getTeacherMsg(inx) {
	var html = "";
	$.ajax({
		type: "post",
		dataType: "json",
		url: PARAMETERS.ctx + "/w/chat/msg/json.html?p=" + PARAMETERS.courseId + "&pageIndex=" + inx + "&type=9",
		error: function(XMLHttpRequest, textStatus, error) { Modal.tips("<font color='#ccc'>加载失败，请稍后重试！</font>", "error", 2500); },
		success: function(msg) {
			if(msg != '' && msg != undefined) {
					var i = 0,
					len = msg.length;
				for(; i < len; i++) {
					var wid = parseInt(msg[i].wid);
					var isteacher = parseInt(msg[i].isteacher);
					var type = parseInt(msg[i].type);
					var content = msg[i].content.replace('■', '|');
					var header = msg[i].header;
					var mp3path = msg[i].mp3path;
					var mp3time = msg[i].mp3time;
					var realname = msg[i].nickname;
					var serverid = msg[i].serverid;
					var ls = isStudent(teacherids, wid);
					gl = isHolder = isStudent(holderids, wid);
						var dtHead = null;
						if(gl && ls) {
							var realname = "主持人",
								header = "http://wimg.keepyoga.com/112670388829777145.jpg";
							dtHead = '<i>' + realname + '</i>' +
								'<img src="' + header + '" alt="">';
						} else if(ls) {
							dtHead = '<i>' + realname + '<time>老师</time></i>' +
								'<img src="' + header + '" alt="" class="teachTap" data-num="' + wid + '" >' +
								'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">';
						} else {}
						/* 如果是老师 */
						/* 老师和管理员的文字发言 */
						if(type == '0') {
							html += '<li class="show1">' +
								'<dl class="student" id="teachText">' +
								'<dt>' +
								dtHead +
								'</dt>' +
								'<dd>' +
								'<span class="triangle-left-student1">&#9670</span>' +
								'<span class="triangle-left-student">&#9670</span>' +
								'<div></div>' +
								'<p class="iscrollPrevent" style="color:#41C3A8;">' + content + '</p>' +
								'</dd>' +
								'</dl>' +
								'</li>';
						} else if(type == '1') {
							if(content == "0") {
								html += '<li class="show1 show3">' +
									'<dl class="son" id="teachSon">' +
									'<dt>' +
									dtHead +
									'</dt>' +
									'<dd>' +
									'<button number="' + btnnum + '"  data-url="' + serverid + '" data-time="' + mp3time + '" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
									'<b class="_unread"></b>' +
									'<i class="time">' + mp3time + '"</i>' +
									'</dd>' +
									'</dl>' +
									'</li>';
							} else {
								html += '<li class="show1 show3">' +
									'<dl class="student teacherAns" id="teachText">' +
									'<dt>' +
									dtHead +
									'</dt>' +
									'<dd>' +
									'<span class="triangle-left-student1">&#9670</span>' +
									'<span class="triangle-left-student">&#9670</span>' +
									'<div></div>' +
									'<p >' + content + '</p>' +
									'<ol></ol>' +
									'<button number="' + btnnum + '" data-url="' + serverid + '" data-time="' + mp3time + '" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
									'<b class="_unread"></b>' +
									'<i class="time">' + mp3time + '"</i>' +
									'</dd>' +
									'</dl>' +
									'</li>';
							}
							btnnum++;
						} else {
							html += '<li class="show1">' +
								'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
								'<dt >' +
								dtHead +
								'</dt>' +
								'<dd style="padding:0;border:none;background:#f4f4f4;">' +
								'<img src="' + serverid + '" class="picArray" />' +
								'</dd>' +
								'</dl>' +
								'</li>';
						}
					
				}
					$("#_flg_li").before(html);
			}else{
				getTeach=false;
			}
			$("#loading").hide();
		}
	});
}
/*  全局变量    */
var isConnection = false, // 链接是否有效
	timer, // 登陆定时器
	voice = { localId: '', serverId: '' },
	isowninitiative = false, // 是否主动离开 ；
	RecordTimer,
	isReconnection = false, // 是否是用户本人确定了重连 
	nologin = PARAMETERS.nologin,
	isAdd = false,
	tpageIndex = 1,
	recordid,
	mp3Timer,
	recordtime = 1,
	realtime = 1,
	pageSize = 10,
	nowH = 0,
	playingId,
	btnnum = 1,
	playnum = 0,
	question = "0",
	showtype = 1, //消息显示模式，0 只看导师  1查看全部
	managerid = PARAMETERS.courseMamagerid,
	isteacher = 0,
	pullDown = null,
	$heart = new Date().getTime();

function startrecord() {
	interval(60);
	wx.startRecord({
		success: function() {
			
		},
		cancel: function() {}
	});
}

function pauseVoice() {
	wx.pauseVoice({
		localId: recordid.toString() // 需要暂停的音频的本地ID，由stopRecord接口获得
	});
}

function uploadrecord() {
	clearInterval(mp3Timer);
	pauseVoice();
	wx.uploadVoice({
		localId: recordid.toString(), // 需要上传的音频的本地ID，由stopRecord接口获得
		isShowProgressTips: 1, // 默认为1，显示进度提示
		success: function(res) {
			$.post(PARAMETERS.ctx + "/weixin/uploadweixinmp3.do", { "serverid": res.serverId }, function(data) {
				sendMsg("talk|" + isteacher + "|" + PARAMETERS.courseId + "|" + PARAMETERS.userId + "|1|" + question + "|" + data + "|" + recordtime + "");
				question = "0";
			});
			$(".teachAnser").hide();
		}
	});
}

function stoprecord() {
	wx.stopRecord({
		success: function(res) {
			recordid = res.localId;
			uploadrecord();
		}
	});
}

function cutrecord() {
	wx.stopRecord({
		success: function(res) {
			recordid = res.localId;
		}
	});
}
var minusTime = 10;

function interval(time) {
	realtime = 1;
	mp3Timer = setInterval(function() {
		realtime++;
		if(realtime >= 50) {
			minusTime--;
			$("#maskTime").html(minusTime + "s");
			$(".mask").find("img").hide();
			$(".mask").find("p").hide();
			$("#maskTitle").show();
			$("#maskTime").show();
			if(minusTime <= 1) {
				clearInterval(mp3Timer);
			}
		} else if(realtime >= time) {
			$(".mask").remove();
			stoprecord();
			clearInterval(mp3Timer);
		}
	}, 1000)
}
// 转义HTML
function escapeHtml(ctn) {
	return ctn.replace(/&/g, '&amp;').replace('|', '■').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/\n/g, '<br>');
}

function ahtml(ctn) {
	return ctn.replace(/((https?|s?ftp):\/\/)?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)\b)\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?\b/ig, function(a, b) {
		return '<a target="_blank" href="' + (b ? '' : 'http://') + a.replace(/&#38;/g, '&') + '">' + a + '</a>'
	})
}

function downloadVoice(str) {
	wx.downloadVoice({
		serverId: str.toString(), // 需要下载的音频的服务器端ID，由uploadVoice接口获得
		isShowProgressTips: 0, // 默认为1，显示进度提示
		success: function(res) {
			playingId = res.localId;
			playVoice(res.localId);
		}
	});
}
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('showOptionMenu');
});
var keepyoga = {
	socket: null, // WebSocket连接对象  
	host: '', // WebSocket连接 url  
	connect: function() { // 连接服务器  
		window.WebSocket = window.WebSocket || window.MozWebSocket;
		if(!window.WebSocket) { // 检测浏览器支持  
			Modal.tips("<font color='#ccc'>抱歉，您的浏览器不支持websocket网络通讯</font>", "error", 2500);
			return;
		}
		this.socket = new WebSocket(this.host); // 创建连接并注册响应函数  
		this.socket.onopen = function() {
			isConnection = true;
		};
		this.socket.onmessage = function(message) {
			var commandList = message.data.toString().split("|");
			if(message.data != '') {
				if(commandList[0] == 'login') { // 登陆成功 
					if(commandList[5] == 1) {
						$(".sideBtn .icon3").addClass("gapall");
						Modal.tips("<font color='#ccc'>当前聊天室开启全员禁言!</font>", "error", 2500, function() {
							$(".textPap").attr(
								"readonly", true
							);
							$(".textPap").attr('placeholder', '导师正在讲课，全员禁言中');
						});
					}
				} else if(commandList[0] == 'heart') {
					$heart = new Date().getTime();
				} else if(commandList[0] == 'talk') { // 聊天消息送达
					talk(commandList);
				} else if(commandList[0] == 'getmsg') {
					getmsg(commandList);
				} else if(commandList[0] == 'gapall') {
					if(PARAMETERS.courseId == commandList[1] && commandList[2] == 'notice') {
						if(commandList[3] == '0') { // 解禁
							Modal.tips("<font color='#ccc'>当前聊天室关闭全员禁言!</font>", "success", 2500, function() {
								$(".textPap").removeAttr("readonly");
								$(".textPap").attr('placeholder', '在此输入消息');
							});
						} else { // 禁言
							Modal.tips("<font color='#ccc'>当前聊天室开启全员禁言!</font>", "error", 2500, function() {
								$(".textPap").attr(
									"readonly", true
								);
								$(".textPap").attr('placeholder', '导师正在讲课，全员禁言中');
							});
						}
					}
				} else if(commandList[0] == 'stopuser') {
					// todo
				} else if(commandList[0] == 'closerooms') {
					if(PARAMETERS.courseId == commandList[1]) {
						Modal.tips("<font color='#ccc'>当前聊天室被关闭了!</font>", "error", 2500, function() {
							window.location.href = PARAMETERS.ctx + "/w/find/index.html?p=1";
						});
					}
				} else if(commandList[0] == 'roomusers') {}
			}
		};
		this.socket.onclose = function() {
			windowClose();
		};
	},
	send: function(message) { // 发送消息方法  
		if(this.socket && isConnection) {
			this.socket.send(message);
			return true;
		}
		console.log('please connect to the server first !!!');
		return false;
	}
};
// 初始化WebSocket连接 url  
keepyoga.host = (window.location.protocol == 'http:') ? 'ws://' : 'wss://';
keepyoga.host += PARAMETERS.socketaddress;
//keepyoga.host +=   '127.0.0.1:3001';
function sendMsg(message) {
	//alert( message )
	if(!message) return;
	if(!keepyoga.send(message)) return;
}

function reConnection() {
	Modal.confirm("网络连接已断开，是否重连？", function() {
		keepyoga.connect();
		// 发送进入命令
		var timer2 = setInterval(function() { // 等待1秒钟在进行命令发送
			if(isConnection) {
				sendMsg("logout|" + PARAMETERS.courseId + "|" + PARAMETERS.userId);
				sendMsg("login|" + PARAMETERS.courseId + "|" + PARAMETERS.userId);
				sendMsg("getmsg|" + PARAMETERS.courseId + "|1|" + pageSize);
				clearInterval(timer2);
			}
		}, 1000);
	});
}
//	    setInterval(function  ({
//	    		if(new Date().getTime()-$heart >=20000){
//	    			console.log("20秒自动重连！")
//	    			//reConnection();
//	    		}
//	    },20000))
function getmsg(command) {
	$("#loading").hide();
	if(command[1] != PARAMETERS.courseId) {
		return;
	}
	var msglist = command[2];
	if(msglist.length == 1) { // 暂无数据了
		return;
	}
	if(isReconnection) { // 如果是重连，清空里面的内容
		$("#list").html("<li></li>");
	}
	var results;
	if(msglist.length > 5) {
		results = jQuery.parseJSON(msglist);
		var html = "",
			ouid = PARAMETERS.courseTid;
		var userid = PARAMETERS.userId;
		for(var i = 0; i < results.length; i++) {
			var wid = parseInt(results[i].wid);
			var isteacher = parseInt(results[i].isteacher);
			var type = parseInt(results[i].type);
			var content = results[i].content.replace('■', '|');
			var header = results[i].header;
			var serverid = results[i].serviceid;
			var mp3time = results[i].mp3time;
			var realname = results[i].nickname;
			if(header.indexOf('http') == -1) {
				header = PARAMETERS.ctx + "/" + header;
			}
			var ls = isStudent(teacherids, wid),
				gl = isStudent(holderids, wid);
			/* 老师或管理员 */
			if(ls || gl) {
				var dtHead = null;
				/* 如果是管理员 */
				if(gl && ls) {
					var realname = "主持人",
						header = "http://wimg.keepyoga.com/112670388829777145.jpg";
					dtHead = '<i>' + realname + '</i>' +
						'<img src="' + header + '" alt="">';
				}
				/* 如果是老师 */
				else if(ls) {
					dtHead = '<i>' + realname + '<time>老师</time></i>' +
						'<img src="' + header + '" alt="" class="teachTap" data-num="' + wid + '" >' +
						'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">';
				} else {}
				/* 老师和管理员的文字发言 */
				if(type == '0') {
					html += '<li class="show1">' +
						'<dl class="student" id="teachText">' +
						'<dt>' +
						dtHead +
						'</dt>' +
						'<dd>' +
						'<span class="triangle-left-student1">&#9670</span>' +
						'<span class="triangle-left-student">&#9670</span>' +
						'<div></div>' +
						'<p class="iscrollPrevent" style="color:#41C3A8;">' + content + '</p>' +
						'</dd>' +
						'</dl>' +
						'</li>';
				} else if(type == '1') {
					if(content == "0") {
						html += '<li class="show1 show3">' +
							'<dl class="son" id="teachSon">' +
							'<dt>' +
							dtHead +
							'</dt>' +
							'<dd>' +
							'<button number="' + btnnum + '"  data-url="' + serverid + '" data-time="' + mp3time + '" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
							'<b class="_unread"></b>' +
							'<i class="time">' + mp3time + '"</i>' +
							'</dd>' +
							'</dl>' +
							'</li>';
					} else {
						html += '<li class="show1">' +
							'<dl class="student teacherAns" id="teachText">' +
							'<dt>' +
							dtHead +
							'</dt>' +
							'<dd>' +
							'<span class="triangle-left-student1">&#9670</span>' +
							'<span class="triangle-left-student">&#9670</span>' +
							'<div></div>' +
							'<p>' + content + '</p>' +
							'<ol></ol>' +
							'<button number="' + btnnum + '" data-url="' + serverid + '" data-time="' + mp3time + '" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
							'<b class="_unread"></b>' +
							'<i class="time">' + mp3time + '"</i>' +
							'</dd>' +
							'</dl>' +
							'</li>';
					}
					btnnum++;
				} else {
					html += '<li class="show1">' +
						'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
						'<dt >' +
						dtHead +
						'</dt>' +
						'<dd style="padding:0;border:none;background:#f4f4f4;">' +
						'<img src="' + serverid + '" class="picArray"/>' +
						'</dd>' +
						'</dl>' +
						'</li>';
				}
			} else {
				/* 学生 */
				var ans = '';
				ans = '<i class="answer" onclick="answer(\'' + realname + '\',\'' + content + '\')">回复</i>';
				html += '<li class="show1">' +
					'<dl class="self">' +
					ans +
					'<dd>' +
					'<span class="triangle-left-self1">&#9670</span>' +
					'<span class="triangle-left-self">&#9670</span>' +
					'<div></div>' +
					'<p>' + content + '</p>' +
					'</dd>' +
					'<dt>' +
					'<i>' + realname + '</i>' +
					'<img src="' + header + '" class="Gagtit" data-uid="' + wid + '"  onclick="stopUser(this)">' +
					'<img src="http://wimg.keepyoga.com/images/Gag.png" alt="" class="Gag">' +
					'<span></span>' +
					'</dt>' +
					'</dl>' +
					'</li>';
			}
		}
		if(tpageIndex == 1) {
			$("#_flg_li").before(html);
		} else {
			$("#list li").eq(0).after(html);
		}
	}
}

function talk(message) {
	if(message.length == PARAMETERS.courseId == message[2]) {
		if(message[3] == 'stop') {
			Modal.tips("<font color='#ccc'>您已经被限制性发言!</font>", "error", 2500);
			return;
		}
		if(message[3] == 'gapall') {
			Modal.tips("<font color='#ccc'>当前聊天室已被禁言！</font>", "error", 2500);
			return;
		}
		if(message[3] == 'system') {
			Modal.tips("<font color='#ccc'>当前聊天室不存在！</font>", "error", 2500);
			return;
		}
		if(message[3] == 'nologin') {
			Modal.tips("<font color='#ccc'>您未登录，请重新登录！</font>", "error", 2500, function() {
				window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + PARAMETERS.wxId + "&redirect_uri=" + PARAMETERS.ctx + "/" + PARAMETERS.urlsecret + "/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
			});
			return;
		}
	}
	var userid = PARAMETERS.userId;
	var isteacher = message[1];
	var roomid = message[2];
	if(PARAMETERS.courseId != roomid) {
		return;
	}
	var wid = message[3];
	var type = message[4];
	var content = message[5].replace('■', '|');
	var serverid = message[6];
	var mp3time = message[7];
	var realname = message[8];
	var header = message[9];
	if(header.indexOf('http') == -1) {
		header = PARAMETERS.ctx + "/" + header;
	}
	var html = "";
	var ls = isStudent(teacherids, wid),
		gl = isStudent(holderids, wid);

	/* 老师或管理员 */
	if(ls || gl) {
		var dtHead = null;
		/* 如果是管理员 */
		if(gl && ls) {
			var realname = "主持人",
				header = "http://wimg.keepyoga.com/112670388829777145.jpg";
			dtHead = '<i>' + realname + '</i>' +
				'<img src="' + header + '" alt="">';
		}
		/* 如果是老师 */
		else if(ls) {
			dtHead = '<i>' + realname + '<time>老师</tiem></i>' +
				'<img src="' + header + '" alt="" class="teachTap" data-num="' + wid + '" >' +
				'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">';

		} else {}
		/* 老师和管理员的文字发言 */
		if(type == '0') {
			html += '<li class="show1">' +
				'<dl class="student" id="teachText">' +
				'<dt>' +
				dtHead +
				'</dt>' +
				'<dd>' +
				'<span class="triangle-left-student1">&#9670</span>' +
				'<span class="triangle-left-student">&#9670</span>' +
				'<div></div>' +
				'<p class="iscrollPrevent" style="color:#41C3A8;">' + content + '</p>' +
				'</dd>' +
				'</dl>' +
				'</li>';
		} else if(type == '1') {
			if(content == "0") {
				html += '<li class="show1 show3">' +
					'<dl class="son" id="teachSon">' +
					'<dt>' +
					dtHead +
					'</dt>' +
					'<dd>' +
					'<button number="' + btnnum + '"  data-url="' + serverid + '" data-time="' + mp3time + '" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
					'<b class="_unread"></b>' +
					'<i class="time">' + mp3time + '"</i>' +
					'</dd>' +
					'</dl>' +
					'</li>';
			} else {
				html += '<li class="show1 show3">' +
					'<dl class="student teacherAns" id="teachText">' +
					'<dt>' +
					dtHead +
					'</dt>' +
					'<dd>' +
					'<span class="triangle-left-student1">&#9670</span>' +
					'<span class="triangle-left-student">&#9670</span>' +
					'<div></div>' +
					'<p>' + content + '</p>' +
					'<ol></ol>' +
					'<button number="' + btnnum + '" data-url="' + serverid + '" data-time="' + mp3time + '" onclick="playMp3(this)"><img src="http://wimg.keepyoga.com/image/son.png" alt=""></button>' +
					'<b class="_unread"></b>' +
					'<i class="time">' + mp3time + '"</i>' +
					'</dd>' +
					'</dl>' +
					'</li>';
			}
			btnnum++;
		} else {
			html += '<li class="show1">' +
				'<dl class="student" id="teachText" style="background:#f4f4f4;">' +
				'<dt >' +
				dtHead +
				'</dt>' +
				'<dd style="padding:0;border:none;background:#f4f4f4;">' +
				'<img src="' + serverid + '" class="picArray"/>' +
				'</dd>' +
				'</dl>' +
				'</li>';
		}
	} else {
		/* 学生 */
		var ans = '';
		/* ans = '<a href="javascript:answer(\''+realname+'\',\''+content+'\');" class="answer">回复</a>'; */
		ans = '<i class="answer" onclick="answer(\'' + realname + '\',\'' + content + '\')">回复</i>';
		html += '<li class="show1">' +
			'<dl class="self">' +
			ans +
			'<dd>' +
			'<span class="triangle-left-self1">&#9670</span>' +
			'<span class="triangle-left-self">&#9670</span>' +
			'<div></div>' +
			'<p>' + content + '</p>' +
			'</dd>' +
			'<dt>' +
			'<i>' + realname + '</i>' +
			'<img src="' + header + '" class="Gagtit" data-uid="' + wid + '"  onclick="stopUser(this)">' +
			'<img src="http://wimg.keepyoga.com/images/Gag.png" alt="" class="Gag">' +
			'<span></span>' +
			'</dt>' +
			'</dl>' +
			'</li>';
	}
	$("#_flg_li").before(html);
	topOrBottom('li:last-child');
}

function addComment() {
	if(!isConnection) { // 网络端口的情况
		reConnection();
		return;
	}
	if(nologin) {
		window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + PARAMETERS.wxId + "&redirect_uri=" + PARAMETERS.ctx + "/" + PARAMETERS.urlsecret + "/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	} else {
		if(isAdd) {
			Modal.tips("<font color='#ccc'>您的发送过于频繁，请稍后再进行发送!</font>", "error", 2500);
			return;
		} else if($("#Itext").val() == '') {
			Modal.tips("<font color='#ccc'>写点什么吧!</font>", "error", 2500);
			return;
		}
		var content = ahtml(escapeHtml($("#Itext").val()));
		sendMsg("talk|" + isteacher + "|" + PARAMETERS.courseId + "|" + PARAMETERS.userId + "|0|" + content + "|0|0");
		$("#Itext").val("");
		$("#Enter").css({ "color": "#939393" });
		if(!isStu) {
			isAdd = true;
			brush_frequency(5000);
		}
	}
}

function windowClose() {
	//alert("windowClose");
	if(keepyoga.socket && !nologin) {
		sendMsg("logout|" + PARAMETERS.courseId + "|" + PARAMETERS.userId);
		isConnection = false;
		keepyoga.socket.close();
	}
}

function fclose() { // 页面关闭，朝服务器发送离开命令
	//alert("fclose");
	if(isConnection) {
		sendMsg("logout|" + PARAMETERS.courseId + "|" + PARAMETERS.userId);
		isConnection = false;
		keepyoga.socket.close();
	}
}
if(!nologin) {
	if(!keepyoga.socket) {
		keepyoga.connect();
		timer = setInterval(function() { // 等待1秒钟在进行命令发送
			if(isConnection) {
				sendMsg("logout|" + PARAMETERS.courseId + "|" + PARAMETERS.userId);
				sendMsg("login|" + PARAMETERS.courseId + "|" + PARAMETERS.userId);
				sendMsg("getmsg|" + PARAMETERS.courseId + "|1|" + pageSize);
				clearInterval(timer);
				
			}
		}, 1000);
	} else
		console.log('websocket already exists .');
}
if(nologin) {

	window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + PARAMETERS.wxId + "&redirect_uri=" + PARAMETERS.ctx + "/" + PARAMETERS.urlsecret + "/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
}
/* 语音联播开始 */

function loadAudio(src, callback) {
	var audio = new Audio(src);
	audio.src = src;
	audio.onloadedmetadata = callback;

}
var base = "http://wimg.keepyoga.com/";
var playtimer, $playjdom;
function playMp3(jdom) {
	$playjdom = $(jdom);
	$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({ "width": "1rem" });
	if($playjdom.hasClass('playing')) {
		$playjdom.removeClass('playing');
		$("#audio111").get(0).pause();
	} else {
		$playjdom.addClass('playing');
		if(!$playjdom.hasClass('firstClick')) {
			$playjdom.addClass('firstClick');
			var mp3source = base + $(jdom).attr("data-url");
			$playjdom.find("img").css({ "width": "4.56rem" }).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
			$("#audio111").get(0).src = mp3source;
			loadAudio(mp3source, function() {
				$("#audio111").get(0).volume = 1;
				$("#audio111").get(0).play();
			});
			$playjdom.next("b").css("visibility", "hidden");
		} else {
			$("#audio111").get(0).play();
		}
	}
	$("#audio").get(0).pause();
}
var vid = document.getElementById("audio111");
vid.onended = function() {
	$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({ "width": "1rem" });
	var $b = $playjdom.parents(".show3").nextAll(".show3").eq(0).find("button");
	if($b.length) {
		playNextMp3($b);
		return;
	}
};
function playstart() {
	var interTime = parseInt($playjdom.attr("data-time")) + 2;
	$playjdom.find("img").css({ "width": "1rem" }).attr("src", PARAMETERS.ctx + "/images/songif.gif");
}
function playNextMp3(btn) {
	$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png");
	$("#audio111").get(0).pause();
	btn.next("b").css("visibility", "hidden");
	btn.find("img").css({ "width": "4.56rem" }).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
	$playjdom = btn;
	var mp3source = btn.attr("data-url");
	$("#audio111").get(0).pause();
	$("#audio111").get(0).src = base + mp3source;
	$("#audio111").get(0).volume = 1;
	$("#audio111").get(0).play();
}
/* 语音联播结束 */
/* 针对导师管理员学员做出的不同判断 */
window.teacherids = PARAMETERS.courseTeacherids;
window.holderids = PARAMETERS.courseHolderids;
function isStudent(str, obj) {
	if(str != "") {
		var teachArray = str.split(",");
		var i = 0,
			len = teachArray.length,
			noStudent = false;
		for(; i < len; i++) {
			if(teachArray[i] == obj) {
				noStudent = true;
				break;
			}
		}
		return noStudent;
	}
}
var isTeach = isStudent(teacherids, PARAMETERS.userId),
	isHolder = isStudent(holderids, PARAMETERS.userId);
window.onload = function() {
	/* loading */
	$("#audio111").get(0).src = '';
	$("#audio111").get(0).play();
	$(".stash").css("display", "none");
	window.isStudent = isStudent;
	if(isTeach || isHolder) {
		isStu = true;
		isteacher = 1;
		$("#headTit").show();
		$("#mainBox").addClass("mainBox2");
		$("#gapall").css("display", "block");
		/* 底部消息区域显示 */
		$("#lsOrGl").show();
		$("#xs").remove();
		if(isTeach) {
			var link1 = $("<link rel='stylesheet' href='" + PARAMETERS.ctx + "/css/mildwinter1.css'/>");
			$("#link").after(link1);
		}
	} else {
		isStu = false;
		/* 底部消息区域显示 */
		$("#xs").show();
		$("#lsOrGl").remove();
		$("#gapall").remove()
	}

	/* 点击去顶部或底部 */
	$("#goBottom").on("tap", function() {
		// myiscroll.scrollToElement('li:last-child', 400, true);
		topOrBottom('li:last-child');
	})
	$("#goTop").on("tap", function() {
		topOrBottom('li:first-child');
	})
	$("footer").on("tap", function() {
		topOrBottom('li:last-child');
	})
	$("#Itext").on("focus", function() {
		topOrBottom('li:last-child');
	})
	$("footer").on("tap", function() {
		topOrBottom('li:last-child')
	})
	/* share弹框 */
	$(".tapShare").on("tap", function() {
		$("#fxBox").show();
		$(".masking1").show();
	})
	$("#fxBox").on("tap", function() {
		$("#fxBox").hide();
	})

	/* 点击关闭按钮  关闭 老师针对学员回复区域 */
	$(".teachAnser img").on("tap", function() {
		$(".teachAnser").hide();
	})
}
/* 判断函数，当消息不止一频幕的时候才能goTop or  goBottom */
function topOrBottom(str) {
	var bodyH = $("#mainBox").height(),
		ulH = $("#list").height();
	if(ulH > bodyH) {
		myiscroll.scrollToElement(str, 400, true);
	}
}
/*弹框*/
function dialog1() {
	var maskDiv = $("<div class='mask'>");
	$("<img src='" + PARAMETERS.ctx + "/images/wx_recold.gif'>").appendTo(maskDiv);
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
		goumai: function() {
			/*确定禁言*/
			gag();
			$("#noshop").remove();
			$(".masking").remove();
		},
		shikan: function() {
			/*取消*/
			$("#noshop").remove();
			$(".masking").remove();
		}
	})
}
/*禁止刷频*/
function brush_frequency(time) {
	setTimeout(function() {
		isAdd = false;
	}, time)
}
/*聊天系统开始*/
pullDown = function() {
	tpageIndex = tpageIndex + 1;
	sendMsg("getmsg|" + PARAMETERS.courseId + "|" + tpageIndex + "|" + pageSize);
	clearInterval(timer);
}
var Sucess = false;

function loaded() {
	var getTeA = false;
	myiscroll = new iScroll("mainBox", {
		preventDefault: false,
		useTransition: false,
		vScrollbar: false,
		checkDOMChanges: true,
		onBeforeScrollStart: function(e) {
			if(e.target.className != "iscrollPrevent" || e.target.tagName != "BUTTON") {
				e.preventDefault();
			}
			getTeA = false;
		},
		onScrollMove: function() {
			if(myiscroll.y >= 30) {
				Sucess = true;
			} else {
				Sucess = false;
			}
			if((this.y - 900) < (this.maxScrollY)) {
				getTeA = true;
			}
		},
		onScrollLimit: function() {},
		onScrollEnd: function() {
			if(Sucess && getAll) {
				pullDown();
				$("#mainBox").addClass("p_t20");
				$("#loading").show();
			}
			if(getTeA && getTeach) {
				inx++;
				getTeacherMsg(inx);
				$("#loading").show();
			}
		}
	})
}
document.addEventListener('touchmove', function(e) {
	e.preventDefault();
}, false);
document.addEventListener('DOMContentLoaded', loaded, false);

/*聊天系统结束*/
/*导师录音开始*/
$.fn.longPress = function(record, stopRecord, Enterfn) {
	var nowTime = null,
		timeout = null,
		longtap = false;
	var isPaused = false,
		isPaused1 = false;
	/*手指按下*/
	$(this)[0].addEventListener('touchstart', function(event) {
		if(!$("#audio").get(0).paused) {
			$("#audio").get(0).pause();
			isPaused = true;
		}
		if(!$("#audio111").get(0).paused) {
			$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png");
			$("#audio111").get(0).pause();
			isPaused1 = true;
		}
		wx.checkJsApi({
			jsApiList: ['startRecord'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
			success: function(res) {
				console.log("success");
			},
			error: function(res) {
				Modal.tips("<font color='#ccc'>res！</font>", "error", 2500)
			}
		});
		$(this).html("松开&nbsp;&nbsp;结束");
		$(this).css("background", "#e8e8e8");
		timeout = setTimeout(function() {
			longtap = true;
			record();
			nowTime = new Date().getTime();
		}, 300);
		event.preventDefault();

	}, false);
	/*手指松开*/
	$(this)[0].addEventListener('touchend', function(event) {

		recordtime = realtime;
		realtime = 1;
		if(longtap) {
			clearInterval(mp3Timer);
			if(new Date().getTime() - nowTime >= 3000) {
				$(".mask").remove();
				Enterfn();

			} else if(new Date().getTime() - nowTime < 3000) {
				cutrecord();
				$(".mask").find("img").attr("src", PARAMETERS.ctx + "/images/no_son.png");
				$(".mask").find("img").addClass("short-time");
				$(".mask").find("p").html("录音时间太短！");
				setTimeout(function() {
					$(".mask").remove();
				}, 500);
			} else {
				$(".mask").remove();
			}
		}
		$(this).html("按住&nbsp;&nbsp;说话");
		$(this).css("background", "white");
		if(isPaused) {
			$("#audio").get(0).play();
		}
		if(isPaused1) {
			$("#audio111").get(0).play();

		}

		clearTimeout(timeout);
		longtap = false;
		event.preventDefault();
	}, false);
}
/* 导师录音功能结束 */
/* 长按录音开始 */
function longTap(str) {
	if($(str).length) {
		$(str).longPress(
			function() {
				dialog1();
				console.log("开始录音");
				startrecord();
			},
			function() {},
			function() {
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
$(".showtype").on("click", function() {
	if(nologin) {
		window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + PARAMETERS.wxId + "&redirect_uri=" + PARAMETERS.ctx + "/" + PARAMETERS.urlsecret + "/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	};
	tpageIndex = 1;
	if(showtype == 0) {
		getAll=true;
		firtStudent=false;
		getTeach = false;
		showtype = 1;
		$(this).find("i").removeClass("active");
		$(this).find("span").html("只看导师");
		$("#list").find(".show1").remove();
		sendMsg("getmsg|" + PARAMETERS.courseId + "|1|" + pageSize);
		clearInterval(timer);
		pullDown = function() {
			tpageIndex = tpageIndex + 1;
			console.log(tpageIndex)
			sendMsg("getmsg|" + PARAMETERS.courseId + "|" + tpageIndex + "|" + pageSize);
			clearInterval(timer);
		};
		$("#loading").show();
	} else {
		getAll=false;
		firtStudent=true;
		inx=1;
		$("#loading").show();
		getTeach = true;
		//pullDown = function() {};
		showtype = 0;
		$(".show1").remove();
		$(this).find("i").addClass("active");
		$(this).find("span").html("查看全部");
		getTeacherMsg(1);
	}
	topOrBottom('li:first-child');
});
/*点击回复显示*/
function answer(name, content) {
	question = content;
	$(".text").html(content);
	$(".name").html("回复" + name + ":");
	$(".teachAnser").show();
}
/* 发送图片相关逻辑 */
$(".sendImage").on("click", function() {
	choseImages();
});

function choseImages() {
	wx.chooseImage({
		count: 1, // 默认9
		sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
		sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
		success: function(res) {
			var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
			uploadmage(localIds);
		}
	});
}
function uploadmage(localid) {
	wx.uploadImage({
		localId: localid.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
		isShowProgressTips: 1, // 默认为1，显示进度提示
		success: function(res) {
			var serverId = res.serverId; // 返回图片的服务器端ID
			uploadToCDN(serverId);
		}
	});
}
function uploadToCDN(serverid) {
	$.post(PARAMETERS.ctx + "/weixin/uploadweixinimage.do", { "serverid": serverid }, function(data) {
		sendMsg("talk|" + isteacher + "|" + PARAMETERS.courseId + "|" + PARAMETERS.userId + "|2|" + question + "|" + data + "|" + recordtime);
	});
}

function downloadImage(serverid) {
	wx.downloadImage({
		serverId: serverid.toString(), // 需要下载的图片的服务器端ID，由uploadImage接口获得
		isShowProgressTips: 1, // 默认为1，显示进度提示
		success: function(res) {
			var localId = res.localId; // 返回图片下载后的本地ID
			alert(JSON.stringify(res))
		}
	});
}
/* 点击图片变轮播--微信 */
$(document).on('click', 'dd img.picArray', function(event) {
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
$("#list").on("click", ".teachTap", function() {
	var teachNum = $(this).attr("data-num");
	window.location.href = PARAMETERS.ctx + "/w/faq/person.html?p=" + teachNum;
})

/*点击向上向下箭头收起展开视频区域*/
$("#arrow_up").on("click", function() {
	if(isTeach || isHolder) {

		if(!$(this).hasClass("UP")) {
			$("#audioMask").hide();
			$("#mainBox").addClass("mainBox3");
			$(".audio_video").slideUp(400, function() {
				$("#arrow_up").addClass("UP");
			});
			$("#headTit").addClass('teach-remind1');
			$("#arrow_up").text('显示');
			$("#list").css("padding-bottom", 11 + "rem");
		} else {
			$("#arrow_up").text('隐藏');
			$("#headTit").removeClass('teach-remind1');
			$(".audio_video").slideDown(400, function() {
				$("#arrow_up").removeClass("UP");
				$("#mainBox").removeClass("mainBox3");
				$("#audioMask").show();
			});
		}
	} else {
		if(!$(this).hasClass("UP")) {
			$("#list").css("padding-bottom", 11 + "rem");
			$("#arrow_up").text('显示');
			$("#audioMask").hide();
			$("#mainBox").addClass("mainBox1");
			$(".audio_video").slideUp(400, function() {
				$("#arrow_up").addClass("UP");
			});
		} else {
			$("#arrow_up").text('隐藏');
			$(".audio_video").slideDown(400, function() {
				$("#arrow_up").removeClass("UP");
				$("#mainBox").removeClass("mainBox1");
				$("#audioMask").show();
			});
		}
	}

});
/*输入框有内容，按钮变色*/
function keyup() {
	if($("#Itext").val().length != 0) {
		$("#Enter").css("color", "#41C3A8");
	} else {
		$("#Enter").css("color", "#939393");
	}
}
/*语音文字切换开始*/
$("#recold").on('click', function() {
	if(!$(this).hasClass("YES")) {
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
$("#audioMask").click(function() {
	$("#audio").get(0).play();
	var $audio111=$("#audio111").get(0);
	if(!$audio111.paused){
		$("#audio111").get(0).pause();
			$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({ "width": "1rem" });
	}
	$(".audio_style").remove();
	$(this).remove();
})

/* 全员禁言 */
function gapall(v) {
	var gapCommand = $(v);
	if(!isConnection) {
		console.log("gapall:::connection is not online!!!!!")
		return;
	}
	if(gapCommand.hasClass("gapall")) {  // 当前禁言状态，恢复开放发言
		sendMsg("gapall|" + PARAMETERS.courseId + "|" + PARAMETERS.userId + "|0");
		$(v).removeClass("gapall");
		Modal.tips("<font color='#ccc'>全员解禁成功!</font>", "error", 2500);
	} else {
		sendMsg("gapall|" + PARAMETERS.courseId + "|" + PARAMETERS.userId + "|1");
		$(v).addClass("gapall");
		Modal.tips("<font color='#ccc'>全员禁言成功!</font>", "error", 2500);
	}
}
/* 对单个学员禁言 */
function stopUser(this_) {
	var su = teacherids.split(",");
	var cuid = PARAMETERS.courseTid;
	var uid = PARAMETERS.userId;
	var inlist = false;
	for(var s in su) {
		if(su[s] == uid) {
			inlist = true;
			break;
		}
	}
	$this = $(this_);
	var wid = $this.attr("data-uid");
	if(inlist) {
		silence("禁言后不可取消，您确定要对该用户禁言吗？", function() {
			/*禁言*/
			$this.siblings().show();
			$(".self dt img.Gagtit").each(function(inx) {
				if($(".self dt img.Gagtit").eq(inx).attr("data-uid") == wid) {
					$(".self dt img.Gagtit").eq(inx).siblings().show();
				}
			})
			sendMsg("stopuser|" + PARAMETERS.courseId + "|" + wid);
		})
	}
}
var $height = $(window).height();
$(window).resize(function() {
	var $h = $(window).height();
	if($h < $height) {
		if(isTeach || isHolder) {
			if(isTeach || isHolder) {
				$("#audioMask").css('display', 'none');
				$(".audio_video").slideUp(400, function() {
					$("#arrow_up").addClass("UP");
					$("#mainBox").addClass("mainBox3");
					$("#headTit").addClass('teach-remind1');
					$("#arrow_up").text('显示');
				});
			} else {
				$("#audioMask").css('display', 'none');
				$(".audio_video").slideUp(400, function() {
					$("#arrow_up").addClass("UP");
					$("#mainBox").addClass("mainBox1");
				});
				$("#arrow_up").text('显示');
			}
		}
	}
})
$("#close").on("click", function() {
	$("#codeBox1").remove();
	$("#codeBox2").remove();
})
$("#codeBox1").on("click", function() {
	$("#codeBox1").remove();
	$("#codeBox2").remove();
})