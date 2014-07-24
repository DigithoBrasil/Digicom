should = require('chai').should()
Natureza = require '../../../app/models/natureza'
Lancamento = require '../../../app/models/lancamento'
calculoDeLancamentosDoMes = require '../../../app/models/calculoDeLancamentosDoMes'


describe 'Cálculo de lançamentos do mês', ->

	_mesDeReferencia = new Date 2014, 7, 1

	it 'deve adicionar ao valor total quando for receita', ->
		lancamentos = [
			new Lancamento valor: 10, natureza: Natureza.receita
			new Lancamento valor: 70, natureza: Natureza.receita
		]

		valor = calculoDeLancamentosDoMes.calcular _mesDeReferencia, lancamentos

		valor.should.be.equal 80

	it 'deve remover do valor total quando for despesa', ->

		lancamentos = [
			new Lancamento valor: 30, natureza: Natureza.despesa
			new Lancamento valor: 10, natureza: Natureza.despesa
		]

		valor = calculoDeLancamentosDoMes.calcular _mesDeReferencia, lancamentos

		valor.should.be.equal -40

	it 'deve ignorar os lançamentos que não possuirem natureza', ->

		lancamentos = [
			new Lancamento valor: 100
			new Lancamento valor: 1000
			new Lancamento valor: 10000
		]

		valor = calculoDeLancamentosDoMes.calcular _mesDeReferencia, lancamentos

		valor.should.be.equal 0

	it 'deve calcular o caixa do mês', ->
		
		lancamentos = [
			new Lancamento valor: 173.33, natureza: Natureza.receita
			new Lancamento valor: 41.81, natureza: Natureza.despesa
			new Lancamento valor: 27.52, natureza: Natureza.receita
			new Lancamento valor: 7.48, natureza: Natureza.despesa
		]

		valor = calculoDeLancamentosDoMes.calcular _mesDeReferencia, lancamentos

		valor.should.be.equal 151.56