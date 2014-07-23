module.exports = (app) ->
	lancamento = app.controllers.lancamento

	app.get '/lancamento', lancamento.index
	app.get '/lancamento/:mes/:ano', lancamento.consultar

	app.get '/lancamento/incluir', lancamento.incluir

	app.post '/lancamento/salvar', lancamento.salvar