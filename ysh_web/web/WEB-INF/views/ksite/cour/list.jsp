<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
			<%@page import="com.yoga.dao.Weixin_blog_user"%>
				<%@ include file="../../taglibs.jsp" %>
					<c:set var="footclass" value="course" />
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
						<link rel="stylesheet" href="${ctx}/css/HotcourseDetail.css?v=${version}">
						<link rel="stylesheet" href="${ctx}/css/swiper-3.3.1.min.css?v=${version}">
						<script type="text/javascript" src="${ctx}/js/jquery.min.js?v=${version}"></script>
						<script type="text/javascript" src="${ctx}/js/swiper-3.3.1.min.js?v=${version}"></script>
						<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
						<script type="text/javascript" src="${ctx}/js/setfontsize.js?v=${version}"></script>
						<script type="text/javascript">
							var nodata = 0;
						</script>
						<style>
							.dlHigh dd{
								color:#1d92fb;
							}
							ul.bj::after{
								content:"";
								display:block;
								position:absolute;
								left:0;
								top:2px;
								right:0;
								bottom:0;
								z-index:99;
								background:rgba(0,0,0,.5);
							}
						</style>
						<title>随心瑜Live|名师课程排行榜 </title>
					</head>

					<body id="getBody">
						<input type="hidden" id="currentSpecial" value="${currentSpecial}" />
						<input type="hidden" id="ctype" value="${ctype}" />
						<input type="hidden" id="orderby" value="${orderby}" />
						<p id="title">${title}</p>
						<div id="fixedDiv">
							<div class="swiper-container  activeNav noneActiveNav" id="activeNav">
								<div class="swiper-wrapper">
									<c:if test="${currentSpecial == 0}">
										<dl data_id="0" class="swiper-slide dlHigh">
									</c:if>
									<c:if test="${currentSpecial > 0}">
										<dl data_id="0" class="swiper-slide">
									</c:if>
										<dt>
											<img src="http://wimg.keepyoga.com/660384239587046383.png" alt="">
										</dt>
										<dd>全部</dd>
									</dl>
									<c:forEach items="${speciallist}" var="special">
										<c:if test="${currentSpecial == special.id}">
											<dl data_id="${special.id}" class="swiper-slide dlHigh">
												<dt>
													<img src="${special.logo}" alt="">
												</dt>
												<dd>${special.name}</dd>
											</dl>
										</c:if>
										<c:if test="${currentSpecial != special.id}">
											<dl data_id="${special.id}" class="swiper-slide">
												<dt>
													<img src="${special.logo}" alt="">
												</dt>
												<dd>${special.name}</dd>
											</dl>
										</c:if>
										
									</c:forEach>
								</div>
							</div>
							<div class="nullDIV"></div>
							<div class="navTop" id="navTop">
								<nav>
									<a href="javascript:;" onclick="gofor(1,0)" class='high'>全部</a>
									<a href="javascript:;" onclick="gofor(1,2)" class=''>视频</a>
									<a href="javascript:;" onclick="gofor(1,1)" class=''>音频</a>
									<a href="javascript:;" onclick="go(1,3)" class=''>线下培训</a>
								</nav>
								<p><span onclick="gofor(2,0)" class='high'>最热</span><b>|</b><span onclick="gofor(2,1)" class=''>最新</span></p>
							</div>
						</div>
						<div class="wrapper">
							<section class="mainBox" id="mainBox">
								<div>
									<div class="swiper-container  activeNav " id="activeNav">
										<div class="swiper-wrapper">
											<c:if test="${currentSpecial == 0}">
												<dl data_id="0" class="swiper-slide dlHigh">
											</c:if>
											<c:if test="${currentSpecial > 0}">
												<dl data_id="0" class="swiper-slide">
											</c:if>
												<dt>
													<img src="http://wimg.keepyoga.com/660384239587046383.png" alt="">
												</dt>
												<dd>全部</dd>
											</dl>
											<c:forEach items="${speciallist}" var="special">
												<c:if test="${currentSpecial == special.id}">
													<dl data_id="${special.id}" class="swiper-slide dlHigh">
														<dt>
															<img src="${special.logo}" alt="">
														</dt>
														<dd>${special.name}</dd>
													</dl>
												</c:if>
												<c:if test="${currentSpecial != special.id}">
													<dl data_id="${special.id}" class="swiper-slide">
														<dt>
															<img src="${special.logo}" alt="">
														</dt>
														<dd>${special.name}</dd>
													</dl>
												</c:if>
											</c:forEach>
										</div>
									</div>
									<div class="contain">
										<div class="navTop">
											<nav>
												<a href="javascript:;" onclick="gofor(1,0)" class='${ctype==0?"high":"" }'>全部</a>
												<a href="javascript:;" onclick="gofor(1,2)" class='${ctype==2?"high":"" }'>视频</a>
												<a href="javascript:;" onclick="gofor(1,1)" class='${ctype==1?"high":"" }'>音频</a>
												<a href="javascript:;" onclick="go(1,3)" class='${ctype==3?"high":"" }'>线下培训</a>
											</nav>
											<c:if test="${ctype <= 2 }">
												<p><span onclick="gofor(2,0)" class='${orderby==0?"high":"" }'>最热</span><b>|</b><span onclick="gofor(2,1)" class='${orderby==1?"high":"" }'>最新</span></p>
											</c:if>
											<c:if test="${ctype == 3 }">
												<p><span onclick="go(2,0)" class='${orderby==0?"high":"" }'>最热</span><b>|</b><span onclick="go(2,1)" class='${orderby==1?"high":"" }'>最新</span></p>
											</c:if>
										</div>
											<ul id="list" class="list">
												<c:if test = "${ctype <= 2 }">
												<div id="courslist">
													<c:forEach items="${courselist.results}" var="course">
														<li data_id="${course.id}">
															<dl>
																<dt>
																	<c:if test="${empty course.icon}">
																		<img src="${ctx}/images/audio.jpg" alt="">
																	</c:if>
																	<c:if test="${not empty course.icon}">
																		<img src="${course.icon}" alt="">
																	</c:if>
																	<p>${course.playcount}人在学</p>
																</dt>
																	<dd>
																		<h4>${course.cname}</h4>
																		<p><i></i>${fn:replace(course.taglist, ","," ")}</p>
																		<c:if test="${course.money == 0}"><span class="free">免费</span></c:if>
																		<c:if test="${course.money > 0}"><span class="money">￥${course.money}元</span></c:if>
			
																	</dd>
																</dl>
															</li>
													</c:forEach>
												</div>
												</c:if>
												<c:if test="${ctype == 3 }">
												<div id="linelist">
												<c:forEach items="${courselist.results}" var="course">
													<li data_id="${course.id}">
														<dl>
															<dt>
																<c:if test="${empty course.icon}">
																	<img src="${ctx}/images/audio.jpg" alt="">
																</c:if>
																<c:if test="${not empty course.icon}">
																	<img src="${course.icon}" alt="">
																</c:if>
																<p>${course.buycount}人已报名</p>
															</dt>
															<dd>
																<h4>${course.cname}</h4>
																<p><i></i>${fn:replace(course.taglist, ","," ")}</p>
																<c:if test="${course.money == 0}"><span class="free">免费</span></c:if>
																<c:if test="${course.money > 0}"><span class="money">￥${course.money}元</span></c:if>
															</dd>
														</dl>
													</li>
												</c:forEach>
												</div>
												</c:if>
											</ul>
									</div>
								</div>
							</section>
							<%@ include file="../footer.jsp" %>
						</div>
						<script src="${ctx}/js/zepto.js?v=${version}"></script>
						<script src="${ctx}/js/iscroll4.js?v=${version}"></script>
						<script src="${ctx}/js/ajax_iscroll.js?v=${version}"></script>
						<script src="${ctx}/js/wblog.js?v=${version}"></script>
						<script>
							var pageIndex = 1;
							var icon = "";
							var title1 = "随心瑜Live|名师课程排行榜";
							var desc1 = "一个瑜伽人的掌上家园";
							var link1 = location.href;
							var img1 = icon;
							wx.config({
								debug: false,
								appId: '${appid}',
								timestamp: '${timestamp}',
								nonceStr: '${nonceStr}',
								signature: '${signature}',
								jsApiList: [
		        'checkJsApi', 'openLocation',
		        'getLocation', 'checkJsApi', 'onMenuShareTimeline', 'onMenuShareAppMessage',
		        'onMenuShareQQ', 'onMenuShareWeibo', 'hideMenuItems', 'showMenuItems', 'hideAllNonBaseMenuItem',
		        'showAllNonBaseMenuItem', 'chooseImage', 'previewImage', 'uploadImage',
		        'chooseWXPay', 'downloadImage', 'getNetworkType', 'openLocation',
		        'getLocation', 'hideOptionMenu', 'showOptionMenu'
		      ]
							});

							var nologin = "${nologin}";
							if (nologin == "true") {
								window.location.href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=${wxid}&redirect_uri=${ctx}/${urlsecret}/authorize.html&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
							}
							window.onload = function () {
								var mySwiper = new Swiper('.swiper-container', {
									slidesPerView: 4.5,
									pagination: '.swiper-pagination',
									lazyLoading: true,
									lazyLoadingInPrevNext: true,
									preventClicks: false,
									preventLinksPropagation: false,
									autoplayDisableOnInteraction: false,
									touchMoveStopPropagation: false
								})
							};

							$(function () {
								$(".activeNav").on("tap", "dl", function () {
									var dataId = $(this).attr("data_id");
									window.location.href = "${ctx}/w/hot/course/list.html?p=" + dataId;
								});

								$(document).on("tap", "#courslist li", function () {
									var dataId = $(this).attr("data_id");
									window.location.href = "${ctx}/w/faq/course.html?p=" + dataId;
								});
								
							});
							
							$(document).on("click","#linelist li",function(){
								var dataId = $(this).attr("data_id");
								window.location.href = "${ctx}/w/faq/courseline.html?p=" + dataId;
							})

							function gofor(t, v) {
								if (t == 1) {
									$("#ctype").val(v);
								} else if (t == 2) {
									$("#orderby").val(v);
								}
								window.location.href = "${ctx}/w/hot/course/list.html?p=" + $("#currentSpecial").val() + "&t=" + $("#ctype").val() + "&by=" + $("#orderby").val();
							}
							
							function go(t,v){
								if(t == 1){
									$("#ctype").val(v);
								}else if (t == 2) {
									$("#orderby").val(v);
								}
								window.location.href = "${ctx}/w/hot/course/line/list.html?p=" + $("#currentSpecial").val() + "&t=" + $("#ctype").val() + "&by=" + $("#orderby").val();
							} 
							
							$("#title").on("tap", function () {
								$(this).hide();
								$(".noneActiveNav").css("visibility", "visible");
								$("#fixedDiv").css("visibility", "visible");
								$("#list").addClass("bj");
							});

							var pageIndex = 1,nodata=1;

							function loadStore() {
								var t = "${ctype}";
								var ur = "";
								if(t == 3){
									ur = "${ctx}/w/hot/course/line/morelist.html?pageIndex=" + (pageIndex + 1) + "&p=" + $("#currentSpecial").val() + "&t=" + $("#ctype").val() + "&by=" + $("#orderby").val()
								}else{
									ur = "${ctx}/w/hot/course/morelist.html?pageIndex=" + (pageIndex + 1) + "&p=" + $("#currentSpecial").val() + "&t=" + $("#ctype").val() + "&by=" + $("#orderby").val()
								}
								if (pageIndex > -1) {
									$.ajax({
										type: "post",
										dataType: "json",
										url: ur,
										error: function (XMLHttpRequest, textStatus, error) {},
										success: function (msg) {
											if (msg.result != '') {
												if(t == 3){
													$("#linelist").append(msg.result);
												}else{
													$("#courslist").append(msg.result);
												}
												pageIndex++;
											} else {
												nodata = 0;
												$("#pullUp").remove();
												pageIndex = -1;
											}
										}
									});
								}
							}
							
						</script>

					</body>

					</html>