// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function log(msg) {
  if (window.console) { window.console.log(msg); }
}
(function($) {
  $(function() {

    
    log('credentials are set in appliction.js and overridden by session creds');
    var opts = $.nmk.session.getUser() || {
      url: 'http://ubuntu:5280/http-bind', 
      jid:'asdf@ubuntu/browser', 
      pw:'asdf'
    };

    log(opts);
    var app = $("body").xmpp(opts);
    app.xmpp('connect');
    window.app = app;
    log(window.app);
  });

})(jQuery);
