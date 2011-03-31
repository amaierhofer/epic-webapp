(function($) {

  // userSession abstraction
  var session = (function() {
    var s = sessionStorage;
    return {
      setUser: function(user)  { s.user = JSON.stringify(user); },
      getUser: function() { return s.user && JSON.parse(s.user); },
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

  $.nmk.session = session;


  $.widget("nmk.app", {
    // default options 
    options: {
    },

    _create: function() {
      this._state = {};
      this._createClient();
      this._bindLogoutListener();
      this._bindLoginListener();
      this._bindShowPageListener();
      this._bindMessageListener();
    },

    _createClient: function() {
      if (!$.nmk.xmpp) { throw 'does not exists $.nmk.xmpp'; }
      if (this.x && this.x.xmpp('option').initialized) { return; }

      // we have two plugins on the same element? is that a good idea? :)
      this.x = $(this.element).xmpp({
        linkHandler: this._linkHandler
      });
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
    _bindLoginListener: function() {
      $("#user_new").live('submit',$.proxy(function() {
        var domain = $("#xmpp_info").attr('data-domain');
        var user = {
          url: $("#xmpp_info").attr('data-url'),
          jid: $("#user_username").val() + "@" + domain + "/browser",
          pw: $("#user_password").val()
        };
        session.setUser(user);
        this._createClient();
      },this));
    },
    _bindShowPageListener: function() {
      var x = this.x;
      $("body").delegate('.ui-page', 'pageshow', function() {
        if (x.xmpp('state').initialized) {
          x.xmpp('update');
        }
      });
    },
    _bindMessageListener: function() {
      var connection = this.x.xmpp('connection');
      $("body").delegate('#new_message', 'submit', function(e) {
        var peer = $(this).find('#peer').val(), msg = 'ping';
        var arr = $(this).serializeArray();
        if (arr.length === 4) { msg = arr[3].value; }
        console.log(peer + " " + msg);
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
})(jQuery);

