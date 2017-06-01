//判断当前用户的身份
function status() {
    var isTeach = jspS.teacherids.split(","),
        isholder = jspS.holderids.split(",");
    if (isTeach.indexOf(jspS.userid) !== -1) {
        return 2;
    } else if (isholder.indexOf(jspS.userid) !== -1) {
        return 1;
    } else {
        return 0;
    }
};
var firstCreat = true;
var u = navigator.userAgent;
var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Adr') > -1; //android终端
var isiOS = !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/); //ios终端
var isAnswer = [];
var answerObj = [];
var ws = '';
$(function () {
    var ws = null;
    var isConnection = false;
// 实例化socket
    var heartCheck = {
        reset: function () {
            vw.datas = [];// 消息体部分,
            vw.dataTeach = [];
            vw.dataAll = [];
            vw.dataStutent = [];
            ws = new WebSocket(APP.SOCKET + "/" + jspS.roomid + "/" + jspS.userid + "?time=" + time);
        }
    }

    function loadingMainData(pageNo) {

        var start1 = pageNo * 2, end1 = (pageNo + 1) * 2-1;
        startSend(start1, end1, 0, 0);
    }

    function loadingAllData(pageNo) {

        var start1 = pageNo * 2, end1 = (pageNo + 1) * 2-1;
        startSend(start1, end1, 0, 1);
    }

    function loadingAskData(pageNo) {

        var start1 = pageNo * 2, end1 = (pageNo + 1) * 50-1;
        startSend(start1, end1, 0, 2);
    }

    if ("WebSocket" in window) {
        console.log("您的浏览器支持websocket通讯");
        var time = new Date().getTime();
        ws = new WebSocket(APP.SOCKET + "/" + jspS.roomid + "/" + jspS.userid + "?time=" + time);
        ws.onopen = function (event) {
            //直播间已经被关闭，拉去历史消息
            loadingMainData(vw.start1);
            loadingAllData(vw.start2);
            loadingAskData(vw.start3);
        };
        ws.onmessage = function (evt) {
            var data = JSON.parse(evt.data);//反序裂化收到的消息体
            if (data.requestType == "Talk") {//判断是否是发的聊天消息
                console.log(data)
                //vw.datas = vw.datas.concat(data);
                if (data.askId != "") {

                    var flag = false;
                    $.each(vw.dataTeach, function (i, item) {
                        if (item.keyId == data.askId) {
                            flag = true;
                        }
                    });

                    if (flag) {
                        $.each(vw.dataTeach, function (i, item) {
                            if (item.keyId == data.askId) {
                                vw.dataTeach.splice(i, 1, data);
                            }
                        });
                    } else {
                        vw.dataTeach = vw.dataTeach.concat(data);
                    }

                    $.each(vw.dataAll, function (i, item) {
                        if (item.keyId == data.askId) {
                            vw.dataAll.splice(i, 1, data);
                        }
                    });
                    $.each(vw.dataStutent, function (i, item) {
                        if (item.keyId == data.askId) {
                            vw.dataStutent.splice(i, 1, data);
                        }
                    });
                } else {
                    vw.dataTeach = vw.dataTeach.concat(data);
                    if (data.status == "0") {
                        vw.dataAll = vw.dataAll.concat(data);

                        vw.dataStutent = vw.dataStutent.concat(data);
                    }
                }
                vw.messageCount = data.messageCount;

                //自滚动

                setTimeout(function () {
                    goBottom(Dom.mainBox);
                }, 300);


            } else if (data.requestType == "Disable") {
                console.log(data);
                $("#startGapBox").hide();
                tips("当前直播间已被全员禁言");
                vw.disabledStatus = true;
            } else if (data.requestType == "UnDisable") {
                console.log(data);
                tips("当前直播间已解除全员禁言");
                $("#startGapBox").hide();
                vw.disabledStatus = false;
            } else if (data.requestType == "UserCount") {
                // tips("当前直播间已解除全员禁言");
                vw.userCount = data.userCount;
            } else if (data.requestType == "MessageCount") {
                // tips("当前直播间已解除全员禁言");
                vw.messageCount = data.messageCount;
            } else if (data.requestType == "CloseRooms") {
                if (data.roomStatus == 2) {
                    tips("课程结束，直播间已被关闭");
                    this.liveColse = true;
                    window.location.href = window.location.href + "&closeRooms=2"
                }
            } else if (data.requestType == "GetMsg") {
                if (jspS.roomStatus !== 2) {
                    if (data.dataType == 0) {
                        if (data.data.length) {
                            var StringToObj = [];
                            for (var i = 0; i < data.data.length; i++) {
                                StringToObj.push(JSON.parse(data.data[i]))
                            }
                            var bb = StringToObj.concat(vw.dataTeach);
                            vw.dataTeach = bb;
                            vw.start1++;
                            vw.mainBox1 = false;
                            loadingMainData(vw.start1);
                        } else {
                            goBottom(Dom.mainBox);
                            tips("");
                        }
                    } else if (data.dataType == 1) {
                        if (data.data.length) {
                            var StringToObj = [];
                            for (var i = 0; i < data.data.length; i++) {
                                StringToObj.push(JSON.parse(data.data[i]))
                            }
                            var bb = StringToObj.concat(vw.dataAll);
                            vw.dataAll=bb;
                            vw.start2++;
                            vw.mainBox2 = false;
                            loadingAllData(vw.start2);
                        } else {
                            tips("")
                        }
                    } else if (data.dataType == 2) {
                        if (data.data.length) {
                            console.log(data.data.length)
                            var StringToObj = [];
                            for (var i = 0; i < data.data.length; i++) {
                                StringToObj.push(JSON.parse(data.data[i]))
                            }
                            var bb = StringToObj.concat(vw.dataStutent);
                            vw.dataStutent = bb;
                            vw.start3++;
                            loadingAskData(vw.start3);
                        } else {
                            tips("")
                        }
                    } else {
                        return;
                    }
                    firstCreat = false;
                } else {
                    // console.log(data.data)
                    if (data.dataType == 0) {
                        if (data.data.length) {
                            var StringToObj = [];
                            for (var i = 0; i < data.data.length; i++) {
                                StringToObj.push(JSON.parse(data.data[i]))
                            }
                            var bb = StringToObj.concat(vw.dataTeach);
                            vw.dataTeach = bb;
                            vw.start1++;
                            vw.mainBox1 = false;
                            loadingMainData(vw.start1);
                        } else {
                            tips("没有更多数据了");
                        }
                    } else if (data.dataType == 1) {
                        if (data.data.length) {
                            var StringToObj = [];
                            for (var i = 0; i < data.data.length; i++) {
                                StringToObj.push(JSON.parse(data.data[i]))
                            }
                            var bb = StringToObj.concat(vw.dataAll);
                            vw.dataAll=bb;
                            vw.start2++;
                            vw.mainBox2 = false;
                            loadingAllData(vw.start2);
                        } else {
                            tips("没有更多数据了")
                        }
                    } else if (data.dataType == 2) {
                        if (data.data.length) {
                            var StringToObj = [];
                            for (var i = 0; i < data.data.length; i++) {
                                StringToObj.push(JSON.parse(data.data[i]))
                            }
                            var bb = StringToObj.concat(vw.dataStutent);
                            vw.dataStutent = bb;
                            vw.start3++;
                            vw.mainBox3 = false;
                            loadingAskData(vw.start3);
                        } else {
                            tips("没有更多数据了")
                        }

                    } else {
                        return;
                    }
                }
                // console.log(data)
            } else {
            }
        };
        ws.onclose = function (e) {
            console.log(e);
            alert("断开连接了")
        }
    } else {
        console.log("您的浏览器不支持websocket通讯");
    }
    function startSend(start, end, roomStatus, dataType) {
        var obj = {
            "userId": jspS.userid,// 用户id
            "roomId": jspS.roomid,// 房间id
            "requestType": "GetMsg",// 请求类型,
            "start": start,//开始条目
            "end": end,//结束条目
            "roomStatus": roomStatus,//直播间转态
            "dataType": dataType//区域
        }
        var objStr = JSON.stringify(obj);
        ws.send(objStr);
    }

    var vw = new Vue({
        el: "#app",
        data: {
            dataCheck: 0,// 学员的消息是否为提问
            identity: status(),// 用户的身份/0-学员1-主持人2-导师
            audioSrc: "http://wimg.keepyoga.com/NOVOICE.mp3",// 初始化一个音频路径，解决报错
            isAnswer: false,//是否是回答学员的消息，控制前端是否显示学员的问题
            questionNickname: "",//老师回答学员的消息的时候，学员的名字
            questionContent: "",//老师回答学员的消息的时候，学员的问题
            datas: [],// 消息体部分,
            dataTeach: [],
            dataAll: [],
            dataStutent: [],
            startLive: false,//直播是否开始,
            isAnswer: false,//导师的消息是否为回答消息
            userheaderimg: "",
            disabledStatus: false,
            gapStutentUserId: "",
            liveColse: false,
            keyID: "",
            messageCreateTime: "",
            roomStatus: jspS.roomStatus,
            mainBox1: false,
            start1: 0,
            mainBox2: false,
            start2: 0,
            mainBox3: false,
            start3: 0,
            userCount: 0,
            messageCount: 0,
            answerObj:[]
        },
        methods: {
            playVideo: function () {// 播放视频
                $("#app").find(".removeVideoMask").remove();
                if (!$("audio").get(0).paused) {
                    $("audio").get(0).pause();
                }
                $("#video").get(0).play();
            },
            closeLive: function () {// 关闭直播间
                changePanleText("关闭直播间", "关闭直播间后不可再次开启", "closeLive");
            },
            answer: function (data) {
                console.log(data);
                $("#transparentBox").show();
                $("btnBroupBox").hide();
                showFootBox("sendAudioBox");
                $(".tp").hide();
                vw.isAnswer = true;
                vw.questionContent = data.content;
                vw.questionNickname = data.userNickName;
                vw.userheaderimg = data.userHeaderImg;
                vw.messageCreateTime = data.messageCreateTime;
                vw.keyID = data.keyId;
                vw.answerObj = data.answerObj;
            },
            gapSutent: function (userid) {
                if(vw.identity!==0){
                    changePanleText("禁言", "对学员单独禁言后不可恢复", "gap");
                    this.gapStutentUserId = userid;
                }
            },
            lookImg: function (url) {//调用微信接口查看大图
                var imgArray = [];
                $(".previewImage").each(function (index, el) {
                    var itemSrc = $(this).attr('src');
                    imgArray.push(itemSrc);
                });
                wx.previewImage({
                    current: url,
                    urls: imgArray
                });
            },
            hideBox: function () {
                $("#teachAudioBox").hide();
                $("#transparentBox").hide();
            },
            playAudio: function ($event) {
                var target = $event.target;
                var Button = $(target).closest("button");
                if (!$("#video").get(0).paused) {
                    $("#video").get(0).pause();
                }
                Dom.app.addClass("play");
                $audio = Button;
                audioPlay($audio);
                onended($audio);
            }
        }
    });

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
        audios: $("audio").get(0),
        videos: $("#video").get(0),
        app: $("#app"),
        btnBroupBox: $("#btnBroupBox")
    };
    var variable = {
        inputText: "",
        mainBox: true,
        left: false,
        right: false,
        CDN: "http://wimg.keepyoga.com/"
    };
    //判断倒计时框还存不存在
    function checkCountDownBox() {
        if (Dom.countDownBox.css('display') == "none") {
            return true;
        } else {
            return false;
        }
    };
    var dataTime = parseInt(APP.URLSEARCH().time);

    function setDate() { //设置一个开课日期
        var format = new Date(dataTime);
        startDate = startDates(format);
        Dom.countDownBox.find("p").text("本次直播将于" + startDate.year + "年" + startDate.month + "月" + startDate.ri + "日   " + startDate.hours + ":" + startDate.minutes + ":" + startDate.seconds + "开始");
    };
    //获取开课日期
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
    //设置倒计时
    var nowTime = function () {
        var data = dataTime - (new Date().getTime()),
            total = data / 1000;
        var day = parseInt(total / (24 * 60 * 60)); //计算整数天数
        var afterDay = total - day * 24 * 60 * 60; //取得算出天数后剩余的秒数
        var hour = parseInt(afterDay / (60 * 60)); //计算整数小时数
        var afterHour = total - day * 24 * 60 * 60 - hour * 60 * 60; //取得算出小时数后剩余的秒数
        var minutes = parseInt(afterHour / 60); //计算整数分
        var seconds = parseInt(total - day * 24 * 60 * 60 - hour * 60 * 60 - minutes * 60); //取得算出分后剩余的秒数
        if (data <= 0) {
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
    if (vw.roomStatus !== 2) {
        setDate();
        nowTime();
    } else {
        Dom.countDownBox.hide();
        tips("当前直播间已被关闭")
        $(".answer-btn").hide();
    }

    var timer = "";
    if (!checkCountDownBox()) {
        var timer = setInterval(function () {
            nowTime();
        }, 1000);
    }
    //  关闭正在加载
    setTimeout(function () {
        $("#stash").remove();
    }, 0);

    $(document).one("click", function () {
        Dom.app.addClass("play");
        Dom.audios.play();
    })
    var $audio = null;
    // $(document).on("click", "button.audiobtn", function () {
    //     if (!$("#video").get(0).paused) {
    //         $("#video").get(0).pause();
    //     }
    //     Dom.app.addClass("play");
    //     $audio = $(this);
    //     audioPlay($audio);
    //     onended($audio);
    // })
    // Dom.app.on("click", "button.audiobtn", function () {
    //     if (!$("#video").get(0).paused) {
    //         $("#video").get(0).pause();
    //     }
    //     Dom.app.addClass("play");
    //     $audio = $(this);
    //     audioPlay($audio);
    //     onended($audio);
    // });
    function onended($this) {
        var _this = $this;
        $("audio").get(0).onended = function () {
            $("button.btn").find("img").css({
                "width": ".5rem",
                "height": ".5rem"
            }).attr("src", "http://wimg.keepyoga.com/image/son.png");
            audioNext(_this);
        }
    };
    function audioNext($this) {
        var audioBtnBox = $this.parents(".audio-btn-box").nextAll(".audio-btn-box"),
            audioItem = $this.parents(".item").nextAll(".item").find(".audio-btn-box");
        if (audioBtnBox.length) {
            $audio = audioBtnBox.eq(0).find("button.btn");
            audioPlay($audio);
        } else if (audioItem.length) {
            $audio = audioItem.eq(0).find("button.btn");
            audioPlay($audio);
        }
    };
    function audioPlay($audio) {
        $("button.btn").find("img").css({
            "width": ".5rem",
            "height": ".5rem"
        }).attr("src", "http://wimg.keepyoga.com/image/son.png");
        var $this = $audio;
        src = $this.attr("data-src");
        $("audio").get(0).src = src;
        $("audio").get(0).play();
        $audio.find("img").css({"width": "1rem"}).attr("src", "http://wimg.keepyoga.com/loding_002.gif");
        onended($this);
    };
    $("audio").get(0).onplaying = function () {
        if (Dom.app.hasClass("play")) {
            $audio.find("img").css({"width": "1rem"}).attr("src", "http://wimg.keepyoga.com/images/songif.gif");
            var cicle = $audio.next(".audio-time-box").find(".cicle");
            if (cicle.length) {
                cicle.remove();
            }
        }
    };
    // 点击编辑文字的区域
    Dom.inputBox.on("click", function (e) {
        var targetId = e.target.id,
            target = e.target,
            tagname = target.tagName.toLocaleLowerCase();
        console.log(targetId);
        // 点击的是input 隐藏提示文字
        // if (targetId == "inputText" || targetId == "inputBox" || targetId == "placeholder" || tagname == "font") {
        //     Dom.placeholder.hide();
        //     $("#inputText").focus();
        // }
        // 点击是否勾选提问按钮
        if (target.closest("#checkBox")) {
            vw.dataCheck ? checked() : check();
        }
        if (targetId == "enterBtn") {
            Dom.enterBtn.hasClass("curr") ? enterText() : "";
        }
    });
    // 发送文字消息
    function enterText() {
        $("#transparentBox").hide();
        var text = Dom.inputText.val();
        var obj = "";
        if (!vw.isAnswer) {
            obj = {
                "userId": jspS.userid,// 用户id
                "userNickName": jspS.nickname,// 用户昵称
                "userHeaderImg": jspS.pic,// 用户头像
                "requestType": "Talk",// 请求类型
                "status": vw.identity,// 用户身份
                "roomId": jspS.roomid,// 房间id
                "talkType": "0",// 消息类型 0-文字1-语音2-图片
                "parentId": "",
                "content": text,// 消息类容
                "readStatus": 0,
                "undoStatus": 0,
                "askId": "",//问题id
                "isAsk": vw.dataCheck,// 是否是问题
                "answerObj": [],
                "isAnswer": vw.isAnswer//导师消息是否为回答消息
            };
            if (vw.disabledStatus && vw.identity == 0) {
                tips("老师正在，讲课，直播间，已被禁言！")
            } else {
                var objStr = JSON.stringify(obj);
                ws.send(objStr);
                vw.dataCheck = 0;
                Dom.enterBtn.removeClass("curr");
                Dom.inputText.val("");
                variable.inputText = "";
                $("#teachAudioBox").hide();
            }
        } else {
            var textObj = {
                "dataType": 0,
                "content": text,
                "userNickName": jspS.nickname,// 用户昵称
                "userHeaderImg": jspS.pic,// 用户头像
            };
            var answerObj1 = vw.answerObj.push(textObj);
            vw.isAnswer = false;
            $(".tp").show();
            obj = {
                "keyId": vw.keyID,
                "userId": jspS.userid,// 用户id
                "userNickName": vw.questionNickname,
                "userHeaderImg": vw.userheaderimg,
                "requestType": "Talk",// 请求类型
                "status": vw.identity,// 用户身份
                "roomId": jspS.roomid,// 房间id
                "talkType": "0",// 消息类型 0-文字1-语音2-图片
                "parentId": "",
                "content": vw.questionContent,// 消息类容
                "readStatus": 0,
                "undoStatus": 0,
                "askId": vw.keyID,//问题id
                "isAsk": vw.dataCheck,// 是否是问题
                "answerObj": vw.answerObj,
                "messageCreateTime": vw.messageCreateTime
            }

            if (vw.disabledStatus && vw.identity == 0) {
                tips("老师正在，讲课，直播间，已被禁言！")
            } else {
                var objStr = JSON.stringify(obj);
                ws.send(objStr);
                vw.start1 = 1;
                vw.dataCheck = 0;
                Dom.enterBtn.removeClass("curr");
                Dom.inputText.text("");
                variable.inputText = "";
                $("#teachAudioBox").hide();
            }
        }

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
    Dom.inputText.keyup(function () {
        var len = 200;
        var inputTextLen = $(this).val().length;
        var inputText = $(this).val();
        if (inputTextLen == 0) {
            Dom.enterBtn.hasClass("curr") ? Dom.enterBtn.removeClass("curr") : "";
            return;
        }
        if (inputTextLen > 0 && inputTextLen < 144) {
            Dom.enterBtn.hasClass("curr") ? "" : Dom.enterBtn.addClass("curr");
            return;
        }
        if (inputTextLen >= 144) {
            return;
        }
    });
    // 点击按钮操作
    Dom.btnBroupBox.on("click", function (e) {
        var target = e.target;
        if (target.closest("#btnBoxBottom")) {
            // 判断是在哪个页面
            if (variable.mainBox && !variable.left && !variable.right) {
                goBottom(Dom.mainBox);
            } else if (!variable.mainBox && variable.left && !variable.right) {
                goBottom(Dom.allBoxAll);
            } else if (!variable.mainBox && !variable.left && variable.right) {
                goBottom(Dom.allBoxQuestion);
            } else {
                return;
            }
            tips("已返回底部");
        }
        if (target.closest("#btnBoxTop")) {
            // 判断是在哪个页面
            if (variable.mainBox && !variable.left && !variable.right) {
                goTop(Dom.mainBox);
            } else if (!variable.mainBox && variable.left && !variable.right) {
                goTop(Dom.allBoxAll);
            } else if (!variable.mainBox && !variable.left && variable.right) {
                goTop(Dom.allBoxQuestion);
            } else {
                return;
            }
            tips("已返回顶部");
        }
        if (target.closest("#btnBoxAsk")) {
            $("#mainBox1").css("top", 0);
            Dom.btnBroupBox.find(".ask-size").hide();
            $("#btnBoxAsk").hide();
            variable.mainBox = false;
            Dom.teachSendBox.addClass("w50");
            if (Dom.tab.find(".left").hasClass("curr")) {
                variable.left = true;
                variable.right = false;
                return;
            } else {
                variable.left = false;
                variable.right = true;
            }
        }
    });
    // 切换顶部导航
    Dom.tab.on("click", "li", function () {
        var $this = $(this);
        if ($this.hasClass("left")) {
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
        }
        Dom.tab.find("li").removeClass("curr");
        $(this).addClass("curr");
    });
    // 回到直播和全员禁言逻辑
    Dom.backGap.on("click", "button", function () {
        var $this = $(this);
        if ($this.hasClass("back")) {
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
            if ($this.text() == "全员禁言") {
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
    Dom.startGapBox.on("click", function (e) {
        var target = e.target,
            targetid = target.id,
            targetclass = target.className,
            targettagname = target.tagName.toLocaleLowerCase();
        if (targetid == "startGapBox" || targetclass == "cancel" || targettagname == "i") {
            // 点击关闭按钮
            Dom.startGapBox.fadeOut(100);
            return;
        } else if (targetclass == "ok") {
            var dataId = Dom.startGapBox.find(".ok").attr("data-id");
            if (dataId == "all-gap") {
                // 此处执行全员禁言操作
                var obj = {
                    "userId": jspS.userid,// 用户id
                    "requestType": "Disable",// 请求类型
                    "status": vw.identity,// 用户身份
                    "roomId": jspS.roomid// 房间id
                };
                var objStr = JSON.stringify(obj);
                ws.send(objStr);
                Dom.backGap.find(".gap").text("解除禁言");
                return;
            } else if (dataId == "all-nogap") {
                // 此处执行全员解除禁言操作
                var obj = {
                    "userId": jspS.userid,// 用户id
                    "requestType": "UnDisable",// 请求类型
                    "status": vw.identity,// 用户身份
                    "roomId": jspS.roomid// 房间id
                };
                var objStr = JSON.stringify(obj);
                ws.send(objStr);
                Dom.backGap.find(".gap").text("全员禁言");
                return;
            } else if (dataId == "gap") {
                // 给学员单独禁言
                var obj = {
                    "userId": jspS.userid,// 用户id
                    "requestType": "UnDisable",// 请求类型
                    "status": vw.identity,// 用户身份
                    "roomId": jspS.roomid,// 房间id
                    "disableUserId": vw.gapStutentUserId
                };
                var objStr = JSON.stringify(obj);
                ws.send(objStr);
                console.log(0)
            } else if (dataId == "closeLive") {
                var obj = {
                    "userId": jspS.userid,// 用户id
                    "requestType": "CloseRooms",// 请求类型
                    "status": vw.identity,// 用户身份
                    "roomId": jspS.roomid// 房间id
                };
                var objStr = JSON.stringify(obj);
                ws.send(objStr);
                $.post(APP.API_PATH + "live/zhibo/closeroom" + jspS.roomid + ".json", function (res) {
                }, 'json');
            } else {
                return;
            }
            Dom.startGapBox.fadeOut(100);
        }
    });

    //分装弹框
    function tips(text) {
        Dom.tips.find("h1").text(text);
        Dom.tips.fadeIn(100, function () {
            Dom.tips.fadeOut(1500);
        });
    };
    // 给语音按钮动态设置宽度
    function setAudioBtnW(time) {
        var w = 2.4 / 60 * time + 1.2;
        return w;
    };
    // 模拟数据给audio设置宽
    var audios = $(".audio-btn-box").find(".btn");
    audios.each(function (i) {
        var time = Math.random() * 60;
        var w = setAudioBtnW(time);
        $(this).css("width", w + "rem");
    })
    //导师或者管理员点击底部消息按钮，显示对应的发送消息的盒子
    Dom.teachSendBox.on("click", "div", function (e) {
        $("#transparentBox").show();
        var $this = $(this),
            className = $this.attr("class").substr(0, 2);
        switch (className) {
            case "yy":
                // 点击语音
                showFootBox("sendAudioBox");
                break;
            case "wz":
                // 点击文字
                showFootBox("teachText");
                break;
            case "tp":
                showFootBox(0);
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
// 老师点击底部的时候 显示对应的盒子
    window.showFootBox = function (id) {
        $("#teachAudioBox").show();
        $("#sendAudioBox").hide();
        $("#teachText").hide();
        $("#" + id).show();
        if (id == 0) {
            $("#teachAudioBox").hide();
        }
    };
//分装发送图片接口
    function choseImages() {
        wx.checkJsApi({
            jsApiList: ['chooseImage'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
            success: function (res) {
                // alert("图片接口成功");
                wx.chooseImage({
                    count: 1, // 默认9
                    sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
                    sourceType: ['album', 'camera'], // 可以指定来源是相册还是相机，默认二者都有
                    success: function (res) {
                        var localIds = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
                        uploadmage(localIds);
                    }, fail: function (res) {
                        //alert(JSON.stringify(res))
                    }
                });
            }
            // 以键值对的形式返回，可用的api值true，不可用为false
            // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
        });
    };
//上传图片接口
    function uploadmage(localid) {
        wx.uploadImage({
            localId: localid.toString(), // 需要上传的图片的本地ID，由chooseImage接口获得
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {
                var serverId = res.serverId; // 返回图片的服务器端ID
                uploadToimage(serverId);
            }
        });
    };
//把图片上传至cdn，上传成功后执行ws.send
    function uploadToimage(serverid) {
        $("#transparentBox").hide();
        $.post(jspS.ctx + "/weixin/uploadweixinimage.do", {"serverid": serverid}, function (data) {
            var obj = {
                "userId": jspS.userid,// 用户id
                "userNickName": jspS.nickname,// 用户昵称
                "userHeaderImg": jspS.pic,// 用户头像
                "requestType": "Talk",// 请求类型
                "status": vw.identity,// 用户身份
                "roomId": jspS.roomid,// 房间id
                "talkType": "2",// 消息类型 0-文字1-语音2-图片
                "parentId": "",
                "content": data,// 消息类容
                "readStatus": 0,
                "undoStatus": 0,
                "askId": "",
                "isAsk": vw.dataCheck,// 是否是问题
                "answerObj": [],
                "isAnswer": false
            };
            var objStr = JSON.stringify(obj);
            ws.send(objStr);
        });
    }

//分装下载图片接口
    function downloadImage(serverid) {
        wx.downloadImage({
            serverId: serverid.toString(), // 需要下载的图片的服务器端ID，由uploadImage接口获得
            isShowProgressTips: 1, // 默认为1，显示进度提示
            success: function (res) {
                var localId = res.localId; // 返回图片下载后的本地ID
                alert(JSON.stringify(res))
            }
        });
    }

//初始化，录音时长和录音定时器
    var recoldTime = 1,
        recoldTimeR = "";
// 分装长按事件
    $.fn.longPress = function (start, end) {
        var timeout = undefined;
        var $this = this;
        for (var i = 0; i < $this.length; i++) {
            $this[i].addEventListener('touchstart', function (event) {
                event.preventDefault();
                timeout = setTimeout(start, 100);
            }, false);
            $this[i].addEventListener('touchend', function (event) {
                end();
                clearTimeout(timeout);
            }, false);
        }
    };
//调用录音长按事件
    $("#recordBox").longPress(startrecord, end);
//长按开始录音
    function startrecord() {
        console.log("开始录音");
        $("#keyframes").addClass("keyFrames");
        wx.checkJsApi({
            jsApiList: ['startRecord'], // 需要检测的JS接口列表，所有JS接口列表见附录2,
            success: function (res) {
                wx.startRecord({
                    success: function () {
                        recoldTimeR = setInterval(function () {
                            if (recoldTime == 59) {
                                end();
                                return;
                            }
                            recoldTime++;
                            Dom.time.html(recoldTime);

                        }, 1000);
                    }, cancel: function () {
                    }
                });
            },
            error: function (res) {
                tips(res);
            }
        });
    };
//松手录音结束
    function end() {
        console.log("录音结束")
        $("#keyframes").removeClass("keyFrames");
        wx.stopRecord({
            success: function (res) {
                var localId = res.localId;
                uploadVoice(localId);
                clearInterval(recoldTimeR);
                $("#teachAudioBox").hide();
            }
        });
    };
// 监听录音自动停止接口
    wx.onVoiceRecordEnd({

        // 录音时间超过一分钟没有停止的时候会执行 complete 回调
        complete: function (res) {
            var localId = res.localId;
            uploadVoice(localId);
            clearInterval(recoldTimeR);
        }
    });
// 录音结束，上传至微信
    function uploadVoice(localId) {
        wx.uploadVoice({
            localId: localId, // 需要上传的音频的本地ID，由stopRecord接口获得
            isShowProgressTips: 0, // 默认为1，显示进度提示
            success: function (res) {
                var serverId = res.serverId; // 返回音频的服务器端ID
                uploadTomp3(serverId);
            }
        })
    };
//语音上传到cdn成功后，调用wx.send方法
    function uploadTomp3(serverid) {
        $("#transparentBox").hide();
        $.post(jspS.ctx + "/weixin/uploadweixinmp3.do", {"serverid": serverid}, function (data) {
            var obj = {};
            if (!vw.isAnswer) {
                obj = {
                    "userId": jspS.userid,// 用户id
                    "userNickName": jspS.nickname,// 用户昵称
                    "userHeaderImg": jspS.pic,// 用户头像
                    "requestType": "Talk",// 请求类型
                    "status": vw.identity,// 用户身份
                    "stutentNickName": vw.questionNickname,
                    "stutentHeader": vw.userheaderimg,
                    "roomId": jspS.roomid,// 房间id
                    "talkType": "1",// 消息类型 0-文字1-语音2-图片
                    "parentId": "",
                    "content": variable.CDN + "" + data,// 消息类容
                    "readStatus": 0,
                    "undoStatus": 0,
                    "askId": "",
                    "isAsk": vw.dataCheck, // 是否是问题
                    "answerObj": [],
                    "isAnswer": vw.isAnswer,//导师消息是否为回答消息
                    "time": recoldTime,
                    "setAudioBtnW": setAudioBtnW(recoldTime)
                };
            } else {
                vw.isAnswer = false;
                $(".tp").show();
                var mp3 = {
                    "time": recoldTime,
                    "setAudioBtnW": setAudioBtnW(recoldTime),
                    "content": variable.CDN + "" + data,
                    "dataType": 1,
                    "userNickName": jspS.nickname,// 用户昵称
                    "userHeaderImg": jspS.pic,// 用户头像
                };
                var answerObj1 = vw.answerObj.push(mp3);
                obj = {
                    "keyId": vw.keyID,
                    "userId": jspS.userid,// 用户id
                    "userNickName": vw.questionNickname,
                    "userHeaderImg": vw.userheaderimg,
                    "requestType": "Talk",// 请求类型
                    "status": vw.identity,// 用户身份
                    "content": vw.questionContent,// 消息类容
                    "roomId": jspS.roomid,// 房间id
                    "talkType": "1",// 消息类型 0-文字1-语音2-图片
                    "parentId": "",
                    "readStatus": 0,
                    "undoStatus": 0,
                    "askId": vw.keyID,
                    "isAsk": vw.dataCheck, // 是否是问题
                    "answerObj": vw.answerObj,
                    "isAnswer": vw.isAnswer,//导师消息是否为回答消息
                    "time": recoldTime,
                    "setAudioBtnW": setAudioBtnW(recoldTime),
                    "messageCreateTime": vw.messageCreateTime
                };
            }
            var objStr = JSON.stringify(obj);
            ws.send(objStr);
            recoldTime = 0;
            Dom.time.html(0);
        });
    };
    // 撤销操作
    // $(document).on("click", ".chehui-btn", function () {
    //     var $this = $(this),
    //         dataId = $this.attr("data-id");
    //     if ($this.parents(".audio-btn-box")) {
    //         $this.parents(".audio-btn-box").remove();
    //     }
    //     if ($this.parents(".text")) {
    //         $this.parents(".text").remove();
    //     } else {
    //         $(this).parents("li").remove();
    //     }
    // });
    //分装返回底部
    function goBottom(Dom) {
        var h = Dom.find("ul").height();
        Dom.animate({
            scrollTop: h
        }, 0);
    };
    //分装返回顶部
    function goTop(Dom) {
        Dom.animate({
            scrollTop: 0
        }, 0);
    };
    // 点击隐藏关闭视频按钮
    Dom.showHideCourse.click(function () {
        if (!$(this).hasClass("show")) {
            hideVideo($(this));
        } else {
            showVideo($(this));
        }
    });
    // 隐藏视频区域
    function hideVideo($this) {
        $this.find(".text1").hide();
        $this.find(".text2").show();
        $this.addClass("show");
        $("#videoBox").slideUp(100);
        if (!checkCountDownBox()) {
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
        if (!checkCountDownBox()) {
            Dom.mainBox.css("top", "5.32rem");
        } else {
            Dom.mainBox.css("top", "4.22rem");
        }
    };
//   导师盒子
    function scrollBox() {
        if (vw.roomStatus == 2) {//直播间关闭了，滚动拉去消息
            Dom.mainBox.on('scroll', function () {
                var h = $("#mainBox").scrollTop(),
                    docH = $("#mainBox").height();
                var scrollTop = $(this).scrollTop();
                var scrollHeight = $("#mainBox ul").height();
                var windowHeight = $(this).height();
                if (scrollTop + windowHeight + 200 > scrollHeight) {
                    tips("正在加载数据...");
                }
                // if (h < 200) {
                //     startSend(20, 39, 0, 0);
                //
                // }
            })
            //   更多消息
            Dom.allBoxAll.on('scroll', function () {
                var h = $("#allBoxAll").scrollTop(),
                    docH = $("#allBoxAll").height();
                var scrollTop = $(this).scrollTop();
                var scrollHeight = $("#allBoxAll ul").height();
                var windowHeight = $(this).height();
                if (scrollTop + windowHeight + 200 > scrollHeight) {
                    tips("正在加载数据...");
                }
            })
            //   提问盒子
            Dom.allBoxQuestion.on('scroll', function () {
                var h = $("#allBoxQuestion").scrollTop(),
                    docH = $("#allBoxQuestion").height();
                var scrollTop = $(this).scrollTop();
                var scrollHeight = $("#allBoxQuestion ul").height();
                var windowHeight = $(this).height();
                if (scrollTop + windowHeight + 200 > scrollHeight) {
                    tips("正在加载数据...");
                }
            });
        } else {//直播间未关闭，滚动拉去消息
            Dom.mainBox.on('scroll', function () {
                var h = $("#mainBox").scrollTop();
                console.log(h)
                if (h < 50 && !vw.mainBox1) {
                    var start = vw.start1 * 50 + 1,
                        end = start + 5;

                    startSend(start, end, 0, 0);
                    tips("正在加载数据...");

                    vw.mainBox1 = true;
                }
            })
            //   更多消息
            Dom.allBoxAll.on('scroll', function () {
                var h = $("#allBoxAll").scrollTop();
                if (h < 50) {
                    var start = vw.start2 * 5 + 1,
                        end = start + 5;

                    startSend(start, end, 0, 1);
                    tips("正在加载数据...");

                    vw.mainBox1 = true;
                }
            })
            //   提问盒子
            Dom.allBoxQuestion.on('scroll', function () {
                var h = $("#allBoxQuestion").scrollTop();
                if (h < 50) {
                    var start = vw.start3 * 5 + 1,
                        end = start + 5;
                    startSend(start, end, 0, 2);
                    tips("正在加载数据...");

                    vw.mainBox1 = true;
                }
            });
        }
    }

    // scrollBox();
        //监听键盘弹起是，修改  输入框的位置
        var DOCUMENTh = $(window).height();
        $("#inputText").focus(function () {
            $("#STUTENTTEST").css("padding-bottom",1.5+"rem");
        })
    $("#inputText").blur(function () {
        $("#STUTENTTEST").css("padding-bottom",.15+"rem");
    })
})