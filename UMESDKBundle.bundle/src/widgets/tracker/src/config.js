
/*
 * http://g.tbcdn.cn/mpi/tracker/@@version/config.js
 */
(function(){
	if (KISSY.Config.debug) {
		var srcPath = "../";
		KISSY.config({
			packages:[
				{
					name:"tracker",
					path:srcPath,
					charset:"utf-8",
					ignorePackageNameInUri:true,
					debug:true
				}
			]
		});
	} else {
		KISSY.config({
			packages: [
				{
					name: 'tracker',
					// 修改 abc.json 中的 version 字段来生成版本号
					path: 'http://g.tbcdn.cn/mpi/tracker/@@version',
					ignorePackageNameInUri: true
				}
			]
		});
	}
})();
