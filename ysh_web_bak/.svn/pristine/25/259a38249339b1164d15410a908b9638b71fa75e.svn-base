;
(function(d, w, $) {
	var iscroll = null;
	var windowH = $(window).height();
	var AJAX = null;
	var maxY = null,
		_thisY = null;
	var canPullUp = false;
	var num = 1;
	var isAdd = false;
	var handler = null;
	var isloadimg = true;
	var have = true;
	/*动态创建pullup*/
	function cratePullUp() {
		var pullUp = $(' <div id="pullUp"><span class="pullUpIcon"></span><span class="pullUpLabel">上拉加载更多</span></div>');
		$('#pullUpWrapper').append(pullUp);
	}
	/*创建回到顶部按钮*/
	function crateGoTop() {
		var $div = $("<div id='goTop' class='goTop fixed'>");
		$(".wrapper").append($div);
	}
	/*显示回到顶部按钮*/
	function showGoTop() {
		if(windowH < (-iscroll.y)) {
			$("#goTop").show(100);
		} else {
			$("#goTop").hide(100);
		}
	}
	//没有数据的时候调用函数
	function noContent() {
		$("#pullUp").find(".pullUpIcon").hide();
		$("#pullUp").find(".pullUpLabel").html("亲，没有更多数据了！");
	}
	/*实例化iscroll*/
	function loaded() {
		iscroll = new iScroll("mainBox", {
			vScrollbar: false,
			bindToWrapper: false,
			//momentum : false,
			bounce: true,
			//bounceLock: false,
			onScrollStart: function() {
				//start的时候显示pullUp,避免抖动
				$("#pullUp").show();
				iscroll.refresh();
				if(APP.PAGE > APP.PAGE_NUM) {
					noContent();
					have = false;
					AJAX = null;
				} else {
					have = true;
				$("#pullUp").find(".pullUpIcon").show();
				$("#pullUp").find(".pullUpLabel").html("上拉加载更多");
				}
			},
			onScrollMove: function() {
				//调用懒加载
				loadImg({
					Id: "mainBox",
					Range: 100
				});
				maxY = iscroll.maxScrollY;
				_thisY = iscroll.y;
				if(_thisY - 20 <= maxY) {
					if(_thisY <= maxY) {
						isAdd = true;
					}
					if(have) {
						$("#pullUp").find(".pullUpIcon").removeClass("loading").addClass("rotate90");
						$("#pullUp").find(".pullUpLabel").html("松手刷新");
					} else {
						noContent();
					}
				}
				showGoTop();
			},
			onScrollEnd: function() {
				if(isAdd) {
					$("#pullUp").show();
					if(have) {
						$("#pullUp").find(".pullUpIcon").removeClass("rotate90").addClass("loading");
						$("#pullUp").find(".pullUpLabel").html("正在加载...");
					} else {
						noContent();
					}
					/*执行ajax*/
					if(typeof AJAX == "function") {
						AJAX();
					}
				} else {
					$("#pullUp").hide();
					iscroll.refresh();
				}
				/*显示回到顶部按钮*/
				showGoTop();
				isAdd = false;
			},
			onScrollLimit: function() {}
		});
		if(!$("#goTop")){
			crateGoTop();
		}
		
		$("#goTop").on("click", function() {
			iscroll.scrollTo(0, 0, 100);
			$("#goTop").hide(100);
		});
	}
	d.addEventListener('touchmove', function(e) {
		e.preventDefault();
	}, false);
//	d.addEventListener('DOMContentLoaded', function() {
//		setTimeout(loaded, 300);
//	}, false);
	w.canPullUp = function(obj) {
		if(obj.cratePullUp) {
			if($("#pullUp").length == 0) {
				cratePullUp();
				$("#pullUp").hide();
			}
		}
		if(typeof(obj.success) == "function") {
			/*AJAX逻辑*/
			var objKey = null;
			AJAX = function() {
				for(i in obj.data) {
					objKey = i;
					break;
				}
				//给翻页参数重新赋值
				obj.data[objKey] = APP.PAGE;
				$.ajax({
					url: obj.url, //+"?p="+APP.PAGE,//请求路劲
					type: obj.type, //请求类型
					dataType: "json", //返回格式
					data: obj.data, //传值给后台
					success: function(res) {
						APP.PAGE += 1; //请求一次，页数+1
						obj.success(res); //请求成功执行
					},
					complete: function(res) {
						$("#pullUp").hide();
						iscroll.refresh();
					},
					error: function(XMLResponse) {
						//console.log(XMLResponse)
					}
				})
			}
		}
	}

	/*懒加载*/
	function loadImg(options) {
		var id = options.Id ? document.getElementById(options.Id) : document;
		if(id === null) return;
		var imgAll = id.getElementsByTagName("img"),
			imgAlllen = imgAll.length,
			dataImg = [];
		for(var i = 0; i < imgAlllen; i++) {
			_imgAll = imgAll[i];
			if(_imgAll.getAttribute("data-src") !== null) {
				if(isLoad(_imgAll)) {
					setimg(_imgAll);
				} else {
					dataImg.push(_imgAll);
				}
			}
		}

		function setimg(ele) {
			ele.src = ele.getAttribute("data-src");
		}

		function isLoad(ele) {
			var scrTop = document.documentElement.scrollTop || document.body.scrollTop || window.pageYOffset,
				edit = ~~ele.getAttribute("data-Range") || options.Range,
				scrHeight = document.documentElement.clientHeight + scrTop + edit,
				offTop = ele.offsetTop;
			return(scrHeight > (-offTop));
		}
		handler = function() {
			for(var i = 0; i < dataImg.length; i++) {
				var _dataImg = dataImg[i];
				if(isLoad(_dataImg)) {
					loading(_dataImg);
					dataImg.splice(i, 1);
					dataImg.length == 0 && islladimg_false();
				}
			}
		}
	}
	var islladimg_false = function() {
		isloadimg = false;
	}
	/*调用loadimg*/
	loadImg({
		Id: "mainBox",
		Range: 100
	});

	function freshto() {
		iscroll.scrollTo(0, 0, 0);
	}
	/*暴露接口给全局*/
	w.loadImg = loadImg;
	w.loaded = loaded;
	w.freshto = freshto;
})(document, window, Zepto);