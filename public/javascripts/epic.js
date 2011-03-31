var epic = (function() {

  var ctr = 0;

  function id() {
//    ctr = ctr + 1;

    return "epic_" + ctr;
  }


  // utils maybe also usefull for xmpp
  function browser() {
    return jid('browser');
  }
  function mobile() {
    return jid('mobile');
  }
  function jid(resource) {
    return Strophe.getBareJidFromJid(xmpp.connection().jid) + "/" + resource;
  }

  // flash smth on page
  function flash(type, msg) {
    var div = '<div class="flash ' + type + '">' + msg +  '</div>';
    $(".ui-page-active .flash_container *").remove();
    $(".ui-page-active .flash_container").append(div);
  }
  // connect to xmpp
  function init() {
    if (xmpp.isConnected()) { return; }
    if (!sessionStorage['pw']) { return; }

    var url = $("#user_info").attr('data-url');
    var jid = $("#user_info").attr('data-jid') + "/browser";
    var pw = sessionStorage['pw'];
    xmpp.connect(url, jid, pw);
    xmpp.bind('transition', function(e, state) {
      flash('notice', state.name);
    });
  }
  // disconnect from xmpp
  function destroy() {
    xmpp.disconnect();
  }


  // triggered from form submission
  function submit(id,obj) {
    var msg;
    if (id == 'new_message') {
      var cat = obj['message[category]'];
      if (parseInt(cat,10) === 0) {
        msg = $iq({ to: mobile(), from: browser(), type: 'get', id: '1'});
        xmpp.connection().sendIQ(msg, function() {
          flash('error', 'error sending iq');
        }, function() { flash('info', 'iq sent ok'); });
      }

      if (parseInt(cat,10) === 1) {
        msg = $msg({ to: mobile(), type: 'chat'}).c('body').t('hi');
        xmpp.connection().send(msg);
      }
 
    }
  }

  return {
    init: init,
    flash: flash,
    destroy: destroy,
    submit: submit
  };
})();
