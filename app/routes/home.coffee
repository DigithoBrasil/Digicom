module.exports = (app) ->
	home = app.controllers.home

	app.get '/', home.index
	app.get '/home', home.index