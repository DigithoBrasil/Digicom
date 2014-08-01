module.exports = (app) ->
	home = app.controllers.home

	app.get '/login', home.login
	app.post '/logon', home.logon
	app.get '/logout', home.logout