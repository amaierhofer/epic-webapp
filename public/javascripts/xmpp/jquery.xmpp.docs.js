/**
 * Extension that lets the xmpp plugin update elements in other documents.
 *
 * It does so by providing that the docs method which returns an object that
 * allows to add, del, and get documents.
 *
 * the internal __updateElements method is then overwritten to include these
 * documents when searching for elements to update
 *
 * Everything is wrapped in a function call because webos mojo environment has 
 * prototype library bound to $.
 *
*/ 

(function($) {
  var __updateElements = $.nmk.xmpp.prototype.__updateElements; 

  $.nmk.xmpp.prototype.__updateElements = function(ev,state) {
    __updateElements.call(this, ev, state);
    $(this.docs().get()).each($.proxy(function(i,doc) {
      $(doc).find('.xmpp-status').each(function(j,e) {
        $(e).html(state.name);
      });
    }, this));
  };

  $.nmk.xmpp.prototype.docs = function() {
    if (!this.__docs) {
      this.__docs = (function(self) {
        var idx = 0;
        var docs = {};

        function get() {
          var arr = [];
          $.each(docs, function(k,v) { arr.push(v); });
          return arr;
        }
        function add(doc) {
          docs[idx] = doc;
          self.__updateElements({}, self.__state);
          return idx++;
        }
        function del(idx) {
          delete docs[idx];
        }
        return {
          get: get, 
          del: del,
          add: add
        };
      })(this);
    }
    return this.__docs;
  };
})(jQuery);
