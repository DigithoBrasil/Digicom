module.exports = (app) ->
	lancamento = app.controllers.lancamento

	app.get '/', lancamento.index