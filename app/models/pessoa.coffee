Mongoose  = require 'mongoose'

pessoaSchema = new Mongoose.Schema
	nome: type: String, required: false

pessoaSchema.methods.lancar = (data, finalidade, detalhesDaCompra, valor) ->
	throw new Error 'Data deve ser informada' if not data

	data: data
	finalidade: finalidade
	detalhesDaCompra: detalhesDaCompra
	valor: valor

Pessoa = Mongoose.model 'Pessoa', pessoaSchema

module.exports = Pessoa