<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../taglibs.jsp" %> 
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no,email=no" name="format-detection">
<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
<script src="${ctx}/js/jquery.min.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
    var ctx = "${ctx}";
    var isweb = false;
    var vzanBrowser = {
        versions: function () {
            var u = navigator.userAgent, app = navigator.appVersion;
            return {/*移动终端浏览器版本信息*/
                trident: u.indexOf('Trident') > -1, /*IE内核*/
                presto: u.indexOf('Presto') > -1, /*opera内核*/
                webKit: u.indexOf('AppleWebKit') > -1, /*苹果、谷歌内核*/
                gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1,/*火狐内核*/
                mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/AppleWebKit/), /*是否为移动终端*/
                ios: !!u.match(/i[^;]+;( U;)? CPU.+Mac OS X/), /*ios终端*/
                android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, /*android终端或者uc浏览器*/
                iPhone: u.indexOf('iPhone') > -1 || (u.indexOf('Mac') > -1 && u.indexOf('Macintosh') < 0), /*是否为iPhone或者QQHD浏览器*/
                iPad: u.indexOf('iPad') > -1, /*是否iPad*/
                webApp: u.indexOf('Safari') == -1, /*是否web应该程序，没有头部与底部*/
                WindowsWechat: u.indexOf('WindowsWechat') > 0/*是否web应该程序，没有头部与底部*/
            };
        }(),
        language: (navigator.browserLanguage || navigator.language).toLowerCase()
    }
</script>
<script type="text/javascript">
	if (!(vzanBrowser.versions.WindowsWechat || vzanBrowser.versions.android || vzanBrowser.versions.iPhone || (vzanBrowser.versions.android && String(navigator.platform).indexOf("Linux") > -1))) {
           if( isweb ) {
		        
           }
	}
</script>
