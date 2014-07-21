Mongoose = require 'mongoose'

module.exports = (app) ->

	lancamentoSchema = new Mongoose.Schema
		data: type: Date, required: true,
		finalidade: type: String, required: true,
		detalhesDaCompra: type: String, required: true,
		valor: type: Number, required: true

	Mongoose.model 'Lancamento', lancamentoSchema