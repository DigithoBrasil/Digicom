exports.start = ->
	express = require 'express'
	serveFavicon = require 'serve-favicon'
	morgan = require 'morgan'
	bodyParser = require 'body-parser'
	mongoose = require 'mongoose'
	moment = require 'moment'
	#passport = require 'passport'
	#session = require 'express-session'
	#flash = require 'connect-flash'

	app = express()

	load = require "express-load"
	server = require 'http'
		.createServer app

	app.set 'views', __dirname + '/views'
	app.set 'view engine', 'jade'

	app.use express.static __dirname + '/public'
	app.use '/vendor', express.static __dirname + '/bower_components'

	##app.use serveFavicon 'path to favico'
	app.use morgan 'dev'
	app.use bodyParser.json()
	app.use bodyParser.urlencoded extended: true

	passport = require 'passport'
	LocalStrategy = require('passport-local').Strategy
	session = require 'express-session'

	a = (usuario, senha, done) ->
		done null, usuario: 'renan'

	passport.use new LocalStrategy(a)

	app.use session secret: 'a6d7b66b15077f4cd2291298c6719b8d' # 'digicom' em md5
	app.use passport.initialize()
	app.use passport.session()

	b = (req, res) ->
		console.log '################# rotas'
		res.redirect '/users/' + req.user.username

	app.post '/logon', passport.authenticate('local'), b

	#app.passport = passport

	if app.get('env') == 'development'
		app.use (err, req, res, next) ->
		    res.status err.status || 500
		    res.render 'error', { message: err.message, error: err }

	load 'controllers', verbose: true
		.then 'routes', verbose: true
		.into app

	if app.get('env') == 'development'
		global.db = mongoose.connect 'mongodb://localhost/digicom'
	else
		global.db = mongoose.connect 'mongodb://DigicomMongo:1_UsFHmOdEV5nwP8b72CJLM_VPcGukOQ6Ch7puX_ioU-@ds050077.mongolab.com:50077/DigicomMongo'
		
	moment.lang 'pt-br'

	port = process.env.PORT || 1337;
	app.listen port, -> console.log 'Digicom iniciada @ ' + port