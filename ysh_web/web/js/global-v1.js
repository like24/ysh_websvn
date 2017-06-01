$(function(){
	
	var swiper = new Swiper('.navContainer',{
        pagination: '.swiper-pagination',
        slidesPerView: 4,
        paginationClickable: true,
		//loop: true
        grabCursor: true,
        paginationClickable: true,
        autoplay: 3000
    });
	
	
	var swiper = new Swiper('.swiper-container',{
        pagination: '.swiper-pagination',
        nextButton: '.swiper-next',
        prevButton: '.swiper-prev',
       // slidesPerView: 1,
      // paginationClickable: true,
        loop: false,
        grabCursor: true,
        paginationClickable: true,
        autoplay: 3000
    });
	
	
	$(".editBtn").click(function(event){
		event.stopPropagation();
		if($(this).hasClass("active")==false){
			$(this).addClass("active");
			$(".edit").slideDown();
		}else{
			$(this).removeClass("active");
			$(".edit").slideUp();
		}
	});
	
	
	//获取验证码
	var interVal;
	var count=5;
	var curCount;
	$("#btnSendCode").click(function(event){
		event.stopPropagation();
		curCount=60;
		$(this).attr("disabled","true");
		$(this).val("请在"+curCount+"秒内输入");
		interVal=window.setInterval(setTime,1000);
		$.ajax({
			type:"post",
			dataType:"json",
			url:  ctx+"/m898"+$("#tel").val()+".html",
			error:function(XMLHttpRequest,textStatus,error){},
			success:function(msg){
				 if( msg.status > 0 ){
					 Modal.tips("恭喜，发送成功 !","success",2000); 
				 }else if( msg.status == -1 ){
					 Modal.tips("1分钟内，请勿重复发送！ !","error",2000); 
				 }else if( msg.status == 0 ){
					 Modal.tips("手机号为空或格式错误！请重试或取消！","error",2000); 
				 }
			}
		});
	});
	function setTime(){
		if(curCount>1){
			curCount--;
			$("#btnSendCode").val("请在"+curCount+"秒内输入");
		}else{
			window.clearInterval(interVal);
			$("#btnSendCode").removeAttr("disabled");
			$("#btnSendCode").val("重新发送验证码");
		}
	}
	
	
	//发布图文
	//$(".releasePic ul:first-child li img, .releasePic li").height($(".releasePic li").width());
	//$(".addTextBtn").css("line-height",$(".releasePic li").width()+"px");
	var imgSrc = "";
	/*
	$(".releasePic ul:last-child").click(function(){
		if($(".releasePic ul:first-child li").length >= 8){
			alert("您最多可以上传8张图片");
		}else{
			$("input[type=file]").change(function(){
				imgSrc = $(this).val();
			})
			var li = '<li><img src="' + imgSrc + '" alt="把这个图片改成上传图片的路径"></li>';	
			$(".releasePic ul:first-child").append(li);
		}
	});
	*/
	
	
	
	//点赞
	$(document).on("click",".newsList li .bottom cite",function(){
		var id = $(this).attr("data-id");
		if(!$(this).attr("lock")){
			$(this).find("span").html(Number($(this).find("span").html())+1);
			$(this).attr("lock","lock");
			$.ajax({
				type:"post",
				dataType:"json",
				url:  ctx+"/weixin/blog/"+ id +"/praise.html",
				error:function(XMLHttpRequest,textStatus,error){},
				success:function(msg){
					if( msg.status == true )
						Modal.tips("点赞成功 !","success",2000);
				}
			}); 
		}else{
			Modal.tips("哎呦，您已经赞过啦，瞧您这记性 !","error",2000);
		}
	});
	
	
	$(".videoContent").find(".bottom cite").click(function(event){
		event.stopPropagation();
		var id = $(this).attr("data-id");
		if(!$(this).attr("lock")){
			$(this).find("span").html(Number($(this).find("span").html())+1);
			$(this).attr("lock","lock");
			$.ajax({
				type:"post",
				dataType:"json",
				url:  ctx+"/weixin/blog/"+ id +"/praise.html",
				error:function(XMLHttpRequest,textStatus,error){},
				success:function(msg){
					if( msg.status == true )
						Modal.tips("点赞成功 !","success",2000);
				}
			});
		}else{
			Modal.tips("哎呦，您已经赞过啦，瞧您这记性 !","error",2000);
		}
	});
	
	
	$(".editIcon.p").click(function(event){
		event.stopPropagation();
		$(this).parents(".editBox").fadeOut();
		$(".addLine").slideDown();
	})
	
	
	
	

	
	
	
	var pageIndex_ = 0;
	
	$(window).scroll(function(){
		if($(document).height()-$(window).height()-$(window).scrollTop() <= 50){
			if( pageIndex_ <= 0 && nIndex == 1){
				pageIndex ++ ;
				$.ajax({
					type:"post",
					dataType:"json",
					url:  ctx+"/weixin/blog/"+ tid +"/"+ pageIndex +"/index1.html",
					error:function(XMLHttpRequest,textStatus,error){},
					success:function(msg){
						 if( msg.result != ''){
						     $(".newsList ul").append( msg.result );
						 }else
							 pageIndex_ = pageIndex;
					}
				}); 
			}
		}
	});
	
	
	//导航条激活的那个LI始终在第一位
	$("nav li").each(function(index){
		$(this).attr("index",index);
	});
	var leftNumber = Number($("nav li.active").attr("index"));
	var oLiWidth = $("nav li").width();
	$("nav .swiper-wrapper").css("transform","translateX(-" + leftNumber*oLiWidth + "px)");
	
	
	$(document).click(function(){
		$(".addLine").slideUp();
		$(".editBox").fadeIn();
	});
	
	
	$(".removeWenzhan").click(function(event){
		event.stopPropagation();
		var id = $(this).attr("data-id");
		Modal.confirm("确认要删除您所发布的内容么？",function(){
			$.ajax({type:"POST",url:ctx+"/weixin/article/remove"+id+".html",success:function(data){
				 if( data.status == true ) { 
					 Modal.tips("删除成功！","success",1500,function(){
						  $("#list_"+id).slideUp();
				     });
				 }else{
					 Modal.tips("删除失败");
				 }
			}});
		});
	});
	
	
	
	$(".bottomSubmit li").click(function(event){
		event.stopPropagation();
		$(this).find("dl").slideDown();
	});
	$(document).click(function(){
		$(".bottomSubmit li dl").slideUp();
	});
	$(window).scroll(function(){
		$(".bottomSubmit li dl").slideUp();
	});

});


//点赞的方法
function clickLike(_this, id, type ){
	    var that = _this;
		$.ajax({
			type:"post",
			dataType:"json",
			url:  ctx+"/weixin/article/"+id+"_"+type+".html",
			error:function(XMLHttpRequest,textStatus,error){},
			success:function(msg){
				if( type == 1 && msg.status == true ){
					Modal.tips("哎呦,收藏成功啦 !","success",2000);
					$(that).parent().html('<img onClick=clickLike(this,'+id+',2) src='+ctx+'/images/starRed.png>');
				}
				if( type == 2 && msg.status == true ){
					Modal.tips("哎呦，取消收藏成功了 !","success",2000);
					$(that).parent().html('<img onClick=clickLike(this,'+id+',1) src='+ctx+'/images/star.png>');
					if( tid == 300 ) {
						$("#article_"+id).slideUp();
					}
				}
			}
		});  
}
function divTarget( id ){
   location.href = ctx + '/d'+id+'.html';
};


