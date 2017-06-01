 wx.ready(function () {
     wx.onMenuShareAppMessage({
         title: title1,
         desc: desc1,
         link: link1,
         imgUrl: img1,
         trigger: function (res) {},
         complete: function (res) {},
         success: function (res) {},
         cancel: function (res) {},
         fail: function (res) {}
     });
     wx.onMenuShareTimeline({
         title: title1,
         link: link1,
         imgUrl: img1,
         trigger: function (res) {},
         complete: function (res) {},
         success: function (res) {},
         cancel: function (res) {},
         fail: function (res) {}
     });
     wx.onMenuShareQQ({
         title: title1,
         desc: desc1,
         link: link1,
         imgUrl: img1,
         trigger: function (res) {},
         complete: function (res) {},
         success: function (res) {},
         cancel: function (res) {},
         fail: function (res) {}
     });
     wx.onMenuShareWeibo({
         title: title1,
         desc: desc1,
         link: link1,
         imgUrl: img1,
         trigger: function (res) {},
         complete: function (res) {},
         success: function (res) {},
         cancel: function (res) {},
         fail: function (res) {}
     });
 });

 var Modal = {
     el: '<div class="dialog">',
     caption: '<div class="dialog-caption"><b></b><div class="dialog-icon" data-dialog-cancel>×</div></div>',
     content: '<div class="content9">',
     btns: '<div class="pc-btn"><a href="#" class="bor1" data-dialog-cancel>取消</a> <a href="#" data-dialog-ok>确定</a></div>',
     mask: '<div class="dialog-overlay">',
     create: function (options) {
         options = options || {}

         var modal = {
             options: options
         }

         modal.el = $(this.el);
         modal.mask = $(this.mask);

         if (options.title) {
             modal.caption = $(this.caption)
             modal.caption.find('b').text(options.title)
             modal.el.append(modal.caption)
         }

         modal.content = $(this.content)
         options.content && modal.content.html(options.content)
         modal.el.append(modal.content)

         if (options.ok || options.cancel) {
             modal.btns = $(this.btns)
             modal.el.append(modal.btns)
         }


         if ($(".dialog").length == 0) {
             $('body').prepend(modal.el);
         }
         if ($(".dialog-overlay").length == 0) {
             $('body').append(modal.mask)
         }
         modal.close = function () {
             modal.el.remove()
             modal.mask.fadeOut(320, function () {
                 modal.mask.remove()
             })
         }
         modal.center = function () {
             modal.el.css({
                 top: ($(window).height() - modal.el.outerHeight()) / 2
             })
         }

         modal.el.on('click', '[data-dialog-cancel]', function (e) {
             e.preventDefault()
             if (options.cancel && options.cancel(modal) === false) return
             modal.close()
         })

         modal.el.on('click', '[data-dialog-ok]', function (e) {
             e.preventDefault()
             if (options.ok && options.ok(modal) === false) return
             modal.close()
         })


         modal.center();

         modal.el.find('input, textarea').eq(0).focus();

         $(window).resize(function () {
             modal.center();
         });

         return modal
     },
     alert: function (str, title) {
         return this.create({
             title: title || ' ',
             content: str
         })
     },
     confirm: function (str, fn, fn2, btn1, btn2) {
         var modal = this.create({
             content: str,
             ok: function (modal) {
                 modal.close();
                 fn && fn();
             },
             cancel: fn2 || function () {}
         })
         if (btn1) {
             modal.el.find('[data-dialog-ok]').text(btn1)
         }
         if (btn2) {
             modal.el.find('[data-dialog-cancel]').text(btn2)
         }
         return modal
     },
     prompt: function (str, fn) {
         var modal = this.create({
             content: '<div class="dialog-prompt-content">' + str + '</div><textarea id="msg" style="width:250px;height:200px;" ></textarea>',
             ok: function (modal) {
                 return fn && fn(modal.el.find('input').val())
             },
             cancel: function () {}
         });
         return modal
     },
     prompt1: function (str, fn) {
         var modal = this.create({
             content: '<div class="dialog-prompt-content">' + str + '</div>',
             ok: function (modal) {
                 return fn && fn(modal.el.find('input').val())
             },
             cancel: function () {}
         });
         return modal
     },
     tips: function (str /*, time, type, fn*/ ) {
         var time = 2000,
             type = '',
             fn = $.noop

         $(arguments).each(function (i) {
             if (i) {
                 var atype = $.type(this);
                 if (atype == 'function') {
                     fn = this;
                 } else if (atype == 'string') {
                     type = this;
                     str = '<i class="dialog-tips-icon ' + type + '"></i>' + str;
                 } else if (atype == 'number') {
                     time = this;
                 };
             };
         })

         var modal = this.create({
             content: str
         })

         modal.el.addClass('dialog-tips').css({
             top: 'auto',
             bottom: '25%'
         })

         setTimeout(function () {
             modal.close()
             fn(modal)
         }, time)

         return modal
     }
 }