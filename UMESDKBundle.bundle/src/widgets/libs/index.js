/**
 * @module libs
 **/
KISSY.add(function (S, Node,Base) {
    var EMPTY = '';
    var $ = Node.all;

    /**
     * @class Libs
     * @constructor
     * @extends Base
     */
    function Libs(comConfig) {
        var self = this;
        //调用父类构造函数
        Libs.superclass.constructor.call(self, comConfig);
    }

    S.extend(Libs, Base, /** @lends Libs.prototype*/{

    }, {ATTRS : /** @lends Libs*/{

    }});

    return Libs;

}, {requires:['node', 'base']});



