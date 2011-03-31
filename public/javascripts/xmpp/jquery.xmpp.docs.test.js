(function($) {
describe('the docs extension', function() {
  beforeEach(function() {
    x = $('<p/>').xmpp();
    docs = x.xmpp('docs');
    doc = $('<div><div class="xmpp-status"/></div>');
  });

  it('returns an object that responds to methods get,add, del', function() {
    expect(docs.get).toBeDefined();
    expect(docs.del).toBeDefined();
    expect(docs.add).toBeDefined();
  });

  it('allows to add and remove documents', function() {
    var idx = docs.add(doc);
    expect(docs.get().length).toEqual(1);
    docs.del(idx);
    expect(docs.get().length).toEqual(0);
  });

  it('xmpp.transition updates .xmpp-status in added document', function() {
    docs.add(doc);
    x.trigger('xmpp.transition', {name : 'CONNECTED'});
    expect(doc.find('.xmpp-status').html()).toEqual('CONNECTED');
  });
});
})(jQuery);


