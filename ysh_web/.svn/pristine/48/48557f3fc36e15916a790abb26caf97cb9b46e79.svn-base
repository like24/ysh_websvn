var vw = new Vue({
	el: "#app",
	data: {
		tabText: ['介绍', '目录', '留言区'], //tab文字
		readyShow: [1, 0, 0], //初始化的时候默认显示的内容
		content: [], //初始化数据
		taglist:[],//taglist
		tutor:[],//导师内容
		menu:[],//目录课程
		commentlist:[],//留言
		seemcourse:[]//相似课程
	},
	methods: {

		changeTab: function($index) {
			//显示对应内容
			this.readyShow = [0, 0, 0]
			this.readyShow.splice($index, 1, 1);
		},
		update: function(res) {
			this.content = res.data;
			//taglist
			this.taglist = res.data.taglist.split(",")
			this.tutor = res.u;
			if(this.menu.length == 0){
				$("#tab").find("span").eq(1).hide();
			}
			//相关课程
			this.seemcourse = res.seemcourse;
			this.commentlist = res.commentlist;
			if(res.items!==undefined){
				this.menu = res.items;
			}
		}
	},
	beforeCreate: function() {
		//实例化之后执行
		var cid = APP.URLSEARCH().cid,
			_this = this;
			
		$.post(APP.API_PATH + 'course.json?p=' + cid + "&i=0", function(res) {
			if(res.status == APP.XHR_STATUS) {
				_this.update(res);
			}
		}, 'json');
			
	},
	updated: function() {
		//调用懒加载
			loadImg({
				Id: "mainBox",
				Range: 100
			});
	}
	
})