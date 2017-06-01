<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.yoga.dao.Weixin_blog_user"%>
<%@ include file="../../taglibs.jsp" %> 
<c:set var="footclass" value="faq" />
<!doctype html>
<html lang="en">
<head>
	<title>您在搜索“${text}”的相关内容</title>
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
	<meta content="yes" name="apple-mobile-web-app-capable">
	<meta content="yes" name="apple-touch-fullscreen">
	<meta content="telephone=no,email=no" name="format-detection">
	<link rel="stylesheet" href="${ctx}/css/reset.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/common.css?v=${version}">
	<link rel="stylesheet" href="${ctx}/css/dialog.css?v=${version}">
	<script src="${ctx}/js/jquery.min.js?v=${version}"></script>
	<link rel="stylesheet" href="${ctx}/css/search.css?v=${version}">
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script type="text/javascript">
       var nodata = ${resultlist.totalCount > 10 ? 1:0};
    </script>
    <script src="${ctx}/js/setfontsize.js?v=${version}"></script>
</head>	
<body>
	<div class="wrapper">
		<section class="mainBox" id="mainBox" >
            <div>
			 <form id="search" action="${ctx}/w/search.html" method="post" >
			    <span id="remove"></span>
			    <input type="text"  placeholder="搜索导师、问题和课程" value="${content}" name="textContent" id="textContent">
			    <button id="sousuo">搜索</button>
			</form>
			<div>
				  <c:if test="${ fn:length( teacherlist.results) > 0 }">
					<div class="daoshi" >
					    <h1>导师</h1>
					    <ul class="list" >
						    <c:forEach items="${teacherlist.results}" var="teacher" varStatus="status">
						         <li data-url="${ctx}/w/faq/person.html?p=${teacher.id}" >    
						            <div>
						           <dl>
						                <dt>
						                    <a href="${ctx}/w/faq/person.html?p=${teacher.id}">
														<c:choose>
															 <c:when test="${ fn:indexOf(teacher.file_path,'http') > -1 }">
																  <img src="${teacher.file_path}"  >
															 </c:when>
															 <c:otherwise>
																  <img src="${ctx}/${teacher.file_path}"  >
															 </c:otherwise>    
													   </c:choose>
													</a>
						                </dt>
						                <dd>
						                    <h4><a href="${ctx}/w/faq/person.html?p=${teacher.id}">${teacher.nickname }</a></h4>
						                    <h5><a href="${ctx}/w/faq/person.html?p=${teacher.id}">${teacher.userpost }</a></h5>
						                    <p><span> ${teacher.ask_count }个回答</span><span> ${teacher.course_count }个课程</span><span>${teacher.fensi_count }人关注</span></p>
						                </dd>
						            </dl>
						        </div>
						    </li>
					    </c:forEach>
					    </ul> 
					  </div>
				 </c:if>
				 
				 <c:if test="${ fn:length(asklist.results) > 0  }">
						<div class="more_question">
						    <h1>问题</h1>
						    <ul>
						      <c:forEach items="${asklist.results}" var="ask" varStatus="status">
						        <li data-url="${ctx}/w/faq/d.html?p=${ask.id}" >
						            <h3>${ask.title}</h3>
						             <p><span>回答：</span>${ask.askusername }<b>|</b><span>${ask.askuserpost}</span></p>
						        </li>
						       </c:forEach> 
						    </ul> 
						</div>
			     </c:if>
			     
			     <c:if test="${ fn:length(courselist.results) > 0 }">
						<div class="more_kecheng">
						    <h1>课程</h1>
						    <ul>
						        <c:forEach items="${courselist.results}" var="course" varStatus="status">
						        	<li data-url="'${ctx}/w/faq/course.html?p=${course.id}'+'&i=0'">
						               <h3>${course.cname }</h3>
						               <p><span>讲师：</span>${course.teachername }<b>|</b><span>${course.teacherport}</span></p>
						            </li>
						        </c:forEach>
						    </ul> 
						</div>
				</c:if>
			</div>
			</div>
		</section> 
		<%@ include file="../footer.jsp" %> 
	</div>
	<script src="${ctx}/js/zepto.js?v=${version}"></script>
	<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
	<script src="${ctx}/js/wblog.js?v=${version}"></script>
	<script src="${ctx}/js/model_dialog.js?v=${version}"></script>
	<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
	<script>
		var pageIndex = 0;
        $("#remove").on("tap", function () {
       		 location.href="${ctx}/w/faq/index.html";
   		})
        $("#sousuo").on("click",function(e){
        	$("#search").submit();
            e.preventDefault();
        }) 
        $("li").on("tap",function(){
            window.location.href=$(this).attr("data-url");
        })
        
        var myscroll;
        function loaded(){
	         setTimeout(function(){
	                myscroll=new iScroll("mainBox",{
	                    vScrollbar : false
	                });
	         },100 );
	    }
	    window.addEventListener("load",loaded,false);
    </script>
</body>
</html>