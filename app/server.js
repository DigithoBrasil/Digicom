var coffee = require('coffee-script/register');
var app = require('./app.coffee');

app.application.listen(process.env.port, function() {
  console.log('Digicom iniciada na porta ' + process.env.port);
});