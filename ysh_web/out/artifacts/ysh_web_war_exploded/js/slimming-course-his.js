// if(PARAMETERS.isflow == 2) {
// 	var sHTML = "<div class='masking-box' id='codeBox1'></div><div class='code-box' id='codeBox2'><img src='" + PARAMETERS.ctx + "/images/close.jpg' class='close' id='close'><p class='tit'>您未关注随心瑜Live，请先关注!!!</p><img src='http://wimg.keepyoga.com/images/ysh-logo.jpg'><p>长按二维码，即可关注</p></div>"
// 	$('body').append(sHTML);
// }
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
var success = false;
var myScroll = null;
//去除浏览器默认事件
document.addEventListener('touchmove', function(e) {
	e.preventDefault();
}, false);
//domready后绑定初始化事件
document.addEventListener('DOMContentLoaded', loaded, false);
/*页面初始化立即加载函数*/
function loaded() {
	myScroll = new iScroll('mainBox', {
		vScrollbar: false,
		onBeforeScrollStart: function(e) {
			if(e.target.className != "iscrollPrevent") {
				e.preventDefault();
			}
		},
		onScrollStart: function() {
			myScroll.refresh();
		},
		onScrollLimit: function() {},
		onScrollMove: function() {

		},
		onScrollEnd: function() {
			if((this.y - 500) < this.maxScrollY && success) {
				if(success) {
					loadStore();
				}
			}
		}
	});
}

function topOrBottom(str) {
	var bodyH = $("#mainBox").height(),
		ulH = $("#list").height();
	if(ulH > bodyH) {
		myScroll.scrollToElement(str, 400, true);
	}
}
/* 语音联播结束 */
/* 判断函数，当消息不止一频幕的时候才能goTop or  goBottom */
$("#goBottom").on("tap", function() {
	// myiscroll.scrollToElement('li:last-child', 400, true);
	topOrBottomIscroll('li:last-child');
})
$("#goTop").on("tap", function() {
	topOrBottomIscroll('li:first-child');
})
window.topOrBottomIscroll = topOrBottom;
/*调用fastclick*/
FastClick.attach(document.body);
/*  全局变量    */
var isConnection = false, // 链接是否有效
	timer, // 登陆定时器
	voice = {
		localId: '',
		serverId: ''
	},
	isowninitiative = false, // 是否主动离开 ；
	RecordTimer,
	isReconnection = false, // 是否是用户本人确定了重连 
	nologin = PARAMETERS.nologin == "true",
	isAdd = false,
	tpageIndex = 0,
	recordid,
	mp3Timer,
	recordtime = 1,
	realtime = 1,
	pageSize = 10,
	nowH = 0,
	playingId,
	btnnum = 1,
	playnum = 1,
	question = "0",
	showtype = 1,
	managerid = PARAMETERS.courseMamagerid,
	linka = window.location.href;
var pageIndex = 1;
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
// 转义HTML
function escapeHtml(ctn) {
	return ctn.replace(/&/g, '&amp;').replace('|', '■').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/\n/g, '<br>');
}

function ahtml(ctn) {
	return ctn.replace(/((https?|s?ftp):\/\/)?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)\b)\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?\b/ig, function(a, b) {
		return '<a target="_blank" href="' + (b ? '' : 'http://') + a.replace(/&#38;/g, '&') + '">' + a + '</a>'
	})
}
document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
	WeixinJSBridge.call('showOptionMenu');
});
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

function loadStore(callback) {
	var getdaturl = PARAMETERS.ctx + "/w/chat/msg/json.html?p=" + PARAMETERS.courseId + "&pageIndex=" + (pageIndex) + "&type=" + showtype;
	$.ajax({
		type: "post",
		dataType: "json",
		url: getdaturl,
		error: function(XMLHttpRequest, textStatus, error) {},
		success: function(msg) {
			if(msg != '' && msg != undefined) {
				var html = "",
					ouid = PARAMETERS.courseTid;
				for(var i = 0; i < msg.length; i++) {
					var userid = PARAMETERS.userId;
					var wid = parseInt(msg[i].wid);
					var isteacher = parseInt(msg[i].isteacher);
					var type = parseInt(msg[i].type);
					var content = msg[i].content.replace('■', '|');
					var header = msg[i].header;
					var mp3path = msg[i].mp3path;
					var mp3time = msg[i].mp3time;
					var realname = msg[i].nickname;
					var serverid = msg[i].serverid;
					if(header.indexOf('http') == -1) {
						header = PARAMETERS.ctx + "/" + header;
					}
					var ls = isStudent(teacherids, wid),
						gl = isStudent(holderids, wid);
					var dtHead = null;
					/* 如果是管理员 */
					if(gl && ls) {
						var realname = "主持人",
							header = "http://wimg.keepyoga.com/112670388829777145.jpg";
						dtHead = '<i>' + realname + '</i>' +
							'<img src="' + header + '" ';

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
								html += '<li class="show1 show2 ">' +
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
								html += '<li class="show1 show2 show3">' +
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
								'<img src="' + serverid + '" class="picArray" />' +
								'</dd>' +
								'</dl>' +
								'</li>';
						}
					} else if(ls) {
						dtHead = '<i>' + realname + '<time>老师</time></i>' +
							'<img src="' + header + '" alt="" class="teachTap" data-num="' + wid + '" >' +
							'<img src="http://wimg.keepyoga.com/images/teach.png" alt="" class="teachHead">';
						if(type == '0') {
							html += '<li >' +
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
								html += '<li class="show3">' +
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
								html += '<li class=" show3">' +
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
							html += '<li>' +
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
					} else {
						/* 学生 */
						var ans = '';
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
				$("#list").html();
				$("#list").append(html);
				$("#loading").css("display", "none");
				pageIndex++;
				success = true;
				callback && callback()

			} else {
				success = false;
			}
		}
	});
}
window.sessionStorage.clear();
var link1 = $("<link rel='stylesheet' href='" + PARAMETERS.ctx + "/css/mildwinter1.css'/>");
loadStore();
$(".showtype").on("click", function() {
	$("#list").html("");
	pageIndex = 1;
	if(showtype == 9) {
		$("#loading").show();
		showtype = 1;
		$(this).find("i").css({
			"background-image": "url('http://wimg.keepyoga.com/images/interact_icon2.png')",
			"background-repeat": "no-repeat"
		});
		$(this).find("span").html("只看导师");
		$("#minldwinter3").remove();
	} else {
		$("#loading").show();
		showtype = 9;
		$(this).find("i").css({
			"background-image": "url('http://wimg.keepyoga.com/images/interact_icon3.png')",
			"background-repeat": "no-repeat"
		});
		$(this).find("span").html("查看全部");
		$("#link").after(link1);
		$(".show1").hide();
	}
	loadStore(function() {
		topOrBottom('li:first-child');
	});

});
/* 语音联播开始 */
function loadAudio(src, callback) {
	var audio = new Audio(src);
	audio.src = src;
	audio.onloadedmetadata = callback;

}
var base = "http://wimg.keepyoga.com/";
var playtimer, $playjdom;

function playMp3(jdom) {
	console.log(0);
	$playjdom = $(jdom);
	$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({
		"width": "1rem"
	});
	if($playjdom.hasClass('playing')) {
		$playjdom.removeClass('playing');
		$("#audio111").get(0).pause();
	} else {
		$playjdom.addClass('playing');
		if(!$playjdom.hasClass('firstClick')) {
			$playjdom.addClass('firstClick');
			var mp3source = base + $(jdom).attr("data-url");
			$playjdom.find("img").css({
				"width": "4.56rem"
			}).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
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
	$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({
		"width": "1rem"
	});
	var $b = $playjdom.parents(".show3").nextAll(".show3").eq(0).find("button");
	if($b.length) {
		playNextMp3($b);
		return;
	}
};

function playstart() {
	var interTime = parseInt($playjdom.attr("data-time")) + 2;
	$playjdom.find("img").css({
		"width": "1rem"
	}).attr("src", PARAMETERS.ctx + "/images/songif.gif");
}

function playNextMp3(btn) {
	$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png");
	$("#audio111").get(0).pause();
	btn.next("b").css("visibility", "hidden");
	btn.find("img").css({
		"width": "4.56rem"
	}).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
	$playjdom = btn;
	var mp3source = btn.attr("data-url");
	$("#audio111").get(0).pause();
	$("#audio111").get(0).src = base + mp3source;
	$("#audio111").get(0).volume = 1;
	$("#audio111").get(0).play();
}

/* 进入导师个人主页 */
$("#list").on("tap", ".teachTap", function() {
	var teachNum = $(this).attr("data-num");
	window.location.href = PARAMETERS.ctx + "/w/faq/person.html?p=" + teachNum;
})

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

$("#audioMask").click(function() {
	createVideo();
	$("#audio").get(0).play();
	var $audio111 = $("#audio111").get(0);
	if(!$audio111.paused) {
		$("#audio111").get(0).pause();
		$("button").find("img").attr("src", PARAMETERS.ctx + "/images/son.png").css({
			"width": "1rem"
		});
	}
	$(".audio_style").remove();
	$(this).remove();
})
$("#close").on("click", function() {
	$("#codeBox1").remove();
	$("#codeBox2").remove();
})
$("#codeBox1").on("click", function() {
	$("#codeBox1").remove();
	$("#codeBox2").remove();
})