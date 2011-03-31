(function($) {
  /**
   * start nodemon reloader.js
   */ 

  function say(msg) {
    if (window.console) {
      window.console.log(msg);
    }
  }

  function connect() {
    say('connecting');
    var s = new WebSocket('ws://localhost:4567/socket.io/websocket');
    
    var time = new Date().getTime();
    s.onconnect = function() { say('connected'); };

    // we get more than just our reload message btw .. 
    s.onmessage = function(message) {
      if (/reload/.test(message.data)) {
        window.location.reload();
        say('reload');
      }
    };
    s.onclose = function() {
      say('disconnect');
      if ((new Date().getTime() - time) > 1000) {
        connect();
      }
    };
  }

  $(function() {
    connect();
  });

})(jQuery);
