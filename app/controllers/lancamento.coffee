Lancamento = require '../models/lancamento'
Organizador = require '../models/organizador'
moment = require 'moment'

module.exports = (app) ->

	consultar = (res, mes, ano) ->
		data = new Date ano, mes, 1

		filtro = data: {
			$gte: data
			$lt: moment(data).endOf('month').toDate()
		}

		Lancamento.find filtro, (erro, todosOsLancamentos) ->
			if erro
				console.log erro
				return

			resultados = for lancamento in todosOsLancamentos
				converterLancamento lancamento

			res.render 'lancamento/index', lancamentos: resultados

	converterLancamento = (lancamento) ->
		data: moment(lancamento.data).format 'DD/MM/YYYY'
		finalidade: lancamento.finalidade
		detalhesDaCompra: lancamento.detalhesDaCompra
		valor: lancamento.valor
	
	LancamentoController =
		index: (req, res) ->
			mes = moment().month() + 1
			ano = moment().year()

			res.redirect "/lancamento/#{mes}/#{ano}"

		consultar: (req, res) ->
			mes = req.params.mes - 1
			ano = req.params.ano

			consultar res, mes, ano

		incluir: (req, res) ->
			res.render 'lancamento/incluir'

		salvar: (req, res) ->
			lancamento = req.body.lancamento
			data = moment lancamento.data

			console.log data.toDate()

			novoLancamento = (new Organizador()).lancar data.toDate(),
				lancamento.finalidade, lancamento.detalhesDaCompra, lancamento.valor

			novoLancamento.save (erro, teste) ->
				if erro
					console.log erro 
					res.redirect '/lancamento'
					return

				res.redirect '/lancamento'