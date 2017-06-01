<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="find" />
<!doctype html>
<html lang="en">
<head>
	<title>导师墙</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}"> 
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script type="text/javascript">
	     var nodata = 0 ;
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
    <link rel="stylesheet" href="${ctx}/css/teach.css?v=${version}">
</head>	 
<body>
    <div class="wrapper">
        <section id="mainBox">
            <div>
                <nav>
	                <ul id="nav">
	                    <li data-url="${ctx}/w/find/index.html" <c:if test="${p==0}">class="high"</c:if>>导师</li>
	                    <li data-url="${ctx}/w/find/index.html?p=1" <c:if test="${p==1}">class="high"</c:if>>活动</li>
				    </ul>
				    <a href="${ctx}/w/search.html">搜索</a>
				</nav>
                <div class="tutor">
                    <ul id="list">
						 <c:forEach items="${teacherlist}" var="tlist"  >
								  <li>
									  <c:forEach items="${tlist}" var="teacher"  >
											   <ol data-id="${teacher.id}" >
											   <c:choose>
															    <c:when test="${ fn:indexOf(teacher.file_path,'http') > -1 }">
																					 <img id="tx_${teacher.id}" src="${teacher.file_path}"  >
															    </c:when>
																<c:otherwise>
																					 <img id="tx_${teacher.id}"  src="${ctx}/${teacher.file_path}">
																			  </c:otherwise>    
																 </c:choose>
											                <div></div>
											                <span>${teacher.nickname}</span>
											     </ol> 
										  </c:forEach>
								  </li>
			              </c:forEach>
                    </ul>
                </div> 
            </div>
        </section>
         <%@ include file="../footer.jsp" %>
    </div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
    <script src="${ctx}/js/jquery.lazyload.min.js"></script>
    <script>
   		 $("img").lazyload();
         var pageIndex = 0;
        $("#list").on("tap", "ol", function () {
        	var teacherid= $(this).attr("data-id");
        	$.ajax({
 				type:"post",
 				dataType:"json",
 				url:  "${ctx}/w/user/info.html?p="+teacherid,
 				error:function(XMLHttpRequest,textStatus,error){},
 				success:function(msg){
 					 showUserInfo( msg.id, msg.username ,msg.header, msg.userpost, msg.remark ,msg.gz );
 				}
        	 });
        })
        $("#nav").on("click","li",function(){
            window.location.href= $(this).attr("data-url");
        }) 
        function showUserInfo(id, username, header, userpost , remark, gz){
        	dialog({
                wrapper: ".wrapper",
                id: "teach",
                mask: true,
                teachImg: header,
                h: username,
                title1: userpost,
                title2: remark,
                radiusBox: true,
                close: true,
                btnleft: (gz == true?"已关注":"关注"),
                btnright: "个人主页",
                bodytap: true,
                focus:  gz,
                goumai: function () {
                	 $(".masking").remove();
                     $("#teach").remove();
                     
                	 $.ajax({
         				type:"post",
         				dataType:"json",
         				url:  "${ctx}/w/follow/"+id+"/false.html",
         				error:function(XMLHttpRequest,textStatus,error){},
         				success:function(msg){
         					if( msg.status == true ){
         						//Modal.tips("<font color='#ccc'>关注成功了 </font>","succes",2500, function(){
         						//	 
         					//});
         					}
         				}
                	 });
                },
                shikan: function () {
                	setTimeout(function(){
                		 window.location.href = '${ctx}/w/faq/person.html?p='+id+"&t=1";
                	},300)
                   
                }
            })
        }
        
        var nologin = "${nologin}"; 
		if( nologin == "true" ) {   
		    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		}
    </script>
</body>