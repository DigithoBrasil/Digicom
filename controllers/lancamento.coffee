Organizador = require '../models/organizador'
Lancamento = require '../models/lancamento'
Natureza = require '../models/natureza'

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
				# TODO: Procurar forma melhor de lidar com ação de modal que necessita estar logado
				resultados.usuarioEstaAutenticado = req.session.loginOrganizador != undefined

				res.render 'lancamento/index', resultados

			consultaDeLancamentos.consultar mes, ano, exibirResultados

		salvar: (req, res) ->
			lancamento = req.body.lancamento
			mes = lancamento.mes
			ano = lancamento.ano

			Organizador.findOne login: req.session.loginOrganizador, (erro, organizador) ->
				novoLancamento

				if lancamento.natureza == Natureza.credito
					novoLancamento = organizador.lancarCredito mes, ano, lancamento.detalhes,
						lancamento.valor

				if lancamento.natureza == Natureza.debito
					novoLancamento = organizador.lancarDebito mes, ano, lancamento.comprovante,
						lancamento.fornecedor, lancamento.detalhes, lancamento.valor

				console.log novoLancamento

				novoLancamento.save (erro) ->
					throw erro if erro

					res.redirect '/lancamento'