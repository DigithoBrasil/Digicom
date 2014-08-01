Mongoose  = require 'mongoose'
Lancamento = require '../models/lancamento'

organizadorSchema = new Mongoose.Schema
	nome: type: String, required: false
	login: type: String, required: true
	senha: type: String, required: true

organizadorSchema.methods.lancar = (data, natureza, finalidade, detalhesDaCompra, valor) ->
	throw new Error 'Data deve ser informada' if not data
	throw new Error 'Natureza deve ser informada' if not natureza
	throw new Error 'Finalidade deve ser informada' if not finalidade
	throw new Error 'Valor deve ser informado' if not valor

	new Lancamento { data: data, natureza: natureza, finalidade: finalidade, detalhesDaCompra: detalhesDaCompra, valor: valor }

module.exports = Mongoose.model 'Organizador', organizadorSchema