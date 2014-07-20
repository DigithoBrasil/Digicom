express = require 'express'

app = express()

load = require "express-load"
server = require 'http'
	.createServer app

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.use express.static __dirname + '/public'
app.use '/vendor', express.static __dirname + '/bower_components'

load 'models'
	.then 'controllers'
	.then 'routes'
	.into app

mongoose = require 'mongoose'
global.db = mongoose.connect 'mongodb://localhost/digicom'

server.listen 3000, ->
	console.log 'Express server listening on port 3000'