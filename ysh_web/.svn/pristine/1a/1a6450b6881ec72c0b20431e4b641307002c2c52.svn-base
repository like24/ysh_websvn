var vw = new Vue({
	el: "#app",
	data: {
		first: true,
		everylist: [],
		showBox: [1, 0, 0, 0], //显示对应盒子
		noContent: false, //没有搜索到内容显示空提示盒子
		text: '', //输入文字
		courselist: [], //课程
		asklist: [], //问答
		teacherlist: [], //瑜伽导师
		courselist3: [], //课程3
		asklist3: [], //问答3
		teacherlist3: [], //瑜伽导师3
		boxShow: false, //是否显示搜索到的所有的页面
		everyShow: true, //是否显示大家都在搜模块
		course: 1, //是否显示课程这个盒子
		teach: 1, //是否显示导师这个盒子
		ask: 1, //是否显示问答这个盒子
		inx: 0
	},
	methods: {
		init: function() {
			var _this = this;
			$.post(APP.API_PATH + "search/index.json", function(res) {
				if(res.status == APP.XHR_STATUS) {
					_this.everylist = res.data;
				}
			}, 'json');
		},
		toUrl: function($event) {
			//点击跳转之前，将所有的数据存到本地存储
			this.setLocalStorage();
			var target = $event.target;
			var href = $(target).closest('a').attr("data-href");
			window.location.href = href;
		},
		setLocalStorage: function() {
			var searchPage = "searchPage";
			//在这里获取所有的数据源，存到本地存储，方便刚进入页面的时候调用
			window.sessionStorage.setItem(searchPage + "history", 1);
			window.sessionStorage.setItem(searchPage + "everylist", JSON.stringify(this.everylist));
			window.sessionStorage.setItem(searchPage + "showBox", JSON.stringify(this.showBox));
			window.sessionStorage.setItem(searchPage + "text", this.text);
			window.sessionStorage.setItem(searchPage + "courselist", JSON.stringify(this.courselist));
			window.sessionStorage.setItem(searchPage + "asklist", JSON.stringify(this.asklist));
			window.sessionStorage.setItem(searchPage + "teacherlist", JSON.stringify(this.teacherlist));
			window.sessionStorage.setItem(searchPage + "courselist3", JSON.stringify(this.courselist3));
			window.sessionStorage.setItem(searchPage + "asklist3", JSON.stringify(this.asklist3));
			window.sessionStorage.setItem(searchPage + "teacherlist3", JSON.stringify(this.teacherlist3));
			window.sessionStorage.setItem(searchPage + "boxShow", this.boxShow);
			window.sessionStorage.setItem(searchPage + "course", this.course);
			window.sessionStorage.setItem(searchPage + "teach", this.teach);
			window.sessionStorage.setItem(searchPage + "ask", this.ask);
			window.sessionStorage.setItem(searchPage + "inx", this.inx);
		},

		search: function() { //点击搜索
			if(this.text !== '') {
				if(this.everyShow) {
					this.everyShow = false; //隐藏大家都在搜模块
				}
				this.resetData();
				this.get();
			}
		},
		resetData: function() { //重置所有data
			this.everylist = [];
			this.showBox = [1, 0, 0, 0];
			this.courselist = [];
			this.asklist = [];
			this.teacherlist = [];
			this.boxShow = false;
			this.course = 1;
			this.ask = 1;
			this.teach = 1;
		},
		get: function() {
			var _this = this;
			$.post(APP.API_PATH + "search.json?c=" + this.text, function(res) {
				if(res.status == APP.XHR_STATUS) {
					console.log(res);
					_this.upData(res); //更新data
				} else {
					_this.noContent = true; //显示空内容盒子
				}
			}, 'json');
		},
		upData: function(res) {
			var _this = this;
			if(res.courselist !== undefined) {
				_this.courselist = res.courselist;
				var len = res.courselist.length;
				if(len < 2) {
					_this.courselist3 = [res.courselist[0]];
				} else if(len < 3) {
					_this.courselist3 = [res.courselist[0], res.courselist[1]];
				} else {
					_this.courselist3 = [res.courselist[0], res.courselist[1], res.courselist[2]];
				}

			} else {
				_this.course = 0;
			}
			if(res.asklist !== undefined) {
				_this.asklist = res.asklist;
				var len = res.asklist.length;
				if(len < 2) {
					_this.asklist3 = [res.asklist[0]];
				} else if(len < 3) {
					_this.asklist3 = [res.asklist[0], res.asklist[1]];
				} else {
					_this.asklist3 = [res.asklist[0], res.asklist[1], res.asklist[2]];
				}
			} else {
				_this.ask = 0;
			}
			if(res.teacherlist !== undefined) {
				_this.teacherlist = res.teacherlist;
				var len = res.teacherlist.length;
				if(len < 2) {
					_this.teacherlist3 = [res.teacherlist[0]];
				} else if(len < 3) {
					_this.teacherlist3 = [res.teacherlist[0], res.teacherlist[1]];
				} else {
					_this.teacherlist3 = [res.teacherlist[0], res.teacherlist[1], res.teacherlist[2]];
				}
			} else {
				_this.teach = 0;
			}
			if(_this.courselist.length == 0 && _this.asklist.length == 0 && _this.teacherlist.length == 0) {
				this.noContent = true;
				_this.boxShow = false;
			} else {
				_this.boxShow = true; //显示搜索到的所有页面的大盒子
			}
		},
		changeNav: function($event) { //切换顶部导航
			this.inx = $($event.target).closest('li').index(); //获取当前索引
			$("nav").find("li").removeClass("active");
			$("nav").find("li").eq(this.inx).addClass("active");
			$("#borderB").removeClass("left0 left1 left2 left3");
			$("#borderB").addClass("left" + this.inx); //显示下边框的位置
			var arr = [1, this.course, this.ask, this.teach];
			//显示对应内容
			for(i in this.showBox) {
				this.showBox[i] = 0;
			}
			if(!arr[this.inx]) {
				this.noContent = true;
				this.showBox.splice(this.inx, 1, 0);
			} else {
				this.showBox.splice(this.inx, 1, 1);
				this.noContent = false;
			}
		},
		clickTag: function($index) {
			this.everyShow = false;
			this.text = $("#every").find("span").eq($index).html();
			this.get();
		}
	},
	created: function() {
		var searchPage = "searchPage";
		if(sessionStorage.getItem(searchPage + "history")) {
			this.first = false;
			this.everylist = JSON.parse(window.sessionStorage.getItem(searchPage + "everylist"));
			this.showBox = JSON.parse(window.sessionStorage.getItem(searchPage + "showBox"));
			this.inx = JSON.parse(window.sessionStorage.getItem(searchPage + "inx"));
			this.noContent = false;
			this.text = window.sessionStorage.getItem(searchPage + "text");
			this.courselist = JSON.parse(window.sessionStorage.getItem(searchPage + "courselist"));
			this.asklist = JSON.parse(window.sessionStorage.getItem(searchPage + "asklist"));
			this.teacherlist = JSON.parse(window.sessionStorage.getItem(searchPage + "teacherlist"));
			this.courselist3 = JSON.parse(window.sessionStorage.getItem(searchPage + "courselist3"));
			this.asklist3 = JSON.parse(window.sessionStorage.getItem(searchPage + "asklist3"));
			this.teacherlist3 = JSON.parse(window.sessionStorage.getItem(searchPage + "teacherlist3"));
			this.boxShow = window.sessionStorage.getItem(searchPage + "boxShow");
			this.everyShow = false;
		this.course = ~~window.sessionStorage.getItem(searchPage + "course");
			this.teach = ~~window.sessionStorage.getItem(searchPage + "teach");
			this.ask =~~window.sessionStorage.getItem(searchPage + "ask");
			
			console.log(this.course);
			$("nav").find("li").removeClass("active");
			$("nav").find("li").eq(this.inx).addClass("active");
			$("#borderB").removeClass("left0 left1 left2 left3");
			$("#borderB").addClass("left" + this.inx); //显示下边框的位置
		}

	},
	updated: function() {
		console.log(0)
		//调用懒加载
		loadImg({
			Id: "mainBox",
			Range: 100
		});
		setTimeout(function() {
			loaded();
		}, 100);

	}
})
if(!sessionStorage.getItem("searchPagehistory")) {
	vw.init();
}else{
	loadImg({
			Id: "mainBox",
			Range: 100
		});
		setTimeout(function() {
			loaded();
		}, 100);
		
}
