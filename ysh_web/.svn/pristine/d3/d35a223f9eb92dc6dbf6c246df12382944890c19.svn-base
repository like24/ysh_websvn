<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="my" /> 
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no,email=no" name="format-detection">
<title>已报名学员</title>
<link rel="stylesheet" href="${ctx}/css/common.css">
<link rel="stylesheet" href="${ctx}/css/reset.css">
<link rel="stylesheet" href="${ctx}/css/saler_list.css">
<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
<script src="${ctx}/js/setfontsize.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${version}"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script src="${ctx}/js/wblog.js?v=${version}"></script>
<style>
        .course-box{
            margin-top: 0.5rem;
            position: relative;
            padding: 1.125rem 0;
            background-color: #fff;
        }
        .avatar{
            width: 2.8rem;
            height: 2.8rem;
            position: absolute;
            top: 50%;
            margin-top: -1.4rem;
            left: 0.75rem;
        }
        .avatar img{
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }
        .course-info{
            font-size: 0.65rem;
            margin-left: 4.25rem;
        }
        .name{
            margin-bottom: 0.4rem;
        }
       
        .number{
            color: #fd9427;
        }
        .time{
            color: #8a8a8a;
        }
        .icon-phone{
            display: inline-block;
            width: 1.65rem;
            height: 1.65rem;
            position: absolute;
            top: 50%;
            margin-top: -0.825rem;
            right: 0.75rem;
        }
        .icon-phone img{
            width: 100%;
            height: 100%;
        }
        .type{
        		color:#9c9c9c;
        		font-size: .6rem;
        }
       
    </style>

</head>
<body>
	<div class="wrapper">
		 <section class="mainBox" id="mainBox">
            <div class="iscrollBox">
                <ul>
                	<c:forEach items="${buyers}" var="buyer" varStatus="status">
	                    <li class="course-box" id="list">
	                        <div class="avatar"><img src="${buyer.filepath }" alt=""></div>
	                        <div class="course-info">
	                            <p class="name">${buyer.realname }</p>
	                            <p class="call"><span>联系方式：</span><span class="number">${buyer.phone }</span></p>
	                            <c:if test="${buyer.mid > 0 }">
		                            <p class="type">
		                              <c:forEach items="${clist}" var="cmoney">
		                                  <c:if test="${cmoney.id == buyer.mid }">${cmoney.cname }</c:if>
		                              </c:forEach>
		                            </p>
	                            </c:if>
	                            <p class="time"><span>购买时间：</span><span>${buyer.createtime }</span></p>
	                        </div>
	                        <a class="icon-phone" href="tel:${buyer.phone }"><img src="${cxt}/images/icon_phone.png" alt=""></a>
	                    </li>
                    </c:forEach>
                </ul>
            </div>
        </section>
		<%@ include file="../footer.jsp"%>
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
	<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
	<script>
	if("${login}"=="false") {   
	    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=http://weixin.keepyoga.com/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
	}
	wx.config({
	    debug: false,
	    appId: '${appid}',
	    timestamp:'${timestamp}' ,
	    nonceStr: '${nonceStr}',
	    signature: '${signature}',
	    jsApiList: [ 
	        'checkJsApi','openLocation',
	        'getLocation','checkJsApi','onMenuShareTimeline','onMenuShareAppMessage',
	        'onMenuShareQQ','onMenuShareWeibo','hideMenuItems','showMenuItems','hideAllNonBaseMenuItem',
	        'showAllNonBaseMenuItem', 'chooseImage','previewImage','uploadImage',
	        'chooseWXPay','downloadImage','getNetworkType','openLocation',
	        'getLocation','hideOptionMenu','showOptionMenu'
	      ]
	}); 
	wx.ready(function(Api){ 
	    wx.hideAllNonBaseMenuItem();
	    wx.showMenuItems({
		    menuList: ['menuItem:share:appMessage','menuItem:share:timeline','menuItem:share:qq','menuItem:share:weiboApp','menuItem:favorite','menuItem:share:facebook','menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
		});
	});
	$(document).on("click","dl",function(){
		window.location.href="${ctx}/"+$(this).attr("id");
	})
	</script>
	<script>
		var pageIndex=window.sessionStorage.getItem("pageIndex");
		if(pageIndex==null||pageIndex==""){
			pageIndex=1;
		}
		var nodata =0;
		var totalPage=parseInt("${totalPage}");
		if(totalPage>pageIndex){
			nodata=1;
		}
		function loadStore(){
			if( pageIndex > -1 ){
				$.ajax({
	 				type:"post",
	 				dataType:"json",
	 				url:  "${ctx}/w/course/line/buyerAjax.shtml?id=${id}&pageIndex="+(pageIndex+1),
	 				error:function(XMLHttpRequest,textStatus,error){},
	 				success:function(data){
	 					if( data.code == 1){
	 						nodata=data.result.length>9?1:0;
	 						 $.each(data.result, function (i, item) {  

	 							var myli = "<li class='course-box'>"+
			                       	 "<div class='avatar'><img src='"+item.filepath+"' alt=''></div>"+
			                        	"<div class='course-info'>"+
			                           	 "<p class='name'>"+item.uname+"</p>"+
			                            	"<p class='call'><span>联系方式：</span><span class='number'>"+item.phone+"</span></p>"+
			                            	"<p class='time'><span>购买时间：</span><span>"+item.createtime+"</span></p>"+
			                        	"</div>"+
			                        	"<a class='icon-phone' href="+'tel:${buyer.phone }'+"><img src='${cxt}/images/icon_phone.png' alt=''></a>"+
			                    	"</li>";
		                        $("#list").append(myli);
	 				        });  
	 					    pageIndex ++;
	 						window.sessionStorage.setItem("pageIndex", pageIndex);
	 					}else{
	 						 nodata = 0;
	 						 $("#pullUp").remove();  
	 					     pageIndex = -1;
	 					}
	 					
	 				}
	 			});  
			}
		}
		
		var font_count = $(".title").find("p").length;
		for (var i = 0; i < font_count; i++) {
			var font = $(".title").eq(i).find("p").html();
			if (font.length > 7) {
				font = font.slice(0, 7) + "...";
				$(".title").eq(i).find("p").html(font);
			}
		} 
	</script>
</body>
</html>