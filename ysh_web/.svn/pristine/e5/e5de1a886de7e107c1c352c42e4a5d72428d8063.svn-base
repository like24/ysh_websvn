<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="find" />
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
    <title>${u.nickname },${u.userpost},导师精品课程、语音问答尽在瑜是乎</title>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <link rel="stylesheet" href="${ctx}/css/personal_homepage.css?v=${version}">
    <style>
    #list li dl:nth-child(2) dd button {position: relative;margin-bottom: .5rem;}
    .nav{width:80%;margin:0 auto}
    .nav ul {
    height: 1.375rem;
    display:flex;
    border: 1px solid #1d92fb;
    width: 100%;
    height: 1.5rem;
    border-radius: 3px;
    margin: .8875rem auto;
}
   .nav ul li{
flex:1;
width:1%;}
    </style>
    <script type="text/javascript">
	     var nodata = ${resultlist.totalCount > 10 ? 1:0};
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
</head>
 <body>
    <div class="wrapper">
        <section class="mainBox" id="mainBox">
            <div class="iscrollBox">
            <div class="info">
                <p class="info_1">
                     <c:choose>
						<c:when test="${ fn:indexOf(u.file_path,'http') > -1 }"><img  id="uh" src="${u.file_path}" class="icon"></c:when>
						<c:otherwise><img src="${ctx}/${u.file_path}" id="uh" class="icon"></c:otherwise>    
					 </c:choose>  
					 <c:if test="${ !nologin && followuser }">
                        <img src="http://wimg.keepyoga.com/question_yes.png" alt="" class="follow">
                     </c:if>
                </p>
                <p class="info_2">
                    <span>${u.nickname }</span>  
                    <c:choose>
                        <c:when test="${ nologin == false && u.id == loginuser.id }">
                            <span class='guanzhu' style="visibility:hidden"></span>
                        </c:when>
                        <c:otherwise>
	                        <c:if test="${ nologin == true || followuser == false }">
		                        <span class='guanzhu' style="background:#1d92fb" data-link="false" id="guan">+关注</span>
		                    </c:if>
		                    <c:if test="${ followuser == true }">
		                        <span class='guanzhu' style="background:#9c9c9c" data-link="true" id="guan">已关注</span>
		                    </c:if>
                        </c:otherwise>
                    </c:choose>   
                </p>
               
                <p class="info_3">${u.userpost}</p>
                <p class="info_4">${u.shortremark}</p>
                <nav class="nav">
                   <nav class="nav">
		               <ul>
		               	 <li><a href="${ctx}/w/faq/person.html?p=${p}&t=4" <c:if test="${t==4 || t == 1}">class="high"</c:if>>课程 </a></li>
		                    <li><a href="${ctx}/w/faq/person.html?p=${p}&t=3" <c:if test="${t==3 || t == 0 }">class="high"</c:if>>问答</a></li>
		                   
		                    <li><a href="${ctx}/w/faq/person.html?p=${p}&t=5" <c:if test="${t==5 || t == 2}">class="high"</c:if>>线下培训</a></li>
		               </ul>
		           </nav> 
	            </nav>
            <c:if test="${u.isacceptask ==2}">
	            <div class="noOpen" id="noOpen">
					<img src="http://wimg.keepyoga.com/747606438608904323.jpg" alt="">
					<p>很抱歉该老师暂未开通问答</p>
				</div>
            </c:if>
            <c:if test="${ nologin == false && loginuser.id != u.id && u.isteacher == 1 && u.isauth == 1 && u.isacceptask != 2 }">
                <div class="hide_or_show" >
	                <textarea class="content_1" id="c" name="c"  placeholder="向 “${u.nickname }”提问，等Ta语言回答；超过${dic*24}小时未回答，将按支付路径全额退款。"></textarea><span class="number" id="zs">0/60</span>
	                <p class="content_2">
	                   <label><input type="checkbox" value="0" id="isopen" name="isopen" checked /><b class="check bg"></b><span>公开回答</span> </label>
	                </p>
	                <c:if test="${ u.askmoney > 0 }">
	                    <p class="content_3">￥${u.askmoney }</p>
	                </c:if>
	                 <c:if test="${ u.askmoney == 0 }">
	                    <p class="content_3">免费</p>
	                </c:if>
	                <p class="content_4"><button class="write" onclick="writeOk(this)">写好了</button></p>
                </div>
           </c:if> 
            </div>
            <c:if test="${resultlist.totalCount > 0}">
                <p class="content">回答了<span> ${resultlist.totalCount} </span>个问题</p>   
            </c:if>
            <ul class="list" id="list">
              <c:forEach items="${resultlist.results}" var="faq" varStatus="status">
                <input type="hidden" id="isplay_${faq.id}" value="0"/>
                <li>
                   <dl>
                      <dt>
                           <a href="javascript:;"><c:choose><c:when test="${ fn:indexOf(faq.header,'http') > -1 }"><img src="${faq.header}" ></c:when><c:otherwise><img src="${ctx}/${faq.header}"></c:otherwise></c:choose></a>
                       </dt>
                       <dd>
                           <h4>${faq.synopsis }</h4>
                           <c:if test="${faq.askmoney > 0}">
                             <p>￥${faq.askmoney }</p>
                           </c:if>
                       </dd>
                   </dl>
                   <dl>
                       <dt>
                           <c:choose><c:when test="${ fn:indexOf(faq.askheader,'http') > -1 }"><img src="${faq.askheader}" ></c:when><c:otherwise><img src="${ctx}/${faq.askheader}"></c:otherwise></c:choose>
                       </dt>
                       <dd>
	                       <c:forEach items="${faq.answers}" var="ans" varStatus="status">
					  		<button class="audio"  onclick="playmp3(this,'${ans.id}')" data-id="${ans.cid}"  data-src="${cdn}/${ans.mp3path}"><img src="http://wimg.keepyoga.com/son.png">免费听</button> 
							<span id="aa_${ans.id}">${ans.timelong}</span>
						 </c:forEach>
					</dd>
                   </dl>
                   <p><span>${faq.showtime}</span><span>听过&nbsp;&nbsp;<span id="span_${faq.id}">${faq.play_count }</span> 人</span></p>
	               </li>
	               <c:if test="${ not empty faq.subcontent}">
	              	 <li>
	              	 	<dl>
	                      	<dt>
	                           <a href="javascript:;"><c:choose><c:when test="${ fn:indexOf(faq.header,'http') > -1 }"><img src="${faq.header}" ></c:when><c:otherwise><img src="${ctx}/${faq.header}"></c:otherwise></c:choose></a>
	                       </dt>
	                       <dd>
	                         <h2>${faq.subcontent}</h2>
	                       </dd>
                 	 	</dl>
	                    <dl>
	                       <dt>
	                           <c:choose><c:when test="${ fn:indexOf(faq.askheader,'http') > -1 }"><img src="${faq.askheader}" ></c:when><c:otherwise><img src="${ctx}/${faq.askheader}"></c:otherwise></c:choose>
	                       </dt>
	                       <dd>
		                       <c:forEach items="${faq.answers_expand}" var="ans" varStatus="status">
						  		<button class="audio"  onclick="playmp3(this,'${ans.id}')" data-id="${ans.cid}"  data-src="${cdn}/${ans.mp3path}"><img src="http://wimg.keepyoga.com/son.png">免费听</button> 
								<span id="aa_${ans.id}">${ans.timelong}</span>
							 </c:forEach>
							</dd>
	                   </dl>
	               	</li>
	               </c:if>
                 </c:forEach>  
            </ul>
           </div>
        </section>
         <%@ include file="../footer.jsp" %> 
    </div>
    <script src="${ctx}/js/zepto.js?v=${version}"></script>
    <script src="${ctx}/js/iscroll4.js?v=${version}"></script>
    <script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
     <script>
		var icon = $("#uh").attr("src"); 
		var title1 = "${u.nickname },${u.userpost},导师精品课程、语音问答尽在瑜是乎";
		var desc1  = "我在瑜是乎平台等你来问，专业的瑜伽培训教育平台。";
		var link1  = location.href;
		var img1   = icon ;
		
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
		wx.ready(function (Api) {
            wx.hideAllNonBaseMenuItem();
            wx.showMenuItems({
                menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
            });
        });
		
		function onBridgeReady(){
	         WeixinJSBridge.invoke(
	             'getBrandWCPayRequest', {
	                "appId" : "${appid}",     //公众号名称，由商户传入     
	                 "timeStamp":"${paytimestamp}",         //时间戳，自1970年以来的秒数     
	                 "nonceStr" : "${paynonceStr}", //随机串     
	                 "package" : "${paypackage}",     
	                 "signType" : "${paysignType}",         //微信签名方式:     
	                 "paySign" : "${paySign}" //微信签名 
	            },
	            function(res){
	                if( res.err_msg == 'get_brand_wcpay_request:ok'){
	                	addContent();
	                }
	                if( res.err_msg == 'get_brand_wcpay_request:cancel'){
	                	location.href ="${ctx}/w/faq/person.html?p=${p}&t=${t}";// 放弃付款
	                }
	            }
	        ); 
	   }
		 
	  function pay(){  
	     if (typeof WeixinJSBridge == "undefined"){
	         if( document.addEventListener ){
	              document.addEventListener('WeixinJSBridgeReady', onBridgeReady, false);
	         }else if (document.attachEvent){
	              document.attachEvent('WeixinJSBridgeReady', onBridgeReady); 
	              document.attachEvent('onWeixinJSBridgeReady', onBridgeReady);
	         }
	      }else{
	         onBridgeReady();
	      }
	  }
	  </script>
    <script src="${ctx}/js/wblog.js?v=${version}"></script>
    <script src="${ctx}/js/model_dialog.js?v=${version}"></script>
    
    <script>
      var gz = false;
      $("span.guanzhu").on("tap",function(){
    	    var link  = $(this).attr("data-link");
    	    if( gz == true ){
    	    	Modal.tips("<font color='#ccc'>亲，不要反复的点，会疼的！</font>","error",2500);
    	    	return;
    	    }
    	    var lid="${loginuser.id}";
    	    var tid="${u.id}";
    	    if( lid == tid ){
    	    	return;
    	    }
    	    
    	    gz = true;
    	    $.ajax({
				type:"post",
				dataType:"json",
				url:  "${ctx}/w/follow/${u.id}/"+link+".html",
				error:function(XMLHttpRequest,textStatus,error){},
				success:function(msg){
					  if( msg.status == true ){
						  if( link == 'true'){
							  $("#guan").attr("data-link","false");
							  $("#guan").css({"background":"#1d92fb"})
							  $("#guan").html('+关注');
						  }else{
							  $("#guan").attr("data-link","true");
							  $("#guan").css({"background":"#9c9c9c"})
							  $("#guan").html('已关注');
						  } 
						  gz = false;
					  }
				}
			});  
      })
	  
	  var loggerid = 0 ;
      
      var isAdding = false;
	  
	    
      function writeOk(o){
    	 if( $("#c").val() == ''){
         	 Modal.tips("<font color='#ccc'>亲，写点内容吧！ </font>","error",2500);
         	 return;
         }
    	 
    	 if( isAdding ){
	   		  return;
	   	 }
	   	 isAdding  = true;
	   	 $(this).onclick=null;
    	 var money = parseInt('${u.askmoney }');
    	 var isopencheck = $("input[type='checkbox']").is(':checked');
    	 var isopen=(isopencheck?0:1);
    	 var c = $("#c").val();
    	 $.ajax({
				type:"post",
				dataType:"json",
				url:  "${ctx}/w/logger/1/"+money+"/${u.id}.html?o=${ordernumber}&isopen="+isopen+"&content="+c,
				error:function(XMLHttpRequest,textStatus,error){},
				success:function(msg){
					  if( msg.id > 0 ){
						  loggerid = msg.id; 
						  if( money > 0 ){
					    		 pay();
					      }else{
					    		 addContent();
					      }
					  }
					 
				}
		 });   
      }
      
     
      
      function addContent(){ 
    	  var isopen = $("input[type='checkbox']").is(':checked');
    	  var c = $("#c").val();
    	  c = encodeURI(encodeURI(c));
          $.ajax({
 				type:"post",
 				dataType:"json",
 				url:  "${ctx}/w/teacher/${u.askmoney }_"+(isopen?0:1)+"_${u.id}/ask.html?or=${ordernumber}&c="+c+"&p="+loggerid,
 				error:function(XMLHttpRequest,textStatus,error){},
 				success:function(msg){
 					  if( msg.status == true ){
 						  $("#c").val('');
 						  setTimeout(function(){
 							 Modal.tips("<font color='#ccc'>亲，您的问题已提交给导师，请关注回复</font>","success",1500,function(){
  							    location.href="${ctx}/w/faq/d.html?p="+msg.sid;
  						     });
 						  },300); 
 					  }else{
 						 setTimeout(function(){
 						    Modal.tips("<font color='#ccc'>"+msg.result+"</font>","error",1500);
 						 },300); 
 					  }
 					  isAdding = false;
 				}
 		 }); 
      }
      
       
      
      $("div.main").on("tap","dl",function(){
			window.location.href=$(this).attr("data-url");
	  })
		
	  function playmp3(jdom,sid){
    	  $("#list button").find("img").attr("src", "http://wimg.keepyoga.com/son.png");
    	  $("#audio111").get(0).pause();
    	  var button = jdom;
				 if(!$(button).attr("play")){
					 var a = $("#aa_"+sid).html();
					 var b = a.substring(3, 5);
		                setTimeout(function () {
		                    $(button).find("img").attr("src", "http://weixin.keepyoga.com/images/son.png");
		                    $("#audio111").get(0).pause();
		                    $(button).removeAttr("play");
		                    //stopVoice();
		                }, b * 1000 + 400);
						var mp3source = $(jdom).attr("data-src");
						var id  = $(jdom).attr("data-id");
						$("#audio111").get(0).pause();
						$("#audio111").get(0).src=mp3source;
						$("#audio111").get(0).volume=1;
						$("#audio111").get(0).play();
						$(button).attr("play","play");
						$("button").find("img").attr("src", "http://wimg.keepyoga.com/son.png");
						$(button).find("img").attr("src", "http://wimg.keepyoga.com/songif.gif"); 
						if( !$(button).hasClass('played')){
							$(button).addClass('played');
							if( $("#isplay_"+id).val()==0){
								$.ajax({
					 				type:"post",
					 				dataType:"json",
					 				url:  "${ctx}/w/faq/count/play.html?p="+id,
					 				error:function(XMLHttpRequest,textStatus,error){},
					 				success:function(msg){
					 					 if( msg.status == true){
					 						 $("#isplay_"+id).val(1);
					 						 $("#span_"+id).html( Number($("#span_"+id).html())+1);
					 					 }
					 				}
					 			}); 
							}
						}
				 }else{
					    $(button).find("img").attr("src", "http://wimg.keepyoga.com/son.png");
						$("#audio111").get(0).pause();
						$(button).removeAttr("play");
				 }
	   }
        var pageIndex = 1;
		function loadStore(){
			if( pageIndex > -1 ){
				$.ajax({
	 				type:"post",
	 				dataType:"json",
	 				url:  "${ctx}/w/faq/person/json.html?p=${p}&t=0&pageIndex="+(pageIndex+1),
	 				error:function(XMLHttpRequest,textStatus,error){},
	 				success:function(msg){
	 					if( msg.result != ''){
	 					    $("#list").append(msg.result);
	 					    pageIndex ++;
	 					}else{
	 					    $("#pullUp").remove(); 
	 					    //Modal.tips("<font color='#ccc'>亲，没有更多数据了！</font>",2500);
	 					    pageIndex = -1;
	 					}
	 				}
	 			});  
			}
		}
		
		$("label").on("tap", function () {
            var inx = $(this),
                atr = inx.attr("abc");
            if (atr == 1) {
                 $("b.check").addClass("bg")
                inx.attr("abc", 0);
            } else {
            	$("b.check").removeClass("bg")
                inx.attr("abc", 1);
            }
        });

		  var nologin = "${nologin}"; 
		  if( nologin == "true" ) { 
			    window.location.href= "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		  }
		  
		 
	      $("#c").on("input", function () {
            var tex = $(this).val();
            $("#zs").html(tex.length + "/60");
            if (tex.length > 60) {
                var text = tex.substring(0, 60);
                $(this).val(text);
                $("#zs").html(60 + "/60");
            }
        })
	    </script>
    <div style="display:hidden" ><audio id="audio111"><source src="" type="audio/mpeg"></audio></div> 
</body>
 
</html> 
 