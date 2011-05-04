(function() {

  function log(msg) {
    if (window.console) { window.console.log(msg); }
  }

  if (window.WebSocket) {
	log('ready');
	ws = new WebSocket('ws://localhost:4567');
	ws.onopen = function() {
		log('connected');
	};
	ws.onmessage = function(msg) {
		log('msg: ' + msg.data);
		if(/reload/.test(msg.data)) {
			window.location.reload();
		}
	};
  }

})();
