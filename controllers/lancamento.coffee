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

			Organizador.findOne login: req.session.loginOrganizador, (erro, organizador) ->
				novoLancamento = organizador.lancar data.toDate(), lancamento.natureza,
					lancamento.finalidade, lancamento.detalhesDaCompra, lancamento.valor

				novoLancamento.save (erro) ->
					throw erro if erro

					res.redirect '/lancamento'