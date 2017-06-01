

(function($) {
    $.fn.citySelect = function(settings) {
        if (this.length < 1) {
            return;
        };
        settings = $.extend({
            url:'/js/city.min.js',
            prov: null,
            city: null,
            dist: null
        },
        settings);


        var city_text = this;
        //创建城市联动box
        var cityarea_html = '<div id="city_area">' + 
                                '<div class="selt_box">' + 
                                    '<div class="cityhead" id="prvarea">' + 
                                        '<div class="ch_box"><div class="bck" id="prv_bck"><i><</i></div></div>' + 
                                        '<dl class="prv_box"></dl>' + 
                                    '</div>' + 
                                    '<div class="cityhead" id="cityarea">' + 
                                        '<div class="ch_box"><div class="bck" id="city_bck"><i></i></div></div>' + 
                                        '<dl class="city_box"></dl>' + 
                                    '</div>' + 
                                    '<div class="cityhead" id="distarea">' + 
                                        '<div class="ch_box"><div class="bck" id="dist_bck"><i><</i></div></div>' + 
                                        '<dl class="dist_box"></dl>' + 
                                    '</div>' + 
                                '</div>' + 
                            '</div>';
        //将联动box加载在body中
        $('body').append(cityarea_html);
        var city_area = $('#city_area');
        var prov_obj = city_area.find(".prv_box");
        var city_obj = city_area.find(".city_box");
        var dist_obj = city_area.find(".dist_box");
        var prov_val = settings.prov;
        var city_val = settings.city;
        var dist_val = settings.dist;
        var datahtml = (settings.required) ? "": "<dd></dd>";
        var city_json;

        //初始值
        if(prov_val==null || city_val==null){
            city_text.val();
        }
        else if(dist_val==null){
            city_text.val(prov_val+city_val);
        }else{
            city_text.val(prov_val+city_val+dist_val);
        }        
        

        //点击元素时展开联动box
        city_text.click(function() {
            city_area.fadeIn();
            $('#prvarea').fadeIn();
        })

        //点击市级返回
        $('#city_bck').click(function(){
            $('#cityarea').fadeOut();
        })
        //点击县级返回
        $('#dist_bck').click(function(){
            $('#distarea').fadeOut();
        })
        var citys = function() {
            //点击省级list时获取市级数据
            $('.prv_box dd').click(function() {
            	$(this).addClass("dd-bj");
            	$that=$(this);
            	 setTimeout(function(){
            		 $that.removeClass("dd-bj");
            	 })
                 	
                 
                var prv_id = $(this).index();
                var p_val = $(this).attr('data-val');
                var temp_html = datahtml;
                if (prv_id < 0 || typeof(city_json.citylist[prv_id].c) == "undefined") {
                    return;
                }
                city_obj.html('');
                $('#cityarea').fadeIn();
               
                
                $.each(city_json.citylist[prv_id].c,function(i, city) {
                    //这个判断没什么用，只是为了去掉向右的符号
                    if (i < 0 || typeof(city_json.citylist[prv_id].c[i].a) == "undefined") {
                        temp_html = '<dd data-val="' + city.n + '">' + city.n + '</dd>';
                        city_obj.append(temp_html);
                    }else{
                        temp_html = '<dd data-val="' + city.n + '">' + city.n + '<i class="city_i">&#xe757;</i></dd>';
                        city_obj.append(temp_html);
                    }
                }) 
                
                //点击市级list时获取县级数据
                $('.city_box dd').click(function() {
                	$(this).addClass("dd-bj");
                	setTimeout(function(){
               		 $that.removeClass("dd-bj");
               	 })
                    	
                    var c_id = $(this).index();
                    var c_val = $(this).attr('data-val');
                    temp_html = datahtml;
                    if (c_id < 0 || typeof(city_json.citylist[prv_id].c[c_id].a) == "undefined") {
                        dist_obj.val('');
                        city_text.val(p_val + c_val);
                        $('#prvarea').fadeOut();
                        $('#cityarea').fadeOut();
                        city_area.fadeOut();
                        return;
                    }
                    dist_obj.html('');
                    $('#distarea').fadeIn();
                   
                    $.each(city_json.citylist[prv_id].c[c_id].a,function(i, dist) {
                        temp_html = '<dd data-val="' + dist.s + '">' + dist.s + '</dd>';
                        dist_obj.append(temp_html);
                    }) 
                    
                    $('.dist_box dd').click(function() {
                    	$(this).addClass("dd-bj");
                    	setTimeout(function(){
                   		 $that.removeClass("dd-bj");
                   	 })
                        	
                        var d_val = $(this).attr('data-val');
                        city_text.val(p_val + c_val + d_val);
                        $('#prvarea').fadeOut();
                        $('#cityarea').fadeOut();
                        $('#distarea').fadeOut();
                        city_area.fadeOut();
                       
                    })
                })
            })
        }

        //获取省级数据
        var init = function() {
            temp_html = datahtml;
            $.each(city_json.citylist,function(i, prv) {
                temp_html = '<dd data-val="' + prv.p + '">' + prv.p + '<i>></i></dd>';
                prov_obj.append(temp_html);
            }) 

            citys();
        }

        // 设置省市json数据
        if (typeof(settings.url) == "string") {
            $.getJSON(settings.url,
            function(json) {
                city_json = json;
                init();
            });
        } else {
            city_json = settings.url;
            init();
        };
    };
})(jQuery);