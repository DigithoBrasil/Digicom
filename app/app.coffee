express = require 'express'

app = express()

load = require "express-load"
server = require 'http'
	.createServer app

app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'

#app.use express.favicon()
#app.use express.logger 'dev'
#app.use express.json()

#app.use express.urlencoded()
#app.use express.bodyParser()
#app.use express.methodOverride()

app.use express.static __dirname + '/public'
app.use '/vendor', express.static __dirname + '/bower_components'

#app.use express.errorHandler() if 'development' == app.get 'env'

load 'models'
	.then 'controllers'
	.then 'routes'
	.into app

server.listen 3000, ->
	console.log 'Express server listening on port 3000'