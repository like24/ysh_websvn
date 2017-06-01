//     Zepto touch port to jQuery
//     Zepto.js
//     (c) 2010-2014 Thomas Fuchs
//     Zepto.js may be freely distributed under the MIT license.

;(function($){
  var touch = {},
    touchTimeout, tapTimeout, swipeTimeout, longTapTimeout,
    longTapDelay = 750,
    gesture

  function swipeDirection(x1, x2, y1, y2) {
    return Math.abs(x1 - x2) >=
      Math.abs(y1 - y2) ? (x1 - x2 > 0 ? 'Left' : 'Right') : (y1 - y2 > 0 ? 'Up' : 'Down')
  }

  function longTap() {
    longTapTimeout = null
    if (touch.last) {
      touch.el.trigger('longTap')
      touch = {}
    }
  }

  function cancelLongTap() {
    if (longTapTimeout) clearTimeout(longTapTimeout)
    longTapTimeout = null
  }

  function cancelAll() {
    if (touchTimeout) clearTimeout(touchTimeout)
    if (tapTimeout) clearTimeout(tapTimeout)
    if (swipeTimeout) clearTimeout(swipeTimeout)
    if (longTapTimeout) clearTimeout(longTapTimeout)
    touchTimeout = tapTimeout = swipeTimeout = longTapTimeout = null
    touch = {}
  }

  function isPrimaryTouch(event){
    return (event.pointerType == 'touch' ||
      event.pointerType == event.MSPOINTER_TYPE_TOUCH)
      && event.isPrimary
  }

  function isPointerEventType(e, type){
    return (e.type == 'pointer'+type ||
      e.type.toLowerCase() == 'mspointer'+type)
  }

  $(document).ready(function(){
    var now, delta, deltaX = 0, deltaY = 0, firstTouch, _isPointerType

    if ('MSGesture' in window) {
      gesture = new MSGesture()
      gesture.target = document.body
    }

    $(document)
      .bind('MSGestureEnd', function(e){
        var swipeDirectionFromVelocity =
          e.velocityX > 1 ? 'Right' : e.velocityX < -1 ? 'Left' : e.velocityY > 1 ? 'Down' : e.velocityY < -1 ? 'Up' : null;
        if (swipeDirectionFromVelocity) {
          touch.el.trigger('swipe')
          touch.el.trigger('swipe'+ swipeDirectionFromVelocity)
        }
      })
      .on('touchstart MSPointerDown pointerdown', function(e){
        if((_isPointerType = isPointerEventType(e, 'down')) &&
          !isPrimaryTouch(e)) return
        firstTouch = _isPointerType ? e : e.originalEvent.touches[0]
        if (e.originalEvent.touches && e.originalEvent.touches.length === 1 && touch.x2) {
          // Clear out touch movement data if we have it sticking around
          // This can occur if touchcancel doesn't fire due to preventDefault, etc.
          touch.x2 = undefined
          touch.y2 = undefined
        }
        now = Date.now()
        delta = now - (touch.last || now)
        touch.el = $('tagName' in firstTouch.target ?
          firstTouch.target : firstTouch.target.parentNode)
        touchTimeout && clearTimeout(touchTimeout)
        touch.x1 = firstTouch.pageX
        touch.y1 = firstTouch.pageY
        if (delta > 0 && delta <= 250) touch.isDoubleTap = true
        touch.last = now
        longTapTimeout = setTimeout(longTap, longTapDelay)
        // adds the current touch contact for IE gesture recognition
        if (gesture && _isPointerType) gesture.addPointer(e.pointerId);
      })
      .on('touchmove MSPointerMove pointermove', function(e){
        if((_isPointerType = isPointerEventType(e, 'move')) &&
          !isPrimaryTouch(e)) return
        firstTouch = _isPointerType ? e : e.originalEvent.touches[0]
        cancelLongTap()
        touch.x2 = firstTouch.pageX
        touch.y2 = firstTouch.pageY

        deltaX += Math.abs(touch.x1 - touch.x2)
        deltaY += Math.abs(touch.y1 - touch.y2)

        /**
         * 修复 android 4.4 swipe 事件
         * https://github.com/madrobby/zepto/issues/315#issuecomment-8386027
         */
        if (touch.x2 && Math.abs(touch.x1 - touch.x2) > 10)
          e.preventDefault()
      })
      .on('touchend MSPointerUp pointerup', function(e){
        if((_isPointerType = isPointerEventType(e, 'up')) &&
          !isPrimaryTouch(e)) return
        cancelLongTap()

        // swipe
        if ((touch.x2 && Math.abs(touch.x1 - touch.x2) > 30) ||
            (touch.y2 && Math.abs(touch.y1 - touch.y2) > 30))

          swipeTimeout = setTimeout(function() {
            touch.el.trigger('swipe')
            touch.el.trigger('swipe' + (swipeDirection(touch.x1, touch.x2, touch.y1, touch.y2)))
            touch = {}
          }, 0)

        // normal tap
        else if ('last' in touch)
          // don't fire tap when delta position changed by more than 30 pixels,
          // for instance when moving to a point and back to origin
          if (deltaX < 30 && deltaY < 30) {
            // delay by one tick so we can cancel the 'tap' event if 'scroll' fires
            // ('tap' fires before 'scroll')
            tapTimeout = setTimeout(function() {

              // trigger universal 'tap' with the option to cancelTouch()
              // (cancelTouch cancels processing of single vs double taps for faster 'tap' response)
              var event = $.Event('tap')
              event.cancelTouch = cancelAll
              touch.el.trigger(event)

              // trigger double tap immediately
              if (touch.isDoubleTap) {
                if (touch.el) touch.el.trigger('doubleTap')
                touch = {}
              }

              // trigger single tap after 250ms of inactivity
              else {
                touchTimeout = setTimeout(function(){
                  touchTimeout = null
                  if (touch.el) touch.el.trigger('singleTap')
                  touch = {}
                }, 250)
              }
            }, 0)
          } else {
            touch = {}
          }
          deltaX = deltaY = 0

      })
      // when the browser window loses focus,
      // for example when a modal dialog is shown,
      // cancel all ongoing events
      .on('touchcancel MSPointerCancel pointercancel', cancelAll)

    // scrolling the window indicates intention of the user
    // to scroll, not tap or swipe, so cancel all ongoing events
    $(window).on('scroll', cancelAll)
  })

  ;['swipe', 'swipeLeft', 'swipeRight', 'swipeUp', 'swipeDown',
    'doubleTap', 'tap', 'singleTap', 'longTap'].forEach(function(eventName){
    $.fn[eventName] = function(callback){ return this.on(eventName, callback) }
  })
})($)

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


//行业 和 地区

var Tree = {};
//解析树形数据
Tree.parse = function(obj) {
	var index = {};

	var walk = function(array, p) {
		var l = array.length
		for (var i = 0; i < l; i++) {
			var item = array[i]
			if (p) {
				item.parent = p
			}
			if (item.id) {
				index[item.id] = item
			} else if (item.children && item.children.length) {
				index[item.name] = item
			}
			if (item.children && item.children.length) {
				walk(item.children, item)
			}
		}
	}
	walk(obj)

	return {
		tree: obj,
		index: index
	}
};
 
/**
 * 执行绑定方法的同时禁用当前元素，避免重复执行绑定的方法 用法类似 on 方法，在事件绑定的函数中加传了 enable 函数，用来解除禁用
 *
 * @param {String}
 *            types 事件类型
 * @param {String}
 *            [selector] 选择器
 * @param {Function}
 *            fn function(e, enable){}
 * @param {Object}
 *            [option] 可以自定义禁用和启用时的回调
 * @return {Object} jQuery Object
 * @version 0.3
 */

$.fn.ice = function(types, selector, fn, option) {
	var undef;

	if (typeof selector == 'function') {
		option = fn;
		fn = selector;
		selector = undef;
	};

	option = $.extend({
		onDisable: function() {},
		onEnable: function() {}
	}, option);

	this.on(types, selector, function(e) {
		var that = this,
			$that = $(that);

		if ($that.is('.disabled')) return false;

		$(this).addClass('disabled');
		option.onDisable.call(that, e);

		return fn.call(that, e, function() {
			$that.removeClass('disabled');
			option.onEnable.call(that, e);
		});
	});
	return this;
}; 
 
