/**
 * 
 */
var vw = new Vue({
	el: "#app",
	data: {
		first: true,
		bannerlist: [],
		activitylist: [],
		tearcherlist: [],
		pclist: [],
		fclist: [],
		classlist: [],
		zhibolist:[]
	},

	methods: {
		//
		init: function() {
			var _this = this;
			//获取数据
			$.post(APP.API_PATH + "index.json", function(res) {
				if(res.status == APP.XHR_STATUS) {
					_this.update(res.data);
				}
			}, 'json');
			//调用iscroll
			canPullUp({
				canPullUp: true
			});
		},
		update: function(data) {
			this.bannerlist = data.bannerlist;
			this.activitylist = data.activitylist;
			this.tearcherlist = data.tearcherlist;
			this.pclist = data.pclist;
			this.fclist = data.fclist;
			this.classlist = data.classlist;
			this.zhibolist = data.zhibolist;
		},
		cycle: function() {
			var mySwiper = new Swiper('.swiper-container1', {
				autoplay: 5000,
				loop: true,
				pagination: '.swiper-pagination',
				lazyLoading: true,
				lazyLoadingInPrevNext: true,
				preventClicks: false,
				preventLinksPropagation: false,
				autoplayDisableOnInteraction: false,
				touchMoveStopPropagation: false,
				lazyLoading: true
			});
			new Swiper('.swiper-container2', {
				slidesPerView: 4,
				paginationClickable: true,
				freeMode: true,
				preventClicks: false,
				preventLinksPropagation: false,
				autoplayDisableOnInteraction: false,
				touchMoveStopPropagation: false,
				lazyLoading: true,
			});

			//调用懒加载
			loadImg({
				Id: "mainBox",
				Range: 100
			});
		}, //点击分类
		topNav: function(index) {
			var $this = $("#swiper2").find(".swiper-slide").eq(index).find("a");
			var dataID = $this.attr("data-id"),
				dataName = $this.attr("data-name"),
				dataUrl = $this.attr("data-url");
			var href1 = dataUrl.replace("#", dataID);
			window.sessionStorage.clear();
		window.location.href = href1 + "?id=" + dataID + "&name=" + dataName + "&index=" + index;

		}
	},
	mounted: function() {},
	updated: function() {
		if(this.first) {
			setTimeout(function() {
				loaded();
				
			}, 100);
			this.cycle();
			this.first = false;
		}
	}
});
vw.init();
