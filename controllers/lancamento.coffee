Organizador = require '../models/organizador'
Lancamento = require '../models/lancamento'

moment = require 'moment'
consultaDeLancamentos = require '../application/query/consultaDeLancamentos'

module.exports = (app) ->

	LancamentoController =
		index: (req, res) ->
			mes = moment().month() + 1
			ano = moment().year()

			res.redirect "/lancamento/#{mes}/#{ano}"

		consultar: (req, res) ->
			mes = req.params.mes
			ano = req.params.ano

			exibirResultados = (resultados) ->
				res.render 'lancamento/index', resultados

			consultaDeLancamentos.consultar mes, ano, exibirResultados

		incluir: (req, res) ->
			res.render 'lancamento/incluir'

		salvar: (req, res) ->
			lancamento = req.body.lancamento
			data = moment lancamento.data

			console.log data.toDate()

			novoLancamento = (new Organizador()).lancar data.toDate(), lancamento.natureza,
				lancamento.finalidade, lancamento.detalhesDaCompra, lancamento.valor

			novoLancamento.save (erro, teste) ->
				if erro
					console.log erro 
					res.redirect '/lancamento'
					return

				res.redirect '/lancamento'