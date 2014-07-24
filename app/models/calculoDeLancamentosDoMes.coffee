Natureza = require '../models/natureza'

exports.calcular = (mesDeReferencia, lancamentos) ->

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