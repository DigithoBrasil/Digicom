autenticacao = require '../middleware/autenticacao'

module.exports = (app) ->
	lancamento = app.controllers.lancamento

	app.get '/lancamento', lancamento.index	
	app.get '/lancamento/:mes/:ano', lancamento.consultar

	app.get '/lancamento/incluir', autenticacao.verificar, lancamento.incluir
	app.post '/lancamento/salvar', autenticacao.verificar, lancamento.salvar