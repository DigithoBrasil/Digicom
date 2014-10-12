Natureza = require '../models/natureza'

exports.calcular = (lancamentos) ->

	caixa =
		credito: 0
		debito: 0
		total: 0

	return caixa if not lancamentos or lancamentos.length == 0

	caixa.credito = lancamentos
		.map (lancamento) ->
			if lancamento.natureza == Natureza.credito then lancamento.valor else 0
		.reduce (valor1, valor2) ->
			valor1 + valor2

	caixa.debito = lancamentos
		.map (lancamento) ->
			if lancamento.natureza == Natureza.debito then lancamento.valor else 0
		.reduce (valor1, valor2) ->
			valor1 + valor2

	caixa.total = caixa.credito - caixa.debito

	return caixa