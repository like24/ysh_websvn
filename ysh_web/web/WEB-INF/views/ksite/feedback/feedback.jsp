<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="my" />
<!doctype html>
<html lang="en">
<head>
	<title>提建议</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}"> 
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<script type="text/javascript" src="${ctx}/js/jquery.form.js?v=${version}"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<link rel="stylesheet" href="${ctx}/css/advuse1.css?v=${version}">
	<script src="${ctx}/js/setfontsize.js?v=${version}"></script>
</head>	 
 <body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox" >
             <form action="${ctx}/w/add/feedback.html" id="addComment" onsubmit="return false;" method="post">
                <input type="hidden" name="questiontype" id="questiontype" value="" />
                <div class="radio">
                 <h4>*问题分类</h4>
              <ol>
                 <label for="radio1" onclick="javascript:$('#questiontype').val('1')">
                     <input type="radio" name="que" value="1"   id="radio1"  />
                     <span></span>课程相关</label>
                 <label for="radio2" onclick="javascript:$('#questiontype').val('3')">
                     <input type="radio" name="que" value="3"    id="radio2" />
                     <span></span>导师相关</label>
               </ol>
                <ol>
                 <label for="radio3" onclick="javascript:$('#questiontype').val('2')">
                     <input type="radio" name="que" value="2"    id="radio3"  />
                     <span></span>问答相关</label>
                 <label for="radio4" onclick="javascript:$('#questiontype').val('0')">
                     <input type="radio" name="que" value="0"  id="radio4"  />
                     <span></span>其他</label>
               </ol>
                 </div>
                 <div class="details">
                     <h4>*建议详情</h4>
                     <textarea name="question" id="question" cols="30" rows="10" placeholder="您的建议是我们成长最大的动力"></textarea>
                     <input type="text" class="tex" onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')"  placeholder="您的联系方式，便于我们与您联系（选填）" name="mobile" maxlength="15" >
                     <button onclick="feedback(this);" class="btn"> 写好了</button>
                 </div>
             </form>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script type="text/javascript"  src="${ctx}/js/zepto.js?v=${version}"></script>
	<script type="text/javascript"  src="${ctx}/js/wblog.js?v=${version}"></script>
	<script type="text/javascript"  src="${ctx}/js/model_dialog.js?v=${version}"></script>
    <script>
      $("label").on("tap",function(){
          $("label").find("span").removeClass("high");
          $(this).find("span").addClass("high");
      })
      
      function feedback(o){
    	  var oo = o ;
    	  if( $(o).hasClass("focused") ){
 			 Modal.tips("意见提交中，请稍后！","error",3000);
 	         return ;
 		  }
    	  var radiocheck  =$('input[type=radio]').is(':checked'); 
    	  if( !radiocheck ){
    		  Modal.tips("<font color='#ccc'>亲，先选择下问题分类！</font>","error",2500);
    		  return ;
    	  } 
    	  if( $.trim($("#question").val()) == ''){
	    	  Modal.tips("<font color='#ccc'>亲，写点内容吧！</font>","error",2500);
	    	  return ;
	      }
    	  $(o).addClass("focused");
    	  $('#addComment').ajaxSubmit(function(data){
	    		 if( data.status == true ) { 
	    			 setTimeout(function(){
		    			 Modal.tips("<font color='#ccc'>建议提交成功 ，我们会及时处理 ！^^</font>","success",2500,function(){
		    				 window.location.href="${ctx}/w/my/index.html";
		    				 $(oo).removeClass("focused");
		    			 });
	    			 },500);
	    		 }else{
	    			 setTimeout(function(){
	    			     Modal.tips("<font color='#ccc'>"+data.result+"</font>","error",2500);
	    			     $(oo).removeClass("focused");
	    			 },500);
	    		 }
	     });  
      }
    </script>
</body>
</html>