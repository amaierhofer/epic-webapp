// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function say(msg) {
  if (window.console) { window.console.log(msg); }
}

$.fn.serializeObject = function()
{
  var o = {};
  var a = this.serializeArray();
  $.each(a, function() {
    if (o[this.name]) {
      if (!o[this.name].push) {
        o[this.name] = [o[this.name]];
      }
      o[this.name].push(this.value || '');
    } else {
      o[this.name] = this.value || '';
    }
  });
  return o;
};

$(function() {

  function connect() {
  }
  var x = $("body").xmpp();
  x.bind('xmpp.transition', function(ev,state) {
    $("#xmpp-status li:eq(0) div").html(state.name);
    $("#xmpp-status li:eq(1) div").html(state.peer ? "CONNECTED" : "DISCONNECTED");
  });

  x.bind('xmpp.message', function(ev,stanza) {
    $("#xmpp-status li:eq(2) div").html($('body',stanza).text());
  });
  window.x = x;

  // if we sign out, we remove our local user
  $("#sign_out").live('click', function() {
    x.xmpp('disconnect');
    delete sessionStorage.user;
  });

  // store pw when user submits the form
  $("#user_new").live('submit',function() {
    var domain = $("#xmpp_info").attr('data-domain');
    var user = {
      url: $("#xmpp_info").attr('data-url'),
      jid: $("#user_username").val() + "@" + domain + "/browser",
      pw: $("#user_password").val()
    };
    sessionStorage.user = JSON.stringify(user);
  });

  // init epic on every page, epic can handle that
  $("body").delegate('.ui-page', 'pageshow', function() {
    console.log('pageshow: ' + location.hash);
    if (!x.xmpp('state').initialized && sessionStorage.user) {
      var opts = JSON.parse(sessionStorage.user);
      if (opts.pw && opts.pw !== "") {
        x.xmpp('option', opts);
        x.xmpp('connect');
      }
    }
    // update footer status bar
    if (x.xmpp('state').initialized) {
      x.trigger('xmpp.transition', x.xmpp('state'));
    }
  });

  // no jquery plugin to handle form serialization to json, e.g. handle nesting
  // nice example for test framework
  $("#new_message :submit").live('click', function(e) {
    var form = $(this).closest('form');
    var id = form.attr('id');
    var obj = form.serializeObject();
    e.preventDefault();
    x.xmpp('send', obj['message[category]']);
  });

});
