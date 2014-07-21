Mongoose  = require 'mongoose'
Lancamento = require '../models/lancamento'

module.exports = (app) ->

	organizadorSchema = new Mongoose.Schema
		nome: type: String, required: false

	organizadorSchema.methods.lancar = (data, finalidade, detalhesDaCompra, valor) ->
		throw new Error 'Data deve ser informada' if not data
		throw new Error 'Finalidade deve ser informada' if not finalidade
		throw new Error 'Detalhes da compra devem ser informados' if not detalhesDaCompra
		throw new Error 'Valor deve ser informado' if not valor

		new Lancamento { data: data, finalidade: finalidade, detalhesDaCompra: detalhesDaCompra, valor: valor }

	Mongoose.model 'Organizador', organizadorSchema