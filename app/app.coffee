express = require 'express'
serveFavicon = require 'serve-favicon'
morgan = require 'morgan'
bodyParser = require 'body-parser'

app = express()

load = require "express-load"
server = require 'http'
	.createServer app

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

app.use express.static __dirname + '/public'
app.use '/vendor', express.static __dirname + '/bower_components'

#app.use serveFavicon 'path to favico'
app.use morgan 'dev'
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true

if app.get 'env' == 'development'
    app.use (err, req, res, next) ->
        res.status err.status || 500
        res.render 'error', { message: err.message, error: err }

load 'models', verbose: true
	.into app

console.log app.models

###load 'controllers', verbose: true
	.into app

load 'routes', verbose: true
	.into app###

mongoose = require 'mongoose'
#global.db = mongoose.connect 'mongodb://localhost/digicom'

server.listen 3000, ->
	console.log 'Digicom iniciada!'