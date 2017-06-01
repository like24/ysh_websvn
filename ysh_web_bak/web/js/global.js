

function playOrPause(o){
	if($(o).hasClass("glyphicon-play")){
		$(o).removeClass("glyphicon-play").addClass("glyphicon-pause");
	}else{
		$(o).removeClass("glyphicon-pause").addClass("glyphicon-play");
	}
}



$(function(){
	var swiper = new Swiper('.swiper-container',{
        pagination: '.swiper-pagination',
        nextButton: '.swiper-next',
        prevButton: '.swiper-prev',
        slidesPerView: 1,
        paginationClickable: true,
        loop: false,
        grabCursor: true,
        paginationClickable: true,
        autoplay: 3000
    });
	
	
	//gotoTop
	function gotoTop(){
		if($(document).scrollTop() > 200){
			$(".back-top").fadeIn();
		}else{
			$(".back-top").fadeOut();
		}
	}
	$(".back-top").click(function(){
		$("html,body").animate({scrollTop:0},700);
	});
	gotoTop();
	$(document).scroll(function(){
		gotoTop();
	});
	
	
	
	$(".faq time").click(function(){
		$(this).addClass("active").siblings().removeClass("active");
	});
	
	
	
	var emptyBox='<div class="empty-box">暂无内容</div>';
	if($(".li-or-dd-empty dd").length == 0 && $(".li-or-dd-empty li").length == 0){
		$(".load-more").hide();
		$(".li-or-dd-empty").append(emptyBox);
	}
	
	 
	
	var text='<div class="v">'+$(".jj .t").html()+'</div>';
	$("#showMore").before($(text));
	$("#showMore").click(function(){
		if(!$(this).attr("show")){
			$(".jj .t").hide();
			$(".jj .v").slideDown();
			$(this).removeClass("transform-rotate-0deg").addClass("transform-rotate-180deg").attr("show","show");
		}else{
			$(".jj .v").slideUp();
			$(".jj .t").show();
			$(this).removeClass("transform-rotate-180deg").addClass("transform-rotate-0deg").removeAttr("show");
		}
	});
	
	
	
	$('#date').datepicker({
		dateFormat : 'yy-mm-dd',
		dayNamesMin : ['日','一','二','三','四','五','六'],
		monthNames : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
		monthNamesShort : ['一月','二月','三月','四月','五月','六月','七月','八月','九月','十月','十一月','十二月'],
		firstDay : 1, 
		changeMonth : true,  
		changeYear : true,           
		showButtonPanel : true,         
		closeText : '关闭',
		currentText : '回到今天',
		prevText:'上个月',
		nextText:'下个月',
		showMonthAfterYear:true,        
		hideIfNoPrevNext : true,        
		yearRange : '1950:2020',
		defaultDate:0,                 
		showAnim:'blind',               
		duration:500
	});  
	 
	$("#teacher-more-show").click(function(){ 
		if(!$(this).attr("show")){
			$("#teacher-more-show-box").slideDown();
			$(this).attr("show","show");
		}else{
			$("#teacher-more-show-box").slideUp();
			$(this).removeAttr("show");
		}
	});
	

	$("#show-more-btn").click(function(){ 
	   $(".qqface-container").fadeOut(); 
		if(!$(this).attr("show")){
			$(".more-post-box").slideDown();
			$(this).attr("show","show");
		}else{
			$(".more-post-box").slideUp();
			$(this).removeAttr("show");
		}
	});
	
   
   $("#footer-face-btn").click(function(){ 
     	$(".more-post-box").fadeOut();
		if(!$(this).attr("show")){
			$(".qqface-container").slideDown();
			var swiper = new Swiper('.qqface-container', {
				pagination: '.swiper-pagination',
				paginationClickable: true
			});
			$(this).attr("show","show");
		}else{
			$(".qqface-container").slideUp();
			$(this).removeAttr("show");
		}
	});
	
	$(".drop-down").click(function(){
		$(this).parents(".f2").find(".drop-m").slideDown("200",function(){
			$(".drop-m dd").click(function(){
				$(this).parents(".f2").find(".drop-down").val($(this).html());
				$(this).parents("dl").slideUp();
			});
		});
	});
	 
	//$(".comment-footer #post-textarea").focus(function(){
	//	$(".qqface-container .swiper-wrapper").fadeOut();
	//	$(".more-post-box").fadeOut();
	//});

	
	
	//$(".comment-footer .t input").width($(".comment-footer .col-xs-10").width()-98+"px");
});

function upImg(){
	var img='images/headImage.jpg';
	var dd='<dd class="border-bottom border-top"><i class="border-left border-right"></i><img src="'+img+'"><span class="glyphicon glyphicon-remove" onClick="deleteImg(this)"></span></dd>';
	$("#img-dt").before($(dd));
	addImgIsShow();
	soundIsShow();
}

function addQQFace(o){	//QQ表情插入页面
	//alert($(o).attr("src")+"|"+$(o).data("name"));
	//$("#post-textarea").append("["+$(o).data("name")+"]");
	insertText(document.getElementById("post-textarea"),"["+$(o).data("name")+"]");
	// $("#post-textarea").val($("#post-textarea").val()+"["+$(o).data("name")+"]");
}

function deleteImg(o){	//删除图片
	$(o).parents("dd").remove();
	i--;
	addImgIsShow();
}

function addImgIsShow(){	//判断图片的加号是否显示
	if($("#uploadImg dd").length > 0){
		$("#img-dt").show();
	}else{
		$("#img-dt").slideUp();
	}
}



function soundIsShow(){		//声音是否显示
	if($(".sound source").attr("src")){
		$(".sound").slideDown();
	}else{
		$(".sound").hide();
	}
}

function videoIsShow(){		//视频上传是否显示
	if($(".video-pic").attr("data-video")!=""){
		$(".video").slideDown();
	}else{
		$(".video").hide();
	}
}

function deleteVideo(o){
	$(o).parents(".video").slideUp().find(".video-pic").attr("data-video","");
}







function isWeiXin() {
    var ua = window.navigator.userAgent.toLowerCase();
    if ((ua.match(/MicroMessenger/i) == 'micromessenger') || $("#checkIsWeiXin").val() == "1") {        
        return true;
    } else {
        return false;
    }
}


function insertText(obj,str){
    if (document.selection){
        var sel = document.selection.createRange();
        sel.text = str;
    }else if(typeof obj.selectionStart === 'number' && typeof obj.selectionEnd === 'number') {
        var startPos = obj.selectionStart,
            endPos = obj.selectionEnd,
            cursorPos = startPos,
            tmpStr = obj.value;
        obj.value = tmpStr.substring(0, startPos) + str + tmpStr.substring(endPos, tmpStr.length);
        cursorPos += str.length;
        obj.selectionStart = obj.selectionEnd = cursorPos;
    }else{
        obj.value += str;
    }
}


function footerQQFace(o){
	insertText(document.getElementById("footer-textarea"),"["+$(o).data("name")+"]");
}


 





function getNowFormatDate() {
    var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = month + seperator1 + strDate+ " " + (date.getHours()<10?('0'+date.getHours()):date.getHours()) + seperator2 + (date.getMinutes()<10?('0'+date.getMinutes()):date.getMinutes()) ;
    return currentdate;
}




//$(function(){
//	function classBoxShow(){
//		if(localStorage.classShow=="1"){
//			$(".student-box").css("height","50%");$(".teacher-box").css("height","50%");$(".teacher-box").find("span").show();
//		}else if(localStorage.classShow=="2"){
//			$(".student-box").css("height","100%");$(".teacher-box").css("height","0");$(".teacher-box").find("span").hide();
//		}else if(localStorage.classShow=="0"){
//			$(".student-box").css("height","0");$(".teacher-box").css("height","100%");$(".teacher-box").find("span").show();
//		}
//	}
//	classBoxShow();
//	$("#teacher-btn, #student-btn").click(function(){
//		if(window.localStorage.classShow == "0"){
//			window.localStorage.classShow = "1";classBoxShow();
//		}else if(window.localStorage.classShow == "1"){
//			window.localStorage.classShow = "2";classBoxShow();
//		}else if(window.localStorage.classShow == "2"){
//			window.localStorage.classShow = "0";classBoxShow();
//		}
//	});
//});

$(function(){
	$(document).on("click","#teacher-btn, #student-btn",function(){
		if($(this).attr("show")==0 || $(this).attr("show")==undefined){
			$(".student-box").animate({height:'100%'},300,"easeOutQuad");
			$(".teacher-box").css("height","0%");
			$(".teacher-box").find("span").hide();
			$("#teacher-btn, #student-btn").attr("show","1")
		}else if($(this).attr("show")==1){
			$(".student-box").css("height","0%");
			$(".teacher-box").animate({height:'100%'},300,"easeOutQuad");
			$(".teacher-box").find("span").show();
			$("#teacher-btn, #student-btn").attr("show","2")
		}else if($(this).attr("show")==2){
			$(".student-box").animate({height:'50%'},300,"easeOutQuad");
			$(".teacher-box").animate({height:'50%'},300,"easeOutQuad");
			$(".teacher-box").find("span").show();
			$("#teacher-btn, #student-btn").attr("show","0")
		}
	});
	
	
	if(!localStorage.pagerr){
		localStorage.pagerr = 1;
	}
	for(var i=localStorage.pagerr; i>1; i--){
		loadMorePage();
	}
	
	function loadMorePage(){
		//var text=$(".class-page-list dd").first().html();
		//text='<dd class="border-bottom">'+text+'</dd>';
		//text=text+text+text+text+text+text;
		//$(".class-page-list dl").append(text);
	}
	$("#indexLoadMore").click(function(){
		//loadMorePage();
		//localStorage.pagerr++;
		//alert(localStorage.pagerr)
	});
});

function limitLength(o){
	  //window.setTimeout(function(){
		//$(".qqface-container").fadeOut();
		//$(".more-post-box").fadeOut();
		var total=Number($("#s").html());
		var len=$(o).val().length;
		$("#b").html(len);
		/*console.log(len);
		console.log($("#b").html());*/
		/*if(len == 0){
			$("#show-more-btn").show();
			$("#footer-post-btn").hide();
		}else if(len > 0 && len <= total){
			$("#show-more-btn").hide();
			$("#footer-post-btn").show();
		}else{
			alert("字数过多");
		}*/
		if(total < len){alert("字数过多");}
		//},100)		
}
 

// 转义HTML
function escapeHtml( ctn ) {
	return ctn.replace(/&/g, '&amp;').replace('|', '■').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/\n/g, '<br>');
}

// 
function ahtml( ctn ){
	return ctn.replace(/((https?|s?ftp):\/\/)?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(ac|ad|aero|ae|af|ag|ai|al|am|an|ao|aq|arpa|ar|asia|as|at|au|aw|ax|az|ba|bb|bd|be|bf|bg|bh|biz|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|cat|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|coop|com|co|cr|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|edu|ee|eg|er|es|et|eu|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gov|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|info|int|in|io|iq|ir|is|it|je|jm|jobs|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly|ma|mc|md|me|mg|mh|mil|mk|ml|mm|mn|mobi|mo|mp|mq|mr|ms|mt|museum|mu|mv|mw|mx|my|mz|name|na|nc|net|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|org|pa|pe|pf|pg|ph|pk|pl|pm|pn|pro|pr|ps|pt|pw|py|qa|re|ro|rs|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr|st|su|sv|sy|sz|tc|td|tel|tf|tg|th|tj|tk|tl|tm|tn|to|tp|travel|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|xn--0zwm56d|xn--11b5bs3a9aj6g|xn--80akhbyknj4f|xn--9t4b11yi5a|xn--deba0ad|xn--g6w251d|xn--hgbk6aj7f53bba|xn--hlcj6aya9esc7a|xn--jxalpdlp|xn--kgbechtv|xn--zckzah|ye|yt|yu|za|zm|zw)\b)\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?\b/ig, function(a, b) {
	    return '<a target="_blank" href="' + (b ? '' : 'http://') + a.replace(/&#38;/g, '&') + '">' + a + '</a>'
    })
}



//扩展Date的format方法   
Date.prototype.format = function (format) {  
    var o = {  
        "M+": this.getMonth() + 1,  
        "d+": this.getDate(),  
        "h+": this.getHours(),  
        "m+": this.getMinutes(),  
        "s+": this.getSeconds(),  
        "q+": Math.floor((this.getMonth() + 3) / 3),  
        "S": this.getMilliseconds()  
    }  
    if (/(y+)/.test(format)) {  
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
    }  
    for (var k in o) {  
        if (new RegExp("(" + k + ")").test(format)) {  
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
        }  
    }  
    return format;  
}  
/**   
*转换日期对象为日期字符串   
* @param date 日期对象   
* @param isFull 是否为完整的日期数据,   
*               为true时, 格式如"2000-03-05 01:05:04"   
*               为false时, 格式如 "2000-03-05"   
* @return 符合要求的日期字符串   
*/    
function getSmpFormatDate(date, isFull) {  
    var pattern = "";  
    if (isFull == true || isFull == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    } else {  
        pattern = "yyyy-MM-dd";  
    }  
    return getFormatDate(date, pattern);  
}  
/**   
*转换当前日期对象为日期字符串   
* @param date 日期对象   
* @param isFull 是否为完整的日期数据,   
*               为true时, 格式如"2000-03-05 01:05:04"   
*               为false时, 格式如 "2000-03-05"   
* @return 符合要求的日期字符串   
*/    

function getSmpFormatNowDate(isFull) {  
    return getSmpFormatDate(new Date(), isFull);  
}  
/**   
*转换long值为日期字符串   
* @param l long值   
* @param isFull 是否为完整的日期数据,   
*               为true时, 格式如"2000-03-05 01:05:04"   
*               为false时, 格式如 "2000-03-05"   
* @return 符合要求的日期字符串   
*/    

function getSmpFormatDateByLong(l, isFull) {  
    return getSmpFormatDate(new Date(l), isFull);  
}  
/**   
*转换long值为日期字符串   
* @param l long值   
* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss   
* @return 符合要求的日期字符串   
*/    

function getFormatDateByLong(l, pattern) {  
    return getFormatDate(new Date(l), pattern);  
}  
/**   
*转换日期对象为日期字符串   
* @param l long值   
* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss   
* @return 符合要求的日期字符串   
*/    
function getFormatDate(date, pattern) {  
    if (date == undefined) {  
        date = new Date();  
    }  
    if (pattern == undefined) {  
        pattern = "yyyy-MM-dd hh:mm:ss";  
    }  
    return date.format(pattern);  
}  



//获取cookie
function getCookie(name){
	var arr = document.cookie.split("; ");
	for(var i=0; i<arr.length; i++){
		var arr2 = arr[i].split("=");
		if(arr2[0] == name){
			return decodeURIComponent(arr2[1]);
		}
	}
	return "";
}



//端午节






