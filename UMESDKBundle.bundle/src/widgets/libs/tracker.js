/**
 * @description tracker
 * @author yingyi.zj@taobao.com
 * */
KISSY.add(function (S, Aplus) {

    var windVaneURL = "http://g.tbcdn.cn/mtb/lib-windvane/1.2.4/??bridge.js,api.js";
    var aliTripBridgeURL = "http://g.tbcdn.cn/mpi/bridge/index-min.js";
    var gettingScript = false;
    var queue = [];
    //判断容器是否为主淘
    var isWindVane = (/WindVane/i).test(window.navigator.userAgent);
    var isAliTrip = (/AliTrip/i).test(window.navigator.userAgent);
    var aliTripBridgeInstance;

    /**
     * 主淘埋点 wiki http://gitlab.alibaba-inc.com/mtb/lib-windvane/tree/master/
     * demo http://mikkoq.3322.org/security.html
     * [string] eid 事件ID，使用选择沟通，请联系颜垣确认
     * [string] a1:数据埋点参数1，含义自定义，默认含义为活动/页面名称
     * [string] a2:数据埋点参数2，含义自定义，默认含义为控件名称
     * [string] a3:数据埋点参数3，含义自定义，默认含义为行为名称
     */
    function plusUT (option, success, failure) {

        if ((!window.WindVane || !window.WindVane.api || !window.WindVane.api.base) && !gettingScript) {
            S.getScript(windVaneURL, {
                success : function () {
                    gettingScript = false;
                    while (queue.length > 0) {
                        window.WindVane.api.base.plusUT.apply(this, queue.shift());
                    }
                },
                error   : function () {
                    gettingScript = false;
                }
            });
            queue.push([success, failure, option]);
            gettingScript = true;
            return;
        }

        if (gettingScript) {
            queue.push([success, failure, option]);
            return;
        }

        window.WindVane.api.base.plusUT(option, success, failure);
    }

    /**
     * 航旅客户端埋点 wiki http://gitlab.alibaba-inc.com/mpi/bridge/tree/master
     * [string] type:数据埋点参数1，含义为埋点类型，1为页面，3为控件
     * [string] name:数据埋点参数2，含义为`类型_控件名称_行为名称`
     */
    function plusAliTripUT (option) {

        if ((!window.Bridge || !aliTripBridgeInstance) && !gettingScript) {
            S.getScript(aliTripBridgeURL, {
                success : function () {
                    gettingScript = false;
                    aliTripBridgeInstance = new Bridge();
                    while (queue.length > 0) {
                        var _option = queue.shift();
                        if(!_option.type) {
                            if(_option.name.match(/^Page/igm)) _option.type = 1;
                            if(_option.name.match(/^Button/igm)) _option.type = 3;
                        }
                        aliTripBridgeInstance.pushBack('bridge:', 'track', _option);
                    }
                },
                error   : function () {
                    gettingScript = false;
                }
            });
            queue.push(option);
            gettingScript = true;
            return;
        }

        if (gettingScript) {
            queue.push(option);
            return;
        }

        if(!option.type) {
            if(option.name.match(/^Page/igm)) option.type = 1;
            if(option.name.match(/^Button/igm)) option.type = 3;
        }

        aliTripBridgeInstance.pushBack('bridge:', 'track', option);
    }

    /**
     * aplus 埋点 wiki http://confluence.taobao.ali.com/pages/viewpage.action?pageId=206409337
     * @param str
     */
    function sendPoint (str) {
        Aplus({
            aplus : true,
            apuri : str
        });
    }

    return {
        sendPoint : function (option) {
            try {
                var _option = {
                    eid : option.eid || '',
                    a1  : option.page,
                    a2  : option.type,
                    a3  : option.action
                };

                if (isWindVane) {
                    plusUT(_option);
                }

                var a = [];

                option.type && a.push(option.type);
                option.page && a.push(option.page);
                option.action && a.push(option.action);

                if (isAliTrip) {
                    plusAliTripUT({
                        name: a.join("_").replace(/page/igm, 'pag0e').replace(/list/igm, 'lis0t').replace(/button/igm, 'butto0n')
                    });
                }

                //fixed by xijian 异步发送埋点解决部分浏览器回退不刷新问题
                setTimeout(function () {
                    sendPoint(a.join("_"));
                }, 0);

            } catch (e) {
                console.info(e);
            }
        }
    }

}, {requires : ["./aplus"]});
