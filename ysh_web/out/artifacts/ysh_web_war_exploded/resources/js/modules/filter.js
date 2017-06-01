var filterPage = "filterPage";
var vw = new Vue({
	el: "#app",
	data: {
		firclick: 1,
		first: true,
		items: [], //初始化 数据
		url: null, //初始化 路劲
		show: false, //是否显示遮罩
		name: window.sessionStorage.getItem(filterPage + "name"), //首页带过来的课程分类名字
		id: APP.URLSEARCH().id, //首页带过来的课程分类id
		showBox: [false, false, false], //是否显示筛选的盒子
		classlist: [], //左侧的一级分类列表
		newHotTxt: "最新", //最新最热
		requireA: { //筛选的条件
			'0': null,
			'1': null,
			'2': null
		},
		ARG: "", //初始化路由参数
		rightList: [], //右侧列表
		newOrHot: 0, //最新
		firstClick: false,
		sp2: 'false',
		noContent: false,
		arg: '',
		index: 0,
		left: false,
		left1: false,
		inx: null, //清除重复点击
		inx1: null, //清除重复点击
		inx2: null, //清除重复点击
		inx3: null //清除重复点击
	},
	methods: {
		topTab: function() { //切换顶部导航
			if(arguments[0] == 0) {
				this.topTabChange(0);
			} else if(arguments[0] == 1) {
				this.topTabChange(1);
			} else {
				this.topTabChange(2);
			}
		},
		topTabChange: function(num) {
			//三角移动
			$("#triangleUp").removeClass("left0 left1 left2");
			$("#triangleUp").addClass("left" + num);
			//变化tab颜色
			$("#topTab").find("li").removeClass("active");
			$("#topTab").find("li").eq(num).addClass("active");
			this.show = true;
			//点击切换显示对应盒子
			this.showBox = [false, false, false];
			this.showBox[num] = true;
		},
		hideBox: function() { //点击遮罩，关闭
			this.showBox = [false, false, false];
			this.show = false;
		},
		updateLeft: function() {
			//获取index.json渲染 课程类别左侧列表

			var _this = this;
			$.post(APP.API_PATH + "index.json", function(res) {
				if(res.status == APP.XHR_STATUS) {
					_this.classlist = res.data.classlist;
				}
			}, 'json');
			this.setright();
		},
		setright: function() {
			var _this = this;
			//课程类别右侧列表
			$.post(APP.API_PATH + "course/" + this.id + "/" + this.newOrHot + ".json", function(res) {
				if(res.status == APP.XHR_STATUS) {
					var data = res.speciallist;
					if(data !== undefined) {
						_this.rightList = data;
					} else {
						_this.rightList = [];
					}
					_this.setLocalStorage();
				}
			}, 'json');
		},
		changeLeft: function(inx) { //点击左侧一级分类
			this.inx = null;
			this.inx2 = null;
			this.inx1 = null;
			if(this.inx3 != inx) {
				this.inx3 = inx;

				this.firclick = false;
				$("#setLeftNav").find("li").removeClass("active");
				this.index = inx + 1;
				$("#setLeftNav").find("li").eq(this.index).addClass("active");
				//1级分类id
				this.id = $("#setLeftNav").find("li").eq(inx + 1).find("i").attr("data-id");
				//更新二级分类列表
				this.setright();
				//更新顶部tab文案
				var shtml = $("#setLeftNav").find("li").eq(inx + 1).find("span").html();
				this.name = shtml;
				this.setLocalStorage();

			}
		},
		oneALL: function() { //1级分类所有
			if(this.inx !== 1) {
				this.inx = 1;
				this.id = 0;
				var HREF = "course/0/" + this.newOrHot + ".json";
				this.hideBox();
				this.init(HREF);
				freshto();
				this.name = "全部"
				$("#setLeftNav").find("li").removeClass("active");
				$("#setLeftNav").find("li").eq(0).addClass("active");
				this.rightList = [];
				this.cycle();
				this.index = 0;
				this.setLocalStorage();
			}
		},
		twoALL: function() { //二级分类所有
			if(this.inx1 != 1) {
				this.inx1 = 1
				this.inx = null;
				this.inx2 = null;
				if(this.id !== 0) {
					var HREF = "course/" + this.id + "/" + this.newOrHot + ".json";
					this.sp2 = 0;
					this.ARG = this.ARG.replace(this.arg, '');
					this.ARG = "sp2=" + 0 + this.ARG;
					this.init("course/" + vw.id + "/" + this.newOrHot + ".json?" + this.ARG);
					freshto();
					this.name = "全部"
					this.hideBox();
					this.arg = "sp2=" + 0;
					this.setLocalStorage();

				}
			}
		},
		newHot: function(num) { //切换最新最热
			this.init("course/" + this.id + "/" + num + ".json?" + this.ARG);
			freshto();
			this.hideBox();
			if(num) { //切换顶部tab文字
				this.newHotTxt = "最热";
				this.newOrHot = 1;
			} else {
				this.newHotTxt = "最新";
				this.newOrHot = 0;
			}
			this.setLocalStorage();
		},
		changeview: function(inx) {

			if(this.inx2 != inx) {
				this.inx2 = inx;
				this.inx = null;
				this.inx1 = null;
				//更换顶部tab文案
				var shtml = $("#changedRight").find("li").eq(inx + 1).find("span").html();
				this.name = shtml;
				//隐藏遮罩层
				this.hideBox();
				var id = $("#changedRight").find("li").eq(inx + 1).find("span").attr("data-id");
				this.sp2 = id;
				//通过正则匹配来删除多余的字符
				this.ARG = this.ARG.replace(this.arg, '');
				this.ARG = "sp2=" + id + this.ARG;
				//点击二级分类给arg赋值
				this.arg = "sp2=" + id;
				this.init("course/" + this.id + "/" + this.newOrHot + ".json?" + this.ARG);
				freshto();
				this.setLocalStorage();
			}
		},
		firtel: function(e) { //点击筛选的逻辑
			if(e.target.tagName.toLowerCase() == "span") {
				var _this = e.target;
				var parent = $(_this).parent(".item");
				var inx = $(parent).attr("data-inx");
				var arg = $(_this).attr("data-inx");
				this.requireA[inx] = arg;
				parent.find("span").removeClass("active");
				$(_this).addClass("active");
				this.setLocalStorage();
			}
		},
		clear: function() { //清空筛选项
			//将require数组置空，那么this.ARG 就等于空
			this.requireA = { //筛选的条件
				'0': null,
				'1': null,
				'2': null
			};
			if(this.sp2 == 'false') {
				this.ARG = "";
			} else {
				console.log(this.sp2)
				this.ARG = this.ARG.replace("sp2=", '');
				this.ARG = "sp2=" + this.sp2
			}
			$("#firter").find("span").removeClass("active");
			this.setLocalStorage();
		},
		enter: function() { //点击确定按钮
			var ct = this.requireA[0],
				hm = this.requireA[1],
				cons = this.requireA[2];
			this.ARG = "";
			var sp2 = null;
			if(this.sp2 == 'false') {
				sp2 = "";
			} else {
				sp2 = "sp2=" + this.sp2;
			}
			if(ct !== null && hm !== null && cons !== null) {
				this.ARG += sp2 + "&ct=" + ct + "&hm=" + hm + "&cons=" + cons;
			} else if(ct !== null && hm !== null && cons == null) {
				this.ARG += sp2 + "&ct=" + ct + "&hm=" + hm;
			} else if(ct !== null && hm == null && cons !== null) {
				this.ARG += sp2 + "&ct=" + ct + "&cons=" + cons;
			} else if(ct !== null && hm == null && cons == null) {
				this.ARG += sp2 + "&ct=" + ct;
			} else if(ct == null && hm !== null && cons !== null) {
				this.ARG += sp2 + "&cons=" + cons + "&hm=" + hm;
			} else if(ct == null && hm == null && cons !== null) {
				this.ARG += sp2 + "&cons=" + cons;
			} else if(ct == null && hm !== null && cons == null) {
				this.ARG += sp2 + "&hm=" + hm;
			} else if(ct == null && hm == null && cons !== null) {
				this.ARG += sp2 + "&cons=" + cons;
			} else if(ct == null && hm == null && cons == null) {
				this.ARG += sp2;
			}
			this.init("course/" + this.id + "/" + this.newOrHot + ".json?" + this.ARG);
			freshto();
			this.hideBox();
			this.setLocalStorage();
		},
		init: function(url) {
			this.url = url;
			var _this = this;
			$.post(APP.API_PATH + this.url, function(res) {
				if(res.status == APP.XHR_STATUS) {
					//求总页数
					APP.PAGE_NUM = Math.ceil(res.totalcount / APP.PAGECOUNT);
					_this.items = res.data;
					APP.PAGE = 2;
				}
				if(_this.items.length == 0) {
					_this.noContent = true;
					$("#pullUp").remove();
				} else {
					_this.noContent = false;
				}
			}, 'json');
			canPullUp({
				canPullUp: true,
				cratePullUp: true,
				url: APP.API_PATH + this.url,
				type: "post",
				data: {
					p: APP.PAGE
				},
				success: function(res) {
					if(res.status == APP.XHR_STATUS) {
						var concatA = _this.items.concat(res.data);
						_this.items = concatA;
					}
				}
			});
		},
		cycle: function() {
			//调用懒加载
			loadImg({
				Id: "mainBox",
				Range: 100
			});
			//freshto();
		},
		toUrl: function($event) {
			//点击跳转之前，将所有的数据存到本地存储
			this.setLocalStorage();
			var target = $event.target;
			var href = $(target).closest('a').attr("data-href");
			window.location.href = href;
		},
		setLocalStorage: function() {
			//在这里获取所有的数据源，存到本地存储，方便刚进入页面的时候调用
			window.sessionStorage.setItem(filterPage + "history", 1);
			window.sessionStorage.setItem(filterPage + "items", JSON.stringify(this.items));
			window.sessionStorage.setItem(filterPage + "url", this.url);
			window.sessionStorage.setItem(filterPage + "show", this.show);
			window.sessionStorage.setItem(filterPage + "name", this.name);
			window.sessionStorage.setItem(filterPage + "id", this.id);
			window.sessionStorage.setItem(filterPage + "showBox", JSON.stringify(this.showBox));
			window.sessionStorage.setItem(filterPage + "classlist", JSON.stringify(this.classlist));
			window.sessionStorage.setItem(filterPage + "newHotTxt", this.newHotTxt);
			window.sessionStorage.setItem(filterPage + "requireA", JSON.stringify(this.requireA));
			window.sessionStorage.setItem(filterPage + "ARG", this.ARG);
			window.sessionStorage.setItem(filterPage + "rightList", JSON.stringify(this.rightList));
			window.sessionStorage.setItem(filterPage + "newOrHot", this.newOrHot);
			window.sessionStorage.setItem(filterPage + "firstClick", this.firstClick);
			window.sessionStorage.setItem(filterPage + "sp2", this.sp2);
			window.sessionStorage.setItem(filterPage + "noContent", this.noContent);
			window.sessionStorage.setItem(filterPage + "arg", this.arg);
			window.sessionStorage.setItem(filterPage + "index", this.index);
		},
		setActive: function() {
			var aSring = "";
			for(i in this.requireA) {
				aSring += "," + this.requireA[i];
			}
			var aArray = aSring.slice(1).split(",");
			for(i in aArray) {
				var spanS = $("#firter .item").eq(i).find("span")
				spanS.each(function(inx, v) {
					if($(spanS[inx]).attr("data-inx") == aArray[i]) {
						$(spanS[inx]).addClass("active");
					}
				})
			}
		},
	},
	created: function() {
		var cur = APP.URLSEARCH().cur;
		var _this = this;
		var name = APP.URLSEARCH().name;
	
		if(cur) {
			if(sessionStorage.getItem(filterPage + "history")) {
				this.first = false;
				this.items = JSON.parse(window.sessionStorage.getItem(filterPage + "items"));
				this.url = window.sessionStorage.getItem(filterPage + "url");
				this.show = false;
				this.name = window.sessionStorage.getItem(filterPage + "name");
				this.id = window.sessionStorage.getItem(filterPage + "id");
				this.showBox = JSON.parse(window.sessionStorage.getItem(filterPage + "showBox"));
				this.classlist = JSON.parse(window.sessionStorage.getItem(filterPage + "classlist"));
				this.newHotTxt = window.sessionStorage.getItem(filterPage + "newHotTxt");
				this.requireA = JSON.parse(window.sessionStorage.getItem(filterPage + "requireA"));
				this.ARG = window.sessionStorage.getItem(filterPage + "ARG");
				this.rightList = JSON.parse(window.sessionStorage.getItem(filterPage + "rightList"));
				this.newOrHot = window.sessionStorage.getItem(filterPage + "newOrHot");
				this.firstClick = window.sessionStorage.getItem(filterPage + "firstClick");
				this.sp2 = window.sessionStorage.getItem(filterPage + "sp2");
				this.noContent = window.sessionStorage.getItem(filterPage + "noContent");
				this.arg = window.sessionStorage.getItem(filterPage + "arg");
				this.index = window.sessionStorage.getItem(filterPage + "index");
				this.init("course/" + this.id + "/" + this.newOrHot + ".json?" + this.ARG);
				setTimeout(function() {
					loaded();
					_this.cycle();
					$("#setLeftNav").find("li").eq(_this.index).addClass("active");

				}, 100);
				this.setActive();
				this.left1 = true;
			} else {
				this.updateLeft();
				this.name = "全部";
				this.index = 0;
				this.id = 0;
				var HREF = "course/0/0.json";
				this.init(HREF);
				this.left = true;
			}
		} else {
			if(window.sessionStorage.getItem(filterPage + "name")) {
				this.first = false;
				this.items = JSON.parse(window.sessionStorage.getItem(filterPage + "items"));
				this.url = window.sessionStorage.getItem(filterPage + "url");
				this.show = false;
				this.name = window.sessionStorage.getItem(filterPage + "name");
				this.id = window.sessionStorage.getItem(filterPage + "id");
				this.showBox = JSON.parse(window.sessionStorage.getItem(filterPage + "showBox"));
				this.classlist = JSON.parse(window.sessionStorage.getItem(filterPage + "classlist"));
				this.newHotTxt = window.sessionStorage.getItem(filterPage + "newHotTxt");
				this.requireA = JSON.parse(window.sessionStorage.getItem(filterPage + "requireA"));
				this.ARG = window.sessionStorage.getItem(filterPage + "ARG");
				this.rightList = JSON.parse(window.sessionStorage.getItem(filterPage + "rightList"));
				this.newOrHot = window.sessionStorage.getItem(filterPage + "newOrHot");
				this.firstClick = window.sessionStorage.getItem(filterPage + "firstClick");
				this.sp2 = window.sessionStorage.getItem(filterPage + "sp2");
				this.noContent = window.sessionStorage.getItem(filterPage + "noContent");
				this.arg = window.sessionStorage.getItem(filterPage + "arg");
				this.index = window.sessionStorage.getItem(filterPage + "index");
				this.init("course/" + this.id + "/" + this.newOrHot + ".json?" + this.ARG);
				setTimeout(function() {
					loaded();
					_this.cycle();
					$("#setLeftNav").find("li").eq(_this.index).addClass("active");

				}, 100);
				this.setActive();
				this.left1 = true;
			} else {
				this.id = APP.URLSEARCH().id;
				this.name = name;
				this.index = ~~APP.URLSEARCH().index + 1;
				this.updateLeft();
				this.init("course/" + this.id + "/" + this.newOrHot + ".json");
				this.left = true;
				this.setLocalStorage();
			}
		}

	},
	updated: function() {
		if(this.first) {
			var _this = this;
			setTimeout(function() {
				$("#setLeftNav").find("li").eq(_this.index).addClass("active");
			}, 10)
			setTimeout(function() {
				loaded();
				new iScroll("setLeftNav", {
					vScrollbar: false
				})

			}, 100);
			this.first = false;
		}
		new iScroll("changedRight", {
			vScrollbar: false
		})
		this.cycle();
		if(this.left) {
			new iScroll("setLeftNav", {
				vScrollbar: false
			})

		}
		if(this.left1) {
			new iScroll("setLeftNav", {
				vScrollbar: false
			})

		}
	}
});