if (JspElement.nologin == "true") {
    window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
}
var id = JspElement.detaillsId;


var vw = new Vue({
    el: "#app",
    data: {
        classList: [], //课程安排
        detaills: [], //介绍
        consultPop: false, //客服弹出框
        myscroll: "",
        totlesaler: "",
        name: "",
        phone: "",
        pwd: "",
        disabledButton: false,
        money: "",
        teachs: [],
        shareLen: [],
        pay: JspElement.payStatus,
        loggerid:"",
        havePhone:false,
        money1 :0
    },
    methods: {
        init: function () {
            var _this = this;
            //课程安排接口
            $.post(APP.API_PATH + "live/item/list.json?zhiboId=" + id, function (res) {
                _this.classList = res.list;
            }, 'json');
            $.post(APP.API_PATH + "live/getDetail.json?zhiboId=" + id, function (res) {
                _this.detaills = res.zhibo;
                _this.shareLen = res.salerlist;
                _this.totlesaler = res.totlesaler;
                _this.money = res.zhibo.fcbl;
                _this.money = _this.money.substr(4)/10*_this.detaills.money;
                _this.money = _this.money.toFixed(2);
                _this.money1 = parseInt(_this.money);
                //_this.pay = true;
            }, 'json');
            $.post(APP.API_PATH + "live/teacher/list.json?zhiboId=" + id, function (res) {
                _this.teachs = res.list;
            }, 'json');

        },
        changeNav: function ($event) { //切换导航
            //获取当前索引
            var _this = this;
            var inx = $($event.target).closest('li').index();
            console.log(inx)
            $("#tab li").removeClass("curr");
            $(this).addClass("curr");
            $("#tab div").removeClass("curr");
            $("#tab div").eq(inx).addClass("curr");

            if (inx == 0) {
                $("#jieshao").show();
                $("#anpai").hide();
            } else if (inx == 2) {
                $("#jieshao").hide();
                $("#anpai").show();
            }
            vw.myscroll.refresh();
        },
        toLiveRoom:function (url1,startTime) {
            if(this.pay){
                var url1 = url1,
                    startTime = startTime;
                    startTime = startTime.replace(/-/g,"/");
                    var time = new Date(startTime).getTime();
                window.location.href = url1+"?time="+time;
                return;
            }else{
                this.goShoping();
            };
        },
        gz: function (tid, followuser, index) { //关注或取消关注
            var followuser1 = followuser,
                tid1 = tid,
                index1 = index,
                _this = this;
            $.post(APP.API_PATH1 + "w/follow/" + tid1 + "/" + followuser1 + ".html", function (res) {
                if (res.status) {
                    var follow = _this.teachs[index1].followuser;
                    if (follow) {
                        _this.teachs[index1].followuser = false;
                    } else {
                        _this.teachs[index1].followuser = true;
                    }
                    ;
                }
                ;
            }, 'json')
        },
        zixun: function () { //点击咨询按钮
            $('#consultPop').show();
            $("#submitBox").hide();
        },
        consultPopHide: function () { //关闭客服微信
            $("#consultPop").hide();
            $("#submitBox").show();

        },
        getMoney: function () { //赚10元
            $("#masking").show();
            $("#submitBox").hide();
            $.post(JspElement.ctx+"/v2/live/besaler.json", function (data) {
                if (data.code == 200) {
                    console.log("添加分销员成功。")
                } else {

                }
            }, 'json');
        },
        maskingHide: function () { //关闭分享弹框
            $("#masking").hide();
            $("#submitBox").show();
        },
        goShoping: function () { //购买按钮
            if(!this.havePhone){
            $("#masking2").show();
            $("#submitBox").animate({
                bottom: 0
            }, 500);
            }else{
                this.submitBtn();
            }
        },
        masking2Hide: function () { //关闭购买的弹出框
            $("#submitBox").animate({
                bottom: '-17rem'
            }, 500);
            $("#masking2").hide();
        },
        check_phone: function (phone) { //验证是否为手机号
            var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
            if (!reg.test(phone)) {
                return false;
            }
            return true;
        },
        tips: function (msg) { //实例化tips
            msg = "<font color='0xFFFFFF'>" + msg + "</font>"
            layer.open({
                content: msg,
                skin: 'msg',
                time: 2 //2秒后自动关闭
            });
        },
        getpwd: function () {
            var that = this;
            if (JspElement.nologin == "true") {
                window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=" + JspElement.wxid + "&redirect_uri=" + JspElement.ctx + "/" + JspElement.urlsecre + "authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
                return;
            }
            if (this.disabledButton) {
                that.tips("请勿重复点击!");
                return;
            }
            if (this.phone == '') {
                that.tips("请输入手机号!");
                return;
            }
            if (this.check_phone(phone)) {
                that.tips("请输入正确的手机号！");
                return;
            }
            this.disabledButton = true;
            $.ajax({
                url: JspElement.ctx + '/w/app/distribution/sendcode.html',
                type: 'post',
                dataType: "json",
                data: {
                    'phone': this.phone
                },
                async: false,
                success: function (data) {
                    if (data.status) {
                        that.tips("短信发送成功！");
                    } else {
                        tips("短信发送失败！");
                        that.disabledButton = false;
                    }
                },
                error: function (err) {
                    this.tips("短信请求失败！");
                    this.disabledButton = false;
                }
            });
            var time = 60;
            $("#getpwd").html(time);
            $("#getpwd").css({
                borderColor: "transparent",
                left: -40 + "px"
            });
            var timer = setInterval(function () {
                time--;
                $("#getpwd").html(time).css("color", "red");
                if (time == 0) {
                    clearInterval(timer);
                    $("#getpwd").html("重新获取");
                    $("#getpwd").css({
                        borderColor: "#07d2ed",
                        left: -120 + "px"
                    });
                    that.disabledButton = false;
                }
            }, 1000)
        },
        submitBtn: function () { //提交订单
            if (this.name == "") {
                this.tips("请输入真实姓名！");
                return;
            } else if (this.phone == "") {
                this.tips("请输入手机号！");
                return;
            } else if (!this.check_phone(this.phone)) {
                this.tips("请输入正确的手机号！");
                return;
            } else if (this.pwd == "") {
                this.tips("请输入验证码");
                return;
            } else {
                var _this = this;
                $.ajax({
                    type: "get",
                    dataType: "json",
                    url: JspElement.ctx+"/w/logger/1000/0/"+JspElement.uid+".html?o="+JspElement.ordernumber+"&usephone="+_this.phone + "&srowid="+userID+"&courseName=" + _this.detaills.name,
                    error: function (XMLHttpRequest, textStatus, error) {
                    },
                    success: function (msg) {
                        if (msg.id > 0) {
                            _this.loggerid = msg.id;
                            _this.save();
                        } else
                            _this. tips("Error");
                    }
                });
                return;
            }
        },
        save: function () {
            var _this = this;
            $.post(JspElement.ctx+"/v2/live/zhibo/info.json", {
                "name": _this.name,
                "phone": _this.phone,
                "sid": userID,
                "ordernumber": JspElement.ordernumber,
                "loggerid": _this.loggerid,
                "pwd": _this.pwd,
                "money":0,
                "zid": _this.detaills.id
            }, function (data) {
                if (data.status) {
                    // $("#signupid").val(data.signupid);
                    _this.weixinPay();
                } else {
                    _this.tips(data.msg);
                }
            });
        }
        ,
        weixinPay: function () {
            var _this = this;
            wx.ready(function (res) {
                wx.chooseWXPay({
                    timestamp: JspElement.paytimestamp, // 支付签名时间戳，注意微信jssdk中的所有使用timestamp字段均为小写。但最新版的支付后台生成签名使用的timeStamp字段名需大写其中的S字符
                    nonceStr: JspElement.paynonceStr, // 支付签名随机串，不长于 32 位
                    package: JspElement.paypackage, // 统一支付接口返回的prepay_id参数值，提交格式如：prepay_id=***）
                    signType: 'MD5', // 签名方式，默认为'SHA1'，使用新版支付需传入'MD5'
                    paySign: JspElement.paySign, // 支付签名
                    success: function (res) {

                        //alert(JSON.stringify(res))
                        // 支付成功后的回调函数
                        if (res.errMsg == 'chooseWXPay:ok') {
                            $("#submitBox").animate({
                                bottom: -17 + "rem"
                            }, 500);
                            $("#jieshao").hide();
                            $("#anpai").show();
                            $("#tab li").removeClass("curr");
                            $("#tab li.right").addClass("curr");
                            $("#tab div").removeClass("curr");
                            $("#tab div.bottom1").addClass("curr");
                            _this.myscroll.refresh();
                            _this.tips("您已购买成功!");
                            _this.Success();
                        } else {
                            $("#submitBox").animate({
                                bottom: -17 + "rem"
                            }, 500);
                            _this.cancle();
                        }
                    },
                    cancel: function (res) {
                        $("#submitBox").animate({
                            bottom: -17 + "rem"
                        }, 500);
                        $("#masking2").hide();
                        //_this.tips("您已取消购买!");
                       var url = window.location.href;
                       if(url.indexOf("?")>0){
                           url = url+"&time="+ new Date().getTime();

                       }else{
                           url = url+"?time="+new Date().getTime();
                       }
                       window.location.href = url;
                    }
                });
            });
        },
        Success:function(){
            this.pay = true;
            $("#masking2").hide();
        },
        cancle:function(){
            $("#masking2").hide();
            // alert("取消购买")
        }
    },

    updated:function(){

    }
})
vw.init();
wx.config({
    debug: false,
    appId: JspElement.appid,
    timestamp: JspElement.timestamp,
    nonceStr: JspElement.nonceStr,
    signature: JspElement.signature,
    jsApiList: [
        'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
        'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
        'showAllNonBaseMenuItem', 'chooseWXPay', 'hideOptionMenu', 'showOptionMenu'
    ]
});
wx.ready(function () {
    //自定义标题
    var title1 = JspElement.sharename,
        img1 = vw.detaills.logo,
        desc1 = JspElement.zhiboremark;
    wx.onMenuShareTimeline({
        title: title1, // 分享标题
        link: link1, // 分享链接
        imgUrl: img1, // 分享图标
        success: function (res) {
            // alert("ok")
            if (res.errMsg == 'shareTimeline:ok') {
                //vw.tips("每成功邀请一位好友听课你将获得"+vw.money+"元收益");
                $("#masking").hide();
            }
        },
        cancel: function () {
        }
    });
    wx.onMenuShareAppMessage({
        title: title1, // 分享标题
        desc: desc1, // 分享描述
        link: link1, // 分享链接
        imgUrl: img1, // 分享图标
        type: '', // 分享类型,music、video或link，不填默认为link
        dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
        success: function (res) {
            if (res.errMsg == 'sendAppMessage:ok') {
                //vw.tips("每成功邀请一位好友听课你将获得"+vw.money+"元收益");
                $("#masking").hide();
            }
        },
        cancel: function () {
        }
    });
});
window.onload=function () {
    var _this = this;
    setTimeout(function () {
        vw.myscroll = new iScroll("mainBox", {
            vScrollbar: false,
            bindToWrapper: false,
            //momentum : false,
            bounce: true,
            onScrollLimit: function () {
            }
        });
    },100);
    setTimeout(function () {
        $("#stash").hide();
        vw.myscroll.refresh();
    },600);
    if(JspElement.mobile && JspElement.realname){
        vw.phone = JspElement.mobile;
        vw.name =JspElement.realname;
        vw.pwd = 99999;
        vw.havePhone=true;
    }else{
        vw.havePhone=false;
    };
}
