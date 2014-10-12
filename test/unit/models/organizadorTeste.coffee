should = require('chai').should()
Natureza = require '../../../models/natureza'
Comprovante = require '../../../models/comprovante'
Organizador = require '../../../models/organizador'

describe 'Organizador', ->
	
	_organizador = new Organizador
	_data = new Date 2014, 7, 1
	_comprovante = Comprovante.notaFiscal
	_fornecedor = 'Multicoisas'
	_detalhes = '2x Fones de ouvido Multilaser'

	it 'deve realizar o lançamento de um crédito', ->
		detalhes = 'Doação Renan'
		valor = 100

		lancamento = _organizador.lancarCredito _data, detalhes, valor

		lancamento.data.should.be.equal _data
		lancamento.natureza.should.be.equal Natureza.credito
		lancamento.detalhes.should.be.equal detalhes
		lancamento.valor.should.be.equal valor

	it 'não deve realizar o lançamento de um crédito sem data', ->
		_organizador.lancarCredito.should.throw /Data deve ser informada/

	it 'não deve realizar o lançamento de um crédito sem detalhes', ->
		testMethod = ->
			_organizador.lancarCredito _data

		testMethod.should.throw /Detalhes devem ser informados/

	it 'não deve realizar o lançamento de um crédito sem valor', ->
		testMethod = ->
			_organizador.lancarCredito _data, 'Detalhes'

		testMethod.should.throw /Valor deve ser informado/

	it 'deve realizar o lançamento de um débito', ->
		valor = 150.00

		lancamento = _organizador.lancarDebito _data, _comprovante, _fornecedor, _detalhes, valor

		lancamento.data.should.be.equal _data
		lancamento.natureza.should.be.equal Natureza.debito
		lancamento.comprovante.should.be.equal _comprovante
		lancamento.fornecedor.should.be.equal _fornecedor
		lancamento.detalhes.should.be.equal _detalhes
		lancamento.valor.should.be.equal valor

	it 'não deve realizar o lançamento de um débito sem data', ->
		_organizador.lancarDebito.should.throw /Data deve ser informada/

	it 'não deve realizar o lançamento de um débito sem comprovante', ->
		testMethod = ->
			_organizador.lancarDebito _data

		testMethod.should.throw /Comprovante deve ser informado/

	it 'não deve realizar o lançamento de um débito sem fornecedor', ->
		testMethod = ->
			_organizador.lancarDebito _data, _comprovante

		testMethod.should.throw /Fornecedor deve ser informado/

	it 'não deve realizar o lançamento de um débito sem valor', ->
		testMethod = ->
			_organizador.lancarDebito _data, _comprovante, _fornecedor

		testMethod.should.throw /Valor deve ser informado/