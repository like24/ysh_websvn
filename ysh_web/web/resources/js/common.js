var APP = {};
// APP.API_PATH = "http://localhost:8080/v2/";
// APP.API_PATH1 = "http://localhost:8080/"
var locationUrl = window.location.href,
    ulr1 = "localhost:8080/",
    url2 = "weixin.keepyoga.com",
    url3 = "wx.keepyoga.com";
if(locationUrl.indexOf(ulr1)>0){
    APP.API_PATH = "http://localhost:8080/v2/";
    APP.API_PATH1 = "http://localhost:8080/";
   // APP.SOCKET = "ws://localhost:8080/ws/coursechat";
    APP.SOCKET = "ws://weixin.keepyoga.com/ws/coursechat";
}else if(locationUrl.indexOf(url2)>0){
    APP.API_PATH = "http://weixin.keepyoga.com/v2/";
    APP.API_PATH1 = "http://weixin.keepyoga.com/";
    APP.SOCKET = "ws://weixin.keepyoga.com/ws/coursechat";
}else if(locationUrl.indexOf(url3)>0){
    APP.API_PATH = "http://wx.keepyoga.com/v2/";
    APP.API_PATH1 = "http://wx.keepyoga.com/";
    APP.SOCKET = "ws://wx.keepyoga.com/ws/coursechat";
}else{
    APP.API_PATH = " http://192.168.1.82:8080/v2/";
    APP.API_PATH1 =  "http://192.168.1.82:8080/";
    APP.SOCKET = "ws://192.168.1.82:8080/ws/coursechat";

}
APP.XHR_STATUS = true;
//总页数
APP.PAGECOUNT = 20;
//翻页初始页码
APP.PAGE_NUM = 2;
APP.PAGE = 2;
//URI - query属性查询
APP.URLSEARCH = function () {
    url = decodeURIComponent(location.search); //获取url中"?"符后的字串
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for(var i = 0; i < strs.length; i ++) {
            theRequest[strs[i].split("=")[0]]=unescape(strs[i].split("=")[1]);
        }
    }
    return theRequest;
}
