/**
 * @fileoverview H5FlightTrends - Search.
 * @author
 */
/**
 * KISSY.use('h5-flight-trends/pages/search/index',function(S,Search){
 *		new Search();
 * });
 */
KISSY.add(function(S,Base,Juicer,Slider,Notification,Mask,Tracker) {

    var Search = Base.extend({
        initializer:function(){
            var that = this;

            that.attrInit();
            that.componentInit();
            that.helperRegister();
            that.renderCardList();
            that.bindEvent();

        },
        attrInit: function () {
            var that = this;

            that.nodes = {};
            that.nodes.wrapper = $('.search-page');
            that.nodes.searchWrap = $('.J_Search');
            that.nodes.cardWrap = $('#card-slide');
            that.nodes.default = $('.default');
            that.nodes.flightCard = $('.flight-card');
            that.nodes.cardStatus = $('.slide-status');
            that.nodes.cardList = $('.card-list');
        },
        componentInit: function() {
            var that = this;

            that.maskObj = new Mask({
                clickHide  : false,
                opacity:0.5,
                disableScroll:false,
                useAnim:false
            }).render();
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
                }else if(pstatus == '暂无'){
                    return 'unavail';
                }
            });
            Juicer.register('getAirportByCode', function(airport) {
                return IATACity[airport];
            });
			Juicer.register('getDay', function(date){
				var d = new Date(date.replace(new RegExp("-","g"),'/'));
				var day = d.getDay();
				var upper = ['日','一','二','三','四','五','六'];
				return '周'+upper[day];
			});
		},
        renderCardList:function(){
            var that = this;

            if(followedList && data && data.length >0){
                if(notAssistant && notAssistant == 'false'){
                    //页面埋点
                    that.sendPoint('Page','RoundFlightOrderAssistant');
                }else{
                    //页面埋点
                    that.sendPoint('Page','FlightBoardFollowed');
                }

                that.nodes.default.addClass('hide');
                that.nodes.flightCard.removeClass('hide');

                var tpl1 = $('#J_card_status_tpl').html().trim();
                var tpl2 = $('#J_card_list_tpl').html().trim();
                var tpl3 = $('#J_card_item_tpl').html().trim();
				that.compiled_tpl_status = juicer(tpl1);
                that.compiled_tpl_list = juicer(tpl2)
                that.compiled_tpl_item = juicer(tpl3);
                var temp = data[0];
                for(var i = 1; i < followedList.length; i++){
                    data[i] = temp;
                }
                var html1 = that.compiled_tpl_status.render(data);
                that.nodes.cardStatus.html(html1);
                data[0] = that.processData(data[0]);
                var html2 = that.compiled_tpl_list.render(data);
                that.nodes.cardList.html(html2);

                that.initCardSlide();
                //每隔1s请求下一个关注航班详情
                for(var i = 1; i < followedList.length; i++){
                    setTimeout((function(k){
                        return function(){
                            if(userAgent == 'iphone'){
                                window.location.href = 'umesdk://flightstatus.subscribe/refresh?index='+k+'&init=1';
                            }
                            else if(userAgent == 'android'){
                                window.umesdk.refreshBg(k);
                            }
                        };
                    })(i),1000*i);
                }
//                that.nodes.default.addClass('hide');
            }else{
                if(notAssistant && notAssistant == 'false'){
                    //页面埋点
                    that.sendPoint('Page','RoundFlightOrderAssistant');
                }else{
                    //页面埋点
                    that.sendPoint('Page','FightBoardUnfollow');
                }
					
                that.nodes.default.removeClass('hide');
                that.nodes.flightCard.addClass('hide');
            }
        },
		refreshPage:function(){
			var that = this;
            if(data && data.length > 0 && data[0]){
                data[0] = that.processData(data[0]);
                var html = that.compiled_tpl_item.render(data[0]);
                $(S.all('.card-item')[index]).html(html);
            }
		},
        processData:function(data){
            if((!data.prealtime1 || data.prealtime1 == '--') && data.pstatus != '取消'){
                data.prealtime1 = data.ptd;
                if(data.pplantime1 == '--'){
                    data.prealtime1 = '--:--'
                }
                data.prealtimetext1 = '预计出发';
            }
            else{
                if(data.prealtime1 == '--'){
                    data.prealtime1 = '--:--'
                }
                data.prealtimetext1 = '实际出发';
            }
            if(( !data.prealtime2 || data.prealtime2 == '--') && data.pstatus != '取消'){
                data.prealtime2 = data.pta;
                if(data.pplantime2 == '--'){
                    data.prealtime2 = '--:--'
                }
                data.prealtimetext2 = '预计到达';
            }
            else{
                if(data.prealtime2 == '--'){
                    data.prealtime2 = '--:--'
                }
                data.prealtimetext2 = '实际到达';
            }
            if(data.pterminal1 == ''){
                data.pterminal1 = '--';
            }
            if(data.pterminal2 == ''){
                data.pterminal2 = '--';
            }
            //若有值机信息，优先显示值机信息，再显示时间差
            if(data.ckiStatus && data.ckiStatus != ''){
                data.offTimeDesc = data.ckiStatus;
            }
            return data;
        },
        changeSubState: function(type, result){
            var that = this;
            if(result == '1' && that.deleteItemNode){
                that.deleteItemNode.remove();
                var nodeArr = S.all('.slide-status i');
                S.each(nodeArr,function(o,i){
                    if(S.one(o).hasClass('sel')){
                        S.one(o).remove();
                    };
                });

                that.cardSlide.destroy();
                that.initCardSlide();

                if(S.one('.slide-status i')){
                    S.one('.slide-status i').addClass('sel');
                }

                that.cardNumDetect();//检测卡片数量以确定显示逻辑
            }
            else if(result == '-2'){
                Notification.simple('亲，您已关注过此航班',2000);
            }
            else{
                Notification.simple('亲，取消关注失败，请稍后再试',2000);
            }
        },
        initCardSlide:function(){
            var that = this;

            that.cardSlide= new Slider('#card-slide', {
                trigger: '.slide-status',
                lazyIndex: 1,
                duration: 300,
                useTransform: true
            });

        },

        getRequestParam: function(param, uri) {
            var value;
            uri = uri || window.location.href;
            value = uri.match(new RegExp('[\?\&]' + param + '=([^\&\#]*)([\&\#]?)', 'i'));
            return value ? decodeURIComponent(value[1]) : value;
        },

        pageGoto: function(href) {
            var that = this;

            if(!(/(waptest\.taobao|wapa.taobao|daily.taobao.net|m.taobao)/).test(location.host)){
                href = href +'&ks-debug';
            }

            window.location.href = href;
        },
        deleteFlight:function(){
            var that = this;

			if(userAgent == 'iphone'){
				window.location.href = 'umesdk://flightstatus.subscribe/cancelSubscribe?index='+that.cardSlide.curIndex;
			}
			else if(userAgent == 'android'){
                window.umesdk.cancleAttentionService(that.cardSlide.curIndex);
			}
        },
        cardNumDetect:function(){
            var that = this;

            var cardNodeArr = S.all('.card-item');
            if(cardNodeArr.length < 1){
                that.nodes.default.removeClass('hide');
                that.nodes.flightCard.addClass('hide');
            }else{
                that.nodes.default.addClass('hide');
                that.nodes.flightCard.removeClass('hide');
            }
        },
        bindEvent:function(){
            var that = this;


            //进入机场详情页
            that.nodes.flightCard.on('click','.c-city',function(e){
                if(notAssistant && notAssistant == 'false'){
                    //页面埋点
                    that.sendPoint('Button','RoundFlightOrderAssistant','Airport');
                }else{
                    //页面埋点
                    that.sendPoint('Button','FlightBoardFollowed','Airport');
                }
				if(userAgent == 'iphone'){
					window.location.href = 'umesdk://flightstatus.airport?code='+$(e.target).find(".port-code").html();
				}
				else if(userAgent == 'android'){
                    window.umesdk.goAirport($(e.target).find(".port-code").html());
				}
            });

            //二态
            that.nodes.flightCard.on('touchstart','.refreshBtn',function(e){
                $(e.currentTarget).addClass('on');
            });
            that.nodes.flightCard.on('touchend','.refreshBtn',function(e){
                $(e.currentTarget).removeClass('on');
            });
            that.nodes.flightCard.on('touchstart','.deleteBtn',function(e){
                $(e.currentTarget).addClass('on');
            });
            that.nodes.flightCard.on('touchend','.deleteBtn',function(e){
                $(e.currentTarget).removeClass('on');
            });
            that.nodes.flightCard.on('click','.refreshBtn',function(e){
				that.sendPoint('Button','FlightBoardFollowed','Refresh');

                var target = S.one(e.currentTarget);
                var parentNode = target.parent('.card-item');
				var flightNumber = $(parentNode[0]).find(".title").html();
				var departure = $(parentNode[0]).find(".dep-port-code").html();
				var arrival = $(parentNode[0]).find(".arr-port-code").html();
				//that.cardSlide.curIndex;当前显示序号
				if(userAgent == 'iphone'){
					window.location.href = 'umesdk://flightstatus.subscribe/refresh?index='+that.cardSlide.curIndex+'&init=0';
				}
				else if(userAgent == 'android'){
                    window.umesdk.refresh(that.cardSlide.curIndex);
				}
            });
            that.nodes.flightCard.on('click','.deleteBtn',function(e){
				that.sendPoint('Button','FlightBoardFollowed','Cancel');

                var target = S.one(e.currentTarget);
                Notification.confirm('亲,取消关注将不再接收此航班动态变化的即时信息', null, function(e, type){
                    if(type == 1){
                        //deleteItemNode-删除航班节点
                        that.deleteItemNode = target.parent('.card-item');
                        that.deleteFlight();
                    }

                    this.hide();
                    that.maskObj.hide();
                }).show();
                that.maskObj.show();
            });

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
            defaultCity:{
                value : {
                    'depCity': '北京',
                    'arrCity': '杭州'
                }
            },
            pflystatus:{
				value:{}
			}
        }
    });

    return Search;

},{
    requires:['base','juicer','../../widgets/libs/slider','../../widgets/libs/notification','../../widgets/mask/index','../../widgets/libs/tracker']
});