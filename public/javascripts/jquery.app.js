(function($) {
  function log(msg) {
    if (window.console) {
      console.log(msg);
    }
  }

  // userSession abstraction
  var session = (function() {
    var s = {};
    return {
      setUser: function(user)  { s.user = JSON.stringify(user); },
      getUser: function() { if(s.user) { return JSON.parse(s.user); } },
      delUser: function() { delete s.user; }
    };
  })();

  function changePage(opts) {
    if (!$.mobile) {
      window.location.href = opts.url;
    } else {
      $.mobile.changePage(opts);
    }
  }

  $.widget("nmk.app", {
    // default options 
    options: {
    },

    _create: function() {
      this._state = {};
      this._createClient();
      this._bindShowPageListener();
      this._bindMessageListener();
      this._bindLogoutListener();
    },

    _createClient: function() {
      if (!$.nmk.xmpp) { throw 'does not exists $.nmk.xmpp'; }
      if (this.x && this.x.xmpp('option').initialized) { return; }

      // we have two plugins on the same element? is that a good idea? :)
      this.x = $(this.element).xmpp({
        linkHandler: this._linkHandler
      });

      // bind Peek to events to populate console
      this.x.bind('xmpp.outgoing',function(ev,body) {
        Peek.show_traffic(body,'outgoing');
      });
      this.x.bind('xmpp.incoming',function(ev,body) {
        Peek.show_traffic(body,'incoming');
      });

      // connect if we have a user
      if (!this.x.xmpp('option').initialized && session.getUser()) { 
        this.x.xmpp('option', session.getUser()); 
        this.x.xmpp('connect');
      }
      window.x = this.x;
    },

    // if we sign out, we remove our local user
    _bindLogoutListener: function() {
      $("#sign_out").live('click', $.proxy(function() {
        this.x.xmpp('disconnect');
        session.delUser();
      }, this));
    },

    _bindShowPageListener: function() {
      var x = this.x;
      $("body").delegate('.ui-page', 'pageshow', function() {
        if (x.xmpp('state').initialized) {
          x.xmpp('update');
        } else { 
            if (x && !x.xmpp('option').initialized && session.getUser()) { 
              x.xmpp('option', session.getUser()); 
              x.xmpp('connect');
            }
        }
      });
    },
    _bindMessageListener: function() {
      var connection = this.x.xmpp('connection');
      $("body").delegate('#new_message', 'submit', function(e) {
        var peer = $(this).find('#peer').val(), msg = 'ping';
        var arr = $(this).serializeArray();
        if (arr.length === 4) { msg = arr[3].value; }
        log(peer + " " + msg);
        var stanza = $msg({to: peer, type: 'chat'}).c('body').t(msg);
        connection.send(stanza);
        return false;
      });
    },
    // TODO
    // define options of xmpp plugin and test for it
    // switch to templating instead of string concat
    _linkHandler: function(jid) {
      var link = $('[data-epic_msg]:first').attr('data-epic_msg');
      return '<a href="' + link + '?jid=' + jid + '">' + jid + '</a>';
    }
  });
  $.nmk.session = session;
  $.nmk.log = log;
})(jQuery);

