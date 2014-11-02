accounting = require 'accounting'
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

		titulo = "#{moment(data).format('MMMM')} de #{moment(data).format('YYYY')}"

		resultado =
			ano: ano
			mes: mes
			titulo: titulo.charAt(0).toUpperCase() + titulo.slice(1)
			consultaAnterior: "/lancamento/#{mesAnterior.month() + 1}/#{mesAnterior.year()}"
			proximaConsulta: "/lancamento/#{proximoMes.month() + 1}/#{proximoMes.year()}"

		Lancamento.find filtro, (erro, todosOsLancamentos) ->
			if erro
				console.log erro
				return

			lancamentosViewModel = for lancamento in todosOsLancamentos
				converterLancamento lancamento

			caixa = calculoDeLancamentosDoMes.calcular todosOsLancamentos

			resultado.lancamentos = lancamentosViewModel
			resultado.caixa = converterCaixa caixa

			cb.apply @, [resultado]

converterLancamento = (lancamento) ->
	data: moment(lancamento.data).format 'MM/YYYY'
	natureza: lancamento.natureza
	comprovante: if lancamento.comprovante then lancamento.comprovante else '---'
	fornecedor: if lancamento.fornecedor then lancamento.fornecedor else '---'
	detalhes: lancamento.detalhes
	valor: formatarNumero lancamento.valor

converterCaixa = (caixa) ->
	credito: formatarNumero caixa.credito
	debito: formatarNumero caixa.debito
	total: formatarNumero caixa.total

formatarNumero = (numero) ->
	accounting.formatMoney numero, 'R$ ', 2, '.', ','

module.exports = ConsultaDeLancamentos