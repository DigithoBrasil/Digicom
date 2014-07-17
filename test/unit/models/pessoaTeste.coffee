should = require('chai').should()
Pessoa = require '../../../app/models/pessoa'

#mocha test/unit/models/pessoaTeste.coffee --compilers coffee:coffee-script/register

describe 'Pessoa', ->
	_pessoa = new Pessoa

	it 'deve lançar um gasto', ->
		data = new Date 2014, 7, 1
		finalidade = 'Presentes'
		detalhesDaCompra = '2x Fones de ouvido Multilaser'
		valor = 150.00

		lancamento = _pessoa.lancar data, finalidade, detalhesDaCompra, valor

		lancamento.data.should.be.equal data
		lancamento.finalidade.should.be.equal finalidade
		lancamento.detalhesDaCompra.should.be.equal detalhesDaCompra
		lancamento.valor.should.be.equal valor

	it 'não deve lançar sem data', ->
		_pessoa.lancar.should.throw /Data deve ser informada/