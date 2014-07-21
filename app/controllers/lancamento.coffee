module.exports = (app) ->
	Organizador = app.models.organizador
	Lancamento = app.models.lancamento

	LancamentoController =
		index: (req, res) ->
			res.render 'lancamento/index'

		incluir: (req, res) ->
			res.render 'lancamento/incluir'

		salvar: (req, res) ->
			lancamento = req.body.lancamento

			console.log app.models
			console.log app.models.organizador

			organizador = new Organizador

			novoLancamento = organizador.criar new Date,
				lancamento.finalidade, lancamento.detalhesDaCompra, lancamento.valor

			console.log novoLancamento

			###Lancamento.create novoLancamento, (erro, lancamento) ->
				res.redirect '/' if erro
				res.redirect '/lancamento'###