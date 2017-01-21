KISSY.add(function(S){ 

    var $ = Zepto;

    var doc = window.document,
        id, ids = [], wrap, item;

    var LoadingClass = function() {
        this.initialize.apply(this, arguments);
    };

    LoadingClass.prototype = {

        isInAlipayNewClient: function() {
            return window.AlipayJSBridge;
        },

        initialize: function() {
            var that = this;
            that.loadingInit();
        },

        loadingInit: function() {
            //避免重复初始化
            if($('div.loading').length) return;

            wrap = document.createElement('div');
            wrap.className = 'loading';
            wrap.style.cssText = [
                'display: none', 
                'background: transparent', 
                'position: absolute',
                'width: 100%', 
                'height: 100%', 
                'left: 0', 
                'top: 0',
                'overflow: hidden', 
                'z-index: 99999'
            ].join(';');
            item = document.createElement('div');
            item.className = 'loading-inner';
            item.style.cssText = [
                'position:absolute',
                'width: 100px',
                'height: 90px',
                //'line-height: 100px',
                'line-height: 90px',
                'color: #FFF',
                'text-align: center',
                'font-size: 11px',
                'border-radius: 13px'
            ].join(';');
            wrap.appendChild(item);
            doc.body.appendChild(wrap);
        },

        _showLoading: function(text, className) {
            if(className) {
                var preClassName = $(wrap).attr('data-classname');

                if(preClassName) {
                    $(wrap).removeClass(preClassName);
                }

                $(wrap).addClass(className);
                $(wrap).attr('data-classname', className);
            }

            if (text) {
                item.innerHTML = text;

                if (wrap.style.display !== 'block') {
                    wrap.style.display = 'block';
                    wrap.style.height = document.body.scrollTop + window.innerHeight + 'px';
                    var bodyRect = document.body.getBoundingClientRect();
                    var spanRect = item.getBoundingClientRect();
                    var zIndex = item.style.zIndex;
                    // item.style.left = (bodyRect.width - spanRect.width) / 2 + 'px';
                    // item.style.top = ((window.innerHeight - spanRect.height) / 2 - bodyRect.top) - 3 + 'px';
                    item.style.position = 'fixed';
                    item.style.left = '50%';
                    item.style.top = '50%';
                    item.style.marginLeft = -spanRect.width / 2 + 'px';
                    item.style.marginTop = -spanRect.height / 2 + 'px';

                    // hack for GT-I9000, fuck I9000, #744645
                    item.style.zIndex = 99999;
                    setTimeout(function() {
                        item.style.zIndex = zIndex;
                    }, 0);
                }
            }

            var now = Date.now();
            ids.push(now);
            return now;
        },

        show: function(text, className,type) {

            if(this.isInAlipayNewClient()) {
                AlipayJSBridge.call('showLoading', {
                    // text: '',
                    delay: 200
                });
                return;
            }

            // text = text || '<div class="trip-loading"></div><div class="trip-loading-text">正在加载...</div>';
            if(type && type == 1){
                text =  '<div class="trip-xb-loading"></div><div class="trip-xb-loading-text">' + (text || '<i>100%</i>出票保证') + '</div>';
            }else{
                text = '<div class="trip-loading"></div><div class="trip-loading-text">' + (text || '正在加载...') + '</div>';
            }

            this._showLoading(text, className);
        },

        hide: function(_id) {

            if(this.isInAlipayNewClient()) {
                AlipayJSBridge.call('hideLoading');
                return;
            }

            if (_id) {
                ids.splice(ids.indexOf(_id), 1);
            } else {
                ids = [];
            }

            if (ids.length === 0) {
                item.innerHTML = '';
                wrap.style.display = 'none';
            }
        }
    };

    return LoadingClass;

});
