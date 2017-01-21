/**
 * http://g.tbcdn.cn/trip/h5-flight-trends/@@version/config.js
 */
(function(){
    KISSY.config('tag', null); //去除?t时间戳

    // 通过URL注入版本：url?version=0.1.2

	var getVersion = function(){
		var m = window.location.href.match(/[\?&]version=(\d+\.\d+\.\d+)/i);
		if(m && m[1]){
			return m[1];
		} else {
			return '@@version';
		}
	}

	//var debug = ~location.search.indexOf('ks-debug');
    //var isDebug =  /w.waptest.taobao.com/.test(location.host);

	var debug = true;
	var isDebug = true;

    if (debug !== true) {
        if (location.host.match(/(waptest\.taobao|wapa.taobao|daily.taobao.net)/)) {
            KISSY.Config.daily = true;
        }
    }
	if (debug || isDebug) {
		var srcPath = "../../";
		KISSY.config({
			combine:false,
			packages:[
				{
					name:"h5-flight-trends",
					path:srcPath,
					charset:"utf-8",
					ignorePackageNameInUri:true,
					debug:true
				}
			]
		});
	} else {
		var srcHost = KISSY.Config.daily ? 
				'g.assets.daily.taobao.net' :
				'g.tbcdn.cn';
        KISSY.config({
			combine:true,
            packages: [
                {
                    name: 'h5-flight-trends',
                    // 修改 abc.json 中的 version 字段来生成版本号
                    path: 'http://'+srcHost+'/trip/h5-flight-trends/' + getVersion(),
                    ignorePackageNameInUri: true
                }
            ]
        });
	}
    KISSY.config({
        modules:{
            'zepto': {
                alias:['h5-flight-trends/widgets/libs/zepto']
            },
            'jhash': {
                alias:['h5-flight-trends/widgets/libs/jhash']
            },
            'util': {
                alias:['h5-flight-trends/widgets/libs/util']
            },
            'juicer': {
                alias:['h5-flight-trends/widgets/libs/juicer']
            },
            'mtop': {
                alias: ['h5-flight-trends/widgets/libs/mtop/index']
            },
            'notification': {
                alias: ['h5-flight-trends/widgets/libs/notification']
            },
            'mask': {
                alias: ['h5-flight-trends/widgets/mask/index']
            },
            'backbone': {
                alias:['h5-flight-trends/widgets/libs/backbone']
            },
            'moment': {
                alias:['h5-flight-trends/widgets/libs/moment']
            },
            'iscroll-lite': {
                alias:['h5-flight-trends/widgets/libs/iscroll-lite']
            },
            'loading':{
                alias:['h5-flight-trends/widgets/libs/loading']
            }
        }
    });
})();
