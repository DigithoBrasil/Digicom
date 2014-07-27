Lancamento = require '../../models/lancamento'

moment = require 'moment'
calculoDeLancamentosDoMes = require '../../models/calculoDeLancamentosDoMes'

ConsultaDeLancamentos =
	consultar: (mes, ano, cb) ->
		data = moment "01/#{mes}/#{ano}", "DD/MM/YYYY"
		mesAnterior = moment(data).subtract 'months', 1
		proximoMes = moment(data).add 'months', 1

		filtro = data: {
			$gte: data.toDate()
			$lt: moment(data).endOf('month').toDate()
		}

		resultado =
			consultaAnterior: "/lancamento/#{mesAnterior.month() + 1}/#{mesAnterior.year()}"
			proximaConsulta: "/lancamento/#{proximoMes.month() + 1}/#{proximoMes.year()}"

		Lancamento.find filtro, (erro, todosOsLancamentos) ->
			if erro
				console.log erro
				return

			lancamentosViewModel = for lancamento in todosOsLancamentos
				converterLancamento lancamento

			resultado.lancamentos = lancamentosViewModel
			resultado.caixa = calculoDeLancamentosDoMes.calcular todosOsLancamentos

			oi = calculoDeLancamentosDoMes.calcular todosOsLancamentos

			console.log oi

			cb.apply @, [resultado]

converterLancamento = (lancamento) ->
	data: moment(lancamento.data).format 'DD/MM/YYYY'
	finalidade: lancamento.finalidade
	detalhesDaCompra: lancamento.detalhesDaCompra
	valor: lancamento.valor

module.exports = ConsultaDeLancamentos