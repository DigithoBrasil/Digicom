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

			caixa = calculoDeLancamentosDoMes.calcular todosOsLancamentos

			resultado.lancamentos = lancamentosViewModel
			resultado.caixa = converterCaixa caixa

			cb.apply @, [resultado]

converterLancamento = (lancamento) ->
	data: moment(lancamento.data).format 'DD/MM/YYYY'
	natureza: lancamento.natureza
	finalidade: lancamento.finalidade
	detalhesDaCompra: lancamento.detalhesDaCompra
	valor: formatarNumero lancamento.valor

converterCaixa = (caixa) ->
	receita: formatarNumero caixa.receita
	despesa: formatarNumero caixa.despesa
	total: formatarNumero caixa.total

formatarNumero = (numero) ->
	numeroFormatado = numero
		.toFixed 2
		.replace ".", ","

	"R$ #{numeroFormatado}"

module.exports = ConsultaDeLancamentos