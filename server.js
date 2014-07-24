/*var coffee = require('coffee-script/register');
var app = require('./app/app.coffee');

var port = process.env.PORT || 3000;

app.application.listen(port, function() {
  console.log('Digicom iniciada na porta ' + port);
});*/

var http = require('http')
var port = process.env.PORT || 1337;
http.createServer(function(req, res) {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello World\n');
}).listen(port);