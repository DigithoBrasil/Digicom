Lancamento = require '../models/lancamento'
Organizador = require '../models/organizador'

module.exports = (app) ->
	
	LancamentoController =
		index: (req, res) ->
			res.render 'lancamento/index'

		incluir: (req, res) ->
			res.render 'lancamento/incluir'

		salvar: (req, res) ->
			lancamento = req.body.lancamento

			organizador = new Organizador

			novoLancamento = organizador.lancar new Date,
				lancamento.finalidade, lancamento.detalhesDaCompra, lancamento.valor

			novoLancamento.save (erro, teste) ->
				if erro
					console.log erro 
					return

				res.redirect '/lancamento'