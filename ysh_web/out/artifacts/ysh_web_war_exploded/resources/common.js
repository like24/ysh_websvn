var APP = {};
//APP.API_PATH = "http://weixin.keepyoga.com/v2/";
APP.API_PATH = "http://localhost:8080/v2/";
APP.API_PATH1 = "http://localhost/:8080/";
APP.XHR_STATUS = true;
//总页数
APP.PAGECOUNT = 20;
//翻页初始页码
APP.PAGE_NUM = 2;
APP.PAGE = 2;
//URI - query属性查询
APP.URLSEARCH = function () {
   var url = decodeURIComponent(location.search); //获取url中"?"符后的字串
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
