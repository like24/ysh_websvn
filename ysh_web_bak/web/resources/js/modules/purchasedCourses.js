var vw = new Vue({
	el:"#app",
	data:{
		tab:true,
		tab1:false,
		zhibo:[],
		lubo:[]
	},
	methods:{
		init:function(){
			var _this = this;
			//直播
			$.post(APP.API_PATH + "my/minebuy/zhibo.json", function(res) {
				_this.zhibo = res.contentlist;
				
			}, 'json');
			//录播
			$.post(APP.API_PATH + "my/minebuy/course.json", function(res) {
				_this.lubo = res.contentlist;
			}, 'json');
		},
		nav:function(num){//切换导航
			if(num){
				this.tab1=true;
				this.tab=false;
				$("#nav").find("li").eq(0).removeClass("curr");
				$("#nav").find("li").eq(1).addClass("curr");
			}else{
				this.tab=true;
				this.tab1=false;
				$("#nav").find("li").eq(1).removeClass("curr");
				$("#nav").find("li").eq(0).addClass("curr");
			};
		}
	}
})
vw.init();
