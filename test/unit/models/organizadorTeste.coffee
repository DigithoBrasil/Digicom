should = require('chai').should()
Natureza = require '../../../models/natureza'
Comprovante = require '../../../models/comprovante'
Organizador = require '../../../models/organizador'

describe 'Organizador', ->
	
	_organizador = new Organizador
	_mes = 8
	_ano = 2014
	_comprovante = Comprovante.notaFiscal
	_fornecedor = 'Multicoisas'
	_detalhes = '2x Fones de ouvido Multilaser'

	it 'deve realizar o lançamento de um crédito', ->
		detalhes = 'Doação Renan'
		valor = 100

		lancamento = _organizador.lancarCredito _mes, _ano, detalhes, valor

		lancamento.data.getFullYear().should.be.equal _ano
		lancamento.natureza.should.be.equal Natureza.credito
		lancamento.detalhes.should.be.equal detalhes
		lancamento.valor.should.be.equal valor

	it 'deve realizar o lançamento de um credito subtraindo 1 no mês solicitado', ->
		numeroDoMesDeAgosto = 7

		lancamento = _organizador.lancarCredito _mes, _ano, _detalhes, 123

		lancamento.data.getMonth().should.be.equal numeroDoMesDeAgosto

	it 'deve realizar o lançamento de um crétido com a data sempre marcada para o dia 1', ->
		lancamento = _organizador.lancarCredito _mes, _ano, _detalhes, 123

		lancamento.data.getDate().should.be.equal 1

	it 'não deve realizar o lançamento de um crédito sem mes', ->
		_organizador.lancarCredito.should.throw /Mês deve ser informado/

	it 'não deve realizar o lançamento de um crédito sem ano', ->
		testMethod = ->
			_organizador.lancarCredito _mes

		testMethod.should.throw /Ano deve ser informado/

	it 'não deve realizar o lançamento de um crédito sem detalhes', ->
		testMethod = ->
			_organizador.lancarCredito _mes, _ano

		testMethod.should.throw /Detalhes devem ser informados/

	it 'não deve realizar o lançamento de um crédito sem valor', ->
		testMethod = ->
			_organizador.lancarCredito _mes, _ano, 'Detalhes'

		testMethod.should.throw /Valor deve ser informado/

	it 'deve realizar o lançamento de um débito', ->
		valor = 150.00

		lancamento = _organizador.lancarDebito _mes, _ano, _comprovante, _fornecedor, _detalhes, valor

		lancamento.data.getFullYear().should.be.equal _ano
		lancamento.natureza.should.be.equal Natureza.debito
		lancamento.comprovante.should.be.equal _comprovante
		lancamento.fornecedor.should.be.equal _fornecedor
		lancamento.detalhes.should.be.equal _detalhes
		lancamento.valor.should.be.equal valor

	it 'deve realizar o lançamento de um débito subtraindo um do mês solicitado', ->
		numeroDoMesDeAgosto = 7

		lancamento = _organizador.lancarDebito _mes, _ano, _comprovante, _fornecedor, _detalhes, 123

		lancamento.data.getMonth().should.be.equal numeroDoMesDeAgosto

	it 'deve realizar o lançamento de um débito sempre com a data marcada para o dia 1', ->
		lancamento = _organizador.lancarDebito _mes, _ano, _comprovante, _fornecedor, _detalhes, 123

		lancamento.data.getDate().should.be.equal 1

	it 'não deve realizar o lançamento de um débito sem mês', ->
		_organizador.lancarDebito.should.throw /Mês deve ser informado/

	it 'não deve realizar o lançamento de um débito sem ano', ->
		testMethod = ->
			_organizador.lancarDebito _mes

		testMethod.should.throw /Ano deve ser informado/

	it 'não deve realizar o lançamento de um débito sem comprovante', ->
		testMethod = ->
			_organizador.lancarDebito _mes, _ano

		testMethod.should.throw /Comprovante deve ser informado/

	it 'não deve realizar o lançamento de um débito sem fornecedor', ->
		testMethod = ->
			_organizador.lancarDebito _mes, _ano, _comprovante

		testMethod.should.throw /Fornecedor deve ser informado/

	it 'não deve realizar o lançamento de um débito sem valor', ->
		testMethod = ->
			_organizador.lancarDebito _mes, _ano, _comprovante, _fornecedor

		testMethod.should.throw /Valor deve ser informado/