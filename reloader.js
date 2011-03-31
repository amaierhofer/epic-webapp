var http = require('http');
var app = http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
});
app.listen(4567);
console.log('Server running 4567');

// this is not triggered again when process is restarted?
(function doWebSocketStuff() {
	function log(msg) { puts('socket.io> ' + msg); }
	var listen = require('socket.io').listen, puts = require('sys').puts;
		clients = [];
	listen(app).on('connection', function(client){ 
		client.on('disconnect', function() { log('client disconnect'); });
		clients.push(client);
	}); 
	process.on('SIGUSR1', function() {
		log('got SIGUSR1, telling connected clients: ' + clients.length);
		clients.forEach(function(client) {
			if (client.connected) {
				client.send('reload');
			}
		});
		clients = [];
	});
})();
