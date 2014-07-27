Mongoose = require 'mongoose'

lancamentoSchema = new Mongoose.Schema
	data: type: Date, required: true
	natureza: type: String, required: true
	finalidade: type: String, required: true
	detalhesDaCompra: type: String
	valor: type: Number, required: true

module.exports = Mongoose.model 'Lancamento', lancamentoSchema