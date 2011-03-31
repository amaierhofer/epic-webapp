(function($) {
describe('webos extension', function() {
  beforeEach(function() {
    url = '';
    params = {};
    $.nmk.xmpp.prototype._connection = { addHandler: function() {} };
    x = $('<p/>').xmpp();
    x.trigger('xmpp.connected');
    x.xmpp('option','controller',{
      serviceRequest: function(u, p) {
        url = u;
        params = p;
      }
    });
    openurl =$msg({from: 'a@b/c'})
      .c('epic')
        .c('operation').t('openurl').up()
        .c('parameter').t('http://www.fad.at');

    ring =$msg({from: 'a@b/c'})
      .c('epic')
        .c('operation').t('ring');

    gps =$msg({from: 'a@b/c'})
      .c('epic')
        .c('operation').t('gps');
  });

  it('opens browser for "openurl" message', function() {
    x.trigger('xmpp.message', Strophe.serialize(openurl));
    expect(url).toEqual('palm://com.palm.applicationManager');
    expect(params).toEqual({ method: 'open', parameters: {
        id: 'com.palm.app.browser',
        params: {  target: 'http://www.fad.at' }
      }
    });
  });


  it('rings phone for "ringphone" message', function() {
    x.trigger('xmpp.message', Strophe.serialize(ring));
    expect(url).toEqual('palm://com.palm.audio/systemsounds');
    expect(params).toEqual({ 
      method: 'playFeedback', 
      parameters: {
          name: 'dtmf_2'
      }
    });
  });


  it('gets gps fix for "gps" message', function() {
    x.trigger('xmpp.message', Strophe.serialize(gps));
    expect(url).toEqual('palm://com.palm.location');
    expect(params).toEqual({ 
      method: 'getCurrentPosition', 
      parameters: {}
    });
  });
});

})(jQuery);
