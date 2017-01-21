/**
 * @fileoverview H5FlightTrends - Detail.
 * @author 
 */
/**
 * KISSY.use('h5-flight-trends/pages/detail/index',function(S,Detail){
 *		new Detail();
 * });
 */
KISSY.add(function(S,Base,Juicer,IATACity,Tracker,Notification,Mask) {

	var Detail = Base.extend({
		initializer:function(){
			var that  = this;

            that.attrInit();
            that.componentInit();
            that.helperRegister();
            that.renderDetail();
            that.bindEvent();

            if(notAssistant && notAssistant == 'false'){
                //页面埋点
                that.sendPoint('Page','FlightOrderAssistant');
            }else{
                //页面埋点
                that.sendPoint('Page','FlightBoardDetail');
            }
		},
        attrInit: function () {
            var that = this;

            that.nodes = {};
            that.nodes.wrapper = S.one('.detail-page');
            that.nodes.followBtn = S.one('.J_followBtn');
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
                }else if(pstatus == '暂无'){
                    return 'unavail';
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
        isSubscribe:function(item){
            if(followedList && followedList.length > 0){
                for(var i = 0; i < followedList.length; i++){
                    if( followedList[i].pdate1 == item.pdate1 && followedList[i].pflycode == item.pflycode
                            && followedList[i].pcity1 == item.pairport1 && followedList[i].pcity2 == item.pairport2)
                        $('#J_followBtn').html('取消关注');
                }
            }
        },
        renderDetail:function(){
			if(detailData && detailData != '' && detailData.pflystatus && detailData.pflystatus.length > 0){
                var that = this;
                var data = detailData.pflystatus[0]
                data = that.processData(data);
				var tpl1 = S.one('#J_info_main_tpl').html().trim();
				var html1 = Juicer(tpl1,data);
				S.one('.info-main').html(html1);

				var tpl2 = S.one('#J_info_detail_tpl').html().trim();
				var html2 = Juicer(tpl2,data);
				S.one('.info-detail').html(html2);
                if(followedNum != 0){
                    $('.followed-tip').html('亲！你已关注了'+followedNum+'条航班信息, 还可以关注'+(followedNum>5 ? 0 : (5-followedNum))+'条');
                }
				S.one('.main').addClass('show').removeClass('hide');
				S.one('.loading-failed-tips').addClass('hide').removeClass('show');
                //判断是否已订阅
                that.isSubscribe(data);
			}else{
				S.one('.main').addClass('hide').removeClass('show');
				S.one('.loading-failed-tips').addClass('show').removeClass('hide');
			}
        },
        processData:function(data){
            if((!data.prealtime1 || data.prealtime1 == '--') && data.pstatus != '取消'){
				//ptd为预计出发时间
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
        bindEvent:function(){
            var that = this;

            //进入机场详情页
            that.nodes.wrapper.on('click','.c-city',function(e){
                if(notAssistant && notAssistant == 'false'){
                    //页面埋点
                    that.sendPoint('Button','SingleFlightOrderAssistant','Airport');
                }else{
                    //页面埋点
                    that.sendPoint('Button','FlightBoardDetail','Airport');
                }
				if(userAgent == 'iphone'){
					window.location.href = 'umesdk://flightstatus.airport?code='+$(e.target).find(".port-code").html();
				}
				else if(userAgent == 'android'){
                    window.umesdk.goAirport($(e.target).find(".port-code").html());
				}
            });

            if(detailData && detailData.pflystatus[0]){
                //到达或取消航班不可关注，若已关注，不disable按钮
                if(followedNum >= 5 && $('#J_followBtn').html() == '关注航班') {
                    S.one('.btn-wrap').addClass('disabled');
                }
                else if((detailData.pflystatus[0].pstatus == '到达' || detailData.pflystatus[0].pstatus == '取消') && $('#J_followBtn').html() == '关注航班'){
                    S.one('.btn-wrap').addClass('hide');
                    S.one('.followed-tip').addClass('hide');
                }
                //subscribe
                else{
                    that.nodes.wrapper.on('click','#J_followBtn',function(e){
                        //防止连击，判断时间戳，小于1s不响应
                        if(that.preClick && detail.preClick != 0){
                            var time  = new Date().getTime();
                            if(time - that.preClick < 1000){
                                that.preClick = 0;
                                return;
                            }
                            else{
                                that.preClick = 0;
                            }
                        }else{
                            that.preClick = new Date().getTime();
                        }
                        var text = $(e.target).html();
                        if(text == '关注航班'){

                            that.sendPoint('Button','FlightBoardDetail','Follow');

                            if(userAgent == 'iphone'){
                                window.location.href = 'umesdk://flightstatus.subscribe/subscribe';
                            }
                            else if(userAgent == 'android'){
                                window.umesdk.attentionService();
                            }
                        }
                        else{
                            that.sendPoint('Button','FlightBoardDetail','Unfollow');
                            Notification.confirm('亲,取消关注将不再接收此航班动态变化的即时信息', null, function(e, type){
                                if(type == 1){
//                                        target.html('关注航班');
                                    if(userAgent == 'iphone'){
                                        window.location.href = 'umesdk://flightstatus.subscribe/cancelSubscribe';
                                    }
                                    else if(userAgent == 'android'){
                                        window.umesdk.cancleAttentionService();
                                    }
                                }
                                this.hide();
                                that.maskObj.hide();
                            }).show();
                            that.maskObj.show();
                        }
                    });
                }
            }
        },
        changeSubState: function(type, result){
            if(result == '1'){
                //成功取消关注的已到达或取消航班，隐藏关注按钮
                if(type == 'cancelSubscribe' && detailData && detailData != '' && detailData.pflystatus && (detailData.pflystatus[0].pstatus == '到达' || detailData.pflystatus[0].pstatus == '取消')) {
                    S.one('.btn-wrap').addClass('hide');
                    S.one('.followed-tip').addClass('hide');
                }
                if(type == 'subscribe'){
                    $('#J_followBtn').html('取消关注');
                    followedNum = followedNum + 1;
                    Notification.simple('关注成功',2000);
                }else{
                    $('#J_followBtn').html('关注航班');
                    followedNum = followedNum - 1;
                }
                $('.followed-tip').html('亲！你已关注了'+followedNum+'条航班信息, 还可以关注'+(5-followedNum)+'条');
            }
            else if(result == '-2'){
                Notification.simple('亲，您已关注过此航班',2000);
                $('#J_followBtn').html('取消关注');
                followedNum = followedNum + 1;
                $('.followed-tip').html('亲！你已关注了'+followedNum+'条航班信息, 还可以关注'+(5-followedNum)+'条');
            }
            else{
                Notification.simple('亲，'+ (type == 'subscribe'? '关注':'取消关注') +'失败，请稍后再试',2000);
            }
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
            pflystatus:{
				value:{}
			}
		}
	});

	return Detail;
	
},{
	requires:['base','juicer','../../datas/iata-city','../../widgets/libs/tracker','../../widgets/libs/notification','../../widgets/mask/index']
});
