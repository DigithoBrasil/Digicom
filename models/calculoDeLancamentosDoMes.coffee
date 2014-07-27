Natureza = require '../models/natureza'

exports.calcular = (lancamentos) ->

	caixa =
		receita: 0
		despesa: 0
		total: 0

	return caixa if not lancamentos or lancamentos.length == 0

	caixa.receita = lancamentos
		.map (lancamento) ->
			if lancamento.natureza == Natureza.receita then lancamento.valor else 0
		.reduce (valor1, valor2) ->
			valor1 + valor2

	caixa.despesa = lancamentos
		.map (lancamento) ->
			if lancamento.natureza == Natureza.despesa then lancamento.valor else 0
		.reduce (valor1, valor2) ->
			valor1 + valor2

	caixa.total = caixa.receita - caixa.despesa

	return caixa