//判断当前用户的身份

function status(){
	var isTeach = jspS.teacherids.split(","),
	isholder = jspS.holderids.split(",");

	if(isTeach.indexOf(jspS.userid)!==-1){
		return 2;
	}else if(isholder.indexOf(jspS.userid)!==-1){
		return 1;
	}else{
		return 0;
		
	}
}
		var vw = new Vue({
		el: "#app",
		data: {
			dataCheck: 0,// 学员的消息是否为提问
			identity: status(),// 用户的身份/0-学员1-主持人2-导师
			audioSrc:"http://wimg.keepyoga.com/NOVOICE.mp3",// 初始化一个音频路径，解决报错
			questionNickname:"",
			questionContent:"",
			datas:[]// 消息体部分
		},
		methods: {
			playVideo: function() {// 播放视频
				$("#app").find(".removeVideoMask").remove();
				
				if(!$("audio").get(0).paused){
					$("audio").get(0).pause();
				}
				$("#video").get(0).play();
			},
			closeLive:function(){// 关闭直播间
				console.log("关闭直播间")
			}
		}
	});
		
var ws = null;
// 实例化socket
if ("WebSocket" in window){
	 console.log("您的浏览器支持websocket通讯");
	 // newWebSocket();
	 var ws = new WebSocket("ws://localhost:8080/ws/coursechat/2222/1111");
	 ws.onopen = function(event){
	 };	
	ws.onmessage = function(evt){
		vw.datas = vw.datas.concat(JSON.parse(evt.data));
		console.log(JSON.parse(evt.data));
	};
}else{
	 console.log("您的浏览器不支持websocket通讯");
}
$(function() {
	// 调用fastclick插件
	FastClick.attach(document.body);
	var Dom = {
		mainBox: $("#mainBox"),
		countDownBox: $("#countDownBox"), // 倒计时
		showHideCourse: $("#showHideCourse"), // 隐藏课件按钮
		inputBox: $("#studentBox"), // 学员的整体
		placeholder: $("#placeholder"), // 提示文字
		inputText: $("#inputText"), // 输入框
		checkBox: $("#checkBox"), // 是否提问
		enterBtn: $("#enterBtn"), // 发送按钮
		tab: $("#tab"), // 切换全部提问tab
		allBoxQuestion: $("#allBoxQuestion"),
		allBoxAll: $("#allBoxAll"),
		backGap: $("#backGap"), // 回到直播盒子
		startGapBox: $("#startGapBox"),
		tips: $("#tips"), // tips
		teachSendBox: $("#teachSendBox"), // 导师发送消息的盒子
		recordBox: $("#recordBox"), // 录音盒子
		time: $("#time"),
		audios:$("audio").get(0),
		videos:$("#video").get(0),
		app:$("#app"),
		btnBroupBox:$("#btnBroupBox")
	};
	var variable = {
		inputText: "",
		mainBox: true,
		left: false,
		right: false
	};
	
	$(document).one("click",function(){
		Dom.app.addClass("play");
		Dom.audios.play();
	})

	var $audio = null;
	Dom.app.on("click","button.btn",function(){
		if(!$("#video").get(0).paused){
			$("#video").get(0).pause();
		};
		Dom.app.addClass("play");
		$audio = $(this);
		audioPlay($audio);
		onended($audio);
	});
	function onended($this){
		var _this = $this;
		
		$("audio").get(0).onended=function(){
			$("button.btn").find("img").css({"width":".5rem","height":".5rem"}).attr("src", "http://wimg.keepyoga.com/image/son.png");
			audioNext(_this);
		}
	};
	function audioNext($this){
		var audioBtnBox = $this.parents(".audio-btn-box").nextAll(".audio-btn-box"),
		audioItem = $this.parents(".item").nextAll(".item").find(".audio-btn-box");
		if(audioBtnBox.length){
			$audio = audioBtnBox.eq(0).find("button.btn");
			audioPlay($audio);
		}else if(audioItem.length){
			$audio = audioItem.eq(0).find("button.btn");
			audioPlay($audio);
		}
	};
	function audioPlay($audio){
		$("button.btn").find("img").css({"width":".5rem","height":".5rem"}).attr("src", "http://wimg.keepyoga.com/image/son.png");
		var $this = $audio;
		src = $this.attr("data-src");
		$("audio").get(0).src = src;
		$("audio").get(0).play();
		$audio.find("img").css({ "width": "1rem" }).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
		onended($this);
	};
	$("audio").get(0).onplaying = function(){
		if(!Dom.app.hasClass("play")){
			$audio.find("img").css({ "width": "1rem" }).attr("src", "http://wimg.keepyoga.com/images/songif.gif");
			var cicle = $audio.next(".audio-time-box").find(".cicle");
			if(cicle.length){
				cicle.remove();
			}
		}
	};
	var dataTime = 1592503480000;
	// 判断倒计时框还存不存在
	function checkCountDownBox() {
		if(Dom.countDownBox.css('display') == "none") {
			return true;
		} else {
			return false;
		}
	};
	function setDate() { // 设置一个开课日期
		format = new Date(dataTime),
			startDate = startDates(format);
		Dom.countDownBox.find("p").text("本次直播将于" + startDate.year + "年" + startDate.month + "月" + startDate.ri + "日   " + startDate.hours + ":" + startDate.minutes + ":" + startDate.seconds + "开始");
	};
	// 获取开课日期
	function startDates(data) {
		return {
			year: data.getFullYear(),
			month: data.getMonth() + 1,
			ri: data.getDate(),
			hours: data.getHours(),
			minutes: data.getMinutes(),
			seconds: data.getSeconds()
		};
	};
	// 设置倒计时
	var nowTime = function() {
		var data = dataTime - (new Date().getTime()),
			total = data / 1000;
		var day = parseInt(total / (24 * 60 * 60)); // 计算整数天数
		var afterDay = total - day * 24 * 60 * 60; // 取得算出天数后剩余的秒数
		var hour = parseInt(afterDay / (60 * 60)); // 计算整数小时数
		var afterHour = total - day * 24 * 60 * 60 - hour * 60 * 60; // 取得算出小时数后剩余的秒数
		var minutes = parseInt(afterHour / 60); // 计算整数分
		var seconds = parseInt(total - day * 24 * 60 * 60 - hour * 60 * 60 - minutes * 60); // 取得算出分后剩余的秒数
		if(data <= 0) {
			Dom.mainBox.css("top", "4.22rem")
			Dom.countDownBox.hide();
			tips("直播已经开始开始");
			clearInterval(timer);
		} else {
			Dom.countDownBox.find(".day").text(day);
			Dom.countDownBox.find(".hour").text(hour);
			Dom.countDownBox.find(".minutes").text(minutes);
			Dom.countDownBox.find(".seconds").text(seconds);
		}
	}
	setDate();
	nowTime();
	var timer = "";
	if(!checkCountDownBox()) {
		var timer = setInterval(function() {
			nowTime();
		}, 1000);
	};
	// 关闭正在加载
	setTimeout(function() {
		$("#stash").remove();
	}, 0);

	// 点击隐藏关闭视频按钮
	Dom.showHideCourse.click(function() {
		if(!$(this).hasClass("show")) {
			hideVideo($(this));
		} else {
			showVideo($(this));
		};
	});
	// 隐藏视频区域
	function hideVideo($this) {
		$this.find(".text1").hide();
		$this.find(".text2").show();
		$this.addClass("show");
		$("#videoBox").slideUp(100);
		if(!checkCountDownBox()) {
			Dom.mainBox.css("top", "1.1rem");
		} else {
			Dom.mainBox.css("top", "0");
		}
	};
	// 显示视频区域
	function showVideo($this) {
		$this.find(".text1").show();
		$this.find(".text2").hide();
		$this.removeClass("show");
		$("#videoBox").slideDown(100);
		if(!checkCountDownBox()) {
			Dom.mainBox.css("top", "5.32rem");
		} else {
			Dom.mainBox.css("top", "4.22rem");
		};
	};

	// 点击编辑文字的区域
	Dom.inputBox.on("click", function(e) {
		var targetId = e.target.id,
			target = e.target,
			tagname = target.tagName.toLocaleLowerCase();
		// 点击的是input 隐藏提示文字
		if(targetId == "inputText" || targetId == "placeholder" || tagname == "font") {
			Dom.placeholder.hide();
			setTimeout(function() {
				Dom.inputText.focus();
			}, 0);
		};
		// 点击是否勾选提问按钮
		if(target.closest("#checkBox")) {
			vw.dataCheck ? checked() : check();
		};
		if(targetId == "enterBtn") {
			Dom.enterBtn.hasClass("curr") ? enterText() : "";
		};
	});
	
	// 老师的页面的下拉加载以前的数据
	Dom.mainBox.on("scroll",function(e){
		
	});
	// 发送文字消息
	function enterText() {
		var text = Dom.inputText.text();
		var obj = {
				"userId":jspS.userid,// 用户id
				"userNickName":jspS.nickname,// 用户昵称
				"userHeaderImg":	jspS.pic,// 用户头像
				"requestType":"talk",// 请求类型
				"status":vw.identity,// 用户身份
				"roomId":jspS.roomid+"_room",// 房间id
				"talkType":"0",// 消息类型 0-文字1-语音2-图片
				"parentId":"",
				"content":text,// 消息类容
				"readStatus":0,
				"undoStatus":0,
				"askId":"",
				"isAsk":vw.dataCheck// 是否是问题
		};
		var objStr = JSON.stringify(obj);
		ws.send(objStr);
		vw.dataCheck= 0;
		Dom.enterBtn.removeClass("curr");
		Dom.inputText.text("");
		variable.inputText = "";
		$("#teachAudioBox").hide();
	};
	// 勾选转态
	function checked() {
		vw.dataCheck = 0;
	};
	// 未勾选转态
	function check() {
		vw.dataCheck = 1;
		
	};
	// 输入框输入文字时变色
	Dom.inputText.keyup(function() {
		var len = 200;
		var inputTextLen = $(this).text().length;
		var inputText = $(this).text();
		if(inputTextLen == 0) {
			Dom.enterBtn.hasClass("curr") ? Dom.enterBtn.removeClass("curr") : "";
			return;
		}
		if(inputTextLen > 0 && inputTextLen < 14) {
			Dom.enterBtn.hasClass("curr") ? "" : Dom.enterBtn.addClass("curr");
			return;
		}
		if(inputTextLen >= 14) {
			return;
		}
	});
	// 点击按钮操作
	Dom.btnBroupBox.on("click", function(e) {
		var target = e.target;
		if(target.closest("#btnBoxBottom")) {
			// 判断是在哪个页面
			if(variable.mainBox && !variable.left && !variable.right) {
				goBottom(Dom.mainBox);
			} else if(!variable.mainBox && variable.left && !variable.right) {
				goBottom(Dom.allBoxAll);
			} else if(!variable.mainBox && !variable.left && variable.right) {
				goBottom(Dom.allBoxQuestion);
			} else {
				return;
			};
			tips("已返回底部");
		}
		if(target.closest("#btnBoxTop")) {
			// 判断是在哪个页面
			if(variable.mainBox && !variable.left && !variable.right) {
				goTop(Dom.mainBox);
			} else if(!variable.mainBox && variable.left && !variable.right) {
				goTop(Dom.allBoxAll);
			} else if(!variable.mainBox && !variable.left && variable.right) {
				goTop(Dom.allBoxQuestion);
			} else {
				return;
			};
			tips("已返回顶部");
		}
		if(target.closest("#btnBoxAsk")) {
			$("#mainBox1").css("top", 0);
			Dom.btnBroupBox.find(".ask-size").hide();
			$("#btnBoxAsk").hide();
			variable.mainBox = false;
			Dom.teachSendBox.addClass("w50");
			if(Dom.tab.find(".left").hasClass("curr")) {
				variable.left = true;
				variable.right = false;
				return;
			} else {
				variable.left = false;
				variable.right = true;
			}
		}
	});

	function goBottom(Dom) {
		if(Dom == "mainBox") {
			var mainBoxHeight = $("#mainBox").find("ul").height()
		} else {
			var mainBoxHeight = Dom.height();
		}
		Dom.animate({
			scrollTop: mainBoxHeight
		}, 0);
	};

	function goTop(Dom) {
		Dom.animate({
			scrollTop: 0
		}, 0);
	};
	Dom.mainBox.scroll(function() {
		var a = $("#mainBox").scrollTop();
	})
	// 切换顶部导航
	Dom.tab.on("click", "li", function() {
		var $this = $(this);
		if($this.hasClass("left")) {
			Dom.tab.find(".bottom").addClass("curr");
			Dom.tab.find(".bottom1").removeClass("curr");
			Dom.allBoxAll.removeClass("all-box-all");
			Dom.allBoxQuestion.addClass("all-box-question");
			variable.right = false;
			variable.left = true;
		} else {
			Dom.tab.find(".bottom1").addClass("curr");
			Dom.tab.find(".bottom").removeClass("curr");
			Dom.allBoxAll.addClass("all-box-all");
			Dom.allBoxQuestion.removeClass("all-box-question");
			variable.left = false;
			variable.right = true;
		};
		Dom.tab.find("li").removeClass("curr");
		$(this).addClass("curr");
	});
	// 回到直播和全员禁言逻辑
	Dom.backGap.on("click", "button", function() {
		var $this = $(this);
		if($this.hasClass("back")) {
			// 回到直播
			$("#mainBox1").css("top", 100 + "%");
			Dom.btnBroupBox.find(".ask-size").show();
			$("#btnBoxAsk").show();
			variable.mainBox = true;
			variable.left = false;
			variable.right = false;
			Dom.teachSendBox.removeClass("w50");
		} else {
			// 全员禁言
			if($this.text() == "全员禁言") {
				changePanleText("全员禁言模式", "全员禁言后，全员不能发言", "all-gap");
				// 全员禁言逻辑
			} else {
				changePanleText("全员解除禁言", "解除禁言后，全员可进行发言", "all-nogap");
				// 全员解禁逻辑
			}
		}
	});
	// 修改禁言弹出框的文案
	function changePanleText(h1, p, dataid) {
		Dom.startGapBox.find("h1").text(h1);
		Dom.startGapBox.find("p").text(p);
		Dom.startGapBox.find(".ok").attr("data-id", dataid);
		Dom.startGapBox.fadeIn(100);
		return;
	};
	// 点击禁言弹出框的逻辑
	Dom.startGapBox.on("click", function(e) {
		var target = e.target,
			targetid = target.id,
			targetclass = target.className,
			targettagname = target.tagName.toLocaleLowerCase();
		if(targetid == "startGapBox" || targetclass == "cancel" || targettagname == "i") {
			// 点击关闭按钮
			Dom.startGapBox.fadeOut(100);
			return;
		} else if(targetclass == "ok") {
			var dataId = Dom.startGapBox.find(".ok").attr("data-id");
			if(dataId == "all-gap") {
				// 此处执行全员禁言操作
				Dom.backGap.find(".gap").text("解除禁言");
				return;
			} else if(dataId == "all-nogap") {
				// 此处执行全员解除禁言操作
				Dom.backGap.find(".gap").text("全员禁言");
				return;
			} else if(dataId == "gap") {
				// 给学员单独禁言
			} else {
				return;
			};
			Dom.startGapBox.fadeOut(100);
		}
	});
	// 撤销操作
	$(document).on("click", ".chehui-btn", function() {
		var $this = $(this),
			dataId = $this.attr("data-id");
		if($this.parents(".audio-btn-box")) {
			$this.parents(".audio-btn-box").remove();
		}
		if($this.parents(".text")) {
			$this.parents(".text").remove();
		} else {
			$(this).parents("li").remove();
		}
	});

	function tips(text) {
		Dom.tips.find("h1").text(text);
		Dom.tips.fadeIn(100, function() {
			Dom.tips.fadeOut(1500);
		});
	};
	// 给语音按钮动态设置宽度
	function setAudioBtnW(time) {
		var w = 2.4 / time + 1.2;
		return w;
	};
	// 模拟数据给audio设置宽
	var audios = $(".audio-btn-box").find(".btn");
	audios.each(function(i) {
		var time = Math.random() * 60;
		var w = setAudioBtnW(time);
		$(this).css("width", w + "rem");
	})
	// 导师发送消息部分
	// 点击语音或者文字和图片
	Dom.teachSendBox.on("click", "div", function(e) {

		var $this = $(this),
			className = $this.attr("class");
		switch(className) {
			case "yy":
				// 点击语音
				showFootBox("sendAudioBox");
				console.log("yuyin");
				break;
			case "wz":
				// 点击文字
				showFootBox("teachText");
				console.log("wenzi");
				break;
			case "tp":
				showFootBox(0);
				var obj = {
						"userId":jspS.userid,// 用户id
						"userNickName":jspS.nickname,// 用户昵称
						"userHeaderImg":	jspS.pic,// 用户头像
						"requestType":"talk",// 请求类型
						"status":vw.identity,// 用户身份
						"roomId":jspS.roomid+"_room",// 房间id
						"talkType":"2",// 消息类型 0-文字1-语音2-图片
						"parentId":"",
						"content":"http://wimg.keepyoga.com/12.jpg",// 消息类容
						"readStatus":0,
						"undoStatus":0,
						"askId":"",
						"isAsk":vw.dataCheck// 是否是问题
				};
				var objStr = JSON.stringify(obj);
				ws.send(objStr);
				$("#teachAudioBox").hide();
				choseImages();
				break;
			default:
				break;
		}
		// 背景高亮
		Dom.teachSendBox.find("div").removeClass("curr");
		$this.addClass("curr");
	});
	// 发送图片
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
	};
	function uploadmage(localid) {
		wx.uploadImage({
			localId: localid.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
			isShowProgressTips: 1, // 默认为1，显示进度提示
			success: function(res) {
				var serverId = res.serverId; // 返回图片的服务器端ID
				uploadToCDN(serverId);
			}
		});
	};
	// 老师点击底部的时候 显示对应的盒子
	var showFootBox = function (id) {
		$("#teachAudioBox").show();
		$("#sendAudioBox").hide();
		$("#teachText").hide();
		$("#"+id).show();
		if(id==0){
			$("#teachAudioBox").hide();
		}
		
	}

	// 长按录音
	$.fn.longPress = function(start,end) {
	    var timeout = undefined;
	    var $this = this;
	    for(var i = 0;i<$this.length;i++){
	        $this[i].addEventListener('touchstart', function(event) {
	        	event.preventDefault();
	            timeout = setTimeout(start, 100);
	            }, false);
	        $this[i].addEventListener('touchend', function(event) {
	        	end();
	            clearTimeout(timeout);
	            }, false);
	    }
	};
	

	$("#recordBox").longPress(start,end);
	function start(){
		console.log("开始录音");
		$("#keyframes").addClass("keyFrames");
	};
	function end(){
		console.log("录音结束")
		$("#keyframes").removeClass("keyFrames");
		var obj = {
				"userId":jspS.userid,// 用户id
				"userNickName":jspS.nickname,// 用户昵称
				"userHeaderImg":	jspS.pic,// 用户头像
				"requestType":"talk",// 请求类型
				"status":vw.identity,// 用户身份
				"roomId":jspS.roomid+"_room",// 房间id
				"talkType":"1",// 消息类型 0-文字1-语音2-图片
				"parentId":"",
				"content":"http://wimg.keepyoga.com/2-1xiaoyuanyuan.mp3",// 消息类容
				"readStatus":0,
				"undoStatus":0,
				"askId":"",
				"isAsk":vw.dataCheck// 是否是问题
		};
		var objStr = JSON.stringify(obj);
		ws.send(objStr);
		$("#teachAudioBox").hide();
	};
	
	
//	导师和管理员 做消息回复
	$(document).on('click', 'button.answer-btn', function(){  
	  var $this = $(this);
	  Dom.btnBroupBox.hide();
	  showFootBox("sendAudioBox");
	  $(".tp").hide();
	  var content  = $this.attr("data-content"),
	  nickname = $this.attr("data-nickname");
	  vw.questionContent = content;
	  vw.questionNickname = nickname;
	});  
});



