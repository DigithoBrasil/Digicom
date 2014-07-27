chai = require 'chai'
chaiStats = require 'chai-stats'

chai.use chaiStats

should = chai.should()
Natureza = require '../../../models/natureza'
Lancamento = require '../../../models/lancamento'
calculoDeLancamentosDoMes = require '../../../models/calculoDeLancamentosDoMes'

describe 'Cálculo de lançamentos do mês', ->

	it 'deve calcular a receita do mês', ->

		lancamentos = [
			new Lancamento valor: 310.33, natureza: Natureza.receita
			new Lancamento valor: 41.81, natureza: Natureza.despesa
			new Lancamento valor: 407.50, natureza: Natureza.receita
		]

		caixa = calculoDeLancamentosDoMes.calcular lancamentos

		caixa.receita.should.be.almost.eql 717.83, 2

	it 'deve calcular a despesa do mês', ->

		lancamentos = [
			new Lancamento valor: 310.33, natureza: Natureza.despesa
			new Lancamento valor: 41.81, natureza: Natureza.receita
			new Lancamento valor: 407.50, natureza: Natureza.despesa
		]

		caixa = calculoDeLancamentosDoMes.calcular lancamentos

		caixa.despesa.should.be.almost.eql 717.83, 2

	it 'deve adicionar ao valor total quando for receita', ->
		lancamentos = [
			new Lancamento valor: 10, natureza: Natureza.receita
			new Lancamento valor: 70, natureza: Natureza.receita
		]

		caixa = calculoDeLancamentosDoMes.calcular lancamentos

		caixa.total.should.be.equal 80

	it 'deve remover do valor total quando for despesa', ->

		lancamentos = [
			new Lancamento valor: 30, natureza: Natureza.despesa
			new Lancamento valor: 10, natureza: Natureza.despesa
		]

		caixa = calculoDeLancamentosDoMes.calcular lancamentos

		caixa.total.should.be.equal -40

	it 'deve ignorar os lançamentos que não possuirem natureza', ->

		lancamentos = [
			new Lancamento valor: 100
			new Lancamento valor: 1000
			new Lancamento valor: 10000
		]

		caixa = calculoDeLancamentosDoMes.calcular lancamentos

		caixa.total.should.be.equal 0

	it 'deve calcular o caixa do mês', ->
		
		lancamentos = [
			new Lancamento valor: 173.33, natureza: Natureza.receita
			new Lancamento valor: 41.81, natureza: Natureza.despesa
			new Lancamento valor: 27.52, natureza: Natureza.receita
			new Lancamento valor: 7.48, natureza: Natureza.despesa
		]

		caixa = calculoDeLancamentosDoMes.calcular lancamentos

		caixa.receita.should.be.almost.eql 200.85, 2
		caixa.despesa.should.be.almost.eql 49.29, 2
		caixa.total.should.be.almost.eql 151.56, 2

	it 'não deve calcular quando não houver lançamentos', ->

		caixa = calculoDeLancamentosDoMes.calcular []
		outroCaixa = calculoDeLancamentosDoMes.calcular null
		maisUmOutroCaixa = calculoDeLancamentosDoMes.calcular()

		caixa.receita.should.be.equal 0
		caixa.despesa.should.be.equal 0
		caixa.total.should.be.equal 0

		outroCaixa.receita.should.be.equal 0
		outroCaixa.despesa.should.be.equal 0
		outroCaixa.total.should.be.equal 0

		maisUmOutroCaixa.receita.should.be.equal 0
		maisUmOutroCaixa.despesa.should.be.equal 0
		maisUmOutroCaixa.total.should.be.equal 0