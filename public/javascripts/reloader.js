(function() {

	console.log('ready');
	ws = new WebSocket('ws://localhost:4567');
	ws.onopen = function() {
		console.log('connected');
	};
	ws.onmessage = function(msg) {
		console.log('msg: ' + msg.data);
		if(/reload/.test(msg.data)) {
			window.location.reload();
		}
	};
})();
