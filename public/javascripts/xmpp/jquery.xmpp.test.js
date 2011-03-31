(function($) {
describe('xmpp as a jquery widget', function() {
  beforeEach(function() {
    $.nmk.xmpp.prototype._connection =  { 
      jid: 'a@a/a',
      addHandler: function() {} 
    };
    x = $('<p/>').xmpp();
    x.trigger('xmpp.connected');
  });

  describe('configuration via option method', function() {
    it('has unreasonable defaults', function() {
      var unreasonableDefaults = { 
        disabled: false,
        url: 'http://localhost/xmpp-httpbind',
        jid: 'a@a/a',
        pw: 'a',
        ping: {
          interval: 60000,
          timeout: 2000
        }
      };
      expect(x.xmpp('option')).toEqual(unreasonableDefaults);
    });

    it('supports per property getter and setter ', function() {
      expect(x.xmpp('option').jid).toEqual('a@a/a');
      x.xmpp('option','jid','b');
      expect(x.xmpp('option').jid).toEqual('b');
    });

    it('supports setting options using an object', function() {
      expect(x.xmpp('option').jid).toEqual('a@a/a');
      x.xmpp('option', { jid: 'b'} );
      expect(x.xmpp('option').jid).toEqual('b');
    });
  });

  describe('xmpp.transition is triggered when connection state changes', function() {
    it('calls callback with event and state object', function() {
      var connected = false;
      x.bind('xmpp.transition', function(ev, state) { connected = true; }); 
      expect(connected).toEqual(false);
      x.trigger('xmpp.transition', {name : 'CONNECTED'});
      expect(connected).toEqual(true);
    });

    it('updates dom elements with class .xmpp-status with current state', function() {
      x.append('<div class="xmpp-status"/>');
      x.trigger('xmpp.transition', {name : 'CONNECTED'});
      expect(x.find('.xmpp-status').html()).toEqual('CONNECTED');
    });

    it('updates dom elements with class ul.xmpp-peers with peer list items', function() {
      x.append('<ul class="xmpp-peers"/>');
      x.trigger('xmpp.transition', {peers : {'b@b/b': 'available'}});
      expect(x.find('.xmpp-peers li').size()).toEqual(1);
      expect(x.find('.xmpp-peers li')[0].className).toEqual("available");
      expect(x.find('.xmpp-peers li').html()).toEqual("b@b/b");
    });

    it('li in .xmpp-peers can be customized via option: linkHandler', function() {
      x.append('<ul class="xmpp-peers"/>');
      x.xmpp('option', 'linkHandler', function(jid) {
        return "test" + jid;
      });
      x.trigger('xmpp.transition', {peers : {'b@b/b': 'available'}});
      expect(x.find('.xmpp-peers li').size()).toEqual(1);
      expect(x.find('.xmpp-peers li')[0].className).toEqual("available");
      expect(x.find('.xmpp-peers li').html()).toEqual("testb@b/b");
    });
  });


  describe('xmpp.presence is triggered when receiving presence messages ', function() {

    available = $pres({from: 'a@b/c'});
    unavailable = $pres({from: 'a@b/c', type: 'unavailable'});

    it('excludes itself from peers object ', function() {
      self = $pres({from: x.xmpp('option').jid});
      x.trigger('xmpp.presence', Strophe.serialize(self));
      expect(x.xmpp('state').peers).toEqual({});
    });

    it('updates peers object when peers goes online', function() {
      x.trigger('xmpp.presence', Strophe.serialize(available));
      expect(x.xmpp('state').peers['a@b/c']).toEqual('available');
    });

    it('updates peers object when peers goes offline', function() {
      x.trigger('xmpp.presence', Strophe.serialize(unavailable));
      expect(x.xmpp('state').peers['a@b/c']).toEqual('unavailable');
    });


    it('updates dom elements with class "xmpp-peers" with current peers', function() {
      x.append('<div class="xmpp-peers"/>');
      x.trigger('xmpp.presence', Strophe.serialize(available));
//      expect(x.find('.xmpp-peers').html()).toEqual("{'a@b/c': 'available'}");
      console.log(x.find('.xmpp-peers'));
    });
  });


  describe('xmpp.message is triggered when receiving messages', function() {
    msg = $msg({from: 'a@b/c', type: 'chat'}).c('body').t('text');

    it('xmpp.message from with body payload', function() {
      var msgReceived = false;
      x.bind('xmpp.message', function(ev,stanza) {
        expect($(stanza).text()).toEqual('text');
        expect($(stanza).attr('from')).toEqual('a@b/c');
        msgReceived = true;
      });
      x.trigger('xmpp.message', Strophe.serialize(msg));
      expect(msgReceived).toEqual(true);
    });
  });
});
})(jQuery);
