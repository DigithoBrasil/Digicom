should = require('chai').should()
Organizador = require '../../../app/models/organizador'

describe 'Organizador', ->
	_organizador = new Organizador
	_data = new Date 2014, 7, 1
	_detalhesDaCompra = '2x Fones de ouvido Multilaser'
	_finalidade = 'Presentes'

	it 'deve lançar um gasto', ->
		valor = 150.00

		lancamento = _organizador.lancar _data, _finalidade, _detalhesDaCompra, valor

		lancamento.data.should.be.equal _data
		lancamento.finalidade.should.be.equal _finalidade
		lancamento.detalhesDaCompra.should.be.equal _detalhesDaCompra
		lancamento.valor.should.be.equal valor

	it 'não deve lançar sem data', ->
		_organizador.lancar.should.throw /Data deve ser informada/

	it 'não deve lançar sem finalidade', ->
		testMethod = ->
			_organizador.lancar _data

		testMethod.should.throw /Finalidade deve ser informada/

	it 'não deve lançar sem detalhes da compra', ->
		testMethod = ->
			_organizador.lancar _data, _finalidade

		testMethod.should.throw /Detalhes da compra devem ser informados/

	it 'não deve lançar sem valor', ->
		testMethod = ->
			_organizador.lancar _data, _finalidade, _detalhesDaCompra

		testMethod.should.throw /Valor deve ser informado/