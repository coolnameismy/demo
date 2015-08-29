/**
 *   Unslider by @idiot and @damirfoy
 *   Contributors:
 *   - @ShamoX
 *
 */

(function($, f) {
    var Unslider = function() {
        //  复制对象
        var _ = this;

        //设置unslider对象

        _.o = {
            speed: 500,     // 切换时候的运动速度,false是不进行切换 (integer or boolean)
            delay: 3000,    // 切换的时间间隔，false是不自动切换 (integer or boolean)
            init: 0,        // 初始化时候的延迟，false为不延迟 (integer or boolean)
            pause: !f,      // 鼠标移上去的时候是否需要暂停切换 默认值是yes(boolean)
            loop: !f,       // 是否循环切换 (boolean)
            keys: f,        // 快捷键 (boolean)
            dots: f,        // 是否显现 可以切换的控制点  (boolean)
            arrows: f,      // 是否显现 上一页下一页的箭头 (boolean)
            prev: '&larr;', // 上一页按钮的文字 (string)
            next: '&rarr;', // 下一页按钮的文字
            fluid: f,       // 是否是一个百分比的宽度（boolean)
            starting: f,    // 开始切换时的回叫函数 (function)
            complete: f,    // 切换完成时候的回叫函数 (function)
            items: '>ul',   // slides jquery选择容器的标签
            item: '>li',    // slides items 选择容器的标签
            easing: 'swing',// 动画运动的方式    swing 或者linear，这个是由jquery $(selector).animate(styles,speed,easing,callback) 方法提供的参数。
            autoplay: true  // 自动播放
        };

        _.init = function(el, o) {
            //  把用户自定义的参数传递给o
            _.o = $.extend(_.o, o);

            _.el = el;//元素
            _.ul = el.find(_.o.items);//slider的容器
            _.max = [el.outerWidth() | 0, el.outerHeight() | 0];
            //这里是检查li的宽高校正，li的宽高如果大于容器的宽高，会把容器最大的宽高赋给li
            _.li = _.ul.find(_.o.item).each(function(index) {
                var me = $(this),
                    width = me.outerWidth(),
                    height = me.outerHeight();

                //  Set the max values
                if (width > _.max[0]) _.max[0] = width;
                if (height > _.max[1]) _.max[1] = height;
            });


            //  存储变量
            var o = _.o,
                ul = _.ul,
                li = _.li,
                len = li.length;

            // 当前的index
            _.i = 0;

            //容器元素设置样式
            el.css({width: _.max[0], height: li.first().outerHeight(), overflow: 'hidden'});

            // 设置li宽度
            ul.css({position: 'relative', left: 0, width: (len * 100) + '%'});
            if(o.fluid) {
                li.css({'float': 'left', width: (100 / len) + '%'});
            } else {
                li.css({'float': 'left', width: (_.max[0]) + 'px'});
            }

            //  自动播放
            o.autoplay && setTimeout(function() {
                if (o.delay | 0) {
                    _.play();

                    if (o.pause) {
                        el.on('mouseover mouseout', function(e) {
                            _.stop();
                            e.type === 'mouseout' && _.play();
                        });
                    };
                };
            }, o.init | 0);

            //  定义快捷键操作
            if (o.keys) {
                $(document).keydown(function(e) {
                    switch(e.which) {
                        case 37:
                            _.prev(); // Left
                            break;
                        case 39:
                            _.next(); // Right
                            break;
                        case 27:
                            _.stop(); // Esc
                            break;
                    };
                });
            };

            //  是否构造dot
            o.dots && nav('dot');

            //  是否构造左右切换箭头
            o.arrows && nav('arrow');

            // 解决自适应 当屏幕大小变化时，重新调整容器的宽度和高度
            o.fluid && $(window).resize(function() {
                _.r && clearTimeout(_.r);

                _.r = setTimeout(function() {
                    var styl = {height: li.eq(_.i).outerHeight()},
                        width = el.outerWidth();

                    ul.css(styl);
                    styl['width'] = Math.min(Math.round((width / el.parent().width()) * 100), 100) + '%';
                    el.css(styl);
                    li.css({ width: width + 'px' });
                }, 50);
            }).resize();

            //  对触摸屏手势滑动的支持，必须添加jquery.event.swipe.js才可以使用。
            if ($.event.special['move'] || $.Event('move')) {
                el.on('movestart', function(e) {
                    if ((e.distX > e.distY && e.distX < -e.distY) || (e.distX < e.distY && e.distX > -e.distY)) {
                        e.preventDefault();
                    }else{
                        el.data("left", _.ul.offset().left / el.width() * 100);
                    }
                }).on('move', function(e) {
                    var left = 100 * e.distX / el.width();
                    var leftDelta = 100 * e.deltaX / el.width();
                    _.ul[0].style.left = parseInt(_.ul[0].style.left.replace("%", ""))+leftDelta+"%";

                    _.ul.data("left", left);
                }).on('moveend', function(e) {
                    var left = _.ul.data("left");
                    if (Math.abs(left) > 30){
                        var i = left > 0 ? _.i-1 : _.i+1;
                        if (i < 0 || i >= len) i = _.i;
                        _.to(i);
                    }else{
                        _.to(_.i);
                    }
                });
            };

            return _;
        };

        //  核心方法，切换方法
        _.to = function(index, callback) {
            if (_.t) {
                _.stop();
                _.play();
            }
            var o = _.o,
                el = _.el,
                ul = _.ul,
                li = _.li,
                current = _.i,
                target = li.eq(index);

            $.isFunction(o.starting) && !callback && o.starting(el, li.eq(current));

            if ((!target.length || index < 0) && o.loop === f) return;

            //  Check if it's out of bounds
            if (!target.length) index = 0;
            if (index < 0) index = li.length - 1;
            target = li.eq(index);

            var speed = callback ? 5 : o.speed | 0,
                easing = o.easing,
                obj = {height: target.outerHeight()};

            if (!ul.queue('fx').length) {
                //  Handle those pesky dots
                el.find('.dot').eq(index).addClass('active').siblings().removeClass('active');

                el.animate(obj, speed, easing) && ul.animate($.extend({left: '-' + index + '00%'}, obj), speed, easing, function(data) {
                    _.i = index;
                    $.isFunction(o.complete) && !callback && o.complete(el, target);
                });
            };
        };

        // 自动播放
        _.play = function() {
            _.t = setInterval(function() {
                _.to(_.i + 1);
            }, _.o.delay | 0);
        };

        // 停止自动播放
        _.stop = function() {
            _.t = clearInterval(_.t);
            return _;
        };

        //立刻切换下一张
        _.next = function() {
            return _.stop().to(_.i + 1);
        };

        //回到上一张
        _.prev = function() {
            return _.stop().to(_.i - 1);
        };

        //创建导航点 和左右切换箭头
        function nav(name, html) {
            if (name == 'dot') {
                html = '<ol class="dots">';
                $.each(_.li, function(index) {
                    html += '<li class="' + (index === _.i ? name + ' active' : name) + '">' + ++index + '</li>';
                });
                html += '</ol>';
            } else {
                html = '<div class="';
                html = html + name + 's">' + html + name + ' prev">' + _.o.prev + '</div>' + html + name + ' next">' + _.o.next + '</div></div>';
            };

            _.el.addClass('has-' + name + 's').append(html).find('.' + name).click(function() {
                var me = $(this);
                me.hasClass('dot') ? _.stop().to(me.index()) : me.hasClass('prev') ? _.prev() : _.next();
            });
        };
    };

    // 扩展jquery方法。
    $.fn.unslider = function(o) {
        var len = this.length;

        //  Enable multiple-slider support
        return this.each(function(index) {
            //  Cache a copy of $(this), so it
            var me = $(this),
                key = 'unslider' + (len > 1 ? '-' + ++index : ''),
                instance = (new Unslider).init(me, o);

            //  Invoke an Unslider instance
            me.data(key, instance).data('key', key);
        });
    };

    Unslider.version = "1.0.0";
})(jQuery, false);