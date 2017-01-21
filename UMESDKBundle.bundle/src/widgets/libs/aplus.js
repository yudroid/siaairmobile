KISSY.add(function(S){

return (function(win) {
	var doc = win.document,
		loc = win.location,
		$ = (win['Zepto'] || win['$']),
		LOG_URL = 'http://log.m.taobao.com/js.do',
		COOKIE_REG = /(?:^|\s)cna=([^;]+)(?:;|$)/
		;		

	function getApRef() {
		return loc.href.toString();
	}

	function getApIP() {
		return '';
	}

	function getApCNA() {
		return doc.cookie.match(COOKIE_REG)
	}

	function parseUrl(url) {
		var a = doc.createElement('a');
		a.href = url;

		return a;
	}

	var orginAjax = $.ajax;

	/**
	 * 扩展后的$.ajax方法，其中options扩充两个参数，分为为aplus和apdata。
	 * aplus为埋点开关
	 */
	var ajax = function(options) {
		var ap_ref, ap_cna, ap_ip, ap_data, ap_uri, ap_options,
			aplus = (options.aplus != null ? options.aplus : $.ajaxSettings.aplus || false),
			params = {'_aplus' : '1'},
			complete = options.complete
			;

        aplus = true;

		function _complete() {
			complete && complete.apply(this, arguments);

			if (aplus === true || aplus === 1) {
				ap_ref = getApRef();
				ap_cna = getApCNA();
				ap_ip = getApIP();
				ap_data = options.apdata || options.ap_data;
		        ap_uri = options.apuri || options.ap_uri;
				ap_ref && (params['ap_ref'] = ap_ref);
				ap_cna && (params['ap_cna'] = ap_cna[1]);
				ap_data && (params['ap_data'] = ap_data);
		        ap_uri && (params['ap_uri'] = ap_uri);
				ap_ip && (params['ap_ip'] = ap_ip);

				ap_options = {
					url : LOG_URL,
					data : params,
					type : 'GET',
					dataType : 'jsonp'
					//headers : {}
				}
				
				// jsonp中，header无用
				// for (var k in params) {
				// 	ap_options.headers[k] = params[k];
				// }

				if (aplus === 2) {
					// TODO 延迟发送的功能，先留坑
				} else {
					// 即可发送埋点请求
					orginAjax(ap_options);
				}
			}
		}

		if (options.url) {
			options.complete = _complete;
			orginAjax(options);
		} else {
			_complete();
		}
	}

    return ajax;
})(window);

});
