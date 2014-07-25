Natureza = require '../models/natureza'

exports.calcular = (lancamentos) ->

	return 0 if not lancamentos or lancamentos.length == 0

	somaDasReceitas = lancamentos
		.map (lancamento) ->
			if lancamento.natureza == Natureza.receita then lancamento.valor else 0
		.reduce (valor1, valor2) ->
			valor1 + valor2

	somaDasDespesas = lancamentos
		.map (lancamento) ->
			if lancamento.natureza == Natureza.despesa then lancamento.valor else 0
		.reduce (valor1, valor2) ->
			valor1 + valor2

	somaDasReceitas - somaDasDespesas