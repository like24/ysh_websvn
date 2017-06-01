var vw = new Vue({
	el: "#app",
	data: {
		first: true,
		items: [],
		url: null,
		show: false,
		activeType: [],
		totalcount:[],
		saler:[],
		isSaler:[],
        contentlist:[]
	},
	methods: {
		init: function(url) {
			this.url = url;
			var _this = this;
			console.log(APP.API_PATH + this.url);
			$.post(APP.API_PATH + this.url, function(res) {
				if(res.status == APP.XHR_STATUS) {
					//求总页数
					APP.PAGE_NUM = Math.ceil(res.totalcount / APP.PAGECOUNT);
					_this.items = res.data;
				console.log(_this.items)
					_this.totalcount = res.totalcount;
					if(res.saler){
						_this.saler = res.saler;
						_this.isSaler = res.issaler;
					}
				}
               if(res.contentlist){
					_this.contentlist = res.contentlist;
			   }
			}, 'json');
			canPullUp({
				canPullUp: true,     
				cratePullUp: true,
				url: APP.API_PATH + this.url,
				type: "post",
				data: { p: APP.PAGE },
				success: function(res) {
					if(res.status == APP.XHR_STATUS) {
						var concatA = _this.items.concat(res.data);
						_this.items = concatA;
					}
				}
			});
		},
		go:function(url1){
			window.location.href=url1;
		},
		cycle: function() {
			var _this = this;

			//调用懒加载
			loadImg({
				Id: "mainBox",
				Range: 100
			});
		},
		fun: function() {

		}
	},
	updated: function() {
		this.cycle();
		if(this.first) {
			setTimeout(function() {
				loaded();
			}, 100);
			this.first = false;
		}
		
	}
})