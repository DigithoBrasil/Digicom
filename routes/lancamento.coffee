autenticacao = require '../middleware/autenticacao'

module.exports = (app) ->
	lancamento = app.controllers.lancamento

	app.get '/lancamento', lancamento.index	
	app.get '/lancamento/:mes/:ano', lancamento.consultar

	app.post '/lancamento/salvarDebito', autenticacao.verificar, lancamento.salvarDebito
	app.post '/lancamento/salvarCredito', autenticacao.verificar, lancamento.salvarCredito