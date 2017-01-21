/**
 * @fileoverview H5FlightTrends - List.
 * @author 
 */
/**
 * KISSY.use('h5-flight-trends/pages/list/index',function(S,List){
 *		new List();
 * });
 */
KISSY.add(function(S,Base,IATACity,Juicer,iScroll,Tracker) {

	var List = Base.extend({
		initializer:function(){
			var that = this;

            that.attrInit();
            that.componentInit();
            that.helperRegister();
            that.renderList();
            that.bindEvent();

		},
        attrInit: function () {
            var that = this;

            that.nodes = {};
            that.nodes.wrapper = S.one('.list-page');
            that.nodes.flightListBox = S.one('.J_listBox');
			that.nodes.flightList = $('.flight-list');
            that.nodes.flightListWrap = $('#J_list');
            that.pullDownNode = $('.J_pullDown');
            that.pullUpNode = $('.J_pullUp');
			that.loadingFailNode = $('.loading-failed-tips');
        },
        componentInit: function() {
            var that = this;

        },
        helperRegister : function() {
            var that = this;

            Juicer.register('getClassNameByStatus', function(pstatus) {
                if(pstatus == '到达'){
                    return 'arrive';
                }else if(pstatus == '起飞'){
                    return 'takeoff';
                }else if(pstatus == '延误'){
                    return 'delay';
                }else if(pstatus == '计划'){
                    return 'plan';
                }else if(pstatus == '取消'){
                    return 'cancel';
                }else if(pstatus == '备降'){
                    return 'ready';
                }else if(pstatus == '返航'){
                    return 'return';
                }
            });
            Juicer.register('getAirportByCode', function(airport) {
                return IATACity[airport];
            });
        },
        getDay:function(date){
            var d = new Date(date.replace(new RegExp("-","g"),'/'));
            var day = d.getDay();
            var upper = ['日','一','二','三','四','五','六'];
            return '周'+upper[day];
        },
        renderList:function(){
            if(data && data != '' && (data.length > 0 || (data.pcont && data.pcont.length > 0))){
                var that = this;
                var tpl = $('#J_list_tpl').html().trim();
                var compiled_tpl = juicer(tpl);
                that.compiled_tpl = compiled_tpl;
                var html = "";
                if(isMult == '0'){
                    that.sendPoint('Page','SearchResultPlace'); // 按照起降地查询的页面埋点
                    $.each(data.pcont, function(){
                        that.showFollowedList(this);
                    });
                    html = that.compiled_tpl.render(data.pcont);
                }
                else{
                    that.sendPoint('Page','SearchResultNum'); // 按照航班号查询的页面埋点
                    $.each(data, function(){
                        that.showFollowedList(this);
                    });
                    html = that.compiled_tpl.render(data);
                }
                that.nodes.flightList.html(html);

                if(isMult == '0'){
                    that.initiScroll();
                    $('body').append('<style type="text/css">.mod-place{display: none}</style>');
                }
                else{
                    $('body').append('<style type="text/css">.mod-place{display: block}</style>');
                }
            }else{
                //S.one('.main').addClass('hide').removeClass('show');
                S.one('#J_list').addClass('hide').removeClass('show');
                S.one('.loading-failed-tips').addClass('show').removeClass('hide');
            }
        },
		showFollowedList:function(item){
			if(followedList && followedList.length > 0){
				for(var i = 0; i < followedList.length; i++){
					//多段和城市对日期不一样
					if((flightDate && followedList[i].pdate1 == flightDate)
						|| (item.pdate1 && followedList[i].pdate1 == item.pdate1)){
						if(followedList[i].pflycode == item.pflycode 
							&& followedList[i].pcity1 == item.pairport1 && followedList[i].pcity2 == item.pairport2)
							item.followed = "followed";
					}
				}
			}
		},
		//show next page, only search by cities use
		renderNextPage:function(){
            var that = this;
			$.each(data.pcont, function(){
				that.showFollowedList(this);
			});
			var html = that.compiled_tpl.render(data.pcont);

            that.nodes.flightList.append(html);

			//隐藏loading图标
			that.pullUpNode.attr('class', 'J_pullUp iscroll-tip hidden');
			that.iScroll.refresh();
        },
		//show previous page
		renderPrevPage:function(){
            var that = this;
			$.each(data.pcont, function(){
				that.showFollowedList(this);
			});
			var html = that.compiled_tpl.render(data.pcont);

			
			var beforeHtml = that.nodes.flightList.html();
			that.nodes.flightList.html(html+beforeHtml);

			//隐藏loading图标
			that.pullDownNode.attr('class', 'J_pullDown iscroll-tip hidden iscroll-pull-down');
            that.iScroll.refresh();
        },

        //初始化滚动
        initiScroll: function(){
            var that = this;

            if (that.iScroll) {
                that.iScroll.refresh();
                return;
            }

            setTimeout(function(){
                that.iScroll = new iScroll(that.nodes.flightListWrap.get(0), {
                    useTransition: true,

                    onBeforeScrollStart: function(e){
                        e.preventDefault();
                    },
                    onScrollMove: function () {

                        if(this.y > 10){
                            that.pullDownNode.removeClass('hidden');
                            that.pullDownNode.find('span').html(that.get('message').upText);
                        }

                        if (this.y > 55 && that.pullDownNode.hasClass('iscroll-pull-down')) {  //如果是下拉，则换成松开刷新
                            that.pullDownNode.addClass('rotate');
                            that.pullDownNode.find('span').html(that.get('message').releaseText);
                            this.minScrollY = 0;
                        }  else if (this.y < 0 && this.y < (this.maxScrollY - 5) && !that.pullUpNode.hasClass('iscroll-loading') && that.hasNextPage) {
                            that.pullUpNode.attr('class', 'J_pullUp iscroll-tip iscroll-loading');
                            this.maxScrollY = this.maxScrollY;
                            that.iScroll.refresh();
                        }
                    },
                    onScrollEnd: function () {
                        if (that.pullDownNode.hasClass('rotate')) {
                            that.pullDownNode.attr('class', 'J_pullDown iscroll-tip iscroll-loading');
                            that.pullDownNode.find('span').html(that.get('message').loading);
                            that.getPrevPage();
                        } else if (that.pullUpNode.hasClass('iscroll-loading')) {
                            that.getNextPage();
                        }
                    }
                });
            },50);
        },
        hasNextPage:function(){
            if(pageEnd < data.pageSize){
                return true;
            }else{
                return false;
            }
        },
        getPrevPage:function(){
            var that = this;
            //var d = that.data;
            if(pageBegin >1){
                //请求上一页数据
               //console.log('请求上一页数据');
               pageBegin--;
			   if(userAgent == 'iphone'){
				   //that.renderPrevPage();
				   window.location.href = 'umesdk://flightstatus.search/byArea?page='+(pageBegin);
			   }
			   else if(userAgent == 'android'){
                   window.umesdk.service(pageBegin,1);
			   }
            }else{
                that._resetScrollTips()
            }

        },
        getNextPage:function(){
            var that = this;

            //var d = that.data;
            if(pageEnd >= data.pageSize){
                that._showNomore();
            }else{
                //请求下一页数据
                //console.log('请求下一页数据');
                pageEnd++;
				if(userAgent == 'iphone'){
				   window.location.href = 'umesdk://flightstatus.search/byArea?page='+(pageEnd);
				}
			    else if(userAgent == 'android'){
                    window.umesdk.service(pageEnd,0);
				}
				//that.renderNextPage();
            }

        },
        _showNomore: function(){
            var that = this;

            if(that.pullUpNode.hasClass('hidden')) return;

            that.pullUpNode.find('span').html(that.get('message').allBack);
            that.pullUpNode.removeClass('iscroll-loading');
            that.iScroll.refresh();
        },
        _resetScrollTips: function(notResetDown, notResetUp){
            var that = this;

            setTimeout(function(){
                if(!notResetDown){
                    that.pullDownNode.attr('class', 'J_pullDown iscroll-tip hidden iscroll-pull-down');
                    that.pullDownNode.find('span').html(that.get('message').upText);
                }

                if(!notResetUp){
                    that.pullUpNode.attr('class', 'J_pullUp  iscroll-tip hidden');
                    that.pullUpNode.find('span').html(that.get('message').loadingMore);
                }
            },300)
        },
        pageGoto:function(href){
            var that = this;

            if(!(/(waptest\.taobao|wapa.taobao|daily.taobao.net|m.taobao)/).test(location.host)){
                href = href +'&ks-debug';
            }

            location.href = href;
        },
        bindEvent :function(){
            var that = this;
            //点击某个航班
            that.nodes.flightListWrap.on('click','.flight-item',function(){
                var target = S.one(this);
				if(userAgent == 'iphone'){
				   window.location.href = "umesdk://flightstatus.search/byFlightNo?flightno="+$(target[0]).find(".no").html()+"&dep="+$(target[0]).find(".dep-port-code").html()+"&arr="+$(target[0]).find(".arr-port-code").html()+"&airline="+$(target[0]).find(".airline").html();
				}
			    else if(userAgent == 'android'){
                    window.umesdk.go($(target[0]).find(".no").html(), $(target[0]).find(".dep-port-code").html(), $(target[0]).find(".arr-port-code").html());
				}
            });
            $('.flight-item').on('touchstart',function(e){
                var target = S.one(this);
                target.addClass('click');
            }).on('touchend',function(e){
                    var target = S.one(this);
                    target.removeClass('click');
            });
        },
        getRequestParam: function(param, uri) {
            var value;
            uri = uri || window.location.href;
            value = uri.match(new RegExp('[\?\&]' + param + '=([^\&\#]*)([\&\#]?)', 'i'));
            return value ? decodeURIComponent(value[1]) : value;
        },
        sendPoint: function(type, page, action) {
            Tracker.sendPoint({
                eid: 9199,
                page: page,
                type: type,
                action: action
            });
        }
	},{
		ATTRS: {
            message: {
                value: {
                    noResult: '亲，你还没有任何订单哦',
                    failure: '亲，网络开小差，读取数据失败<div class="refresh-list J_RefreshBtn">刷新</div>',
                    loading: '正在载入...',
                    releaseText: '松开查看当天更多历史航班',
                    upText: '下拉查看当天更多历史航班',
                    loadingMore: '加载更多...',
                    allBack: '亲，只有这么多了'
                }
            }
		}
	});

	return List;
	
},{
	requires:['base','../../datas/iata-city','juicer','iscroll-lite','../../widgets/libs/tracker']
});
