var coffee = require('coffee-script/register');
var app = require('./app/app.coffee');

process.env.port = process.env.port || 3000

app.application.listen(process.env.port, function() {
  console.log('Digicom iniciada na porta ' + process.env.port);
});