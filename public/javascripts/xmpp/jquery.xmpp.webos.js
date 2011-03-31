/**
 *
 */ 

(function($) {
  function isOperation(stanza,operation) {
    if($(stanza).find('operation').text() == operation) {
      return true;
    }
    return false;
  }

  var __onMessageReceived = $.nmk.xmpp.prototype.__onMessageReceived;
  $.nmk.xmpp.prototype.__onMessageReceived = function(ev,stanza) {
    __onMessageReceived.call(this,ev,stanza);
    if (!this.options.controller) {
      this.__log('we dont have a controller, returning');
      return;
    }

    var c = this.options.controller;
    if (isOperation(stanza,'openurl')) {
      c.serviceRequest('palm://com.palm.applicationManager',{
        method: 'open',
        parameters: {
          id: 'com.palm.app.browser',
          params: {
            target: $(stanza).find('parameter').text()
          }
        }
      });
    }

    if(isOperation(stanza,'ring')) {
      c.serviceRequest('palm://com.palm.audio/systemsounds',{
        method: 'playFeedback', 
        parameters: {
            name: 'dtmf_2'
        }
      });
    }

    if(isOperation(stanza,'gps')) {
      c.serviceRequest('palm://com.palm.location',{
        method: 'getCurrentPosition', 
        parameters: {}
      });
    }
  };
})(jQuery);
