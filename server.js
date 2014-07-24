var coffee = require('coffee-script/register');
var app = require('./app/app.coffee');

var port = process.env.PORT || 3000;

app.application.listen(port, function() {
  console.log('Digicom iniciada na porta ' + port);
});