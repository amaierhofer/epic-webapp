(function($,Strophe) {
  describe("XMPP Discovery support", function() {
    beforeEach(function() {
      x = $('<p/>').xmpp();

      $.nmk.xmpp.prototype.connect =  function() { };
      $.nmk.xmpp.prototype._connection =  new Strophe.Connection();
      x.xmpp('connect');
      x.trigger('xmpp.connected');
      c = x.xmpp('connection');
    });

    it("defines disco object on connection", function() {
      var c = x.xmpp('connection');
      expect(c).toBeDefined();
      expect(c.disco).toBeDefined();
    });

    it("should not test for 2 handlers registered (presence and message)", function() {
      expect(c.addHandlers.length).toBe(2);
    });

    it("should allow allow to send disco requests and trigger fn on response", function() {});

    it ("responds to disco#info depending on config", function() {
    });

    it ("responds to disco#items depending on config", function() {
    });


  });
})(jQuery, Strophe);
