/**
 * @description tracker
 * @author yingyi.zj@taobao.com
 * */
KISSY.add('h5-flight/widgets/tracker/index',function (S, Aplus) {

    var windVaneURL = "http://g.tbcdn.cn/mtb/lib-windvane/1.2.0/??bridge.js,api.js";
    var aliTripBridgeURL = "http://g.tbcdn.cn/mpi/bridge/index-min.js";
    var gettingScript = false;
    var queue = [];
    var userAgent = window.navigator.userAgent;
    //判断容器是否为主淘
    var isWindVane = (/WindVane/i).test(userAgent);
    //判断是否为航旅客户端
    var isAliTrip = (/AliTrip/i).test(userAgent);
    var aliTripBridgeInstance;
    //type 1 : 页面进入埋点
    //type 2 : 页面离开埋点
    //type 3 : 控件点击埋点
    var typeMap = {
        "page"       : 1,
        "view"       : 1,
        "controller" : 1,
        "button"     : 3,
        "list"       : 3,
        "listitem"   : 3,
        "item"       : 3,
        "tab"        : 3
    };
    var replaceReg = /(page|view|controller|button|list|listitem|item|tab)/gi;
    var eid = "9199";

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
     * @author baozi
     */
    function plusAliTripUT (option) {

        function sendPoint (option) {
            var _option = {};
            var type = option.type.toLowerCase();

            if (type in typeMap) {
                _option.type = typeMap[type];
            }

            _option.name = (option.page + (option.action ? "_" + option.action : "")).replace(replaceReg, function ($0, $1) {
                return $1.substr(0, $1.length - 2) + "0" + $1.substr($1.length - 2);
            });
            console.info(_option);
            aliTripBridgeInstance.pushBack('bridge:', 'track', _option);
        }

        if ((!window.Bridge || !aliTripBridgeInstance) && !gettingScript) {
            S.getScript(aliTripBridgeURL, {
                success : function () {
                    gettingScript = false;
                    aliTripBridgeInstance = new Bridge();
                    while (queue.length > 0) {
                        var _option = queue.shift();
                        sendPoint(_option);
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

        sendPoint(option);
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
        console.info(str);
    }

    return {
        sendPoint : function (option) {
            try {
                var _option = {
                    eid : option.eid || eid,
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
                    plusAliTripUT(option);
                }

                setTimeout(function () {
                    sendPoint(a.join("_"));
                }, 0);

            } catch (e) {
                console.info(e);
            }
        }
    }

}, {requires : ["./aplus"]});