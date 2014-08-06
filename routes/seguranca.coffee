module.exports = (app) ->
	seguranca = app.controllers.seguranca

	app.get '/logon', seguranca.logon
	app.post '/logon', seguranca.autenticar

	app.get '/logout', seguranca.logout