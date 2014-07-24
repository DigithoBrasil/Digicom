var coffee = require('coffee-script/register');
var app = require('./app/app.coffee');

var port = process.env.PORT || 1337;

app.application.listen(port);