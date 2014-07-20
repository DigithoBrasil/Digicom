module.exports = (app) ->
	lancamento = app.controllers.lancamento

	app.get '/lancamento', lancamento.index
	app.post '/lancamento/criar', lancamento.criar