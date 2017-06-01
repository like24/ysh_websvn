<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
        <%@page import="com.yoga.dao.Weixin_blog_user"%>
            <%@ include file="../../taglibs.jsp" %>
                <c:set var="footclass" value="v2index" />
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">
                    <meta content="yes" name="apple-mobile-web-app-capable">
                    <meta content="yes" name="apple-touch-fullscreen">
                    <meta content="telephone=no,email=no" name="format-detection">
                    <title>搜索</title>
                    <script src="${ctx}/resources/js/lib/setfontsize.min.js"></script>
                    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
                    <link rel="stylesheet" href="${ctx}/resources/css/reset.css" />
                    <link rel="stylesheet" href="${ctx}/resources/css/index.css" />
                    <link rel="stylesheet" href="${ctx}/resources/css/search.css" /> </head>
                <body>
                    <div class="wrapper bg-e4" id="app" v-cloak>
                        <header class="fixed header flex">
                            <input type="text" placeholder="搜索课程、问题和导师" class="search-text" v-model.trim="text" />
                            <button type="button" class="search-btn" @click="search">搜索</button>
                        </header>
                        <!--    iscroll滚动    -->
                        <section class="iscroll-box absolute ohidden" id="mainBox">
                            <div class="iscrollBox " id="pullUpWrapper">
                                <!--    大家都在搜模块start   -->
                                <div class="every-body-box " v-show="everyShow">
                                    <p class="tit">大家都在搜</p>
                                    <div class="every-box" id="every"> <span class="item" v-for="(item,$index) in everylist" @click=clickTag($index)>{{ item.sname }}</span> </div>
                                </div>
                                <!--    大家都在搜模块 end  -->
                                <div v-if="boxShow">
                                    <nav class="relative">
                                        <ul class="flex nav" id="nav">
                                            <li class="active" @click="changeNav($event)">全部</li>
                                            <li @click="changeNav($event)">课程</li>
                                            <li @click="changeNav($event)">问答</li>
                                            <li @click="changeNav($event)">导师</li>
                                        </ul> <i class="boder-b absolute" id="borderB"></i> </nav>
                                    <!--   全部模块 start   -->
                                    <div v-if="showBox[0]">
                                        <!--课程-->
                                        <div class="recommend bg-fff m30 m-b" v-show="course">
                                            <div class="title flex" >
                                                <h4>课程</h4> <a href="javascript:;" data-href="${ctx}/v2/index/free/more.shtml" class="block" @click="toUrl($event)">查看全部 &gt;</a> </div>
                                            <ul>
                                                <li class="item " v-for="item in courselist3">
                                                    <a href="javascript:;" :data-href="'${ctx}/w/faq/course.html?p='+item.cid+'&i=0'" @click="toUrl($event)" class="flex"> <i class="icon" :class="item.ctype?'icon-video':'icon-audio'"></i>
                                                        <p class="text ellipsis">{{ item.cname }} : {{ item.remark }} </p>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <!--问答-->
                                        <div class="interlocution-box bg-fff m30 m-b" v-show="ask">
                                            <!-- 标题 -->
                                            <div class="title flex">
                                                <h4>问答</h4> <a href="javascript:;" data-href="${ctx}/w/faq/index.html?p=0" class="block" @click="toUrl($event)">查看全部 ></a> </div>
                                            <ul>
                                                <li v-for='item in asklist3'>
                                                    <a href="javascript:;" :data-href="'${ctx}/w/faq/d.html?p='+item.aid" @click="toUrl($event)">
                                                        <p class="tit">{{ item.content }}</p>
                                                        <div class="tutor"> <span>回答导师：</span><span class="name">{{ item.askusername }} | {{ item.askuserpost }}</span> </div>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                        <!--导师-->
                                        <div class="yoga-tutor-box bg-fff m30 m-b" v-show="teach">
                                            <!-- 标题 -->
                                            <div class="title flex">
                                                <h4>瑜伽导师</h4> <a href="javascript:;" data-href="${ctx}/v2/index/tutor/more.shtml" class="block" @click="toUrl($event)">查看全部 ></a> </div>
                                            <div>
                                                <dl class="item" v-for="item in teacherlist3">
                                                    <a href="javascript:;" :data-href="'${ctx}/w/faq/person.html?p='+item.id+'&t=4'" class="flex" @click="toUrl($event)"> <dt>
	            					<img :data-src="item.icon" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt=" item.name头像" />
	            				</dt>
                                                        <dd class="ohidden">
                                                            <h5 class="name">{{ item.name }}</h5> <span class="job ellipsis">{{ item.userport }}</span>
                                                            <p class="summary ellipsis">{{ item.shortremark }}</p>
                                                        </dd>
                                                    </a>
                                                </dl>
                                            </div>
                                        </div>


                                    </div>
                                    <!--   全部模块 end   -->
                                    <!--   课程模块 start   -->
                                    <div class="course-box hot-recommend bg-fff m30 m-b" v-if="showBox[1]">
                                        <div>
                                            <dl class="item" v-for="item in courselist">
                                                <a href="javascript:;" :data-href="'${ctx}/w/faq/course.html?p='+item.cid+'&i=0'" class="flex" @click="toUrl($event)"> <dt class="relative">
	            					<img :data-src="item.logo" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt="item.cname" />
	            					<i class="icon  absolute" :class="item.ctype?'icon-video':'icon-audio'"></i>
	            					<p class="topic  absolute" :class="item.ctype?'blue':'orange'">
	            						<small></small>
	            					</p>
	            				</dt>
                                                    <dd class="ohidden relative">
                                                        <h5 class="name ellipsis">{{ item.cname }}</h5> <span class="type block ellipsis2">{{ item.remark }}</span> <span class="time block">时长：<time>{{ item.longtime }}</time></span>
                                                        <p class='money absolute' v-if="item.money  > 0 "><small>￥</small><big>{{ item.money }}</big></p>
                                                        <p class='money absolute free' v-if="item.money <=0 ">免费</p>
                                                    </dd>
                                                </a>
                                            </dl>
                                        </div>
                                    </div>
                                    <!--   课程模块 end   -->
                                    <!--   问答模块 start   -->
                                    <div class="interlocution-box bg-fff m30 m-b" v-if="showBox[2]">
                                        <ul>
                                            <li v-for='item in asklist'>
                                                <a href="javascript:;" :data-href="'${ctx}/w/faq/d.html?p='+item.aid" @click="toUrl($event)">
                                                    <p class="tit">{{ item.content }}</p>
                                                    <div class="tutor"> <span>回答导师：</span><span class="name">{{ item.askusername }} | {{ item.askuserpost }}</span> </div>
                                                </a>
                                            </li>
                                        </ul>
                                    </div>
                                    <!--   问答模块 end   -->
                                    <!--   导师模块 start   -->
                                    <div class="yoga-tutor-box bg-fff m30 m-b" v-if="showBox[3]">
                                        <div>
                                            <dl class="item" v-for="item in teacherlist">
                                                <a href="javascript:;" :data-href="'${ctx}/w/faq/person.html?p='+item.id+'&t=4'" class="flex" @click="toUrl($event)"> <dt>
	            					<img :data-src="item.icon" src="${ctx}/resources/images/pixel.gif" class="loadingimg" :alt=" item.name头像" />
	            				</dt>
                                                    <dd class="ohidden">
                                                        <h5 class="name">{{ item.name }}</h5> <span class="job ellipsis">{{ item.userport }}</span>
                                                        <p class="summary ellipsis">{{ item.shortremark }}</p>
                                                    </dd>
                                                </a>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                                <!--   导师模块 end   -->
                                <!--没有搜索到内容-->
                                <div class="no-content text-c" v-show="noContent"> <i class="icon bad"></i> <span>尴尬了，没有找到</span> <a href="${ctx}/v2/index.shtml">去首页看看</a> </div>
                            </div>
                        </section>
                        <!--    底部导航开始    -->
                        <%@ include file="../footer.jsp" %>
                    </div>
                    <script src="${ctx}/resources/js/lib/vue.min.js"></script>
                    <script src="${ctx}/resources/js/lib/zepto.min.js"></script>
                    <script src="${ctx}/resources/js/lib/iscroll4.min.js"></script>
                    <script src="${ctx}/resources/js/lib/iscroll-pullup.js"></script>
                    <script src="${ctx}/resources/js/common.js"></script>
                    <script src="${ctx}/resources/js/modules/search.js"></script>
                    <script type="text/javascript">
                        wx.hideMenuItems({
                            menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:share:qq', 'menuItem:share:weiboApp', 'menuItem:favorite', 'menuItem:share:facebook', 'menuItem:share:QZone'] // 要隐藏的菜单项，只能隐藏“传播类”和“保护类”按钮，所有menu项见附录3
                        });
                    </script>
                </body>

                </html>